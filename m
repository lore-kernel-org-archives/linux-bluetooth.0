Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CE5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Oct 2021 19:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C4660F9C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Oct 2021 19:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbhJGTil (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Oct 2021 15:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhJGTij (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Oct 2021 15:38:39 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC26EC061570
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Oct 2021 12:36:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c29so6219672pfp.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Oct 2021 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dbUp97nMAfJPEEwmtIjAMFsS49UNI7EM1PidaU6Ju/k=;
        b=ig8jwlIo5nZZwMZeyx4zUd+EA7muRc2s7O/6oAS8N0cVXQTHK1fdid//ip/cOQLs7c
         kGSFQPXb2+vuscgH5a3jNTx0oTBl4xBzaQQGz1JgWgFIY589DqHgSNPFYObpk2IQvMYf
         3y7KWG/lZlKO3UgnTMCl1SLc4YBiQHfuS6xtegth045fX4+UbZ7x+307XcK9AKG8T6nD
         xKdm/L5LKvYAgi2Rrg8gk4UDg0y2jZ4OE0LIW1BOCLrXpQxZg9p1eFpZ++Xyn4yQ85zF
         SkUWy/rgrdktFfMWsz3hW8e1BTU2zhoct0vndNEHG8jd6AemkAl1qn5i/BQvfD6W9NPb
         Nh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dbUp97nMAfJPEEwmtIjAMFsS49UNI7EM1PidaU6Ju/k=;
        b=ruQam2w56cD5k5yVXS1aFTxn+imZAO2xGY4Z8ksDMTv4xFgVZF2jj8ZNWpFUBboDmK
         0/Hum3cC9LmVjBqLQnYUD3rvyDKWBdiKeE65yy7opxZ8tt0IRnPCDyAwVt3SsLhJwlz0
         ckfgJyxBD5HKjqT2a+H0P2BJZU/1RI0iDLPWAmuqYFrW5abU92b/74a07GnjGbgZ4kyY
         XBvUaGLE6WsRSY0pSm/gn8sopT5NdDceRj0KNyygLqVEpcUo6pGhdQrBB2IOza+VMUQq
         eOfRZxG4zMWF6XYTR2IFlFHAMcY1ohbJmvgirpeqYLhb6eYKwHWJX7sAEUUIonkhm6yV
         /9qQ==
X-Gm-Message-State: AOAM531+uaRUP+onLy/tr6IGxy+QhR7zMrwrW6D537sUI01iaP+cIBDW
        /V+wvu6DSUu6L7dbKrD1D9xMQfIjFgnrCQ==
X-Google-Smtp-Source: ABdhPJx3/VKHMcC67SZgx7mgLeZnPNyaUXFy+xm8gvdcD810urlKWEGSZ/C/zTozRs7fg2nGLflzVw==
X-Received: by 2002:a62:5e44:0:b0:44b:1ab4:59c5 with SMTP id s65-20020a625e44000000b0044b1ab459c5mr6138309pfb.13.1633635405019;
        Thu, 07 Oct 2021 12:36:45 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:4a7b:d840:6dbb:9d5c])
        by smtp.gmail.com with ESMTPSA id d9sm118815pgn.64.2021.10.07.12.36.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:36:44 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v10 1/4] emulator: Add support to config the accept and resolve list
Date:   Thu,  7 Oct 2021 12:36:40 -0700
Message-Id: <20211007193643.61436-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds interfaces to config the accept list and resolve list in
the btdev.
---
 emulator/btdev.c  | 37 +++++++++++++++++++++++++++++--------
 emulator/btdev.h  |  4 ++++
 emulator/hciemu.c | 16 ++++++++++++++++
 emulator/hciemu.h |  4 ++++
 4 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 148e32b7d..2c199ed85 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -191,6 +191,10 @@ struct btdev {
 	} __attribute__ ((packed)) le_cig;
 	uint8_t  le_iso_path[2];
 
+	/* Real time length of AL array */
+	uint8_t le_al_len;
+	/* Real time length of RL array */
+	uint8_t le_rl_len;
 	struct btdev_al le_al[AL_SIZE];
 	struct btdev_rl le_rl[RL_SIZE];
 	uint8_t  le_rl_enable;
@@ -475,6 +479,18 @@ static void rl_clear(struct btdev *dev)
 		rl_reset(&dev->le_rl[i]);
 }
 
+/* Set the real time length of AL array */
+void btdev_set_al_len(struct btdev *btdev, uint8_t len)
+{
+	btdev->le_al_len = len;
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
@@ -486,6 +502,9 @@ static void btdev_reset(struct btdev *btdev)
 
 	al_clear(btdev);
 	rl_clear(btdev);
+
+	btdev->le_al_len = AL_SIZE;
+	btdev->le_rl_len = RL_SIZE;
 }
 
 static int cmd_reset(struct btdev *dev, const void *data, uint8_t len)
