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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA19FC433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 23:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B25AF613DE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 23:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhDWXye (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Apr 2021 19:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhDWXyb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Apr 2021 19:54:31 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51647C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Apr 2021 16:53:54 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id kb13-20020a17090ae7cdb02901503d67f0beso5248301pjb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Apr 2021 16:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DRCnyaUPkJedmZNFFFo2zFLByhzwZOSPcPNKaj0YSLg=;
        b=ZQ4GxJa8XlaYvrlOkZz7+8dnCUSOUwTlkf9vkdO5naODe9CUfpwRlLoRIEqXMwlB1N
         jbZRpjeQ5FLUVgpHAZNoz/vIoWvX+/D5uvTLzxIzbaDgk2p9f11f73R9VSc5dRSC7PvQ
         +KgvqP6USgI/v8HIBPUov4TaB27TXzm2op5MfQUAIdkMfe2TZJdmbFKCJjUjh5oNVy7O
         0a7RCW0Wvo02T5QSI1AdN4F4G+4LVXz3MTUVeayvhsEksxVL7O4QTAYtxrmlTc0NwdPH
         dZ5q7YGYzQ+D6+RSzpqmTcJmOiARzz9tSO6DUAL2mx5l3ao1eXC1zrI14eSa2Ag2opNC
         O5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DRCnyaUPkJedmZNFFFo2zFLByhzwZOSPcPNKaj0YSLg=;
        b=VYhzL4PrYdp01SACEoUu/6b7SJ2qkywGDdqGzbGKfx/lCSZFRVpgEpbwTHNO34f5X0
         WaNHDzLGRZ96Esp/c9ec/S5Bp+Oo62v9v2uZCWbj8TZzabMRCEQsl08CeQs5R51cFZO7
         6MQcZwRgS26XUpW4lfKFkrx99OiWXG5/Q46NRnXNt/NCzplTfaxxjH+VdCVRSvKZ9V3H
         g57HBjJCOx9LQloe7zwQjphNSK9NBK9j1CEUc5gLr77K+SoaMJ9MHGXdZSKrG5sg0MRn
         1aKQz+3SOmFqlbqbnP/Jj2A+1VVdRnKADYZHdJTalNLuwjVBUsm7h7a31D8h+IZF39ET
         pUIw==
X-Gm-Message-State: AOAM531hxsfkqXYmelAvUYfrcq81fKq6pvtpD8xZHfqTQfJ6DAwH7LlZ
        lrtYTgFQBbil+8ut9ZYFA36v5FhzNIo=
X-Google-Smtp-Source: ABdhPJxQjbqmNV+MlBAF6Jkh2EGqw5ecowQPYrIzSl89F/rDPC5M62Xhgfcd3F7lP9lcuVyCW7+Ekg==
X-Received: by 2002:a17:90a:420d:: with SMTP id o13mr8582884pjg.61.1619222033657;
        Fri, 23 Apr 2021 16:53:53 -0700 (PDT)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:d830:3e1c:a9e3:7268:3bbf])
        by smtp.gmail.com with ESMTPSA id v64sm5792318pfc.117.2021.04.23.16.53.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 16:53:53 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 1/3] emulator/btdev: Add missing commands
Date:   Fri, 23 Apr 2021 16:53:50 -0700
Message-Id: <20210423235352.33965-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds missing commands HCI_Read_RSSI and
HCI_Read_Transmit_Power_Level commands.
---
 emulator/btdev.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index b4ed0e909..b21d5ca75 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -2013,6 +2013,24 @@ static int cmd_write_voice(struct btdev *dev, const void *data, uint8_t len)
 	return 0;
 }
 
+static int cmd_read_tx_power_level(struct btdev *dev, const void *data,
+				   uint8_t len)
+{
+	const struct bt_hci_cmd_read_tx_power *cmd = data;
+	struct bt_hci_rsp_read_tx_power rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.handle = le16_to_cpu(cmd->handle);
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	if (cmd->type)
+		rsp.level = 4;
+	else
+		rsp.level = -1;
+	cmd_complete(dev, BT_HCI_CMD_READ_TX_POWER, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
 static int cmd_read_num_iac(struct btdev *dev, const void *data, uint8_t len)
 {
 	struct bt_hci_rsp_read_num_supported_iac rsp;
@@ -2182,6 +2200,21 @@ static int cmd_read_country_code(struct btdev *dev, const void *data,
 	return 0;
 }
 
+static int cmd_read_rssi(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_read_rssi *cmd = data;
+	struct bt_hci_rsp_read_rssi rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.handle = le16_to_cpu(cmd->handle);
+	rsp.rssi = -1;
+	cmd_complete(dev, BT_HCI_CMD_READ_RSSI, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
 static int cmd_enable_dut_mode(struct btdev *dev, const void *data,
 							uint8_t len)
 {
@@ -2259,6 +2292,7 @@ static int cmd_enable_dut_mode(struct btdev *dev, const void *data,
 	CMD(BT_HCI_CMD_WRITE_CLASS_OF_DEV, cmd_write_class, NULL), \
 	CMD(BT_HCI_CMD_READ_VOICE_SETTING, cmd_read_voice, NULL), \
 	CMD(BT_HCI_CMD_WRITE_VOICE_SETTING, cmd_write_voice, NULL), \
+	CMD(BT_HCI_CMD_READ_TX_POWER, cmd_read_tx_power_level, NULL), \
 	CMD(BT_HCI_CMD_READ_NUM_SUPPORTED_IAC, cmd_read_num_iac, NULL), \
 	CMD(BT_HCI_CMD_READ_CURRENT_IAC_LAP, cmd_read_current_iac_lap, \
 					NULL), \
@@ -2273,6 +2307,7 @@ static int cmd_enable_dut_mode(struct btdev *dev, const void *data,
 	CMD(BT_HCI_CMD_READ_LOCAL_EXT_FEATURES, cmd_read_local_ext_features, \
 					NULL), \
 	CMD(BT_HCI_CMD_READ_COUNTRY_CODE, cmd_read_country_code, NULL), \
+	CMD(BT_HCI_CMD_READ_RSSI, cmd_read_rssi, NULL), \
 	CMD(BT_HCI_CMD_ENABLE_DUT_MODE, cmd_enable_dut_mode, NULL)
 
 static void set_common_commands_bredr20(struct btdev *btdev)
@@ -2319,6 +2354,7 @@ static void set_common_commands_bredr20(struct btdev *btdev)
 	btdev->commands[9]  |= 0x02;	/* Write Class Of Device */
 	btdev->commands[9]  |= 0x04;	/* Read Voice Setting */
 	btdev->commands[9]  |= 0x08;	/* Write Voice Setting */
+	btdev->commands[10] |= 0x04;	/* Read TX Power Level */
 	btdev->commands[11] |= 0x04;	/* Read Number of Supported IAC */
 	btdev->commands[11] |= 0x08;	/* Read Current IAC LAP */
 	btdev->commands[11] |= 0x10;	/* Write Current IAC LAP */
@@ -2330,6 +2366,7 @@ static void set_common_commands_bredr20(struct btdev *btdev)
 	btdev->commands[13] |= 0x08;	/* Write AFH Assess Mode */
 	btdev->commands[14] |= 0x40;	/* Read Local Extended Features */
 	btdev->commands[15] |= 0x01;	/* Read Country Code */
+	btdev->commands[15] |= 0x20;	/* Read RSSI */
 	btdev->commands[16] |= 0x04;	/* Enable Device Under Test Mode */
 }
 
-- 
2.25.1

