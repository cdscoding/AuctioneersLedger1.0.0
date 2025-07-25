-- Auctioneer's Ledger - Constants
-- This file contains all the static configuration values for the addon.
AL.VERSION = "1.0.86" 

-- Core numerical constants (independent)
AL.COL_PADDING = 5
AL.ICON_TEXT_PADDING = 4
AL.ITEM_ICON_SIZE = 18
AL.DELETE_BUTTON_SIZE = 20
AL.EXPAND_BUTTON_SIZE = 16
AL.BUTTON_HEIGHT = 24
AL.BUTTON_SPACING = 5
AL.TAB_BUTTON_HEIGHT = 20
AL.TAB_BUTTON_WIDTH = 120
AL.TAB_BUTTON_SPACING = 2
AL.POPUP_WIDTH = 240
AL.POPUP_HEIGHT = 160
AL.POPUP_OFFSET_X = 10
AL.ITEM_ROW_HEIGHT = 22
AL.COLUMN_HEADER_HEIGHT = 20
AL.EVENT_DEBOUNCE_TIME = 0.75
AL.PERIODIC_REFRESH_INTERVAL = 7.0
AL.MAIL_REFRESH_DELAY = 0.25
AL.MAX_MAIL_ATTACHMENTS_TO_SCAN = 12
AL.STALE_DATA_THRESHOLD = 300
AL.MAX_WARBAND_BANK_TABS_TO_CHECK = 7
AL.DEFAULT_WINDOW_WIDTH = 1270
AL.DEFAULT_WINDOW_HEIGHT = 770
AL.HELP_WINDOW_WIDTH = 740
AL.HELP_WINDOW_HEIGHT = 600

-- Blaster Constants
AL.BLASTER_WINDOW_WIDTH = 360
-- [[ DIRECTIVE: Increased height to prevent UI bounce ]]
AL.BLASTER_WINDOW_HEIGHT = 550
AL.BLASTER_BUTTON_WIDTH = 140
AL.BLASTER_LOGO_PATH = "Interface\\AddOns\\AuctioneersLedger\\Media\\BlasterLogo.tga"
AL.BLASTER_FAIL_ICON_PATH = "Interface\\Buttons\\UI-GroupLoot-Pass-Down"
AL.BLASTER_LOGO_WIDTH = 300
AL.BLASTER_LOGO_HEIGHT = 203
AL.BLASTER_QUEUE_ITEM_SIZE = 30
AL.BLASTER_QUEUE_ITEM_PADDING = 2
AL.BLASTER_SCROLL_WIDTH = 35
AL.BLASTER_CONTROLS_WIDTH = 350
AL.BLASTER_RADIO_SIZE = 20
AL.BLASTER_HISTORY_PANEL_WIDTH = 500
AL.BLASTER_HISTORY_PANEL_X_OFFSET = -5
AL.BLASTER_HISTORY_TAB_WIDTH = 115
AL.BLASTER_HISTORY_TAB_HEIGHT = 22
AL.BLASTER_HISTORY_TAB_SPACING = 2
AL.BLASTER_HISTORY_ROW_HEIGHT = 20
AL.BH_COL_ICON_AND_NAME_WIDTH = 200
AL.BH_COL_QTY_WIDTH = 50
AL.BH_COL_PRICE_WIDTH = 120
AL.BH_COL_DATE_WIDTH = 60

-- [[ NEW: Patreon Logo Constants ]]
AL.PATREON_LOGO_PATH = "Interface\\AddOns\\AuctioneersLedger\\Media\\PatreonLogo.tga"

-- Popup Constants
AL.POPUP_FEEDBACK_DURATION = 3.0
AL.ORIGINAL_POPUP_TEXT = "Drag an item here to track it."

-- [[ BUG FIX: Corrected order of dependent constants ]]
-- Dependent layout constants
AL.COL_ICON_WIDTH = AL.ITEM_ICON_SIZE
AL.COL_NAME_TEXT_WIDTH = 230
AL.EFFECTIVE_NAME_COL_WIDTH = AL.EXPAND_BUTTON_SIZE + AL.ICON_TEXT_PADDING + AL.COL_ICON_WIDTH + AL.ICON_TEXT_PADDING + AL.COL_NAME_TEXT_WIDTH
AL.LEFT_PANEL_WIDTH = 166
AL.DIVIDER_THICKNESS = 2

-- Column widths
AL.STOCK_COL_CHARACTER_WIDTH = 150
AL.STOCK_COL_REALM_WIDTH = 150
AL.STOCK_COL_NOTES_WIDTH = 150
AL.STOCK_COL_LOCATION_WIDTH = 150
AL.STOCK_COL_OWNED_WIDTH = 110
AL.STOCK_COL_DELETE_BTN_AREA_WIDTH = 60

AL.FIN_COL_CHARACTER_WIDTH = 135
AL.FIN_COL_REALM_WIDTH = 135
AL.FIN_COL_TOTAL_BOUGHT_WIDTH = 125
AL.FIN_COL_TOTAL_SOLD_WIDTH = 125
AL.FIN_COL_TOTAL_PROFIT_WIDTH = 125
AL.FIN_COL_TOTAL_LOSS_WIDTH = 125

