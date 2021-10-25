Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10F7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 04:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D691E60FBF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 04:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhJYEtx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 00:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbhJYEtv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 00:49:51 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4C5C061745
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Oct 2021 21:47:29 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id l186so3267609pge.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Oct 2021 21:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QzNUEGLXUNt3vd3D+yISGLe6W/66aRI7qYr//lJTxqg=;
        b=hTPCIienQ/+IZx23iGf8G8VPIDMS39KHcjkQ8YNXJBxu5j2ei1ghL6H/i19b2lqkjw
         fWFyI3CIJA/MTemTDYZLBOCQGJtZS75LLu4h8pmNRwogFJOALTCATwN1u8mshdjv8RLt
         yGZ+GNcIq8AfsYdJPzsXR5hz73f6gX+oHUNMW4hgTrEaqUCQ+CgkGi5ksuCx2ppYbM+G
         fGzVpqbx/n7KyRNy0RqE48V5G/nAaVeAVOJwa9qki71nUtrghjzkB6/aZhJVvVLrSidS
         PKYPfbXyYQwF8FaEi8CNzHrKErpX3ck2BqfQiBZol07jpWfNQxEfU+4zHA1FgG27YIoz
         Z1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QzNUEGLXUNt3vd3D+yISGLe6W/66aRI7qYr//lJTxqg=;
        b=I+QXKqjn4EsttjfSOluEtqHtA9ranIq0XvHinq1bA5WjJjR+lfBsyrn3H29srKdPGg
         pxKgvhLyn/iJZRGyo/yR/VpuPxEr0vj3mYbSnw2bdZqhfckwhlwnlzQi03TaiqbE5K7b
         Uk6oZSEI39iFHCw3JnQYnx4+9vQZ3uQCf7yURbvXW89qDMYWVHKUJSCNoooHO0iwR59F
         MP60kGCN5jx2PfMFRmVqMjO0YHK0AInUVVdyMizr5R/hfmjg5Cc9kUBwJ2AvliDwF+fd
         7R9JR9NPnH1zhBVCRSZ6UM3UmkWHs2s1yUk8lm5JOSmCVaRYlZJo3y7wcpPppUcIPXOT
         qGLA==
X-Gm-Message-State: AOAM5317xt4CnT9uhfuZyRFvcTNnQBaYFIxaYfWYC3QDoFKxMYYyzdMx
        DsDWHE7GkqSg9/NJ93J9UhK3cT3xao2huQ==
X-Google-Smtp-Source: ABdhPJwpgiur9nAlGdz1HBFg4aOWnq/v21MQfGB5D1od8UGaopqDt+vy9vfJcWBkB7l1wcRPdJ2q5Q==
X-Received: by 2002:a05:6a00:1503:b0:472:df2c:d821 with SMTP id q3-20020a056a00150300b00472df2cd821mr15830487pfu.60.1635137249113;
        Sun, 24 Oct 2021 21:47:29 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:d228:1bef:af2a:db8e])
        by smtp.gmail.com with ESMTPSA id a17sm13926204pfv.64.2021.10.24.21.47.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 21:47:28 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 3/4] emulator: Add support to get the advertising address
