-- Auctioneer's Ledger - GUI Display
-- This file handles the rendering of actual data rows within the ledger.

function AL:CreateItemRowFrame(parent, itemData, yOffset, isEvenRow, precomputedDetails, isParentRow, isExpanded)
    local r = CreateFrame("Frame", "AL_ItemRow_" .. (yOffset or math.random(1, 99999)), parent)
    if not (r and r.IsObjectType and r:IsObjectType("Frame")) then return CreateFrame("Frame", nil, UIParent):Hide() end
    r.isEvenRow = isEvenRow; r.itemID = itemData.itemID; r.characterName = itemData.characterName or ""; r.characterRealm = itemData.characterRealm or ""; r.isParentRow = isParentRow
    r:SetSize(parent:GetWidth(), AL.ITEM_ROW_HEIGHT); r:SetPoint("TOPLEFT", 0, -yOffset)
    r.bg = r:CreateTexture(nil, "BACKGROUND"); r.bg:SetAllPoints(true); if isEvenRow then r.bg:SetColorTexture(unpack(AL.ROW_COLOR_EVEN)) else r.bg:SetColorTexture(unpack(AL.ROW_COLOR_ODD)) end
    local internalContentStartX = AL.COL_PADDING; if not isParentRow then internalContentStartX = internalContentStartX + AL.CHILD_ROW_INDENT end
    local currentColumnX = internalContentStartX 
    if isParentRow then r.expandButton = CreateFrame("Button", nil, r); r.expandButton:SetSize(AL.EXPAND_BUTTON_SIZE, AL.EXPAND_BUTTON_SIZE); r.expandButton:SetPoint("LEFT", currentColumnX, 0); r.expandButton.icon = r.expandButton:CreateTexture(nil, "ARTWORK"); r.expandButton.icon:SetAllPoints(true); r.expandButton.icon:SetTexture(isExpanded and "Interface\\Buttons\\UI-MinusButton-Up" or "Interface\\Buttons\\UI-PlusButton-Up"); r.expandButton.itemID = itemData.itemID; r.expandButton:SetScript("OnClick", function(selfBtn) _G.AL_SavedData.Settings.itemExpansionStates[selfBtn.itemID] = not _G.AL_SavedData.Settings.itemExpansionStates[selfBtn.itemID]; AL:RefreshLedgerDisplay() end) end; currentColumnX = currentColumnX + AL.EXPAND_BUTTON_SIZE + AL.ICON_TEXT_PADDING
    r.icon = r:CreateTexture(nil, "ARTWORK"); r.icon:SetSize(AL.ITEM_ICON_SIZE, AL.ITEM_ICON_SIZE); r.icon:SetPoint("LEFT", r, "LEFT", currentColumnX, 0); r.icon:SetTexture(itemData.itemTexture or "Interface\\Icons\\inv_misc_questionmark"); currentColumnX = currentColumnX + AL.ITEM_ICON_SIZE + AL.ICON_TEXT_PADDING
    r.nameFS = r:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny"); r.nameFS:SetPoint("LEFT", r, "LEFT", currentColumnX, 0); r.nameFS:SetSize(AL.COL_NAME_TEXT_WIDTH, AL.ITEM_ROW_HEIGHT); r.nameFS:SetJustifyH("LEFT"); r.nameFS:SetJustifyV("MIDDLE")
	
    -- Warband Stock Columns
    currentColumnX = internalContentStartX + AL.EFFECTIVE_NAME_COL_WIDTH + AL.COL_PADDING
    r.locCharacterFS = r:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny"); r.locCharacterFS:SetPoint("LEFT", r, "LEFT", currentColumnX, 0); r.locCharacterFS:SetSize(AL.STOCK_COL_CHARACTER_WIDTH, AL.ITEM_ROW_HEIGHT); r.locCharacterFS:SetJustifyH(AL.CHILD_ROW_DATA_JUSTIFY_H); currentColumnX = currentColumnX + AL.STOCK_COL_CHARACTER_WIDTH + AL.COL_PADDING
    r.locRealmFS = r:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny"); r.locRealmFS:SetPoint("LEFT", r, "LEFT", currentColumnX, 0); r.locRealmFS:SetSize(AL.STOCK_COL_REALM_WIDTH, AL.ITEM_ROW_HEIGHT); r.locRealmFS:SetJustifyH(AL.CHILD_ROW_DATA_JUSTIFY_H); currentColumnX = currentColumnX + AL.STOCK_COL_REALM_WIDTH + AL.COL_PADDING
    r.notesFS = r:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny"); r.notesFS:SetPoint("LEFT", r, "LEFT", currentColumnX, 0); r.notesFS:SetSize(AL.STOCK_COL_NOTES_WIDTH, AL.ITEM_ROW_HEIGHT); r.notesFS:SetJustifyH(AL.CHILD_ROW_DATA_JUSTIFY_H); currentColumnX = currentColumnX + AL.STOCK_COL_NOTES_WIDTH + AL.COL_PADDING
    r.locationFS = r:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny"); r.locationFS:SetPoint("LEFT", r, "LEFT", currentColumnX, 0); r.locationFS:SetSize(AL.STOCK_COL_LOCATION_WIDTH, AL.ITEM_ROW_HEIGHT); r.locationFS:SetJustifyH(AL.CHILD_ROW_DATA_JUSTIFY_H); currentColumnX = currentColumnX + AL.STOCK_COL_LOCATION_WIDTH + AL.COL_PADDING
    r.ownedFS = r:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny"); r.ownedFS:SetPoint("LEFT", r, "LEFT", currentColumnX, 0); r.ownedFS:SetSize(AL.STOCK_COL_OWNED_WIDTH, AL.ITEM_ROW_HEIGHT); r.ownedFS:SetJustifyH(AL.CHILD_ROW_DATA_JUSTIFY_H); currentColumnX = currentColumnX + AL.STOCK_COL_OWNED_WIDTH + AL.COL_PADDING
    local locDeleteButtonX = currentColumnX
    
    -- [[ REFACTORED: Finance Columns ]]
    currentColumnX = internalContentStartX + AL.EFFECTIVE_NAME_COL_WIDTH + AL.COL_PADDING
    r.finCharacterFS = r:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny"); r.finCharacterFS:SetPoint("LEFT", r, "LEFT", currentColumnX, 0); r.finCharacterFS:SetSize(AL.FIN_COL_CHARACTER_WIDTH, AL.ITEM_ROW_HEIGHT); r.finCharacterFS:SetJustifyH("CENTER"); currentColumnX = currentColumnX + AL.FIN_COL_CHARACTER_WIDTH + AL.COL_PADDING
    r.finRealmFS = r:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny"); r.finRealmFS:SetPoint("LEFT", r, "LEFT", currentColumnX, 0); r.finRealmFS:SetSize(AL.FIN_COL_REALM_WIDTH, AL.ITEM_ROW_HEIGHT); r.finRealmFS:SetJustifyH("CENTER"); currentColumnX = currentColumnX + AL.FIN_COL_REALM_WIDTH + AL.COL_PADDING
    r.finTotalBoughtFS = r:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny"); r.finTotalBoughtFS:SetPoint("LEFT", r, "LEFT", currentColumnX, 0); r.finTotalBoughtFS:SetSize(AL.FIN_COL_TOTAL_BOUGHT_WIDTH, AL.ITEM_ROW_HEIGHT); r.finTotalBoughtFS:SetJustifyH("CENTER"); currentColumnX = currentColumnX + AL.FIN_COL_TOTAL_BOUGHT_WIDTH + AL.COL_PADDING
    r.finTotalSoldFS = r:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny"); r.finTotalSoldFS:SetPoint("LEFT", r, "LEFT", currentColumnX, 0); r.finTotalSoldFS:SetSize(AL.FIN_COL_TOTAL_SOLD_WIDTH, AL.ITEM_ROW_HEIGHT); r.finTotalSoldFS:SetJustifyH("CENTER"); currentColumnX = currentColumnX + AL.FIN_COL_TOTAL_SOLD_WIDTH + AL.COL_PADDING
    r.finTotalProfitFS = r:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny"); r.finTotalProfitFS:SetPoint("LEFT", r, "LEFT", currentColumnX, 0); r.finTotalProfitFS:SetSize(AL.FIN_COL_TOTAL_PROFIT_WIDTH, AL.ITEM_ROW_HEIGHT); r.finTotalProfitFS:SetJustifyH("CENTER"); currentColumnX = currentColumnX + AL.FIN_COL_TOTAL_PROFIT_WIDTH + AL.COL_PADDING
    r.finTotalLossFS = r:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny"); r.finTotalLossFS:SetPoint("LEFT", r, "LEFT", currentColumnX, 0); r.finTotalLossFS:SetSize(AL.FIN_COL_TOTAL_LOSS_WIDTH, AL.ITEM_ROW_HEIGHT); r.finTotalLossFS:SetJustifyH("CENTER");

    -- ... (Auction Pricing and Settings columns remain the same) ...
    currentColumnX = internalContentStartX + AL.EFFECTIVE_NAME_COL_WIDTH + AL.COL_PADDING; r.apCharacterFS = r:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny"); r.apCharacterFS:SetPoint("LEFT", r, "LEFT", currentColumnX, 0); r.apCharacterFS:SetSize(AL.AP_COL_CHARACTER_WIDTH, AL.ITEM_ROW_HEIGHT); r.apCharacterFS:SetJustifyH(AL.CHILD_ROW_DATA_JUSTIFY_H); currentColumnX = currentColumnX + AL.AP_COL_CHARACTER_WIDTH + AL.COL_PADDING; r.apRealmFS = r:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny"); r.apRealmFS:SetPoint("LEFT", r, "LEFT", currentColumnX, 0); r.apRealmFS:SetSize(AL.AP_COL_REALM_WIDTH, AL.ITEM_ROW_HEIGHT); r.apRealmFS:SetJustifyH(AL.CHILD_ROW_DATA_JUSTIFY_H); currentColumnX = currentColumnX + AL.AP_COL_REALM_WIDTH + AL.COL_PADDING; r.autoPricingCB = CreateFrame("CheckButton", nil, r, "UICheckButtonTemplate"); r.autoPricingCB:SetSize(24, 24); r.autoPricingCB:SetPoint("CENTER", r, "LEFT", currentColumnX + (AL.AP_COL_ALLOW_AUTO_PRICING_WIDTH / 2), 0); r.autoPricingCB:SetScript("OnClick", function(self) AL:SaveCharacterItemSetting(r.itemID, r.characterName, r.characterRealm, "autoUpdateFromMarket", self:GetChecked()) end); currentColumnX = currentColumnX + AL.AP_COL_ALLOW_AUTO_PRICING_WIDTH + AL.COL_PADDING; r.safetyNetBuyoutInputs = AL:CreateMoneyInput(r, currentColumnX, 0, itemData.safetyNetBuyout, "safetyNetBuyout", itemData.itemID, r.characterName, r.characterRealm); currentColumnX = currentColumnX + AL.AP_COL_SAFETY_NET_WIDTH + AL.COL_PADDING; r.normalBuyoutPriceInputs = AL:CreateMoneyInput(r, currentColumnX, 0, itemData.normalBuyoutPrice, "normalBuyoutPrice", itemData.itemID, r.characterName, r.characterRealm); currentColumnX = currentColumnX + AL.AP_COL_NORMAL_BUYOUT_WIDTH + AL.COL_PADDING; r.undercutAmountInputs = AL:CreateMoneyInput(r, currentColumnX, 0, itemData.undercutAmount, "undercutAmount", itemData.itemID, r.characterName, r.characterRealm);
    currentColumnX = internalContentStartX + AL.EFFECTIVE_NAME_COL_WIDTH + AL.COL_PADDING; r.asCharacterFS = r:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny"); r.asCharacterFS:SetPoint("LEFT",r,"LEFT",currentColumnX,0); r.asCharacterFS:SetSize(AL.AS_COL_CHARACTER_WIDTH,AL.ITEM_ROW_HEIGHT); r.asCharacterFS:SetJustifyH("CENTER"); currentColumnX = currentColumnX + AL.AS_COL_CHARACTER_WIDTH + AL.COL_PADDING; r.asRealmFS = r:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny"); r.asRealmFS:SetPoint("LEFT",r,"LEFT",currentColumnX,0); r.asRealmFS:SetSize(AL.AS_COL_REALM_WIDTH,AL.ITEM_ROW_HEIGHT); r.asRealmFS:SetJustifyH("CENTER"); currentColumnX = currentColumnX + AL.AS_COL_REALM_WIDTH + AL.COL_PADDING; r.durationContainer = CreateFrame("Frame", nil, r); r.durationContainer:SetPoint("LEFT",r,"LEFT",currentColumnX,0); r.durationContainer:SetSize(AL.AS_COL_DURATION_WIDTH, AL.ITEM_ROW_HEIGHT); currentColumnX = currentColumnX + AL.AS_COL_DURATION_WIDTH + AL.COL_PADDING; r.durationButtons = {}; local durations = {{label="12h", val=720}, {label="24h", val=1440}, {label="48h", val=2880}}; for i, durInfo in ipairs(durations) do local cbName = r:GetName() .. "_DurationCheckBox_" .. i; local cb = CreateFrame("CheckButton", cbName, r.durationContainer, "UICheckButtonTemplate"); cb:SetSize(20,20); cb.durationValue = durInfo.val; _G[cbName.."Text"]:SetText(""); local cbText = cb:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny"); cbText:SetPoint("LEFT", cb, "RIGHT", 2, 0); cbText:SetText(durInfo.label); if i == 1 then cb:SetPoint("LEFT", 20, 0) else cb:SetPoint("LEFT", r.durationButtons[i-1], "RIGHT", 45, 0) end; cb:SetScript("OnClick", function(self) for _, otherBtn in ipairs(r.durationButtons) do otherBtn:SetChecked(otherBtn == self) end; AL:SaveAuctionSetting(r.itemID, r.characterName, r.characterRealm, "duration", self.durationValue) end); table.insert(r.durationButtons, cb) end; r.asStackableFS = r:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny"); r.asStackableFS:SetPoint("LEFT",r,"LEFT",currentColumnX,0); r.asStackableFS:SetSize(AL.AS_COL_STACKABLE_WIDTH,AL.ITEM_ROW_HEIGHT); r.asStackableFS:SetJustifyH("CENTER"); currentColumnX = currentColumnX + AL.AS_COL_STACKABLE_WIDTH + AL.COL_PADDING; r.asQuantityEB = CreateFrame("EditBox", nil, r, "InputBoxTemplate"); r.asQuantityEB:SetPoint("LEFT",r,"LEFT",currentColumnX+15,0); r.asQuantityEB:SetSize(AL.AS_COL_QUANTITY_WIDTH-30,AL.ITEM_ROW_HEIGHT); r.asQuantityEB:SetNumeric(true); r.asQuantityEB:SetAutoFocus(false); r.asQuantityFS_NA = r:CreateFontString(nil, "ARTWORK", "GameFontNormal"); r.asQuantityFS_NA:SetPoint("CENTER", r.asQuantityEB, "CENTER", 0, 0); r.asQuantityFS_NA:SetText("N/A"); r.asQuantityFS_NA:SetTextColor(1, 1, 1, 1); local function commitQuantity(self) AL:SaveAuctionSetting(r.itemID, r.characterName, r.characterRealm, "quantity", tonumber(self:GetText()) or 1); if self and self:HasFocus() then self:ClearFocus() end end; r.asQuantityEB:SetScript("OnEnterPressed", commitQuantity); r.asQuantityEB:SetScript("OnEditFocusLost", commitQuantity); r.asQuantityEB:SetScript("OnEscapePressed", function(self) self:ClearFocus() end);

    r.parentDeleteButton = CreateFrame("Button", nil, r, "UIPanelButtonTemplate"); r.parentDeleteButton:SetSize(AL.DELETE_BUTTON_SIZE, AL.DELETE_BUTTON_SIZE); r.parentDeleteButton:SetText("X"); r.parentDeleteButton:SetPoint("LEFT", r, "LEFT", locDeleteButtonX + 20, 0); r.parentDeleteButton.itemID = itemData.itemID; r.parentDeleteButton.itemName = itemData.itemName or "Unknown Item"; r.parentDeleteButton:SetScript("OnClick", function(selfBtn) if StaticPopupDialogs["AL_CONFIRM_DELETE_ALL_ITEM_INSTANCES"] then StaticPopup_Show("AL_CONFIRM_DELETE_ALL_ITEM_INSTANCES", selfBtn.itemName, nil, { itemID = selfBtn.itemID }) else AL:RemoveAllInstancesOfItem(selfBtn.itemID) end end)
    r.childDeleteButton = CreateFrame("Button", nil, r, "UIPanelButtonTemplate"); r.childDeleteButton:SetSize(AL.DELETE_BUTTON_SIZE, AL.DELETE_BUTTON_SIZE); r.childDeleteButton:SetText("X"); r.childDeleteButton:SetPoint("LEFT", r, "LEFT", locDeleteButtonX + 20, 0); r.childDeleteButton:SetScript("OnClick", function() AL:RemoveTrackedItem(r.itemID, r.characterName, r.characterRealm) end)

    if r.safetyNetBuyoutInputs.container then r.safetyNetBuyoutInputs.container:Hide() end; if r.normalBuyoutPriceInputs.container then r.normalBuyoutPriceInputs.container:Hide() end; if r.undercutAmountInputs.container then r.undercutAmountInputs.container:Hide() end

    if isParentRow then 
        local pr, pg, pb = GetItemQualityColor(itemData.itemRarity or 1)
        r.nameFS:SetText(itemData.itemName or "Unknown Item"); r.nameFS:SetTextColor(pr,pg,pb)
        if r.expandButton then r.expandButton:Show() end
    else 
        if r.expandButton then r.expandButton:Hide() end
        local pr, pg, pb = GetItemQualityColor(itemData.itemRarity or 1)
        if AL.currentActiveTab == AL.VIEW_WARBAND_STOCK then
            r.nameFS:SetText(itemData.itemName); r.nameFS:SetTextColor(precomputedDetails.colorR, precomputedDetails.colorG, precomputedDetails.colorB)
            r.locCharacterFS:SetText(itemData.characterName); r.locCharacterFS:SetTextColor(precomputedDetails.colorR, precomputedDetails.colorG, precomputedDetails.colorB)
            r.locRealmFS:SetText(itemData.characterRealm); r.locRealmFS:SetTextColor(precomputedDetails.colorR, precomputedDetails.colorG, precomputedDetails.colorB)
			r.notesFS:SetText(precomputedDetails.notesText); r.notesFS:SetTextColor(precomputedDetails.colorR, precomputedDetails.colorG, precomputedDetails.colorB)
			r.locationFS:SetText(precomputedDetails.locationText); r.locationFS:SetTextColor(precomputedDetails.colorR, precomputedDetails.colorG, precomputedDetails.colorB)
			r.ownedFS:SetText(precomputedDetails.displayText); r.ownedFS:SetTextColor(precomputedDetails.colorR, precomputedDetails.colorG, precomputedDetails.colorB)
        elseif AL.currentActiveTab == AL.VIEW_AUCTION_FINANCES or AL.currentActiveTab == AL.VIEW_VENDOR_FINANCES then
            r.nameFS:SetText(itemData.itemName); r.nameFS:SetTextColor(pr,pg,pb)
            r.finCharacterFS:SetText(itemData.characterName); r.finCharacterFS:SetTextColor(pr,pg,pb)
            r.finRealmFS:SetText(itemData.characterRealm); r.finRealmFS:SetTextColor(pr,pg,pb)
            
            local prefix = (AL.currentActiveTab == AL.VIEW_AUCTION_FINANCES) and "Auction" or "Vendor"
            r.finTotalBoughtFS:SetText(itemData["total" .. prefix .. "BoughtQty"] or 0)
            r.finTotalSoldFS:SetText(itemData["total" .. prefix .. "SoldQty"] or 0)

            -- [[ FIX: Apply correct formatting based on the active tab ]]
            if AL.currentActiveTab == AL.VIEW_AUCTION_FINANCES then
                r.finTotalProfitFS:SetText(AL:FormatGoldAndSilverRoundedUp(itemData["total" .. prefix .. "Profit"] or 0))
                r.finTotalLossFS:SetText(AL:FormatGoldAndSilverRoundedUp(itemData["total" .. prefix .. "Loss"] or 0))
            else -- This covers AL.VIEW_VENDOR_FINANCES
                r.finTotalProfitFS:SetText(AL:FormatGoldWithIcons(itemData["total" .. prefix .. "Profit"] or 0))
                r.finTotalLossFS:SetText(AL:FormatGoldWithIcons(itemData["total" .. prefix .. "Loss"] or 0))
            end
            
            r.finTotalProfitFS:SetTextColor(unpack(AL.COLOR_PROFIT))
            r.finTotalLossFS:SetTextColor(unpack(AL.COLOR_LOSS))
            
        elseif AL.currentActiveTab == AL.VIEW_AUCTION_PRICING then
            r.nameFS:SetText(itemData.itemName); r.nameFS:SetTextColor(pr,pg,pb); r.apCharacterFS:SetText(itemData.characterName); r.apCharacterFS:SetTextColor(pr,pg,pb); r.apRealmFS:SetText(itemData.characterRealm); r.apRealmFS:SetTextColor(pr,pg,pb); if itemData.autoUpdateFromMarket then r.autoPricingCB:SetChecked(true) else r.autoPricingCB:SetChecked(false) end
        elseif AL.currentActiveTab == AL.VIEW_AUCTION_SETTINGS then
			r.nameFS:SetText(itemData.itemName); r.nameFS:SetTextColor(pr,pg,pb); r.asCharacterFS:SetText(itemData.characterName); r.asCharacterFS:SetTextColor(pr,pg,pb); r.asRealmFS:SetText(itemData.characterRealm); r.asRealmFS:SetTextColor(pr,pg,pb); local settings = itemData.auctionSettings; if settings then local isAnyDurationChecked = false; for _, btn in ipairs(r.durationButtons) do local savedDuration = settings.duration; if type(savedDuration) ~= "number" then savedDuration = tonumber(savedDuration) or 720 end; local isChecked = (btn.durationValue == savedDuration); btn:SetChecked(isChecked); if isChecked then isAnyDurationChecked = true end end; if not isAnyDurationChecked and #r.durationButtons > 0 then r.durationButtons[1]:SetChecked(true) end; local ok, stack = pcall(function() return select(8, GetItemInfo(itemData.itemLink or itemData.itemID)) end); local maxStack = (ok and tonumber(stack)) or 1; local isStackable = maxStack > 1; r.asStackableFS:SetText(isStackable and "Yes" or "No"); if isStackable then r.asQuantityEB:Show(); r.asQuantityFS_NA:Hide(); r.asQuantityEB:SetText(settings.quantity or 1) else r.asQuantityEB:Hide(); r.asQuantityFS_NA:Show(); r.asQuantityFS_NA:SetText("1") end end
        end
    end

    r:SetScript("OnEnter", function(s) GameTooltip:SetOwner(s, "ANCHOR_RIGHT"); if itemData.itemLink then GameTooltip:SetHyperlink(itemData.itemLink) else GameTooltip:SetItemByID(itemData.itemID) end; GameTooltip:Show() end)
    r:SetScript("OnLeave", function(s) GameTooltip:Hide() end)
    return r
