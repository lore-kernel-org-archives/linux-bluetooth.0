Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD933C12002
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 23:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEC9461396
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 23:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbhGOAB2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jul 2021 20:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhGOAB1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jul 2021 20:01:27 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5A4C061762
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 16:58:34 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id q10so3451099pfj.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 16:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PbiiiM8zip/W7X26lU1NxZPBKk6n2vAUfcryPqy6b+M=;
        b=RhzoM+QMXBtR0IH9A7mkTuRY5vol2HXJjZRpvlXbsSme0m8mZkaxBLzE0Oowdo9TMP
         kvJOsJlWC7QIyL5XbmVv0PCYFlu5fv/2Ocsg37JJgchd99HiU8mTSnmUeUapDsDNaSiq
         yzZSRTZShX0fJXg9ju5kzeMBYi9r0zDPTyTlhuRwePOClecaBtHQqAeCVyaULMK3XFcT
         K6Owcw73gPM85vVJwU96ao7w4aypd8JHVsK2hSQ6JEOMdxfhfL/VI1P1urz2XOmqDW2S
         S1EA0jYzCPlpKjlecdgBbK08XAUi5qe0n+lVwjJES5xm81yEq1V6RIv/j+zIiRTVE9RJ
         Yx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PbiiiM8zip/W7X26lU1NxZPBKk6n2vAUfcryPqy6b+M=;
        b=CWcQ7bAiiDHPSL1Cj8Fl/bfd14BCRFUrcc4gIJqGWr+Anh0Twkzy6OLrUhcb/s8YF9
         95IggxyF3acd+5ncJ7cqEt7fYZ+EwvH1nbNlKeeK9BTsHJoFcyD1CYGpX17Hd2RCSAom
         phHhzRI0CSsZ2uJ5pMRffc9CaAkWVzTBCDgjqOo5tpooCfM5o6Ic/tQs7wHrBfJi5jyw
         vQYjromL+3zzm24IF2QnebHHTD3/KoL/bdzDTzUfV+rqlXyIfBE9azNSmH87x0WU9/gw
         7uOKrUJ7X6Atbi3nL/Cf7UcDsoppwXb4B6LKOT/n/bUnLYvtGNKqdUbdlZExI4cEAdqV
         LoiA==
X-Gm-Message-State: AOAM532vyBiGb5uVC7ZIUAE3fBCTckTzRKN5UOn/o0hjMlBOTlmPRSx+
        vTK/bi7aPPop38nn35RrIwRpcKwyso6Aw/cg
X-Google-Smtp-Source: ABdhPJxvkji2tzOwIi2Kg29vDnEe9CqxtIngfNl8PFGB+fcAFU/GpSrSODmFGnMimJDoAGwOfzZd6A==
X-Received: by 2002:a65:6a4c:: with SMTP id o12mr636538pgu.108.1626307114036;
        Wed, 14 Jul 2021 16:58:34 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x30sm4008580pfh.126.2021.07.14.16.58.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 16:58:33 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] btdev: Add proper checks for own_addr_type for LE (extended) scan
Date:   Wed, 14 Jul 2021 16:58:32 -0700
Message-Id: <20210714235832.2992619-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

own_addr_type 0x01 and 0x03 shall check that a random address has
properly been set:

BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 4, Part E
page 2496:

  'If LE_Scan_Enable is set to 0x01, the scanning parameters'
  Own_Address_Type parameter is set to 0x01 or 0x03, and the random
  ddress for the device has not been initialized, the Controller shall
  return the error code Invalid HCI Command Parameters (0x12).'

BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 4, Part E
page 2614:

  'If Enable is set to 0x01, the scanning parameters' Own_Address_Type
  parameter is set to 0x01 or 0x03, and the random address for the
  device has not been initialized, the Controller shall return the
  error code Invalid HCI Command Parameters (0x12).'
---
 emulator/btdev.c | 101 ++++++++++++++++++++++++++++++++++++-----------
 src/main.conf    |   4 +-
 2 files changed, 81 insertions(+), 24 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index abd0263d1..e4612ec9e 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -3220,10 +3220,28 @@ static void le_set_adv_enable_complete(struct btdev *btdev)
 	}
 }
 
