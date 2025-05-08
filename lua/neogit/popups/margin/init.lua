local popup = require("neogit.lib.popup")
local config = require("neogit.config")
local actions = require("neogit.popups.margin.actions")

local M = {}

function M.create()
  local p = popup
    .builder()
    :name("NeogitMarginPopup")
    :option("n", "max-count", "256", "Limit number of commits", { default = "256", key_prefix = "-" })
    :switch("o", "topo", "Order commits by", {
      cli_suffix = "-order",
      options = {
        { display = "", value = "" },
        { display = "topo", value = "topo" },
        { display = "author-date", value = "author-date" },
        { display = "date", value = "date" },
      },
    })
    :switch("g", "graph", "Show graph", {
      enabled = true,
      internal = true,
      incompatible = { "reverse" },
      dependent = { "color" },
    })
    :switch_if(
      config.values.graph_style == "ascii" or config.values.graph_style == "kitty",
      "c",
      "color",
      "Show graph in color",
      { internal = true, incompatible = { "reverse" } }
    )
    :switch("d", "decorate", "Show refnames", { enabled = true, internal = true })
    :group_heading("Refresh")
    :action("g", "buffer", actions.log_current)
    :new_action_group("Margin")
    :action("L", "toggle visibility", actions.toggle_visibility)
    :action("l", "cycle style", actions.cycle_date_style)
    :action("d", "toggle details", actions.toggle_details)
    :action("x", "toggle shortstat", actions.log_current)
    :build()

  p:show()

  return p
end

return M
