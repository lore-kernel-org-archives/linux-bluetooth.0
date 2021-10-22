Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C7BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Oct 2021 20:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D316112F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Oct 2021 20:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhJVUur (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Oct 2021 16:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbhJVUuq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Oct 2021 16:50:46 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0403EC061764
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Oct 2021 13:48:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q19so4689634pfl.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Oct 2021 13:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GN64q4nuu6zkiuwohx69Zu7UQYLWgsXgndnImWCPccA=;
        b=oRadd7noXfLPJoctrVClJt+UgKwTYi7lZtfI4I9Pc/0pT5+S8god1Taecwws2B9wr+
         xYTGfljxuhd+oJtBzqiEJk/ypKH4Ax1CNaVXMLoO3MKQzIWDvEfqoO9gTdJ8iv/2t+UM
         dNw3srVpQy7p7UBgN7RW5kgVVIJdpsfBYsYOvBjLDAdU33nAMRH3gsqh3a80IJ2wzN6Y
         akgtKN4YNQux91f0+Tmqm5cwMEbu3oPx+kzgG4NIch5uijLZ+pWruiBZDw4xTEe57RWA
         X57cAK56fvSQBaRJX0NJXl3GaBOjYKtBXD45xtgji82G+VkCzdkwNWEmrP28jCBE8VOb
         MlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GN64q4nuu6zkiuwohx69Zu7UQYLWgsXgndnImWCPccA=;
        b=OSOp9VSO88U6uo42KL3KamlLOY0eZL0kx88Ii1G4c6l+gIbu+xwFPa7qqZMWoTPtv5
         5NMWA3Azg2K0E49t3815548BuqBkjRHYXwWO0QcGxp5t9M6fkvN3dS1dEs2HpVmBjkhy
         nWRXV/ojK6D/fcmhl8WZQF2t15HPsAwshidzyFSPNPKTyLBQ3E1g9/9jz1UQjIKm9p29
         bg1BsQ/KCmPdyNl2m0TSZnSfIZB8IuDrdU3l9pbOaF1I18qby4BzgL/KA5jC5an/ap5a
         dJKnU0U9TlSBD4c6rupWztyPCqhslWEX9uAoxqblSSVM+ye09dsibJP8Kd74RIEj3zHU
         r+VQ==
X-Gm-Message-State: AOAM532Xs483yGzXjQsPsTPc7EVnd6ZkVwpiWinhc04DY/DPrt/H9FcY
        zxtCWHvrEbbwzkTlGzIZ16gLiSjV7lS5YQ==
X-Google-Smtp-Source: ABdhPJwYQ+DOnE4oiCGoKX/u9HbW+YbQdy8CDD1KIK6eua3jak+Wvr0VWAPXJ/VW+2gb/NewPxnQWQ==
X-Received: by 2002:a05:6a00:813:b0:470:bbc2:49ae with SMTP id m19-20020a056a00081300b00470bbc249aemr1972110pfk.29.1634935708051;
        Fri, 22 Oct 2021 13:48:28 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:6966:f5b2:62ac:cf35])
        by smtp.gmail.com with ESMTPSA id z19sm10285654pfj.156.2021.10.22.13.48.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 13:48:26 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v14 1/5] emulator: Add support to config the accept and resolve list
Date:   Fri, 22 Oct 2021 13:48:21 -0700
Message-Id: <20211022204825.397952-1-hj.tedd.an@gmail.com>
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

