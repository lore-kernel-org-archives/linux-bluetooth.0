Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C95C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 17:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B846139F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 17:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhJURut (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Oct 2021 13:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhJURul (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Oct 2021 13:50:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00E9C061225
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 10:48:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u6so958916ple.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+nSjo3S3XWCq/xfgmNAmdEjOY895Hk3ZrQObeV+jey8=;
        b=q3BgsNusuW44hdBAAbcdMQWmEwxnghi9UkwXeyzh3K1GTZfPvfO4A6zsnybwMoB4aT
         ufjSWizHgqLGCTPWCCN1exzX79l6BOYMogMfovhaoQncbVytqCPDAcGkT0MZJl9pd2Qo
         eP7CeRMp70x2vaUWg/vhP7gq4BmR7SzO8ZAin8HXLk/ea6wGeoedIBJNBviqN57KSm9Q
         /t9pZnZWdHHYlT4vyte5aO0hIM6tSlC9+hnqqu3jAcQHGqvT2axUyqJbZIj2itlFIf5e
         GYztWSOX+E4kVrbGfZAxYXt2/36wT6e4HPhLWk7oBTg2UZpWNSETPfyAIQ4u2lji/GSC
         dtpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+nSjo3S3XWCq/xfgmNAmdEjOY895Hk3ZrQObeV+jey8=;
        b=OmoqmZU+jMaKx/CudYBjzvx3QVIdGuNX4aDzDuculX5yiJfaUq/dPi8/Ghl1LL5yt6
         nuV/2cuZVwx1ZLtcFX7z2RPcK/90ic5I+hjdJ0p1VrGZgqw0oCxg1yHAdA9j6s/e0FMi
         1sV3yqlup3+vGAyFS6xiIwFNiOqyd2p8S3BSRq4ExJ6Cdo9lW48f40cCb+UtkCVUDm6g
         aV7z4ZHquCU/0CbF1cUnkXHU/LURtzsngapRp+dU8oNL5unuNffrwU3V+tFaFcELq1le
         4x5QMVKVcAM2Kn3DQay/lasO37VOXljBbNyYTSvHp15xiDRbo3Bq2JL9DJnbW91VYHDg
         EsVA==
X-Gm-Message-State: AOAM5310J5M0y+9/CK6Tv2TivbVAawBWQEHgcxElF+qu1QEGvnosaUSD
        cCFEuWz/FqefzenugbaLkqs7Che4wL4aLA==
X-Google-Smtp-Source: ABdhPJzeAIOI6Vpri+y2Q1QnKRV1mveY2HkVzRbbcdMzgH+KoDs0WxhOmFp9qr1QqpdXo5VmDNebYg==
X-Received: by 2002:a17:90b:4b07:: with SMTP id lx7mr8146850pjb.195.1634838487197;
        Thu, 21 Oct 2021 10:48:07 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:e439:7541:94af:b362])
        by smtp.gmail.com with ESMTPSA id g4sm5732586pgs.42.2021.10.21.10.48.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 10:48:06 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v13 3/5] emulator: Add support to get the advertising address
Date:   Thu, 21 Oct 2021 10:48:02 -0700
Message-Id: <20211021174804.340160-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211021174804.340160-1-hj.tedd.an@gmail.com>
References: <20211021174804.340160-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch add supprt emulator to get the advertising address of the
central device.
---
 emulator/btdev.c  | 31 ++++++++++++++++++++++++++-----
 emulator/btdev.h  |  2 ++
 emulator/hciemu.c | 15 +++++++++++++++
 emulator/hciemu.h |  3 +++
 4 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index bf6a03e59..d9c55d99d 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -4653,6 +4653,7 @@ static void send_ext_adv(struct btdev *btdev, const struct btdev *remote,
 					struct le_ext_adv *ext_adv,
 					uint16_t type, bool is_scan_rsp)
 {
+
 	struct __packed {
 		uint8_t num_reports;
 		union {
@@ -4768,6 +4769,9 @@ static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
 
 		/* Disable all advertising sets */
 		queue_foreach(dev->le_ext_adv, ext_adv_disable, NULL);
+
+		dev->le_adv_enable = 0x00;
+
 		goto exit_complete;
 	}
 
@@ -4822,6 +4826,8 @@ static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
 
 		ext_adv->enable = cmd->enable;
 
+		dev->le_adv_enable = 0x01;
+
 		if (!cmd->enable)
 			ext_adv_disable(ext_adv, NULL);
 		else if (eas->duration)
@@ -4886,7 +4892,7 @@ static int cmd_remove_adv_set(struct btdev *dev, const void *data,
 						UINT_TO_PTR(cmd->handle));
 	if (!ext_adv) {
 		status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
-		cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_ADV_DATA, &status,
+		cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_ADV_SET, &status,
 						sizeof(status));
 		return 0;
 	}
@@ -5152,6 +5158,11 @@ static void le_ext_conn_complete(struct btdev *btdev,
 		ev.latency = lecc->latency;
 		ev.supv_timeout = lecc->supv_timeout;
 
+		/* Set Local RPA if an RPA was generated for the advertising */
+		if (ext_adv->rpa)
+			memcpy(ev.local_rpa, ext_adv->random_addr,
+						sizeof(ev.local_rpa));
+
 		le_meta_event(conn->link->dev,
 				BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &ev,
 				sizeof(ev));
@@ -5165,10 +5176,7 @@ static void le_ext_conn_complete(struct btdev *btdev,
 	memcpy(ev.peer_addr, cmd->peer_addr, 6);
 	ev.role = 0x00;
 
-	/* Set Local RPA if an RPA was generated for the advertising */
-	if (ext_adv->rpa)
-		memcpy(ev.local_rpa, ext_adv->random_addr,
-					sizeof(ev.local_rpa));
+	memset(ev.local_rpa, 0, sizeof(ev.local_rpa));
 
 	le_meta_event(btdev, BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &ev,
 						sizeof(ev));
@@ -6376,6 +6384,19 @@ uint8_t btdev_get_le_scan_enable(struct btdev *btdev)
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

