defmodule Portal do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: Portal.Worker.start_link(arg1, arg2, arg3)
      # worker(Portal.Worker, [arg1, arg2, arg3]),
      worker(Portal.Door, [])
    ]

    opts = [strategy: :simple_one_for_one, name: Portal.Supervisor]
    Supervisor.start_link(children, opts)

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    
  end

  defstruct [:left, :right]

  @doc """
  Starts transferring the data tot he portal on the "left" to the "right". 
  """
  def transfer(left, right, data) do
    # First add all the data to the portal on the left
    for item <- data do
      Portal.Door.push(left, item)
    end

    # Returns a portal struct we will use next
    %Portal{left: left, right: right}
  end
  @doc """
  Pushes the data to the right in the given "portal".
  """
  def push_right(portal) do
    # See if we can pop data fromthe left. If so, push the
    # popped data tot he right. Otherwise, do nothing.
    case Portal.Door.pop(portal.left) do
      :error -> :ok
      {:ok, h} -> Portal.Door.push(portal.right, h)    
    end

    # Let's return the portal itself
    portal
  end

   @doc """
  Shoots a new door with the given "colour"
  """

  def shoot(colour) do
    Supervisor.start_child(Portal.Supervisor, [colour])
  end
  
end

defimpl Inspect, for: Portal do
  def inspect(%Portal{left: left, right: right}, _) do
    left_door = inspect(left)
    right_door = inspect(right)

    left_data = inspect(Enum.reverse(Portal.Door.get(left)))
    right_data = inspect(Portal.Door.get(right))

    max = max(String.length(left_door), String.length(left_data))

    """
    #Portal<
      #{String.rjust(left_door, max)} <=> #{right_door}
      #{String.rjust(left_data, max)} <=> #{right_data}
    >
    """
  end
end





