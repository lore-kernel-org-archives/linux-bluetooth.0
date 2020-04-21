Return-Path: <SRS0=JHfm=6F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5026AC54FCC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 22:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2582E206E9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 22:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7l16SPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgDUWZ2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgDUWZ2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 18:25:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A352C0610D5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 15:25:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a22so2013637pjk.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=stWdumnPmieMa0L7Ba6L3twmNAgPtVRN8STkeFbEOLU=;
        b=u7l16SPoSik0+MUfBpjJ448AHmC7X0QKkQ+EfamrP2SCMObTI3q2oiLmcEmE4/w9Z0
         qXMBeEINzJRipwns+H8jze0CbS0YiC3NiaQDxHK+pgaqxfP6azyc47bSNxCir1yEJQPF
         sxefD2Cg2QfGmBFz9cUiogZZBs32ZpJW5G/A/ntOgwjE3EICtPrNDb6OgPWDthtb/wIM
         njFij5rmXw3dtNnisyGRspuFC+DpCf/jgVjrSurxhLlI+ooJdGS4UOzx22TOJIKVqZpN
         1FPbmVQkpBuSuHifJsP/6rFEn91Oz5E/bMzrbLKOWndcdkFZT6lXUJlb+AiOcoZUtkEO
         xQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=stWdumnPmieMa0L7Ba6L3twmNAgPtVRN8STkeFbEOLU=;
        b=PmuIgXmwDeE1tDRUEApVYJXenG5mb8SulelzrJCqFNA6F1VQ9KvzufpjY009MY3lLE
         z7lv/J9KJ6QlEHAWRANRdbx12rnd3MShi+CygErExYdqWqwlkIB13Aq44qNpqPjAUzS6
         E6G56WKgjQ55/NSlCNlJ2uBb6oD5ky3FODI5c4+bveCIF4H40V+YmFSqQZICw3ibtV3p
         9zVyObgbzFUkkqn/DJhErgw4LM1kmr1UJDujFSpNeLhQ4T6fR0d46ML6RV5OVTn7li0A
         9jzCv4cJmkuyHcDZxmkfUl9lXZ1lYLoJ2iKRRE2IGxKGWAwq/wB2M1E0Ocj1hWMUKWFS
         zKwA==
X-Gm-Message-State: AGi0PuYx30+YM+Epnaa2nur06NXqqRJc5lV2/e7IxQh2zpOEnzPvQzfc
        mvJAP3YqMdzaUJJe2GdtJXbg6V8HKVQ=
X-Google-Smtp-Source: APiQypK6EfgaUgR0nVwOPdBo9gen82Y3T8AqAFHgkK63KCXaNLoSH7+n7Scl6jDBAgt0XtGM236OQQ==
X-Received: by 2002:a17:90a:17e7:: with SMTP id q94mr8546578pja.80.1587507926885;
        Tue, 21 Apr 2020 15:25:26 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e196sm3384040pfh.43.2020.04.21.15.25.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 15:25:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] emulator: Fix version number of ISO related features
Date:   Tue, 21 Apr 2020 15:25:21 -0700
Message-Id: <20200421222521.226385-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200421222521.226385-1-luiz.dentz@gmail.com>
References: <20200421222521.226385-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

There are part of Bluetooth 5.2 specification not 6.0.
---
 emulator/btdev.c  | 64 +++++++++++++++++++++++------------------------
 emulator/btdev.h  |  2 +-
 emulator/hciemu.c |  4 +--
 emulator/hciemu.h |  2 +-
 emulator/vhci.c   |  2 +-
 5 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index f9e1e6675..dbbf8e70a 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -517,8 +517,8 @@ static void set_le_commands(struct btdev *btdev)
 	if (btdev->type >= BTDEV_TYPE_BREDRLE50)
 		set_le_50_commands(btdev);
 
-	/* Extra LE commands for >= 6.0 adapters */
-	if (btdev->type >= BTDEV_TYPE_BREDRLE60)
+	/* Extra LE commands for >= 5.2 adapters */
+	if (btdev->type >= BTDEV_TYPE_BREDRLE52)
 		set_le_60_commands(btdev);
 }
 
@@ -588,7 +588,7 @@ static void set_bredrle_features(struct btdev *btdev)
 		btdev->le_features[1] |= 0x10;  /* LE EXT ADV */
 	}
 
