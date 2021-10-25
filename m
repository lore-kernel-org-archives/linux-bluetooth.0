Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92D8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 04:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C6A60FBF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 04:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhJYEtu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 00:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhJYEtt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 00:49:49 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309F3C061745
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Oct 2021 21:47:28 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r2so9678481pgl.10
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Oct 2021 21:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GN64q4nuu6zkiuwohx69Zu7UQYLWgsXgndnImWCPccA=;
        b=kUJy2KoQbWBBlw3dSaqeCHZjREFkGq/akTqxmvcriEwLkjg+IHhZXKL5o6HwXfIyJg
         Kagka173v9T7uiJHYWsbiDX/RdOoqGaExUdbWlrjLxka9xlH8uk5QRN/0lTZUSHwuoSM
         Zr6q83B+qIFqVYfbxOTcd53ttjrX7jedPxhURmjZNY0j53/8fLtI/Pti4jRcyCECZKlU
         LAWhPnEKSWkCwsG3X3M+nWvI3bVovyGm6QiT0QMIB1RoYiLRmHKcEPbJzRKfpyVCZzEV
         TPd+uIalGNWKYy+ErkYjoR0a5+peeireV3SOXyXw35T8q9kv77qwO19AviLucf4jsBxX
         g7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GN64q4nuu6zkiuwohx69Zu7UQYLWgsXgndnImWCPccA=;
        b=tSXtRHlOv8Iyjanu/WBjacXlUlvFbOF9LW+Z02P9Ij7E0ps0A/S4MomgOtoeM7OiIt
         g6SFBQ37F1DXHAgC8YJejiudF2uhhtbuGJvVC1dSo6W9lkiemVOavft9owAFtwnLjQkn
         t4e0smF4/gLT4QUJhkr9SpN+4lSx/2xtfhmW0OjUlM3cZRGqsMYL1XlrOzuLTz0brVi3
         k3f3ve/Qj89e8RuR++bl35UAUkrVJS+KOmbM6VsHBidM3gYe7e+gdONsi8YkKloSFtKW
         1RFN7G7HN1WVBHkHlykVM1bJiMwkyAH0LEs6n1D3/g9WUlMPyddEix0fuMBa4JH1eSvl
         JDUg==
X-Gm-Message-State: AOAM533vx/OTX6Pob6gexygb/4P7dFrS/E7yMPrOJqGUMbWdgKoyaZys
        HBnaLglXkW5P/FfxUrvU++p+31WYyk4ozA==
X-Google-Smtp-Source: ABdhPJwr/clZcO5XZHfbYu4WqkVs6yB0sYyGLnbqk15jQGMcS7L0JYsGJfF6/UHCvHIstZN9fwZKQA==
X-Received: by 2002:a05:6a00:24c1:b0:44d:3047:4229 with SMTP id d1-20020a056a0024c100b0044d30474229mr15690312pfv.70.1635137247322;
        Sun, 24 Oct 2021 21:47:27 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:d228:1bef:af2a:db8e])
        by smtp.gmail.com with ESMTPSA id a17sm13926204pfv.64.2021.10.24.21.47.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 21:47:26 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 1/4] emulator: Add support to config the accept and resolve list
Date:   Sun, 24 Oct 2021 21:47:22 -0700
Message-Id: <20211025044725.482641-1-hj.tedd.an@gmail.com>
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
index 03003d949..1ae71765d 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -198,6 +198,10 @@ struct btdev {
 	} __attribute__ ((packed)) le_cig;
 	uint8_t  le_iso_path[2];
 
+	/* Real time length of AL array */
+	uint8_t le_al_len;
+	/* Real time length of RL array */
+	uint8_t le_rl_len;
 	struct btdev_al le_al[AL_SIZE];
 	struct btdev_rl le_rl[RL_SIZE];
 	uint8_t  le_rl_enable;
@@ -482,6 +486,18 @@ static void rl_clear(struct btdev *dev)
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
@@ -493,6 +509,9 @@ static void btdev_reset(struct btdev *btdev)
 
 	al_clear(btdev);
 	rl_clear(btdev);
+
+	btdev->le_al_len = AL_SIZE;
+	btdev->le_rl_len = RL_SIZE;
 }
 
 static int cmd_reset(struct btdev *dev, const void *data, uint8_t len)
@@ -3578,7 +3597,7 @@ static int cmd_read_al_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_accept_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = AL_SIZE;
+	rsp.size = dev->le_al_len;
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE, &rsp,
 						sizeof(rsp));
 
@@ -3665,7 +3684,7 @@ static int cmd_add_al(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < AL_SIZE; i++) {
+	for (i = 0; i < dev->le_al_len; i++) {
 		struct btdev_al *al = &dev->le_al[i];
 
 		if (AL_ADDR_EQUAL(al, cmd->addr_type, &cmd->addr)) {
@@ -3716,7 +3735,7 @@ static int cmd_remove_al(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < AL_SIZE; i++) {
+	for (i = 0; i < dev->le_al_len; i++) {
 		struct btdev_al *al = &dev->le_al[i];
 
 		ba2str(&al->addr, addr);
@@ -3731,7 +3750,7 @@ static int cmd_remove_al(struct btdev *dev, const void *data, uint8_t len)
 		}
 	}
 
-	if (i == AL_SIZE)
+	if (i == dev->le_al_len)
 		return -EINVAL;
 
 	status = BT_HCI_ERR_SUCCESS;
@@ -3762,7 +3781,7 @@ static int cmd_add_rl(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < RL_SIZE; i++) {
+	for (i = 0; i < dev->le_rl_len; i++) {
 		struct btdev_rl *rl = &dev->le_rl[i];
 
 		if (RL_ADDR_EQUAL(rl, cmd->addr_type, &cmd->addr)) {
@@ -3813,7 +3832,7 @@ static int cmd_remove_rl(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < RL_SIZE; i++) {
+	for (i = 0; i < dev->le_rl_len; i++) {
 		struct btdev_rl *rl = &dev->le_rl[i];
 
 		if (RL_ADDR_EQUAL(rl, cmd->addr_type, &cmd->addr)) {
@@ -3822,7 +3841,7 @@ static int cmd_remove_rl(struct btdev *dev, const void *data, uint8_t len)
 		}
 	}
 
-	if (i == RL_SIZE)
+	if (i == dev->le_rl_len)
 		return -EINVAL;
 
 	status = BT_HCI_ERR_SUCCESS;
@@ -3860,7 +3879,7 @@ static int cmd_read_rl_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_resolv_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = RL_SIZE;
+	rsp.size = dev->le_rl_len;
 
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_RESOLV_LIST_SIZE,
 							&rsp, sizeof(rsp));
@@ -6310,6 +6329,8 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
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

