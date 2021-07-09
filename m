Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99A8C07E99
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jul 2021 20:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A44AC613AB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jul 2021 20:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhGIUWl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jul 2021 16:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGIUWl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jul 2021 16:22:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3F3C0613DD
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jul 2021 13:19:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so6701126pjo.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jul 2021 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jmG0OxSqUvmmIudd9CMY55a4Q4aZQc+lcjD3v5X938o=;
        b=iX++I1PPs/QXJfPBkeHZcB9uLMZtv5eDg5fzU2jrI6uTwVkQjHrFK1tKv1OuZSi0Rk
         /XkAFMSByGfNFfK0Y2CDv8jZZ+I66kkCVSeRwgkl12y1NMtqpmrRuIkFtTI7zVYz66Yx
         2+er9XZ5KzCE8TKrtfNUoSvnpxN5XFLdProSE76O68pexKkbwDxGM3eDw2aOKwSGh3Az
         FojxtvrL9KkF7qyTLBRh+cK92QejegOIaGuZlAeMJPKLWUKehWJGac+mRwVUOJc2O9dK
         20bhsreg22KJWDXmBgR9RGKBz5T9u5SzWN2iDl4DsjKHp06/b7VK2kmZQsnVbOAMn6HR
         VeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jmG0OxSqUvmmIudd9CMY55a4Q4aZQc+lcjD3v5X938o=;
        b=muHz1XFGwqVFnEzT0lRHXBWu4zYq7H4MGSu0Z/iGxoLus32oxZQnnLRRPmiditJG7Z
         4P8iP6g43ktBjnpozJgmIbGRNbClZHyoEtAaNeJPNaG8K+LmcSXeyVPtVcemGHAIfc42
         R6v7tgVn3DK2A5YeLincwWx3a/hnVQd6k5T/jPKl4yIaVU0wU5Mq2VrjpTCSNMjslre8
         I56qNROCPUtSChLy7wzgE9qABAC3wnsXpA7ouhb7Q/8H/L4bu5yCjU+/cVUzy1VSZVXz
         PN/uGKemtBNR0xUGpNQ8HLwBwpWyzvEwl7V9rGMaxn/9KjTSf8BsV9Fy9WJURtIJB6/c
         o2tw==
X-Gm-Message-State: AOAM533xadyDs5+lC2iqgc+/UNe89BTqFm5Tg1/mOGmCWhRu1RTVRdi9
        PwLQ9I5R6dLt6qu6zBAQqZLM1LANtvY=
X-Google-Smtp-Source: ABdhPJyuoEixVNoeraWI1y/hsMSTV/eEBQk9gA6qMR8q3HGsdLPizKmk/ef3rgiJIrclztgj9PRx6A==
X-Received: by 2002:a17:902:6b41:b029:128:eb35:271f with SMTP id g1-20020a1709026b41b0290128eb35271fmr32101814plt.48.1625861996590;
        Fri, 09 Jul 2021 13:19:56 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id p24sm7661842pfh.17.2021.07.09.13.19.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 13:19:55 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v6 1/2] emulator: Add support to config the white and resolve list
Date:   Fri,  9 Jul 2021 13:19:53 -0700
Message-Id: <20210709201954.919338-1-hj.tedd.an@gmail.com>
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
index a7fda2c89..d3bc7c25e 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -33,8 +33,8 @@
 #include "monitor/bt.h"
 #include "btdev.h"
 
-#define WL_SIZE			16
-#define RL_SIZE			16
+#define WL_SIZE			3
+#define RL_SIZE			3
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