end

-- [[ NEW VERSION: This function now processes rows in batches to prevent UI freezes. ]]
function AL:RefreshLedgerDisplay()
    if not self.ScrollChild or not AL.currentActiveTab or not _G.AL_SavedData.Settings.filterSettings[AL.currentActiveTab] then return end

    -- Cancel any previous refresh that might be in progress
    if self.rowCreationTimer then
        self.rowCreationTimer:Cancel()
        self.rowCreationTimer = nil
    end

    -- Clear existing rows and update the main layout
    for _, f in ipairs(self.itemRowFrames or {}) do f:Hide(); f:SetParent(nil) end
    wipe(self.itemRowFrames);
    self:UpdateLayout()

    -- This inner function will create a batch of rows
    local function ProcessRowBatch(displayData, startIndex)
        local batchSize = 30 -- Process 30 rows per batch
        local yOffset = (startIndex - 1) * AL.ITEM_ROW_HEIGHT

        for i = startIndex, math.min(startIndex + batchSize - 1, #displayData) do
            local entry = displayData[i]
            local isEvenRow = (#AL.itemRowFrames % 2 == 0)
            local rowFrame
            if entry.type == "parent" then
                rowFrame = AL:CreateItemRowFrame(AL.ScrollChild, entry.data, yOffset, isEvenRow, nil, true, entry.data.isExpanded)
            elseif entry.type == "child" then
                rowFrame = AL:CreateItemRowFrame(AL.ScrollChild, entry.data.original, yOffset, isEvenRow, entry.data.details, false)
            end

            if rowFrame then
                table.insert(AL.itemRowFrames, rowFrame)
                yOffset = yOffset + AL.ITEM_ROW_HEIGHT
                
                -- [[ This block was copied from the original function to set column visibility ]]
                local elements = {rowFrame.locationFS, rowFrame.ownedFS, rowFrame.notesFS, rowFrame.locCharacterFS, rowFrame.locRealmFS, rowFrame.finCharacterFS, rowFrame.finRealmFS, rowFrame.finTotalBoughtFS, rowFrame.finTotalSoldFS, rowFrame.finTotalProfitFS, rowFrame.finTotalLossFS, rowFrame.apCharacterFS, rowFrame.apRealmFS, rowFrame.autoPricingCB, rowFrame.safetyNetBuyoutInputs.container, rowFrame.normalBuyoutPriceInputs.container, rowFrame.undercutAmountInputs.container, rowFrame.asCharacterFS, rowFrame.asRealmFS, rowFrame.durationContainer, rowFrame.asStackableFS, rowFrame.asQuantityEB, rowFrame.asQuantityFS_NA, rowFrame.childDeleteButton, rowFrame.parentDeleteButton}; for _, el in ipairs(elements) do if el then el:Hide() end end; if AL.currentActiveTab == AL.VIEW_WARBAND_STOCK then if not rowFrame.isParentRow then rowFrame.locCharacterFS:Show(); rowFrame.locRealmFS:Show(); rowFrame.notesFS:Show(); rowFrame.locationFS:Show(); rowFrame.ownedFS:Show(); rowFrame.childDeleteButton:Show() else rowFrame.parentDeleteButton:Show() end elseif AL.currentActiveTab == AL.VIEW_AUCTION_FINANCES or AL.currentActiveTab == AL.VIEW_VENDOR_FINANCES then if not rowFrame.isParentRow then rowFrame.finCharacterFS:Show(); rowFrame.finRealmFS:Show(); rowFrame.finTotalBoughtFS:Show(); rowFrame.finTotalSoldFS:Show(); rowFrame.finTotalProfitFS:Show(); rowFrame.finTotalLossFS:Show() end elseif AL.currentActiveTab == AL.VIEW_AUCTION_PRICING then if not rowFrame.isParentRow then rowFrame.apCharacterFS:Show(); rowFrame.apRealmFS:Show(); rowFrame.autoPricingCB:Show(); rowFrame.safetyNetBuyoutInputs.container:Show(); rowFrame.normalBuyoutPriceInputs.container:Show(); rowFrame.undercutAmountInputs.container:Show() end elseif AL.currentActiveTab == AL.VIEW_AUCTION_SETTINGS then if not rowFrame.isParentRow then rowFrame.asCharacterFS:Show(); rowFrame.asRealmFS:Show(); rowFrame.durationContainer:Show(); rowFrame.asStackableFS:Show(); local itemData = entry.data.original; local ok, stack = pcall(function() return select(8, GetItemInfo(itemData.itemLink or itemData.itemID)) end); local maxStack = (ok and tonumber(stack)) or 1; local isStackable = maxStack > 1; if isStackable then rowFrame.asQuantityEB:Show(); rowFrame.asQuantityFS_NA:Hide() else rowFrame.asQuantityEB:Hide(); rowFrame.asQuantityFS_NA:Show() end end end
            end
        end

        -- Update the scroll child height
        AL.ScrollChild:SetHeight(math.max(10, #AL.itemRowFrames * AL.ITEM_ROW_HEIGHT))

        -- If there are more rows, schedule the next batch
        if startIndex + batchSize <= #displayData then
            AL.rowCreationTimer = C_Timer.After(0, function()
                ProcessRowBatch(displayData, startIndex + batchSize)
            end)
        else
            AL.rowCreationTimer = nil -- All done
        end
    end

    -- STEP 1: Gather and sort all data (this is fast)
    local finalDisplayData = {}
    local allCharacterEntries = {}
    for itemID, itemEntry in pairs(_G.AL_SavedData.Items or {}) do
        if tonumber(itemID) and type(itemEntry) == "table" and type(itemEntry.characters) == "table" then
            for charKey, charData in pairs(itemEntry.characters) do
                if type(charData) == "table" and (itemEntry.itemLink or charData.itemLink) then
                    table.insert(allCharacterEntries, {
                        itemID = itemID, itemLink = itemEntry.itemLink or charData.itemLink, itemName = itemEntry.itemName, itemTexture = itemEntry.itemTexture, itemRarity = itemEntry.itemRarity,
                        characterName = charData.characterName, characterRealm = charData.characterRealm, lastVerifiedLocation = charData.lastVerifiedLocation, lastVerifiedCount = charData.lastVerifiedCount, lastVerifiedTimestamp = charData.lastVerifiedTimestamp, awaitingMailAfterAuctionCancel = charData.awaitingMailAfterAuctionCancel,
                        safetyNetBuyout = charData.safetyNetBuyout or 0, normalBuyoutPrice = charData.normalBuyoutPrice or 0, undercutAmount = charData.undercutAmount or 0, auctionSettings = charData.auctionSettings or {duration=720, quantity=1}, autoUpdateFromMarket = charData.autoUpdateFromMarket,
                        totalAuctionBoughtQty = charData.totalAuctionBoughtQty or 0, totalAuctionSoldQty = charData.totalAuctionSoldQty or 0, totalAuctionProfit = charData.totalAuctionProfit or 0, totalAuctionLoss = charData.totalAuctionLoss or 0,
                        totalVendorBoughtQty = charData.totalVendorBoughtQty or 0, totalVendorSoldQty = charData.totalVendorSoldQty or 0, totalVendorProfit = charData.totalVendorProfit or 0, totalVendorLoss = charData.totalVendorLoss or 0,
                    })
                end
            end
        end
    end

    local currentFilters = _G.AL_SavedData.Settings.filterSettings[AL.currentActiveTab]
    local initialItemsToProcess = {}; local ok, err = pcall(function() if AL.currentActiveTab == AL.VIEW_WARBAND_STOCK then for _, entry in ipairs(allCharacterEntries) do table.insert(initialItemsToProcess, { original = entry, details = self:GetItemOwnershipDetails(entry) }) end else for _, entry in ipairs(allCharacterEntries) do table.insert(initialItemsToProcess, { original = entry }) end end end); if not ok then return end
    local itemsToProcess = {}; for _, item in ipairs(initialItemsToProcess) do local passesAllFilters = true; local filter_ok, filter_err = pcall(function() local qualityFilter = currentFilters.quality; if qualityFilter ~= nil and qualityFilter ~= -1 then if not (item.original.itemRarity == qualityFilter or (qualityFilter == 5 and item.original.itemRarity >= 5)) then passesAllFilters = false end end; if passesAllFilters and currentFilters.stack then local _, _, _, _, _, _, _, maxStack = GetItemInfo(item.original.itemLink or item.original.itemID); local isStackable = (tonumber(maxStack) or 1) > 1; if (currentFilters.stack == AL.FILTER_STACKABLE and not isStackable) or (currentFilters.stack == AL.FILTER_NONSTACKABLE and isStackable) then passesAllFilters = false end end end); if passesAllFilters then table.insert(itemsToProcess, item) end end
    
    if AL.currentActiveTab == AL.VIEW_WARBAND_STOCK and currentFilters.view == "GROUPED_BY_ITEM" then local groupedByItem = {}; for _, augmentedEntry in ipairs(itemsToProcess) do local itemID = augmentedEntry.original.itemID; if not groupedByItem[itemID] then groupedByItem[itemID] = {itemID = itemID, itemName = augmentedEntry.original.itemName, itemTexture = augmentedEntry.original.itemTexture, itemRarity = augmentedEntry.original.itemRarity, itemLink = augmentedEntry.original.itemLink, isExpanded = (_G.AL_SavedData.Settings.itemExpansionStates[itemID]) or false, characters = {}} end; table.insert(groupedByItem[itemID].characters, augmentedEntry) end; local parentRowDataForSorting = {}; for _, groupData in pairs(groupedByItem) do table.insert(parentRowDataForSorting, groupData) end; table.sort(parentRowDataForSorting, function(a,b) return (a.itemName or "") < (b.itemName or "") end); for _, groupData in ipairs(parentRowDataForSorting) do table.insert(finalDisplayData, {type = "parent", data = groupData}); if groupData.isExpanded then table.sort(groupData.characters, function(a,b) if a.original.characterName == b.original.characterName then return (a.original.characterRealm or "") < (b.original.characterRealm or "") end return (a.original.characterName or "") < (b.original.characterName or "") end); for _, childAugmentedEntry in ipairs(groupData.characters) do table.insert(finalDisplayData, {type = "child", data = childAugmentedEntry}) end end end
    else table.sort(itemsToProcess, function(a_entry, b_entry) local a, b = a_entry.original, b_entry.original; local a_name, b_name = a.itemName or "", b.itemName or ""; local a_char, b_char = a.characterName or "", b.characterName or ""; local a_realm, b_realm = a.characterRealm or "", b.characterRealm or ""; if AL.currentActiveTab == AL.VIEW_WARBAND_STOCK then if currentFilters.sort == AL.SORT_CHARACTER then if a_char ~= b_char then return a_char < b_char; end; if a_name ~= b_name then return a_name < b_name; end; return a_realm < b_realm; elseif currentFilters.sort == AL.SORT_REALM then if a_realm ~= b_realm then return a_realm < b_realm; end; if a_char ~= b_char then return a_char < b_char; end; return a_name < b_name; else local targetLoc; if currentFilters.sort == AL.SORT_BAGS then targetLoc = AL.LOCATION_BAGS elseif currentFilters.sort == AL.SORT_BANK then targetLoc = AL.LOCATION_BANK elseif currentFilters.sort == AL.SORT_MAIL then targetLoc = AL.LOCATION_MAIL elseif currentFilters.sort == AL.SORT_AUCTION then targetLoc = AL.LOCATION_AUCTION_HOUSE elseif currentFilters.sort == AL.SORT_LIMBO then targetLoc = AL.LOCATION_LIMBO elseif currentFilters.sort == AL.SORT_WARBAND_BANK then targetLoc = AL.LOCATION_WARBAND_BANK elseif currentFilters.sort == AL.SORT_REAGENT_BANK then targetLoc = AL.LOCATION_REAGENT_BANK end; if targetLoc then local aIsTarget = (a_entry.details and a_entry.details.locationText == targetLoc); local bIsTarget = (b_entry.details and b_entry.details.locationText == targetLoc); if aIsTarget and not bIsTarget then return true; end; if not aIsTarget and bIsTarget then return false; end; end end elseif AL.currentActiveTab == AL.VIEW_AUCTION_FINANCES or AL.currentActiveTab == AL.VIEW_VENDOR_FINANCES or AL.currentActiveTab == AL.VIEW_AUCTION_PRICING or AL.currentActiveTab == AL.VIEW_AUCTION_SETTINGS then if currentFilters.sort == AL.SORT_CHARACTER then if a_char ~= b_char then return a_char < b_char end elseif currentFilters.sort == AL.SORT_REALM then if a_realm ~= b_realm then return a_realm < b_realm end end end; if a_name ~= b_name then return a_name < b_name end; if a_char ~= b_char then return a_char < b_char end; return a_realm < b_realm end); for _, augmentedEntry in ipairs(itemsToProcess) do table.insert(finalDisplayData, {type = "child", data = augmentedEntry}) end end
    
    -- STEP 2: Start the asynchronous batch creation of UI elements
    if #finalDisplayData > 0 then
        ProcessRowBatch(finalDisplayData, 1)
    end
end

function AL:RefreshLedgerDisplay()
    if not self.ScrollChild or not AL.currentActiveTab or not _G.AL_SavedData.Settings.filterSettings[AL.currentActiveTab] then return end
    local currentFilters = _G.AL_SavedData.Settings.filterSettings[AL.currentActiveTab]
    for _, f in ipairs(self.itemRowFrames or {}) do f:Hide(); f:SetParent(nil) end
    wipe(self.itemRowFrames); local yOffset = 0; self:UpdateLayout()
    local finalDisplayData = {}; local allCharacterEntries = {}
    for itemID, itemEntry in pairs(_G.AL_SavedData.Items or {}) do
        if tonumber(itemID) and type(itemEntry) == "table" and type(itemEntry.characters) == "table" then
            for charKey, charData in pairs(itemEntry.characters) do
                if type(charData) == "table" and (itemEntry.itemLink or charData.itemLink) then
                    table.insert(allCharacterEntries, {
                        itemID = itemID, itemLink = itemEntry.itemLink or charData.itemLink, itemName = itemEntry.itemName, itemTexture = itemEntry.itemTexture, itemRarity = itemEntry.itemRarity,
                        characterName = charData.characterName, characterRealm = charData.characterRealm, lastVerifiedLocation = charData.lastVerifiedLocation, lastVerifiedCount = charData.lastVerifiedCount, lastVerifiedTimestamp = charData.lastVerifiedTimestamp, awaitingMailAfterAuctionCancel = charData.awaitingMailAfterAuctionCancel,
                        safetyNetBuyout = charData.safetyNetBuyout or 0, normalBuyoutPrice = charData.normalBuyoutPrice or 0, undercutAmount = charData.undercutAmount or 0, auctionSettings = charData.auctionSettings or {duration=720, quantity=1}, autoUpdateFromMarket = charData.autoUpdateFromMarket,
                        totalAuctionBoughtQty = charData.totalAuctionBoughtQty or 0, totalAuctionSoldQty = charData.totalAuctionSoldQty or 0, totalAuctionProfit = charData.totalAuctionProfit or 0, totalAuctionLoss = charData.totalAuctionLoss or 0,
                        totalVendorBoughtQty = charData.totalVendorBoughtQty or 0, totalVendorSoldQty = charData.totalVendorSoldQty or 0, totalVendorProfit = charData.totalVendorProfit or 0, totalVendorLoss = charData.totalVendorLoss or 0,
                    })
                end
            end
        end
    end
    
    local initialItemsToProcess = {}; local ok, err = pcall(function() if AL.currentActiveTab == AL.VIEW_WARBAND_STOCK then for _, entry in ipairs(allCharacterEntries) do table.insert(initialItemsToProcess, { original = entry, details = self:GetItemOwnershipDetails(entry) }) end else for _, entry in ipairs(allCharacterEntries) do table.insert(initialItemsToProcess, { original = entry }) end end end); if not ok then return end
    local itemsToProcess = {}; for _, item in ipairs(initialItemsToProcess) do local passesAllFilters = true; local filter_ok, filter_err = pcall(function() local qualityFilter = currentFilters.quality; if qualityFilter ~= nil and qualityFilter ~= -1 then if not (item.original.itemRarity == qualityFilter or (qualityFilter == 5 and item.original.itemRarity >= 5)) then passesAllFilters = false end end; if passesAllFilters and currentFilters.stack then local _, _, _, _, _, _, _, maxStack = GetItemInfo(item.original.itemLink or item.original.itemID); local isStackable = (tonumber(maxStack) or 1) > 1; if (currentFilters.stack == AL.FILTER_STACKABLE and not isStackable) or (currentFilters.stack == AL.FILTER_NONSTACKABLE and isStackable) then passesAllFilters = false end end end); if passesAllFilters then table.insert(itemsToProcess, item) end end
    if AL.currentActiveTab == AL.VIEW_WARBAND_STOCK and currentFilters.view == "GROUPED_BY_ITEM" then local groupedByItem = {}; for _, augmentedEntry in ipairs(itemsToProcess) do local itemID = augmentedEntry.original.itemID; if not groupedByItem[itemID] then groupedByItem[itemID] = {itemID = itemID, itemName = augmentedEntry.original.itemName, itemTexture = augmentedEntry.original.itemTexture, itemRarity = augmentedEntry.original.itemRarity, itemLink = augmentedEntry.original.itemLink, isExpanded = (_G.AL_SavedData.Settings.itemExpansionStates[itemID]) or false, characters = {}} end; table.insert(groupedByItem[itemID].characters, augmentedEntry) end; local parentRowDataForSorting = {}; for _, groupData in pairs(groupedByItem) do table.insert(parentRowDataForSorting, groupData) end; table.sort(parentRowDataForSorting, function(a,b) return (a.itemName or "") < (b.itemName or "") end); for _, groupData in ipairs(parentRowDataForSorting) do table.insert(finalDisplayData, {type = "parent", data = groupData}); if groupData.isExpanded then table.sort(groupData.characters, function(a,b) if a.original.characterName == b.original.characterName then return (a.original.characterRealm or "") < (b.original.characterRealm or "") end return (a.original.characterName or "") < (b.original.characterName or "") end); for _, childAugmentedEntry in ipairs(groupData.characters) do table.insert(finalDisplayData, {type = "child", data = childAugmentedEntry}) end end end
    else table.sort(itemsToProcess, function(a_entry, b_entry) local a, b = a_entry.original, b_entry.original; local a_name, b_name = a.itemName or "", b.itemName or ""; local a_char, b_char = a.characterName or "", b.characterName or ""; local a_realm, b_realm = a.characterRealm or "", b.characterRealm or ""; if AL.currentActiveTab == AL.VIEW_WARBAND_STOCK then if currentFilters.sort == AL.SORT_CHARACTER then if a_char ~= b_char then return a_char < b_char; end; if a_name ~= b_name then return a_name < b_name; end; return a_realm < b_realm; elseif currentFilters.sort == AL.SORT_REALM then if a_realm ~= b_realm then return a_realm < b_realm; end; if a_char ~= b_char then return a_char < b_char; end; return a_name < b_name; else local targetLoc; if currentFilters.sort == AL.SORT_BAGS then targetLoc = AL.LOCATION_BAGS elseif currentFilters.sort == AL.SORT_BANK then targetLoc = AL.LOCATION_BANK elseif currentFilters.sort == AL.SORT_MAIL then targetLoc = AL.LOCATION_MAIL elseif currentFilters.sort == AL.SORT_AUCTION then targetLoc = AL.LOCATION_AUCTION_HOUSE elseif currentFilters.sort == AL.SORT_LIMBO then targetLoc = AL.LOCATION_LIMBO elseif currentFilters.sort == AL.SORT_WARBAND_BANK then targetLoc = AL.LOCATION_WARBAND_BANK elseif currentFilters.sort == AL.SORT_REAGENT_BANK then targetLoc = AL.LOCATION_REAGENT_BANK end; if targetLoc then local aIsTarget = (a_entry.details and a_entry.details.locationText == targetLoc); local bIsTarget = (b_entry.details and b_entry.details.locationText == targetLoc); if aIsTarget and not bIsTarget then return true; end; if not aIsTarget and bIsTarget then return false; end; end end elseif AL.currentActiveTab == AL.VIEW_AUCTION_FINANCES or AL.currentActiveTab == AL.VIEW_VENDOR_FINANCES or AL.currentActiveTab == AL.VIEW_AUCTION_PRICING or AL.currentActiveTab == AL.VIEW_AUCTION_SETTINGS then if currentFilters.sort == AL.SORT_CHARACTER then if a_char ~= b_char then return a_char < b_char end elseif currentFilters.sort == AL.SORT_REALM then if a_realm ~= b_realm then return a_realm < b_realm end end end; if a_name ~= b_name then return a_name < b_name end; if a_char ~= b_char then return a_char < b_char end; return a_realm < b_realm end); for _, augmentedEntry in ipairs(itemsToProcess) do table.insert(finalDisplayData, {type = "child", data = augmentedEntry}) end end
    for i, entry in ipairs(finalDisplayData) do local isEvenRow = (#self.itemRowFrames % 2 == 0); local rowFrame; if entry.type == "parent" then rowFrame = self:CreateItemRowFrame(self.ScrollChild, entry.data, yOffset, isEvenRow, nil, true, entry.data.isExpanded) elseif entry.type == "child" then rowFrame = self:CreateItemRowFrame(self.ScrollChild, entry.data.original, yOffset, isEvenRow, entry.data.details, false) end; if rowFrame then table.insert(self.itemRowFrames, rowFrame); yOffset = yOffset + AL.ITEM_ROW_HEIGHT; local elements = {rowFrame.locationFS, rowFrame.ownedFS, rowFrame.notesFS, rowFrame.locCharacterFS, rowFrame.locRealmFS, rowFrame.finCharacterFS, rowFrame.finRealmFS, rowFrame.finTotalBoughtFS, rowFrame.finTotalSoldFS, rowFrame.finTotalProfitFS, rowFrame.finTotalLossFS, rowFrame.apCharacterFS, rowFrame.apRealmFS, rowFrame.autoPricingCB, rowFrame.safetyNetBuyoutInputs.container, rowFrame.normalBuyoutPriceInputs.container, rowFrame.undercutAmountInputs.container, rowFrame.asCharacterFS, rowFrame.asRealmFS, rowFrame.durationContainer, rowFrame.asStackableFS, rowFrame.asQuantityEB, rowFrame.asQuantityFS_NA, rowFrame.childDeleteButton, rowFrame.parentDeleteButton}; for _, el in ipairs(elements) do if el then el:Hide() end end; if AL.currentActiveTab == AL.VIEW_WARBAND_STOCK then if not rowFrame.isParentRow then rowFrame.locCharacterFS:Show(); rowFrame.locRealmFS:Show(); rowFrame.notesFS:Show(); rowFrame.locationFS:Show(); rowFrame.ownedFS:Show(); rowFrame.childDeleteButton:Show() else rowFrame.parentDeleteButton:Show() end elseif AL.currentActiveTab == AL.VIEW_AUCTION_FINANCES or AL.currentActiveTab == AL.VIEW_VENDOR_FINANCES then if not rowFrame.isParentRow then rowFrame.finCharacterFS:Show(); rowFrame.finRealmFS:Show(); rowFrame.finTotalBoughtFS:Show(); rowFrame.finTotalSoldFS:Show(); rowFrame.finTotalProfitFS:Show(); rowFrame.finTotalLossFS:Show() end elseif AL.currentActiveTab == AL.VIEW_AUCTION_PRICING then if not rowFrame.isParentRow then rowFrame.apCharacterFS:Show(); rowFrame.apRealmFS:Show(); rowFrame.autoPricingCB:Show(); rowFrame.safetyNetBuyoutInputs.container:Show(); rowFrame.normalBuyoutPriceInputs.container:Show(); rowFrame.undercutAmountInputs.container:Show() end elseif AL.currentActiveTab == AL.VIEW_AUCTION_SETTINGS then if not rowFrame.isParentRow then rowFrame.asCharacterFS:Show(); rowFrame.asRealmFS:Show(); rowFrame.durationContainer:Show(); rowFrame.asStackableFS:Show(); local itemData = entry.data.original; local ok, stack = pcall(function() return select(8, GetItemInfo(itemData.itemLink or itemData.itemID)) end); local maxStack = (ok and tonumber(stack)) or 1; local isStackable = maxStack > 1; if isStackable then rowFrame.asQuantityEB:Show(); rowFrame.asQuantityFS_NA:Hide() else rowFrame.asQuantityEB:Hide(); rowFrame.asQuantityFS_NA:Show() end end end end end
    self.ScrollChild:SetHeight(math.max(10, #self.itemRowFrames * AL.ITEM_ROW_HEIGHT))
end
