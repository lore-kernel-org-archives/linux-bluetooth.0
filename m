Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55988C55186
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 21:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 303B520724
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 21:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4zQgz/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgDWVzH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgDWVzH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Apr 2020 17:55:07 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E341C09B042
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 14:55:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t4so2887409plq.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Y3cH/k4X9c9gMMu/uU1sRz7+q1h8kNwjSNhobDRWoWM=;
        b=g4zQgz/8cIB1j7HDHs9PFu+cOs6Dbw6MndpMvN1+Ca+VkR1jHmPSnlN4t1LHNUumMA
         K0E//2NeHJyua8OJW+8hMvKJ8Jv9LOxze2kYsfihAMwFHZCZrnru4xqCSY2j/1He4EdD
         ilsxvaKujrJHWeyt1h3eeNSHVAZZsZOoMhPMeGhrYow8Cd8dtYnw1UixGiMYz2gwSFh+
         L+bpPR7DWC5EatPdwzlyHjqtsBEAHyiQJdzU44Vf0zOL6ayBjO6geR8ZHkOZ/H17xLsN
         nyw/fCwaViinNMhn/AlzY/4K0t26jqT/O85TSFUYDNM9VKND1C0+G773Racv71GglaIn
         /dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y3cH/k4X9c9gMMu/uU1sRz7+q1h8kNwjSNhobDRWoWM=;
        b=Kkm4vlWtM3ISa0eTntUAZenao6ZD2IXYLx2ASSdOspxTUDIZ7myS3Rlc6ryqv8jFly
         Y9lbek5uzxF9KScQkbGQJ2oTuc9p8HNaJv2VyvgUxyZ8F50DEmj/FRc5iWOQzFFsNxoX
         Sjja6AEjtMdsqFYnLxkuvSpzpLXoRyCtc7ohieq1HJnzbDeOQmuj5r7zC+y+3nj9sVXA
         m/C9rKjQam4U7QoxtIhqdlLoLC6oAFfgZJgNuLTC+p+u+QXgBnjGJeLXC4PggjZpeUBG
         DjOYm0EwnPNxrrYrgz6uqwoUKsp8Qkqy1OjyqnnVx541pg+V78ht2UPGEB8PAPPuJFwu
         7cyg==
X-Gm-Message-State: AGi0PuaAbCDLVhL4jo26neEF/4g4HvdT5bWywvIWbFzFdKa9gNX/i1Sc
        8+1osyWtz24RdUykjolaHD4uMBMEtys=
X-Google-Smtp-Source: APiQypJ1khrn3M8QQdPSAOzgE2v80D+wUZ7I/BMxRQy+PXn+Mop7TetRv4+VZy46QcP4JvYeYWFPRg==
X-Received: by 2002:a17:90a:324f:: with SMTP id k73mr2937084pjb.195.1587678905880;
        Thu, 23 Apr 2020 14:55:05 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id k12sm2972294pgj.33.2020.04.23.14.55.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 14:55:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/6] emulator: Fix version number of ISO related features
Date:   Thu, 23 Apr 2020 14:54:58 -0700
Message-Id: <20200423215501.427266-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200423215501.427266-1-luiz.dentz@gmail.com>
References: <20200423215501.427266-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

There are part of Bluetooth 5.2 specification not 6.0.
---
 emulator/btdev.c  | 66 +++++++++++++++++++++++------------------------
 emulator/btdev.h  |  2 +-
 emulator/hciemu.c |  4 +--
 emulator/hciemu.h |  2 +-
 emulator/vhci.c   |  2 +-
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 0de273e53..fc2fb2065 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -447,7 +447,7 @@ static void set_le_50_commands(struct btdev *btdev)
 	btdev->commands[38] |= 0x40;	/* LE Read Periodic Adv List Size */
 }
 
