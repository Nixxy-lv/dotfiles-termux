-- leader key  
vim.g.mapleader = " "  

-- bootstrap lazy.nvim  
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)  

require("lazy").setup({  

--[[ CATPPUCCIN THEME  
{  
"catppuccin/nvim",  
name = "catppuccin",  
config = function()  
require("catppuccin").setup({ flavour = "mocha" })  
vim.cmd.colorscheme("catppuccin")  
end,  
},  
]]  

--[[ MOONFLY THEME  
{  
  "bluz71/vim-moonfly-colors",  
  name = "moonfly",  
  lazy = false,  
  priority = 1000,  
  config = function()  
    vim.opt.termguicolors = true  
    vim.g.moonflyTransparent = false  
    vim.g.moonflyItalics = true  
    vim.cmd.colorscheme("moonfly")  
  end,  
}, ]]

-- CATPPUCCIN FROST
{
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background=true,

      color_overrides = {
        mocha = {
          blue = "#89b4fa",
          sky = "#74c7ec",
          sapphire = "#74c7ec",
        },
      },

      highlight_overrides = {
        mocha = function(colors)
          return {
            Comment = { fg = colors.sky, style = { "italic" } },
            LineNr = { fg = colors.overlay0 },
            CursorLineNr = { fg = colors.blue },
          }
        end,
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}, 

-- LAZYGIT
{
  "kdheepak/lazygit.nvim",
  cmd = "LazyGit",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
  },
},

-- STATUS LINE
{
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = nil,
        icons_enabled = true,
        section_separators = "",
        component_separators = "",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename" },
        lualine_x = { "diagnostics" },
        lualine_y = { "filetype" },
        lualine_z = { "location" },
      },
    })
  end,
},

-- NOTES
{
  "renerocksai/telekasten.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("telekasten").setup({
      home = vim.fn.expand("~/notes"),
    })

    vim.keymap.set("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>")
    vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>")
    vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>")
    vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
  end,
},

-- BETTER IDK
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup()
  end,
},

-- SOME CONFIG STUFF IDK
{
  "folke/neoconf.nvim",
  cmd = "Neoconf",
  config = true,
},


-- MINIMAP
{
  "echasnovski/mini.map",
  config = function()
    local map = require("mini.map")

    map.setup({
      window = {
        side = "right",
        width = 12,
        winblend = 10,
        show_integration_count = false,
      },
    })

    -- Toggle key
    vim.keymap.set("n", "<leader>m", function()
      map.toggle()
    end, { desc = "Toggle minimap" })

    -- Auto-enable ONLY for large files
    vim.api.nvim_create_autocmd("BufReadPost", {
      callback = function()
        if vim.api.nvim_buf_line_count(0) > 300 then
          map.open()
        end
      end,
    })
  end,
},

-- AUTO PAIRS (brackets, quotes, etc.)
{
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      check_ts = false, -- set true if you later use treesitter
    })
  end,
},

-- FILE EXPLORER  
{  
"nvim-tree/nvim-tree.lua",  
dependencies = { "nvim-tree/nvim-web-devicons" },  
config = function()  
require("nvim-tree").setup()  
end,  
},  

-- DASHBOARD  
{  
"goolord/alpha-nvim",  
dependencies = { "nvim-tree/nvim-web-devicons" },  
config = function()  
local alpha = require("alpha")  
local dashboard = require("alpha.themes.dashboard")  

dashboard.section.header.val = {    
    " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",    
    " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",    
    " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",    
    " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",    
    " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",    
    " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",    
  }    

  dashboard.section.buttons.val = {    
    dashboard.button("f", "󰝰  Find File", ":Telescope find_files<CR>"),    
    dashboard.button("n", "  New File", ":ene <BAR> startinsert<CR>"),    
    dashboard.button("e", "󰈞  Explorer", ":NvimTreeToggle<CR>"),    
    dashboard.button("c", "  Configs", ":e $MYVIMRC<CR>"),    
    dashboard.button("q", "󰩈  Quit", ":qa<CR>"),    
  }    

  local win_height = vim.fn.winheight(0)    
  local header_lines = #dashboard.section.header.val    
  local button_lines = #dashboard.section.buttons.val * 2    
  local content_lines = header_lines + button_lines    
  local padding = math.floor((win_height - content_lines) / 2)    

  dashboard.config.layout = {    
    { type = "padding", val = padding },    
    dashboard.section.header,    
    { type = "padding", val = 2 },    
    dashboard.section.buttons,    
    { type = "padding", val = 1 },    
    dashboard.section.footer,    
  }    

  alpha.setup(dashboard.config)    
end,  

},  

-- FUZZY FINDER  
{  
"nvim-telescope/telescope.nvim",  
dependencies = { "nvim-lua/plenary.nvim" },  
},  

