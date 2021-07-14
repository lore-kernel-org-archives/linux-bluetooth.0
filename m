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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9C4C07E9A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 07:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E05613B2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 07:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbhGNHkV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jul 2021 03:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbhGNHkU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jul 2021 03:40:20 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC114C06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 00:37:28 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id a127so1238259pfa.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 00:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HdgKpk+Ln/9f2wngtLzKKPkXrdHKx0yUPKfG2qrr/E8=;
        b=SBOJ1z1XDP+Rzq9qgq9O9gg4BbuhHbL3Bg2DLlDfm+4HR0QliQUhAieJ0tXTFDGQgs
         hs03PRtG/u10nsIbc/NPXlz8xbzKRk5VOON+VIqIKM1GtSHTvgGIj1xjhH9ijVwVKmT4
         oG+Aft3bgTJerMogJ5H5u1ZVDeAIMTysen9vVxDcVtbQa5o52ZrsBK+OmmhsPaUXP+s0
         CYh1rRl4fYC4R0+zT1WlZbPLqn1+luYpnwJFXeLVll5XcRJoxa8H4vS8dTNnqXBai5ni
         OnCLDroYFpTyg7DfZhAZdrFtoqgHqHWfaD8Au6uzSbIImgmIyJ8mK2WNHHUzjf9WWk9Y
         N82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HdgKpk+Ln/9f2wngtLzKKPkXrdHKx0yUPKfG2qrr/E8=;
        b=HnL7LUnBTX9TEVrDlScB1kJrmT7UlJhROmjdMXPegwPmfMB0FkMv0U4I2baLOtOTJ1
         57yVNI0jZOWkTJETEy1eXEiHX/pdnbTPj8bdlrvc056sdhKyCfTBrxO4bYZYunTLjryY
         kThFaWmcBKvXr42F04BMFKpRgrfPqeRD75BEqHgDKymF9i1Gtn63O9jOH6+Ukrosu/N3
         NIuJjhQXRGaZ9E37NEUsVczGAW8ib9MCwhGXVU4te2QeOk7qqQre6z358wBNwT6d8/fm
         mp3sSdlspU7c4kEE8T7JO7ljYXVr5MiWnsFLHrH2P4TaWwYOYzM9HVev8b5Ct0sLGn7d
         zV+Q==
X-Gm-Message-State: AOAM530DssSGWrFnHQNjtlGN9dTUTIIWY7EosWd6aMZ3QbTTBECPrX5O
        Yi1mn+o1bp8cSQTlyrwHc94AIDyCLX0=
X-Google-Smtp-Source: ABdhPJx+Skgt4DmbamgodE7jPnNdbJ6UyioIAyrUgBPUX/RcFK1zzU5wmGH4fzFcNrDjYG55BpnQww==
X-Received: by 2002:a05:6a00:21c6:b029:2ff:e9:94f0 with SMTP id t6-20020a056a0021c6b02902ff00e994f0mr8742399pfj.73.1626248248138;
        Wed, 14 Jul 2021 00:37:28 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::614f])
        by smtp.gmail.com with ESMTPSA id 10sm1542612pfh.174.2021.07.14.00.37.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 00:37:27 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v7 1/2] emulator: Add support to config the white and resolve list
Date:   Wed, 14 Jul 2021 00:37:25 -0700
Message-Id: <20210714073726.169006-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds interfaces to config the white list and resolve list in
the btdev.
---
 emulator/btdev.c  | 41 +++++++++++++++++++++++++++++++----------
 emulator/btdev.h  |  4 ++++
 emulator/hciemu.c | 16 ++++++++++++++++
 emulator/hciemu.h |  4 ++++
 4 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index a7fda2c89..e29ef2762 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -33,8 +33,8 @@
 #include "monitor/bt.h"
 #include "btdev.h"
 
-#define WL_SIZE			16
-#define RL_SIZE			16
+#define WL_SIZE			3
+#define RL_SIZE			4
 #define CIS_SIZE		3
 
 #define has_bredr(btdev)	(!((btdev)->features[4] & 0x20))
@@ -190,6 +190,10 @@ struct btdev {
 	} __attribute__ ((packed)) le_cig;
 	uint8_t  le_iso_path[2];
 
+	/* Real time length of WL array */
+	uint8_t le_wl_len;
+	/* Real time length of RL array */
+	uint8_t le_rl_len;
 	struct btdev_wl le_wl[WL_SIZE];
 	struct btdev_rl le_rl[RL_SIZE];
 	uint8_t  le_rl_enable;
@@ -456,6 +460,18 @@ static void rl_clear(struct btdev *dev)
 		rl_reset(&dev->le_rl[i]);
 }
 
