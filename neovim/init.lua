-- leader key
vim.g.mapleader = " "

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  --  THEME
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  --  FILE EXPLORER
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
    end,
  },

  -- 🖥️ DASHBOARD (LOGO)
 {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      "LAZYVIM",
    }

    dashboard.section.buttons.val = {
      dashboard.button("f", "󰝰  Find File"),
      dashboard.button("n", "  New File"),
      dashboard.button("e", "󰈞  Explorer"),
      dashboard.button("c", "  Configs"),
      dashboard.button("q", "󰩈  Quit"),
    }

    alpha.setup(dashboard.config)
  end,
} 

  --  FUZZY FINDER (per Find File)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  --  COMMAND LINE + POPUP (LazyVim style)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        cmdline = {
          view = "cmdline_popup",
        },
        messages = {
          view = "notify",
        },
        popupmenu = {
          enabled = true,
        },
      })
    end,
  },

  --  NOTIFICATIONS
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  },

})

--  KEYBINDS
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>f", ":Telescope find_files<CR>")

-- indentation settings
vim.opt.tabstop = 2        -- how wide a tab looks
vim.opt.shiftwidth = 2     -- indentation size
vim.opt.expandtab = true   -- use spaces instead of tabs
vim.opt.smartindent = true -- auto indent