AL.AP_COL_CHARACTER_WIDTH = 140
AL.AP_COL_REALM_WIDTH = 140
AL.AP_COL_ALLOW_AUTO_PRICING_WIDTH = 105
AL.AP_COL_SAFETY_NET_WIDTH = 130
AL.AP_COL_NORMAL_BUYOUT_WIDTH = 130
AL.AP_COL_UNDERCUT_AMOUNT_WIDTH = 130

AL.AS_COL_CHARACTER_WIDTH = 150
AL.AS_COL_REALM_WIDTH = 150
AL.AS_COL_DURATION_WIDTH = 240
AL.AS_COL_STACKABLE_WIDTH = 120
AL.AS_COL_QUANTITY_WIDTH = 120

-- Other layout constants
AL.CHILD_ROW_INDENT = 0
AL.PARENT_ICON_AREA_X_OFFSET = 0
AL.CHILD_ICON_AREA_X_OFFSET = 0
AL.WINDOW_DIVIDER_COLOR = {0.45, 0.45, 0.45, 0.8}
AL.LABEL_BACKDROP_COLOR = {1, 1, 1, 1}
AL.LABEL_TEXT_COLOR = {1, 0.82, 0, 1}
AL.CHILD_ROW_DATA_JUSTIFY_H = "CENTER"

-- View Modes
AL.VIEW_WARBAND_STOCK = "WARBAND_STOCK"
AL.VIEW_AUCTION_FINANCES = "AUCTION_FINANCES"
AL.VIEW_VENDOR_FINANCES = "VENDOR_FINANCES"
AL.VIEW_AUCTION_PRICING = "AUCTION_PRICING"
AL.VIEW_AUCTION_SETTINGS = "AUCTION_SETTINGS"

-- UI Positioning
AL.TAB_TOP_OFFSET = 5
AL.TAB_HORIZONTAL_POSITION_OFFSET = 0
AL.MAIN_CONTENT_VERTICAL_OFFSET_ADJUSTMENT = -50
AL.SCROLL_FRAME_VERTICAL_OFFSET = 100
AL.ITEM_ROW_CONTENT_TOTAL_WIDTH = 0

-- Colors
AL.ROW_COLOR_EVEN = {0.17, 0.17, 0.20, 0.7}
AL.ROW_COLOR_ODD = {0.14, 0.14, 0.17, 0.7}
AL.COLOR_LIMBO = {0.6, 0.6, 0.6, 1.0}
AL.COLOR_STALE_MULTIPLIER = 0.75
AL.COLOR_DEFAULT_TEXT_RGB = {221/255, 221/255, 221/255, 1.0}
AL.COLOR_BANK_GOLD = {0.9, 0.7, 0.3, 1.0}
AL.COLOR_AH_BLUE = {0.5, 0.8, 1.0, 1.0}
AL.COLOR_MAIL_TAN = {0.82, 0.70, 0.55, 1.0}
AL.COLOR_WARBAND_BANK = {1.0, 0.2, 0.2, 1.0}
AL.COLOR_REAGENT_BANK = {0.2, 0.7, 0.7, 1.0}
AL.COLOR_PARENT_ROW_TEXT_NEUTRAL = {0.85, 0.85, 0.95, 0.7}
AL.COLOR_PROFIT = {0.2, 1.0, 0.2, 1.0}
AL.COLOR_LOSS = {1.0, 0.2, 0.2, 1.0}
AL.COLOR_NEUTRAL_PROFIT_LOSS = {0.8, 0.8, 0.8, 1.0}
AL.COLOR_EDITBOX_BACKGROUND = {0.1, 0.1, 0.1, 0.9}
AL.COLOR_EDITBOX_BORDER = {0.4, 0.4, 0.4, 1.0}
AL.COLOR_DISABLED_TEXT = {0.5, 0.5, 0.5, 1.0}
AL.COLOR_TAB_INACTIVE_TEXT = {0.6, 0.6, 0.6, 1.0}

-- Sort Criteria
AL.SORT_ALPHA = "ALPHA"
AL.SORT_ITEM_NAME_FLAT = "ITEM_NAME_FLAT"
AL.SORT_BAGS = "BAGS"
AL.SORT_BANK = "BANK"
AL.SORT_MAIL = "MAIL"
AL.SORT_AUCTION = "AUCTION"
AL.SORT_LIMBO = "LIMBO"
AL.SORT_WARBAND_BANK = "WARBAND_BANK"
AL.SORT_REAGENT_BANK = "REAGENT_BANK"
AL.SORT_CHARACTER = "CHARACTER"
AL.SORT_REALM = "REALM"
AL.SORT_QUALITY_PREFIX = "QUALITY_"

-- NEW: Stack Filter Constants
AL.FILTER_STACK_PREFIX = "FILTER_STACK_"
AL.FILTER_STACKABLE = "STACKABLE"
AL.FILTER_NONSTACKABLE = "NONSTACKABLE"
AL.FILTER_ALL_STACKS = "ALL"

-- Location Constants
AL.LOCATION_BAGS = "Bags"
AL.LOCATION_BANK = "Bank"
AL.LOCATION_MAIL = "Mail"
AL.LOCATION_AUCTION_HOUSE = "Auction House"
AL.LOCATION_WARBAND_BANK = "Warband Bank"
AL.LOCATION_REAGENT_BANK = "Reagent Bank"
AL.LOCATION_LIMBO = "Limbo"
