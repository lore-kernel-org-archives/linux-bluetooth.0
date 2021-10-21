Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F489C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 17:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 245C661378
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 17:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhJURum (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Oct 2021 13:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhJURuW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Oct 2021 13:50:22 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54FCC061220
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 10:48:06 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v20so936053plo.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+HVrtpGhtDU4jb4AP5mkfcwHZNRHWdP4BGOrKQYxClQ=;
        b=bVzXokD9Tu20XKjdoTYoYkZIgjQ+XTDiHetak/9Fr6cQFm71dOsUlVngHfVEeoBPUl
         sco82jWmJ31A3mEF95uhOUrTjRSwrGF7uP/RQLyZR+5PTcfkNxhdV0dt7DvV9mIdPOzH
         5M/IESdja5REd07FUh9Tl4MYH+UESNpkCJ2WBqhFaVBLlPN4a9OW5/CMQS5wOWdsFL5C
         JmgSStp8kNdi1kJ0BViCs30SK3TVdvJz4zdlN+x+ZEp/cVzx5d+0t4QYuJn/joz78Mp7
         loDqW5HV3plXCMUwy4Rbneiz4f5o4zBgtQ/5lFnHQOx4uEOI6VdnTiNhWTXRUjdReVWH
         ms0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+HVrtpGhtDU4jb4AP5mkfcwHZNRHWdP4BGOrKQYxClQ=;
        b=SR0fDZdDHUftQrVr9yGwINIaQXo6hP7urkwZRd7aIHWbaWKLL5AO4Duwk3/bCpu9iy
         z4pApqk8DlvFjijIyeTehITvCnSv4EpzKx328i9qZmEeP77h0j09XdDCUQ+t7DdEoe99
         1ls5chvYPAmo6xSrPoiTpBDs6Y6wtN5VNGTGIZKWgx7f9ex0QHU18UJHkFUtPdIsXI42
         nWbAjdkmw76FOgw7XprLheS1QVVOvBSObsqVEo0GDEfnM0BLD2gawwjStjbC1DiMIZDH
         m/Zmc13scMPW1ax7aLM6e4HR3UsNPYKGSPHUr5LCTUa2GUKmjQ7RNqgjx6Fzcez2CBjR
         e2zg==
X-Gm-Message-State: AOAM531VHKzxxh2BaQlY7SqnXhvl9kfviz/qaWgcn2WPxAlnFIYO9SM1
        xqsplN6AXCZavl8MMuJUanhLp4fGbJCRzQ==
X-Google-Smtp-Source: ABdhPJwzAJ1W7zVhtRGP8O5tCC3HLNZQ30rGhhOvXZC/S4Nw6tY+QXsJxNEOxQdOpBqQROkWJMzlMg==
X-Received: by 2002:a17:90b:3852:: with SMTP id nl18mr8168034pjb.94.1634838485934;
        Thu, 21 Oct 2021 10:48:05 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:e439:7541:94af:b362])
        by smtp.gmail.com with ESMTPSA id g4sm5732586pgs.42.2021.10.21.10.48.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 10:48:04 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v13 1/5] emulator: Add support to config the accept and resolve list
Date:   Thu, 21 Oct 2021 10:48:00 -0700
Message-Id: <20211021174804.340160-1-hj.tedd.an@gmail.com>
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
 emulator/hciemu.c | 28 ++++++++++++++++++++++++++++
 emulator/hciemu.h |  4 ++++
 4 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index f28187362..bf6a03e59 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -196,6 +196,10 @@ struct btdev {
 	} __attribute__ ((packed)) le_cig;
 	uint8_t  le_iso_path[2];
 
+	/* Real time length of AL array */
+	uint8_t le_al_len;
+	/* Real time length of RL array */
+	uint8_t le_rl_len;
 	struct btdev_al le_al[AL_SIZE];
 	struct btdev_rl le_rl[RL_SIZE];
 	uint8_t  le_rl_enable;
@@ -480,6 +484,18 @@ static void rl_clear(struct btdev *dev)
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
@@ -491,6 +507,9 @@ static void btdev_reset(struct btdev *btdev)
 
 	al_clear(btdev);
 	rl_clear(btdev);