-	if (btdev->type >= BTDEV_TYPE_BREDRLE60) {
+	if (btdev->type >= BTDEV_TYPE_BREDRLE52) {
 		btdev->le_features[3] |= 0x10;  /* LE CIS Master */
 		btdev->le_features[3] |= 0x20;  /* LE CIS Slave */
 		btdev->le_features[3] |= 0x40;  /* LE ISO Broadcaster */
@@ -692,7 +692,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 
 	if (type == BTDEV_TYPE_BREDRLE || type == BTDEV_TYPE_LE ||
 			type == BTDEV_TYPE_BREDRLE50 ||
-			type == BTDEV_TYPE_BREDRLE60) {
+			type == BTDEV_TYPE_BREDRLE52) {
 		btdev->crypto = bt_crypto_new();
 		if (!btdev->crypto) {
 			free(btdev);
@@ -708,7 +708,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	switch (btdev->type) {
 	case BTDEV_TYPE_BREDRLE:
 	case BTDEV_TYPE_BREDRLE50:
-	case BTDEV_TYPE_BREDRLE60:
+	case BTDEV_TYPE_BREDRLE52:
 		btdev->version = 0x09;
 		set_bredrle_features(btdev);
 		set_bredrle_commands(btdev);
@@ -3077,7 +3077,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	case BT_HCI_CMD_READ_LE_HOST_SUPPORTED:
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
 				btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 		rlhs.status = BT_HCI_ERR_SUCCESS;
 		rlhs.supported = btdev->le_supported;
@@ -3089,7 +3089,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
 				btdev->type != BTDEV_TYPE_LE &&
 				btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 		wlhs = data;
 		btdev->le_supported = wlhs->supported;
@@ -3101,7 +3101,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	case BT_HCI_CMD_READ_SECURE_CONN_SUPPORT:
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
 				btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 		rscs.status = BT_HCI_ERR_SUCCESS;
 		rscs.support = btdev->secure_conn_support;
@@ -3111,7 +3111,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	case BT_HCI_CMD_WRITE_SECURE_CONN_SUPPORT:
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
 				btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 		wscs = data;
 		btdev->secure_conn_support = wscs->support;
@@ -3122,7 +3122,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	case BT_HCI_CMD_READ_LOCAL_OOB_EXT_DATA:
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
 				btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 		rloed.status = BT_HCI_ERR_SUCCESS;
 		cmd_complete(btdev, opcode, &rloed, sizeof(rloed));
@@ -3131,7 +3131,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	case BT_HCI_CMD_READ_SYNC_TRAIN_PARAMS:
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
 				btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 		rstp.status = BT_HCI_ERR_SUCCESS;
 		rstp.interval = cpu_to_le16(btdev->sync_train_interval);
@@ -3283,7 +3283,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
 					btdev->type != BTDEV_TYPE_BREDR &&
 					btdev->type != BTDEV_TYPE_BREDRLE50 &&
-					btdev->type != BTDEV_TYPE_BREDRLE60)
+					btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 		reks = data;
 		read_enc_key_size_complete(btdev, le16_to_cpu(reks->handle));
@@ -3659,7 +3659,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_READ_NUM_SUPPORTED_ADV_SETS:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		rlrnsas.status = BT_HCI_ERR_SUCCESS;
@@ -3669,7 +3669,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_SET_ADV_SET_RAND_ADDR:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		lsasra = data;
@@ -3679,7 +3679,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		if (btdev->le_adv_enable) {
@@ -3700,7 +3700,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		lseae = data;
@@ -3716,7 +3716,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_ADV_DATA:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		lsead = data;
@@ -3727,7 +3727,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_SCAN_RSP_DATA:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		lsesrd = data;
@@ -3738,7 +3738,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_REMOVE_ADV_SET:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		status = BT_HCI_ERR_SUCCESS;
@@ -3746,7 +3746,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_CLEAR_ADV_SETS:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		status = BT_HCI_ERR_SUCCESS;
@@ -3768,7 +3768,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		lsesp = data;
@@ -3791,7 +3791,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		lsese = data;
@@ -3806,14 +3806,14 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
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
@@ -3824,7 +3824,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 
 	case BT_HCI_CMD_LE_SET_CIG_PARAMS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE60)
+		if (btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 		memcpy(&btdev->le_cig, data, len);
 		lscp.params.status = BT_HCI_ERR_SUCCESS;
@@ -3835,7 +3835,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 
 	case BT_HCI_CMD_LE_CREATE_CIS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE60)
+		if (btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
@@ -3843,7 +3843,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 
 	case BT_HCI_CMD_LE_ACCEPT_CIS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE60)
+		if (btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
@@ -3852,7 +3852,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 
 	case BT_HCI_CMD_LE_REJECT_CIS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE60)
+		if (btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
@@ -3863,7 +3863,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 
 	case BT_HCI_CMD_LE_SET_HOST_FEATURE:
-		if (btdev->type != BTDEV_TYPE_BREDRLE60)
+		if (btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
 
 		status = BT_HCI_ERR_SUCCESS;
@@ -4108,7 +4108,7 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			return;
 		lsese = data;
 		if (btdev->le_scan_enable && lsese->enable)
@@ -4116,7 +4116,7 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 		break;
 	case BT_HCI_CMD_LE_EXT_CREATE_CONN:
 		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE60)
+				btdev->type != BTDEV_TYPE_BREDRLE52)
 			return;
 		leecc = data;
 		btdev->le_scan_own_addr_type = leecc->own_addr_type;
@@ -4124,7 +4124,7 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
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