-static void set_le_60_commands(struct btdev *btdev)
+static void set_le_52_commands(struct btdev *btdev)
 {
 	btdev->commands[41] |= 0x20;	/* LE Read Buffer Size v2 */
 	btdev->commands[41] |= 0x40;	/* LE Read ISO TX Sync */
@@ -516,9 +516,9 @@ static void set_le_commands(struct btdev *btdev)
 	if (btdev->type >= BTDEV_TYPE_BREDRLE50)
 		set_le_50_commands(btdev);
 
-	/* Extra LE commands for >= 6.0 adapters */
-	if (btdev->type >= BTDEV_TYPE_BREDRLE60)
-		set_le_60_commands(btdev);
+	/* Extra LE commands for >= 5.2 adapters */
+	if (btdev->type >= BTDEV_TYPE_BREDRLE52)
+		set_le_52_commands(btdev);
 }
 
 static void set_bredrle_commands(struct btdev *btdev)
@@ -587,7 +587,7 @@ static void set_bredrle_features(struct btdev *btdev)
 		btdev->le_features[1] |= 0x10;  /* LE EXT ADV */
 	}
 
-	if (btdev->type >= BTDEV_TYPE_BREDRLE60) {
+	if (btdev->type >= BTDEV_TYPE_BREDRLE52) {
 		btdev->le_features[3] |= 0x10;  /* LE CIS Master */
 		btdev->le_features[3] |= 0x20;  /* LE CIS Slave */
 		btdev->le_features[3] |= 0x40;  /* LE ISO Broadcaster */
@@ -691,7 +691,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 
 	if (type == BTDEV_TYPE_BREDRLE || type == BTDEV_TYPE_LE ||
 			type == BTDEV_TYPE_BREDRLE50 ||
-			type == BTDEV_TYPE_BREDRLE60) {
+			type == BTDEV_TYPE_BREDRLE52) {
 		btdev->crypto = bt_crypto_new();
 		if (!btdev->crypto) {
 			free(btdev);
@@ -707,7 +707,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	switch (btdev->type) {
 	case BTDEV_TYPE_BREDRLE:
 	case BTDEV_TYPE_BREDRLE50:
-	case BTDEV_TYPE_BREDRLE60:
+	case BTDEV_TYPE_BREDRLE52:
 		btdev->version = 0x09;
 		set_bredrle_features(btdev);
 		set_bredrle_commands(btdev);
@@ -3076,7 +3076,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	case BT_HCI_CMD_READ_LE_HOST_SUPPORTED:
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
 				btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 		rlhs.status = BT_HCI_ERR_SUCCESS;
 		rlhs.supported = btdev->le_supported;
@@ -3088,7 +3088,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
 				btdev->type != BTDEV_TYPE_LE &&
 				btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 		wlhs = data;
 		btdev->le_supported = wlhs->supported;
@@ -3100,7 +3100,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	case BT_HCI_CMD_READ_SECURE_CONN_SUPPORT:
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
 				btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 		rscs.status = BT_HCI_ERR_SUCCESS;
 		rscs.support = btdev->secure_conn_support;
@@ -3110,7 +3110,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	case BT_HCI_CMD_WRITE_SECURE_CONN_SUPPORT:
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
 				btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 		wscs = data;
 		btdev->secure_conn_support = wscs->support;
@@ -3121,7 +3121,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	case BT_HCI_CMD_READ_LOCAL_OOB_EXT_DATA:
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
 				btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 		rloed.status = BT_HCI_ERR_SUCCESS;
 		cmd_complete(btdev, opcode, &rloed, sizeof(rloed));
@@ -3130,7 +3130,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	case BT_HCI_CMD_READ_SYNC_TRAIN_PARAMS:
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
 				btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 		rstp.status = BT_HCI_ERR_SUCCESS;
 		rstp.interval = cpu_to_le16(btdev->sync_train_interval);
@@ -3282,7 +3282,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
 					btdev->type != BTDEV_TYPE_BREDR &&
 					btdev->type != BTDEV_TYPE_BREDRLE50 &&
-					btdev->type != BTDEV_TYPE_BREDRLE60)
+					btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 		reks = data;
 		read_enc_key_size_complete(btdev, le16_to_cpu(reks->handle));
@@ -3658,7 +3658,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_READ_NUM_SUPPORTED_ADV_SETS:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		rlrnsas.status = BT_HCI_ERR_SUCCESS;
@@ -3668,7 +3668,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_SET_ADV_SET_RAND_ADDR:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		lsasra = data;
@@ -3678,7 +3678,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		if (btdev->le_adv_enable) {
@@ -3699,7 +3699,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		lseae = data;
@@ -3715,7 +3715,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_ADV_DATA:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		lsead = data;
@@ -3726,7 +3726,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_SCAN_RSP_DATA:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		lsesrd = data;
@@ -3737,7 +3737,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_REMOVE_ADV_SET:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		status = BT_HCI_ERR_SUCCESS;
@@ -3745,7 +3745,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_CLEAR_ADV_SETS:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		status = BT_HCI_ERR_SUCCESS;
@@ -3767,7 +3767,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		lsesp = data;
@@ -3790,7 +3790,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		lsese = data;
@@ -3805,14 +3805,14 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_EXT_CREATE_CONN:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
 		break;
 
 	case BT_HCI_CMD_LE_READ_BUFFER_SIZE_V2:
-		if (btdev->type != BTDEV_TYPE_BREDRLE60)
+		if (btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 		lrbsv2.status = BT_HCI_ERR_SUCCESS;
 		lrbsv2.acl_mtu = cpu_to_le16(btdev->acl_mtu);
@@ -3823,7 +3823,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 
 	case BT_HCI_CMD_LE_SET_CIG_PARAMS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE60)
+		if (btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 		memcpy(&btdev->le_cig, data, len);
 		lscp.params.status = BT_HCI_ERR_SUCCESS;
@@ -3834,7 +3834,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 
 	case BT_HCI_CMD_LE_CREATE_CIS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE60)
+		if (btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
@@ -3842,7 +3842,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 
 	case BT_HCI_CMD_LE_ACCEPT_CIS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE60)
+		if (btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
@@ -3851,7 +3851,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 
 	case BT_HCI_CMD_LE_REJECT_CIS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE60)
+		if (btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
@@ -4098,7 +4098,7 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			return;
 		lsese = data;
 		if (btdev->le_scan_enable && lsese->enable)
@@ -4106,7 +4106,7 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_EXT_CREATE_CONN:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			return;
 		leecc = data;
 		btdev->le_scan_own_addr_type = leecc->own_addr_type;
@@ -4114,7 +4114,7 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_CREATE_CIS:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			return;
 		leccis = data;
 		le_cis_request(btdev, leccis);
diff --git a/emulator/btdev.h b/emulator/btdev.h
index b535930de..a9f71b281 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -64,7 +64,7 @@ enum btdev_type {
 	BTDEV_TYPE_AMP,
 	BTDEV_TYPE_BREDR20,
 	BTDEV_TYPE_BREDRLE50,
-	BTDEV_TYPE_BREDRLE60,
+	BTDEV_TYPE_BREDRLE52,
 };
 
 enum btdev_hook_type {
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 23891a2ee..ac861cce2 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -335,8 +335,8 @@ struct hciemu *hciemu_new(enum hciemu_type type)
 	case HCIEMU_TYPE_BREDRLE50:
 		hciemu->btdev_type = BTDEV_TYPE_BREDRLE50;
 		break;
-	case HCIEMU_TYPE_BREDRLE60:
-		hciemu->btdev_type = BTDEV_TYPE_BREDRLE60;
+	case HCIEMU_TYPE_BREDRLE52:
+		hciemu->btdev_type = BTDEV_TYPE_BREDRLE52;
 		break;
 	default:
 		return NULL;
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index 6f651cb98..4c8858bb6 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -32,7 +32,7 @@ enum hciemu_type {
 	HCIEMU_TYPE_LE,
 	HCIEMU_TYPE_LEGACY,
 	HCIEMU_TYPE_BREDRLE50,
-	HCIEMU_TYPE_BREDRLE60,
+	HCIEMU_TYPE_BREDRLE52,
 };
 
 enum hciemu_hook_type {
diff --git a/emulator/vhci.c b/emulator/vhci.c
index 7a69b484e..f79b34f46 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -105,7 +105,7 @@ struct vhci *vhci_open(enum vhci_type type)
 
 	switch (type) {
 	case VHCI_TYPE_BREDRLE:
-		btdev_type = BTDEV_TYPE_BREDRLE60;
+		btdev_type = BTDEV_TYPE_BREDRLE52;
 		ctrl_type = HCI_PRIMARY;
 		break;
 	case VHCI_TYPE_BREDR:
-- 
2.25.3