+
+	btdev->le_al_len = AL_SIZE;
+	btdev->le_rl_len = RL_SIZE;
 }
 
 static int cmd_reset(struct btdev *dev, const void *data, uint8_t len)
@@ -3576,7 +3595,7 @@ static int cmd_read_al_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_accept_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = AL_SIZE;
+	rsp.size = dev->le_al_len;
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE, &rsp,
 						sizeof(rsp));
 
@@ -3663,7 +3682,7 @@ static int cmd_add_al(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < AL_SIZE; i++) {
+	for (i = 0; i < dev->le_al_len; i++) {
 		struct btdev_al *al = &dev->le_al[i];
 
 		if (AL_ADDR_EQUAL(al, cmd->addr_type, &cmd->addr)) {
@@ -3714,7 +3733,7 @@ static int cmd_remove_al(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < AL_SIZE; i++) {
+	for (i = 0; i < dev->le_al_len; i++) {
 		struct btdev_al *al = &dev->le_al[i];
 
 		ba2str(&al->addr, addr);
@@ -3729,7 +3748,7 @@ static int cmd_remove_al(struct btdev *dev, const void *data, uint8_t len)
 		}
 	}
 
-	if (i == AL_SIZE)
+	if (i == dev->le_al_len)
 		return -EINVAL;
 
 	status = BT_HCI_ERR_SUCCESS;
@@ -3760,7 +3779,7 @@ static int cmd_add_rl(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < RL_SIZE; i++) {
+	for (i = 0; i < dev->le_rl_len; i++) {
 		struct btdev_rl *rl = &dev->le_rl[i];
 
 		if (RL_ADDR_EQUAL(rl, cmd->addr_type, &cmd->addr)) {
@@ -3811,7 +3830,7 @@ static int cmd_remove_rl(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < RL_SIZE; i++) {
+	for (i = 0; i < dev->le_rl_len; i++) {
 		struct btdev_rl *rl = &dev->le_rl[i];
 
 		if (RL_ADDR_EQUAL(rl, cmd->addr_type, &cmd->addr)) {
@@ -3820,7 +3839,7 @@ static int cmd_remove_rl(struct btdev *dev, const void *data, uint8_t len)
 		}
 	}
 
-	if (i == RL_SIZE)
+	if (i == dev->le_rl_len)
 		return -EINVAL;
 
 	status = BT_HCI_ERR_SUCCESS;
@@ -3858,7 +3877,7 @@ static int cmd_read_rl_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_resolv_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = RL_SIZE;
+	rsp.size = dev->le_rl_len;
 
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_RESOLV_LIST_SIZE,
 							&rsp, sizeof(rsp));
@@ -6299,6 +6318,8 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	btdev->conns = queue_new();
 	btdev->le_ext_adv = queue_new();
 
+	btdev->le_al_len = AL_SIZE;
+	btdev->le_rl_len = RL_SIZE;
 	return btdev;
 }
 
diff --git a/emulator/btdev.h b/emulator/btdev.h
index 412bfd158..b5f9979a8 100644
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
index 4752c8a4d..1f7af3b93 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -601,6 +601,34 @@ void hciemu_set_central_le_states(struct hciemu *hciemu,
 	btdev_set_le_states(dev, le_states);
 }
 
+void hciemu_set_central_le_al_len(struct hciemu *hciemu, uint8_t len)
+{
+	struct btdev *dev;
+
+	if (!hciemu || !hciemu->vhci)
+		return;
+
+	dev = vhci_get_btdev(hciemu->vhci);
+	if (!dev)
+		return;
+
+	btdev_set_al_len(dev, len);
+}
+
+void hciemu_set_central_le_rl_len(struct hciemu *hciemu, uint8_t len)
+{
+	struct btdev *dev;
+
+	if (!hciemu || !hciemu->vhci)
+		return;
+
+	dev = vhci_get_btdev(hciemu->vhci);
+	if (!dev)
+		return;
+
+	btdev_set_rl_len(dev, len);
+}
+
 bool hciemu_add_central_post_command_hook(struct hciemu *hciemu,
 			hciemu_command_func_t function, void *user_data)
 {
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index 338fa844d..2a49d8bad 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -61,6 +61,10 @@ uint8_t hciemu_get_central_le_scan_enable(struct hciemu *hciemu);
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

