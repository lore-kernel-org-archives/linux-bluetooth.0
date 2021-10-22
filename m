Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293E3C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Oct 2021 20:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F4EF611F2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Oct 2021 20:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhJVUut (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Oct 2021 16:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbhJVUus (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Oct 2021 16:50:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DABC061764
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Oct 2021 13:48:30 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e5-20020a17090a804500b001a116ad95caso3866387pjw.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Oct 2021 13:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QzNUEGLXUNt3vd3D+yISGLe6W/66aRI7qYr//lJTxqg=;
        b=N2cMiT0YhTjO13ff1a/crVCCKFZJCZyyomdLp7lZ3594q8FXua5LpxoyjLkzdMn0ug
         MWrpcQtH7DXv0jtpFpPxzH1LlXm9zENE1TyxE1PTyCi0slo9G/Eajp4zJy4p4CkBV4Gq
         H/CFYEx/10Zf/vm7UD7m+j3i5/7ibEHMHeq0Lgt2RjTOLRXf1hY1e4QCF078LRdWOZ1N
         E7enDTImoO3+cU+/ZqyH9a2DbX4bjPmtn10HXPxexr1mK4DH/Kr9RHRzjgfkQfg1GJCA
         n1Kwpugq47xJDXseVj7ysIaetK4f+cvdQwkKRXevuWr0MCdcS42NN6SIpFx3Yvh+VUlb
         te0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QzNUEGLXUNt3vd3D+yISGLe6W/66aRI7qYr//lJTxqg=;
        b=47IB19wSrGjQt5IfmBtZ4zc3MiHc9dnj9eZ6wNg2BLWCozNvqP+jUadpnrOpNkjtOp
         9DHOmgHI1GMZHugqnPZS8RKLHpeJk8nil3Kp5VDxzLb6aPf2NFZccuCpRiVHkoTFyqWC
         e+qXoDBk2LBkHWniAOssQiTCVjqhx+K9rAaYUGD7vIWCCtqKCuF+4FiINiOO6Km6FgH7
         ZHNNcFXJa/501NxgsdULNx2LFj/F6JmSeYyLRQitRITKRxzv9oQV/ETpNe0plVMOSCF+
         vfjut2UjFHNz98ochm1HdTXH8xnUODG0MMgFvly1ClRTVD8X/Llngk6C1N626Mvh/9o8
         /F7A==
X-Gm-Message-State: AOAM531YNy5TGXbrJJ3aLu3jUEG4gyidwMHDk8xclUuCv0M5As1XSVSP
        s4Q6NVcJk1EOjmckqv9/AiMHCxO72NMHlw==
X-Google-Smtp-Source: ABdhPJytxv1WLW19MC6IUARIJBeiiZWY9sb29LkqHB4CyyDyxFnVc43se/auOPdk8BxDQ2clqSjMAA==
X-Received: by 2002:a17:90b:1bc6:: with SMTP id oa6mr17281967pjb.206.1634935710060;
        Fri, 22 Oct 2021 13:48:30 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:6966:f5b2:62ac:cf35])
        by smtp.gmail.com with ESMTPSA id z19sm10285654pfj.156.2021.10.22.13.48.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 13:48:29 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v14 3/5] emulator: Add support to get the advertising address
Date:   Fri, 22 Oct 2021 13:48:23 -0700
Message-Id: <20211022204825.397952-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211022204825.397952-1-hj.tedd.an@gmail.com>
References: <20211022204825.397952-1-hj.tedd.an@gmail.com>
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

