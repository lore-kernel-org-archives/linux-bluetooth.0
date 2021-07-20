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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74832C6377A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 01:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE1B6120D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 01:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbhGTA4b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Jul 2021 20:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbhGTAzz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Jul 2021 20:55:55 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815D9C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jul 2021 18:36:33 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id q10so18243769pfj.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jul 2021 18:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/KgM+xtm06i6t+5gzMSNAIXwRWnWMlx2w4kOt0WehI=;
        b=ZpRABd+sDtddx9R+m77nJLdcIRV/bTpPUwCOSPpi4HvGimEtMXst+LB/2A6JIBoRJ1
         /NFA10tuOUlHu3UJPMm3QXPqrEcQQrE/9XN0eAvjYLJGX+A81dbarBmQ7RAzyE555GT4
         31l7fjjuDCwKME7qcB8n9VI8ym9DCOJIqzfnrZ4xZoYnOEk+BfsldsQoUiQS1I6FGm5e
         biXUTBC6SHqvb2aiKl0Qhr/NmNSyHSNIR/nD58EGKCYDaeqhWI8y81JRPIg24GSENHFr
         R1VRSATAZXHVZPNnKAeDKN3xcBMBky13DvMzpTkDX2M5L54+KuXeYsHe3W8O/gdPsSk4
         B0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/KgM+xtm06i6t+5gzMSNAIXwRWnWMlx2w4kOt0WehI=;
        b=IXkO8bgGXB7uKYyhiuI3s+TUpvY/Qd1n0FNtt+6L8Jt7Oc9Mpagfad5CvmqBakVFvN
         JSjU1FLrDSaQG3IkmLxq3H+TUcIgNQeI+kDait4kmsRC8BC09zhsJh0nPiQ1V4gywKqN
         yv6Xt9dzOIPcMRidqgfAh0H9vZAi3iBUR5ICrNluCtKfnPzLagZ0LDys+2ZPNE6HJzSw
         LcNKiN3As21lRZ8+PxR3DtmCi8GW1I8pguicxNmvCB3Mw15zBIhulv+I6mRl+6zHkP9m
         axNEvNHOlN7omNw8DaEXnDTuP0D0UfdexcFJbAhmUZ925TrdcbXdfDiICSAR1U6tROR3
         k3Pw==
X-Gm-Message-State: AOAM5326j1ZH0WrQGZF1wJiycWW9ALLgIpjkATvhIhb+hWwFqYMtLMII
        PQ1dVscWZlnkSPd1tF6L20iNxnPl39g=
X-Google-Smtp-Source: ABdhPJzLqmmCPKy272GMwsdtYnHunzEQtG9ED4DmU+9iMr8s3nmTM7a9vH9JhXDiHSeLJaf/mZ2ayA==
X-Received: by 2002:a62:dd83:0:b029:30f:d69:895f with SMTP id w125-20020a62dd830000b029030f0d69895fmr29166819pff.17.1626744992621;
        Mon, 19 Jul 2021 18:36:32 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::b4ad])
        by smtp.gmail.com with ESMTPSA id u12sm4940087pju.15.2021.07.19.18.36.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 18:36:31 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v8 1/2] emulator: Add support to config the white and resolve list
Date:   Mon, 19 Jul 2021 18:36:29 -0700
Message-Id: <20210720013630.478929-1-hj.tedd.an@gmail.com>
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
index c9ec22ebe..5041a68e6 100644
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
@@ -3495,7 +3514,7 @@ static int cmd_read_wl_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_white_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = WL_SIZE;
+	rsp.size = dev->le_wl_len;
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE, &rsp,
 						sizeof(rsp));
 
@@ -3582,7 +3601,7 @@ static int cmd_add_wl(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < WL_SIZE; i++) {
+	for (i = 0; i < dev->le_wl_len; i++) {
 		struct btdev_wl *wl = &dev->le_wl[i];
 
 		if (WL_ADDR_EQUAL(wl, cmd->addr_type, &cmd->addr)) {
@@ -3633,7 +3652,7 @@ static int cmd_remove_wl(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < WL_SIZE; i++) {
+	for (i = 0; i < dev->le_wl_len; i++) {
 		struct btdev_wl *wl = &dev->le_wl[i];
 
 		ba2str(&wl->addr, addr);
@@ -3648,7 +3667,7 @@ static int cmd_remove_wl(struct btdev *dev, const void *data, uint8_t len)
 		}
 	}
 
-	if (i == WL_SIZE)
+	if (i == dev->le_wl_len)
 		return -EINVAL;
 
 	status = BT_HCI_ERR_SUCCESS;
@@ -3679,7 +3698,7 @@ static int cmd_add_rl(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < RL_SIZE; i++) {
+	for (i = 0; i < dev->le_rl_len; i++) {
 		struct btdev_rl *rl = &dev->le_rl[i];
 
 		if (RL_ADDR_EQUAL(rl, cmd->addr_type, &cmd->addr)) {
@@ -3730,7 +3749,7 @@ static int cmd_remove_rl(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
 
-	for (i = 0; i < RL_SIZE; i++) {
+	for (i = 0; i < dev->le_rl_len; i++) {
 		struct btdev_rl *rl = &dev->le_rl[i];
 
 		if (RL_ADDR_EQUAL(rl, cmd->addr_type, &cmd->addr)) {
@@ -3739,7 +3758,7 @@ static int cmd_remove_rl(struct btdev *dev, const void *data, uint8_t len)
 		}
 	}
 
-	if (i == RL_SIZE)
+	if (i == dev->le_rl_len)
 		return -EINVAL;
 
 	status = BT_HCI_ERR_SUCCESS;
@@ -3777,7 +3796,7 @@ static int cmd_read_rl_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_resolv_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = RL_SIZE;
+	rsp.size = dev->le_rl_len;
 
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_RESOLV_LIST_SIZE,
 							&rsp, sizeof(rsp));
@@ -6166,6 +6185,8 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
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