Date:   Sun, 24 Oct 2021 21:47:24 -0700
Message-Id: <20211025044725.482641-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025044725.482641-1-hj.tedd.an@gmail.com>
References: <20211025044725.482641-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch add supprt emulator to get the advertising address of the
central device.
---
 emulator/btdev.c  | 23 +++++++++++++++++++++--
 emulator/btdev.h  |  2 ++
 emulator/hciemu.c | 15 +++++++++++++++
 emulator/hciemu.h |  3 +++
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 1ae71765d..e129b5cda 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -4655,6 +4655,7 @@ static void send_ext_adv(struct btdev *btdev, const struct btdev *remote,
 					struct le_ext_adv *ext_adv,
 					uint16_t type, bool is_scan_rsp)
 {
+
 	struct __packed {
 		uint8_t num_reports;
 		union {
@@ -4770,6 +4771,9 @@ static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
 
 		/* Disable all advertising sets */
 		queue_foreach(dev->le_ext_adv, ext_adv_disable, NULL);
+
+		dev->le_adv_enable = 0x00;
+
 		goto exit_complete;
 	}
 
@@ -4824,6 +4828,8 @@ static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
 
 		ext_adv->enable = cmd->enable;
 
+		dev->le_adv_enable = 0x01;
+
 		if (!cmd->enable)
 			ext_adv_disable(ext_adv, NULL);
 		else if (eas->duration)
@@ -4888,7 +4894,7 @@ static int cmd_remove_adv_set(struct btdev *dev, const void *data,
 						UINT_TO_PTR(cmd->handle));
 	if (!ext_adv) {
 		status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
-		cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_ADV_DATA, &status,
+		cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_ADV_SET, &status,
 						sizeof(status));
 		return 0;
 	}
@@ -5158,7 +5164,7 @@ static void le_ext_conn_complete(struct btdev *btdev,
 		/* Set Local RPA if an RPA was generated for the advertising */
 		if (ext_adv->rpa)
 			memcpy(ev.local_rpa, ext_adv->random_addr,
-					sizeof(ev.local_rpa));
+							sizeof(ev.local_rpa));
 
 		le_meta_event(conn->link->dev,
 				BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &ev,
@@ -6387,6 +6393,19 @@ uint8_t btdev_get_le_scan_enable(struct btdev *btdev)
 	return btdev->le_scan_enable;
 }
 
+const uint8_t *btdev_get_adv_addr(struct btdev *btdev, uint8_t handle)
+{
+	struct le_ext_adv *ext_adv;
+
+	/* Check if Ext Adv is already existed */
+	ext_adv = queue_find(btdev->le_ext_adv, match_ext_adv_handle,
+							UINT_TO_PTR(handle));
+	if (!ext_adv)
+		return NULL;
+
+	return ext_adv_addr(btdev, ext_adv);
+}
+
 void btdev_set_le_states(struct btdev *btdev, const uint8_t *le_states)
 {
 	memcpy(btdev->le_states, le_states, sizeof(btdev->le_states));
diff --git a/emulator/btdev.h b/emulator/btdev.h
index b5f9979a8..9493938c6 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -78,6 +78,8 @@ uint8_t btdev_get_scan_enable(struct btdev *btdev);
 
 uint8_t btdev_get_le_scan_enable(struct btdev *btdev);
 
+const uint8_t *btdev_get_adv_addr(struct btdev *btdev, uint8_t handle);
+
 void btdev_set_le_states(struct btdev *btdev, const uint8_t *le_states);
 
 void btdev_set_al_len(struct btdev *btdev, uint8_t len);
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 1f7af3b93..057f76ff3 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -629,6 +629,21 @@ void hciemu_set_central_le_rl_len(struct hciemu *hciemu, uint8_t len)
 	btdev_set_rl_len(dev, len);
 }
 
+const uint8_t *hciemu_get_central_adv_addr(struct hciemu *hciemu,
+								uint8_t handle)
+{
+	struct btdev *dev;
+
+	if (!hciemu || !hciemu->vhci)
+		return NULL;
+
+	dev = vhci_get_btdev(hciemu->vhci);
+	if (!dev)
+		return NULL;
+
+	return btdev_get_adv_addr(dev, handle);
+}
+
 bool hciemu_add_central_post_command_hook(struct hciemu *hciemu,
 			hciemu_command_func_t function, void *user_data)
 {
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index 2a49d8bad..3a06ca578 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -65,6 +65,9 @@ void hciemu_set_central_le_al_len(struct hciemu *hciemu, uint8_t len);
 
 void hciemu_set_central_le_rl_len(struct hciemu *hciemu, uint8_t len);
 
+const uint8_t *hciemu_get_central_adv_addr(struct hciemu *hciemu,
+							uint8_t handle);
+
 typedef void (*hciemu_command_func_t)(uint16_t opcode, const void *data,
 						uint8_t len, void *user_data);
 
-- 
2.25.1

