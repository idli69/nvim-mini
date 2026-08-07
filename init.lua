vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Options
local o = vim.opt

o.number = true
o.relativenumber = true
o.wrap = false

o.clipboard = "unnamedplus"
o.mouse = "a"
o.termguicolors = true

o.ignorecase = true
o.smartcase = true

o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.smartindent = true

o.signcolumn = "yes"

o.scrolloff = 8
o.sidescrolloff = 8

o.splitbelow = true
o.splitright = true

o.undofile = true
o.updatetime = 200

o.fillchars:append({ eob = " " })

-- Keymaps
local map = vim.keymap.set

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Files
map("n", "<leader>w", "<cmd>w<CR>")
map("n", "<leader>q", "<cmd>q<CR>")

-- Clear search
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Better scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize windows
map("n", "<Left>", "<cmd>vertical resize -3<CR>")
map("n", "<Right>", "<cmd>vertical resize +3<CR>")
map("n", "<Up>", "<cmd>resize +2<CR>")
map("n", "<Down>", "<cmd>resize -2<CR>")

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<CR>")
map("n", "<S-l>", "<cmd>bnext<CR>")

-- Autocommands
local group = vim.api.nvim_create_augroup("config", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = group,
    callback = function()
        local line = vim.fn.line([['"]])
        if line > 1 and line <= vim.fn.line("$") then
            vim.cmd.normal([[g`"]])
        end
    end,
})

-- Plugins
vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/MeanderingProgrammer/treesitter-modules.nvim" },
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },
    { src = "https://github.com/wakatime/vim-wakatime" },
})

-- Theme
require("gruvbox").setup({
    transparent_mode = true,
    overrides = {
        NormalFloat = { bg = "NONE" },
        FloatBorder = { bg = "NONE" },
        SignColumn = { bg = "NONE" },
        StatusLine = { bg = "NONE" },
        StatusLineNC = { bg = "NONE" },
    },
})
vim.cmd.colorscheme("gruvbox")


require('treesitter-modules').setup({
    ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "javascript",
        "typescript",
    },
    auto_install = true,
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<cr>',
            node_incremental = '<cr>',
            scope_incremental = false,
            node_decremental = '<bs>',
        },
    },
})

-- mini.nvim
require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.comment").setup()
require("mini.ai").setup()
require("mini.surround").setup()
require("mini.input").setup()
require("mini.notify").setup()
require("mini.statusline").setup()
require("mini.bufremove").setup()
require("mini.extra").setup()
require("mini.indentscope").setup()
require("mini.pick").setup()

-- Plugin keymaps

-- Oil
require("oil").setup()
map("n", "-", "<cmd>Oil --float<CR>", { desc = "Open parent directory" })
-- Mini Pick
map("n", "<leader>ff", MiniPick.builtin.files, { desc = "Find files" })
map("n", "<leader>fg", MiniPick.builtin.grep_live, { desc = "Live grep" })
map("n", "<leader>fb", MiniPick.builtin.buffers, { desc = "Buffers" })
map("n", "<leader>fh", MiniPick.builtin.help, { desc = "Help tags" })
-- Delete buffer
map("n", "<leader>bd", MiniBufremove.delete, { desc = "Delete buffer" })