------------------------------------------------------------
-- FIX: NOTIFICATIONS
------------------------------------------------------------

-- NOTIFICATIONS (must load BEFORE noice uses vim.notify)
{  
  "rcarriga/nvim-notify",  
  config = function()  
    local notify = require("notify")

    notify.setup({
      stages = "fade_in_slide_out",
      timeout = 3000,
      background_colour = "#000000",
    })

    vim.notify = notify  
  end,  
},  

-- COMMAND LINE UI  
{  
"folke/noice.nvim",  
event = "VeryLazy",  
dependencies = {  
"MunifTanjim/nui.nvim",  
"rcarriga/nvim-notify",  
},  
config = function()  
require("noice").setup({  
cmdline = { view = "cmdline_popup" },  
messages = { view = "notify" },  
popupmenu = { enabled = true },  

-- avoid duplicate notification spam
lsp = {
  progress = { enabled = false },
},

notify = {
  enabled = true,
  view = "notify",
},

})  
end,  
},  

-- LSP (Rust)  
{  
"neovim/nvim-lspconfig",  
config = function()  
vim.lsp.config("rust_analyzer", {  
on_attach = function(client, bufnr)  
client.server_capabilities.semanticTokensProvider = nil  
end,  
settings = {  
["rust-analyzer"] = {  
cargo = {  
allFeatures = false,  
loadOutDirsFromCheck = false,  
},  
checkOnSave = false,  
diagnostics = {  
enable = true,  
disabled = { "unresolved-proc-macro" },  
},  
procMacro = { enable = false },  
inlayHints = { enable = false },  
files = {  
excludeDirs = { ".git", "target", ".direnv" },  
watcherExclude = { "/target/" }  
},  
workspace = {  
symbol = {  
search = { kind = "only_types" }  
}  
},  
}  
}  
})  

vim.lsp.enable("rust_analyzer")    
vim.lsp.set_log_level("off")    
end,  

},  

-- AUTOCOMPLETION  
{  
"hrsh7th/nvim-cmp",  
dependencies = {  
"hrsh7th/cmp-nvim-lsp",  
"hrsh7th/cmp-buffer",  
"hrsh7th/cmp-path",  
"hrsh7th/cmp-cmdline",  
"L3MON4D3/LuaSnip",  
"saadparwaiz1/cmp_luasnip",  
"rafamadriz/friendly-snippets",  
},  
config = function()  
local cmp = require("cmp")  
local luasnip = require("luasnip")  

vim.opt.completeopt = "menu,menuone,noselect"    
require("luasnip.loaders.from_vscode").lazy_load()    

cmp.setup({    
  snippet = {    
    expand = function(args)    
      luasnip.lsp_expand(args.body)    
    end,    
  },    
  completion = {    
    autocomplete = false,    
    keyword_length = 2,    
  },    
  performance = {    
    debounce = 60,    
    throttle = 30,    
    max_view_entries = 20    
  },    
  mapping = cmp.mapping.preset.insert({    
    ["<C-Space>"] = cmp.mapping.complete(),    
    ["<CR>"] = cmp.mapping.confirm({ select = true }),    
    ["<C-Tab>"] = cmp.mapping(function(fallback)    
      if cmp.visible() then    
        cmp.select_next_item()    
      elseif luasnip.expand_or_jumpable() then    
        luasnip.expand_or_jump()    
      else    
        cmp.complete()    
      end    
    end, { "i", "s" }),    
    ["<S-Tab>"] = cmp.mapping(function(fallback)    
      if cmp.visible() then    
        cmp.select_prev_item()    
      elseif luasnip.jumpable(-1) then    
        luasnip.jump(-1)    
      else    
        fallback()    
      end    
    end, { "i", "s" }),    
    ['<C-e>'] = cmp.mapping.abort(),    
  }),    
  sources = cmp.config.sources({    
    { name = "nvim_lsp", keyword_length = 2 },    
    { name = "luasnip" },    
    { name = "path", keyword_length = 3 },    
  }, {    
    { name = "buffer", keyword_length = 3 },    
  }),    
  experimental = {    
    ghost_text = false,    
  },    
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done()
)
    
end,  

},  
})  

-- KEYBINDS  
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")  
vim.keymap.set("n", "<leader>f", ":Telescope find_files<CR>") 
vim.keymap.set("n", "<leader>pt", ":set paste<CR>", { desc = "Enable paste mode" })
vim.keymap.set("n", "<leader>npt", ":set nopaste<CR>", { desc = "Disable paste mode" }) 

-- INDENTATION  
vim.opt.tabstop = 2  
vim.opt.shiftwidth = 2  
vim.opt.expandtab = true  
vim.opt.smartindent = true  

-- LINE NUMBERS  
vim.opt.number = false  
vim.opt.relativenumber = true