@@ -3571,7 +3590,7 @@ static int cmd_read_al_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_accept_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = AL_SIZE;
+	rsp.size = dev->le_al_len;
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE, &rsp,
 						sizeof(rsp));
 
@@ -3658,7 +3677,7 @@ static int cmd_add_al(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < AL_SIZE; i++) {
+	for (i = 0; i < dev->le_al_len; i++) {
 		struct btdev_al *al = &dev->le_al[i];
 
 		if (AL_ADDR_EQUAL(al, cmd->addr_type, &cmd->addr)) {
@@ -3709,7 +3728,7 @@ static int cmd_remove_al(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < AL_SIZE; i++) {
+	for (i = 0; i < dev->le_al_len; i++) {
 		struct btdev_al *al = &dev->le_al[i];
 
 		ba2str(&al->addr, addr);
@@ -3724,7 +3743,7 @@ static int cmd_remove_al(struct btdev *dev, const void *data, uint8_t len)
 		}
 	}
 
-	if (i == AL_SIZE)
+	if (i == dev->le_al_len)
 		return -EINVAL;
 
 	status = BT_HCI_ERR_SUCCESS;
@@ -3755,7 +3774,7 @@ static int cmd_add_rl(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < RL_SIZE; i++) {
+	for (i = 0; i < dev->le_rl_len; i++) {
 		struct btdev_rl *rl = &dev->le_rl[i];
 
 		if (RL_ADDR_EQUAL(rl, cmd->addr_type, &cmd->addr)) {
@@ -3806,7 +3825,7 @@ static int cmd_remove_rl(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < RL_SIZE; i++) {
+	for (i = 0; i < dev->le_rl_len; i++) {
 		struct btdev_rl *rl = &dev->le_rl[i];
 
 		if (RL_ADDR_EQUAL(rl, cmd->addr_type, &cmd->addr)) {
@@ -3815,7 +3834,7 @@ static int cmd_remove_rl(struct btdev *dev, const void *data, uint8_t len)
 		}
 	}
 
-	if (i == RL_SIZE)
+	if (i == dev->le_rl_len)
 		return -EINVAL;
 
 	status = BT_HCI_ERR_SUCCESS;
@@ -3853,7 +3872,7 @@ static int cmd_read_rl_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_resolv_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = RL_SIZE;
+	rsp.size = dev->le_rl_len;
 
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_RESOLV_LIST_SIZE,
 							&rsp, sizeof(rsp));
@@ -6294,6 +6313,8 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	btdev->conns = queue_new();
 	btdev->le_ext_adv = queue_new();
 
+	btdev->le_al_len = AL_SIZE;
+	btdev->le_rl_len = RL_SIZE;
 	return btdev;
 }
 
diff --git a/emulator/btdev.h b/emulator/btdev.h
index f7cba149a..cce49db3b 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -80,6 +80,10 @@ uint8_t btdev_get_le_scan_enable(struct btdev *btdev);
 
 void btdev_set_le_states(struct btdev *btdev, const uint8_t *le_states);
 
+void btdev_set_al_len(struct btdev *btdev, uint8_t len);
+
+void btdev_set_rl_len(struct btdev *btdev, uint8_t len);
+
 void btdev_set_command_handler(struct btdev *btdev, btdev_command_func handler,
 							void *user_data);
 
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index bd6bf1e63..d18b3469b 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -581,6 +581,22 @@ void hciemu_set_central_le_states(struct hciemu *hciemu,
 	btdev_set_le_states(hciemu->dev, le_states);
 }
 
+void hciemu_set_central_le_al_len(struct hciemu *hciemu, uint8_t len)
+{
+	if (!hciemu || !hciemu->dev)
+		return;
+
+	btdev_set_al_len(hciemu->dev, len);
+}
+
+void hciemu_set_central_le_rl_len(struct hciemu *hciemu, uint8_t len)
+{
+	if (!hciemu || !hciemu->dev)
+		return;
+
+	btdev_set_rl_len(hciemu->dev, len);
+}
+
 bool hciemu_add_central_post_command_hook(struct hciemu *hciemu,
 			hciemu_command_func_t function, void *user_data)
 {
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index 3d3d93b4b..73a90c1e6 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -60,6 +60,10 @@ uint8_t hciemu_get_central_le_scan_enable(struct hciemu *hciemu);
 void hciemu_set_central_le_states(struct hciemu *hciemu,
 						const uint8_t *le_states);
 
+void hciemu_set_central_le_al_len(struct hciemu *hciemu, uint8_t len);
+
+void hciemu_set_central_le_rl_len(struct hciemu *hciemu, uint8_t len);
+
 typedef void (*hciemu_command_func_t)(uint16_t opcode, const void *data,
 						uint8_t len, void *user_data);
 
-- 
2.25.1

