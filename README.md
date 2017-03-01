# Portal
An Elixir project based on the [Portal tutorial](https://howistart.org/posts/elixir/1).
Here we use the Elixir programming language to build portals by shooting doors of different colors and transferring data between them. We will even learn how we can distribute doors across different machines in our network.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `portal` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:portal, "~> 0.1.0"}]
    end
    ```

  2. Ensure `portal` is started before your application:

    ```elixir
    def application do
      [applications: [:portal]]
    end
    ```

