Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14EFC432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 22:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53DA61042
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 22:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbhHQWfP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbhHQWfP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 18:35:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65017C061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 15:34:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so4078381pje.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 15:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QX5Ahay99vHQNM3thlX+13DvgAe2/fK68BenbLhmDhs=;
        b=t/OFi6jc9l6B6xjEiuHOq9U75NMv+xpv+fwc+9EQzEFpnTcBLWgVr0FK7xyB0uN5iN
         51dYQpqLf1qP+NViWRKchvL9/xzb/pUAPYDmSDjoJ86+sEsZCyQXOXSm6hS3/WGnbJl7
         rVgArTayP2eMVmP8IVEXUoFMzBzfcvj7OBAArn5ztcdJqkFCPaMFaTuWnk5eWWO+eU4X
         t7fyiOIu5LtgXyDYwxdIk5fUTWiQeu5p8dlWEB+/AdoIpFU9Ns+/8l39oNigC04+kYWe
         g/qOXBodVjFDXR6t59Pj4EkXhZHtZDNn6HRu5edt/t7J+eiorRkf0Hc63dYv388drzNf
         hPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QX5Ahay99vHQNM3thlX+13DvgAe2/fK68BenbLhmDhs=;
        b=eUdl1XKZ3U/UsppbLDKswOaQFYeinHwd1v5d2aK0cXF9Ii1J3frNBhbDKAdJwaR3y0
         IVKNckCpx1mgCXQ+uxSwSKEl/LbbezyBqTa/e59NJyFc2jjC5ol9nQpijlv89yhreKi2
         t2UeDxCuzxv1VF5FWsTO1ptO0hp7Y6BKWp5IdUgLa15vZko5GqZWpWJpx+LWLbTiiyc0
         V6B2f5OO8vsSCA02cA+2qLEWLL4+VnmCkXShmdVkHRwjBz+SYC84837xT9JubJHuDjUm
         +OancXWvmjMnDgIXdLBAss+bwSBsKAELtPip9z3FTqvt1r3knWlV/Aw8ne5rQpqz3yZR
         ERdA==
X-Gm-Message-State: AOAM5320QPUN/6qh+YV/jZK9B+qQRBmxtZn1glxRTXcGaOW2t3pAlZ2b
        mz2YNN33dxfyCAAoRQ6HyetSO9x6/Z4=
X-Google-Smtp-Source: ABdhPJwObJv0kf3hugKU0Cg1ZiGBXU3e/B3vOyJMEeoHiFl6ePQkONi3N1W46uItDoX1shFO9NnEwA==
X-Received: by 2002:a17:90a:c8b:: with SMTP id v11mr5667766pja.114.1629239678444;
        Tue, 17 Aug 2021 15:34:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:9d2d:9805:b76a:427e])
        by smtp.gmail.com with ESMTPSA id i8sm3658491pfo.117.2021.08.17.15.34.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 15:34:37 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v9 1/2] emulator: Add support to config the white and resolve list
Date:   Tue, 17 Aug 2021 15:34:36 -0700
Message-Id: <20210817223437.411624-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
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
index f8daf4587..a197e4917 100644
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
@@ -191,6 +191,10 @@ struct btdev {
 	} __attribute__ ((packed)) le_cig;
 	uint8_t  le_iso_path[2];
 
+	/* Real time length of WL array */
+	uint8_t le_wl_len;
+	/* Real time length of RL array */
+	uint8_t le_rl_len;
 	struct btdev_wl le_wl[WL_SIZE];
 	struct btdev_rl le_rl[RL_SIZE];
 	uint8_t  le_rl_enable;
@@ -475,6 +479,18 @@ static void rl_clear(struct btdev *dev)
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
@@ -486,6 +502,9 @@ static void btdev_reset(struct btdev *btdev)
 
 	wl_clear(btdev);
 	rl_clear(btdev);
+
+	btdev->le_wl_len = WL_SIZE;
+	btdev->le_rl_len = RL_SIZE;
 }
 
 static int cmd_reset(struct btdev *dev, const void *data, uint8_t len)
@@ -3515,7 +3534,7 @@ static int cmd_read_wl_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_white_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = WL_SIZE;
+	rsp.size = dev->le_wl_len;
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE, &rsp,
 						sizeof(rsp));
 
@@ -3602,7 +3621,7 @@ static int cmd_add_wl(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < WL_SIZE; i++) {
+	for (i = 0; i < dev->le_wl_len; i++) {
 		struct btdev_wl *wl = &dev->le_wl[i];
 
 		if (WL_ADDR_EQUAL(wl, cmd->addr_type, &cmd->addr)) {
@@ -3653,7 +3672,7 @@ static int cmd_remove_wl(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < WL_SIZE; i++) {
+	for (i = 0; i < dev->le_wl_len; i++) {
 		struct btdev_wl *wl = &dev->le_wl[i];
 
 		ba2str(&wl->addr, addr);
@@ -3668,7 +3687,7 @@ static int cmd_remove_wl(struct btdev *dev, const void *data, uint8_t len)
 		}
 	}
 
-	if (i == WL_SIZE)
+	if (i == dev->le_wl_len)
 		return -EINVAL;
 
 	status = BT_HCI_ERR_SUCCESS;
@@ -3699,7 +3718,7 @@ static int cmd_add_rl(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < RL_SIZE; i++) {
+	for (i = 0; i < dev->le_rl_len; i++) {
 		struct btdev_rl *rl = &dev->le_rl[i];
 
 		if (RL_ADDR_EQUAL(rl, cmd->addr_type, &cmd->addr)) {
@@ -3750,7 +3769,7 @@ static int cmd_remove_rl(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < RL_SIZE; i++) {
+	for (i = 0; i < dev->le_rl_len; i++) {
 		struct btdev_rl *rl = &dev->le_rl[i];
 
 		if (RL_ADDR_EQUAL(rl, cmd->addr_type, &cmd->addr)) {
@@ -3759,7 +3778,7 @@ static int cmd_remove_rl(struct btdev *dev, const void *data, uint8_t len)
 		}
 	}
 
-	if (i == RL_SIZE)
+	if (i == dev->le_rl_len)
 		return -EINVAL;
 
 	status = BT_HCI_ERR_SUCCESS;
@@ -3797,7 +3816,7 @@ static int cmd_read_rl_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_resolv_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = RL_SIZE;
+	rsp.size = dev->le_rl_len;
 
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_RESOLV_LIST_SIZE,
 							&rsp, sizeof(rsp));
@@ -6236,6 +6255,8 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
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
index fe5ef747a..ec60b7cea 100644
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
2.25.1