+/* Set the real time length of WL array */
+void btdev_set_wl_len(struct btdev *btdev, uint8_t len)
+{
+	btdev->le_wl_len = len;
+}
+
+/* Set the real time length of RL array */
+void btdev_set_rl_len(struct btdev *btdev, uint8_t len)
+{
+	btdev->le_rl_len = len;
+}
+
 static void btdev_reset(struct btdev *btdev)
 {
 	/* FIXME: include here clearing of all states that should be
@@ -467,6 +483,9 @@ static void btdev_reset(struct btdev *btdev)
 
 	wl_clear(btdev);
 	rl_clear(btdev);
+
+	btdev->le_wl_len = WL_SIZE;
+	btdev->le_rl_len = RL_SIZE;
 }
 
 static int cmd_reset(struct btdev *dev, const void *data, uint8_t len)
@@ -3404,7 +3423,7 @@ static int cmd_read_wl_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_white_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = WL_SIZE;
+	rsp.size = dev->le_wl_len;
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE, &rsp,
 						sizeof(rsp));
 
@@ -3491,7 +3510,7 @@ static int cmd_add_wl(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < WL_SIZE; i++) {
+	for (i = 0; i < dev->le_wl_len; i++) {
 		struct btdev_wl *wl = &dev->le_wl[i];
 
 		if (WL_ADDR_EQUAL(wl, cmd->addr_type, &cmd->addr)) {
@@ -3542,7 +3561,7 @@ static int cmd_remove_wl(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < WL_SIZE; i++) {
+	for (i = 0; i < dev->le_wl_len; i++) {
 		struct btdev_wl *wl = &dev->le_wl[i];
 
 		ba2str(&wl->addr, addr);
@@ -3557,7 +3576,7 @@ static int cmd_remove_wl(struct btdev *dev, const void *data, uint8_t len)
 		}
 	}
 
-	if (i == WL_SIZE)
+	if (i == dev->le_wl_len)
 		return -EINVAL;
 
 	status = BT_HCI_ERR_SUCCESS;
@@ -3591,7 +3610,7 @@ static int cmd_add_rl(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < RL_SIZE; i++) {
+	for (i = 0; i < dev->le_rl_len; i++) {
 		struct btdev_rl *rl = &dev->le_rl[i];
 
 		if (RL_ADDR_EQUAL(rl, cmd->addr_type, &cmd->addr)) {
@@ -3642,7 +3661,7 @@ static int cmd_remove_rl(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < RL_SIZE; i++) {
+	for (i = 0; i < dev->le_rl_len; i++) {
 		struct btdev_rl *rl = &dev->le_rl[i];
 
 		if (RL_ADDR_EQUAL(rl, cmd->addr_type, &cmd->addr)) {
@@ -3651,7 +3670,7 @@ static int cmd_remove_rl(struct btdev *dev, const void *data, uint8_t len)
 		}
 	}
 
-	if (i == RL_SIZE)
+	if (i == dev->le_rl_len)
 		return -EINVAL;
 
 	status = BT_HCI_ERR_SUCCESS;
@@ -3689,7 +3708,7 @@ static int cmd_read_rl_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_resolv_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = RL_SIZE;
+	rsp.size = dev->le_rl_len;
 
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_RESOLV_LIST_SIZE,
 							&rsp, sizeof(rsp));
@@ -6034,6 +6053,8 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	btdev->conns = queue_new();
 	btdev->le_ext_adv = queue_new();
 
+	btdev->le_wl_len = WL_SIZE;
+	btdev->le_rl_len = RL_SIZE;
 	return btdev;
 }
 
diff --git a/emulator/btdev.h b/emulator/btdev.h
index f7cba149a..b427a3a66 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -80,6 +80,10 @@ uint8_t btdev_get_le_scan_enable(struct btdev *btdev);
 
 void btdev_set_le_states(struct btdev *btdev, const uint8_t *le_states);
 
+void btdev_set_wl_len(struct btdev *btdev, uint8_t len);
+
+void btdev_set_rl_len(struct btdev *btdev, uint8_t len);
+
 void btdev_set_command_handler(struct btdev *btdev, btdev_command_func handler,
 							void *user_data);
 
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index a3ec44243..b8d85bb23 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -580,6 +580,22 @@ void hciemu_set_master_le_states(struct hciemu *hciemu, const uint8_t *le_states
 	btdev_set_le_states(hciemu->dev, le_states);
 }
 
+void hciemu_set_master_le_wl_len(struct hciemu *hciemu, uint8_t len)
+{
+	if (!hciemu || !hciemu->dev)
+		return;
+
+	btdev_set_wl_len(hciemu->dev, len);
+}
+
+void hciemu_set_master_le_rl_len(struct hciemu *hciemu, uint8_t len)
+{
+	if (!hciemu || !hciemu->dev)
+		return;
+
+	btdev_set_rl_len(hciemu->dev, len);
+}
+
 bool hciemu_add_master_post_command_hook(struct hciemu *hciemu,
 			hciemu_command_func_t function, void *user_data)
 {
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index 8bf2d070e..4a89b8d59 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -60,6 +60,10 @@ uint8_t hciemu_get_master_le_scan_enable(struct hciemu *hciemu);
 void hciemu_set_master_le_states(struct hciemu *hciemu,
 						const uint8_t *le_states);
 
+void hciemu_set_master_le_wl_len(struct hciemu *hciemu, uint8_t len);
+
+void hciemu_set_master_le_rl_len(struct hciemu *hciemu, uint8_t len);
+
 typedef void (*hciemu_command_func_t)(uint16_t opcode, const void *data,
 						uint8_t len, void *user_data);
 
-- 
2.26.3