+#define RL_ADDR_EQUAL(_rl, _type, _addr) \
+	(_rl->type == _type && !bacmp(&_rl->addr, (bdaddr_t *)_addr))
+
+static struct btdev_rl *rl_find(struct btdev *dev, uint8_t type, uint8_t *addr)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(dev->le_rl); i++) {
+		struct btdev_rl *rl = &dev->le_rl[i];
+
+		if (RL_ADDR_EQUAL(rl, type, addr))
+			return rl;
+	}
+
+	return NULL;
+}
+
 static int cmd_set_adv_enable(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_set_ext_adv_enable *cmd = data;
 	uint8_t status;
+	bool random_addr;
 
 	if (dev->le_adv_enable == cmd->enable) {
 		status = BT_HCI_ERR_COMMAND_DISALLOWED;
@@ -3233,6 +3251,36 @@ static int cmd_set_adv_enable(struct btdev *dev, const void *data, uint8_t len)
 	dev->le_adv_enable = cmd->enable;
 	status = BT_HCI_ERR_SUCCESS;
 
+	if (!cmd->enable)
+		goto done;
+
+	random_addr = bacmp((bdaddr_t *)dev->random_addr, BDADDR_ANY);
+
+	/* If Advertising_Enable is set to 0x01, the advertising parameters'
+	 * Own_Address_Type parameter is set to 0x01, and the random address for
+	 * the device has not been initialized, the Controller shall return the
+	 * error code Invalid HCI Command Parameters (0x12).
+	 */
+	if (dev->le_adv_own_addr == 0x01 && !random_addr) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	/* If Advertising_Enable is set to 0x01, the advertising parameters'
+	 * Own_Address_Type parameter is set to 0x03, the controller's resolving
+	 * list did not contain a matching entry, and the random address for the
+	 * device has not been initialized, the Controller shall return the
+	 * error code Invalid HCI Command Parameters (0x12).
+	 */
+	if (dev->le_adv_own_addr == 0x03 && !random_addr) {
+		if (!dev->le_rl_enable ||
+				!rl_find(dev, dev->le_adv_direct_addr_type,
+					dev->le_adv_direct_addr)) {
+			status = BT_HCI_ERR_INVALID_PARAMETERS;
+			goto done;
+		}
+	}
+
 done:
 	cmd_complete(dev, BT_HCI_CMD_LE_SET_ADV_ENABLE, &status,
 						sizeof(status));
@@ -3275,6 +3323,18 @@ static int cmd_set_scan_enable(struct btdev *dev, const void *data, uint8_t len)
 		goto done;
 	}
 
+	/* If LE_Scan_Enable is set to 0x01, the scanning parameters'
+	 * Own_Address_Type parameter is set to 0x01 or 0x03, and the random
+	 * address for the device has not been initialized, the Controller shall
+	 * return the error code Invalid HCI Command Parameters (0x12).
+	 */
+	if ((dev->le_scan_own_addr_type == 0x01 ||
+			dev->le_scan_own_addr_type == 0x03) &&
+			!bacmp((bdaddr_t *)dev->random_addr, BDADDR_ANY)) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
 	dev->le_scan_enable = cmd->enable;
 	dev->le_filter_dup = cmd->filter_dup;
 	status = BT_HCI_ERR_SUCCESS;
@@ -3586,9 +3646,6 @@ static int cmd_remove_wl(struct btdev *dev, const void *data, uint8_t len)
 	return 0;
 }
 
-#define RL_ADDR_EQUAL(_rl, _type, _addr) \
-	(_rl->type == _type && !bacmp(&_rl->addr, (bdaddr_t *)_addr))
-
 static int cmd_add_rl(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_add_to_resolv_list *cmd = data;
@@ -4538,20 +4595,6 @@ static bool ext_adv_timeout(void *user_data)
 	return false;
 }
 
-static struct btdev_rl *rl_find(struct btdev *dev, uint8_t type, uint8_t *addr)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(dev->le_rl); i++) {
-		struct btdev_rl *rl = &dev->le_rl[i];
-
-		if (RL_ADDR_EQUAL(rl, type, addr))
-			return rl;
-	}
-
-	return NULL;
-}
-
 static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
 							uint8_t len)
 {
@@ -4819,14 +4862,28 @@ static int cmd_set_ext_scan_enable(struct btdev *dev, const void *data,
 	const struct bt_hci_cmd_le_set_ext_scan_enable *cmd = data;
 	uint8_t status;
 
-	if (dev->le_scan_enable == cmd->enable)
+	if (dev->le_scan_enable == cmd->enable) {
 		status = BT_HCI_ERR_COMMAND_DISALLOWED;
-	else {
-		dev->le_scan_enable = cmd->enable;
-		dev->le_filter_dup = cmd->filter_dup;
-		status = BT_HCI_ERR_SUCCESS;
+		goto done;
+	}
+
+	/* If Enable is set to 0x01, the scanning parameters' Own_Address_Type
+	 * parameter is set to 0x01 or 0x03, and the random address for the
+	 * device has not been initialized, the Controller shall return the
+	 * error code Invalid HCI Command Parameters (0x12).
+	 */
+	if ((dev->le_scan_own_addr_type == 0x01 ||
+			dev->le_scan_own_addr_type == 0x03) &&
+			!bacmp((bdaddr_t *)dev->random_addr, BDADDR_ANY)) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
 	}
 
+	dev->le_scan_enable = cmd->enable;
+	dev->le_filter_dup = cmd->filter_dup;
+	status = BT_HCI_ERR_SUCCESS;
+
+done:
 	cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE, &status,
 							sizeof(status));
 
diff --git a/src/main.conf b/src/main.conf
index 198899541..791b0f909 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -70,7 +70,7 @@
 # Possible values: "off", "device", "network"
 # "network" option not supported currently
 # Defaults to "off"
-# Privacy = off
+Privacy = device
 
 # Specify the policy to the JUST-WORKS repairing initiated by peer
 # Possible values: "never", "confirm", "always"
@@ -88,7 +88,7 @@
 
 # Enables experimental features and interfaces.
 # Defaults to false.
-#Experimental = false
+Experimental = true
 
 [BR]
 # The following values are used to load default adapter parameters for BR/EDR.
-- 
2.31.1

