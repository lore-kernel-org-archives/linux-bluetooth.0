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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353ADC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Feb 2021 21:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD06664F7C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Feb 2021 21:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhBDVDK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhBDVDI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Feb 2021 16:03:08 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F7FC0613D6
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Feb 2021 13:02:27 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id m6so2903412pfk.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Feb 2021 13:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cxJ2AcqmvudTDKqZIphB7sIF2A+O2rDouQtJy9HYwBU=;
        b=E36d1jvJSw7hqo7Oh2mdCqvXetP2ubYAdvkGsCuoy1V1hPtzB+BuM/coO071O1PVIO
         uDTG8WGPBdMCmHPwPkcak8UeohEhSiKN4XDrdJF7gxrm2tL6Ys2IP1C648bBTHqfEgmu
         lQMHZy36Mdvq21SnoPBopbTRG+sq0c1dGnE0Q6Ksd1qIUQ5ANJgXQNSP0e3lAU4zTm3c
         OeS2/MwG6n3qMi9/1KjEWZoXVvSU2vCWs37dA0rqbYIQIshrvSeWV/sbewLCknyQBR2e
         ftxCXXYurhifrzX3d12RCTFGcWMBmbDDaKRp+5KRqMAuTSb5XQIcl89Auw88DXkQkQ1c
         n3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cxJ2AcqmvudTDKqZIphB7sIF2A+O2rDouQtJy9HYwBU=;
        b=WT7mmkgMH98lPZ9gXLYrBIFv5yYy7DJi1aOyEj/c+kq/k0UY/YH8DG8fi6WZ2B6eMY
         5XpQLvioeYUPgJQpksvAfZNlpS00crJp+pc19xE7vQUKoFZIpkjwdCDPZ5G5uUlb9HFA
         RPVUb/1ldP/ZY1LfG8Vnb32cm8v6r7gplj078M09BHaQUTg1OChc7Kqfi4F1NnccqILn
         HFZQlka6tMMHJyYzfYrPaqjOOdWH/5lC4XrE7sx4EXm/O0Soy0dPbM/aZs8/YvPqiRg8
         gWVt4FsBcd+weyRtuzg34z4p4z+eMT8guPtvXP9E249MX/OsDPvICX4U6FvFygvOkFJr
         vSog==
X-Gm-Message-State: AOAM531zr6fZpc7p32KvyeiF+pb10I1Md5Gxd6TCd+UhZwkHcoccnCej
        jmSeP8fMOFGn4fVWycRSBU/BqF2Tz7eK2w==
X-Google-Smtp-Source: ABdhPJwR2c5mVGx8kfkY0zc1/75+q+dF7AEskxMkBFP4TOf+kS2eW4WIpCLNgc6T4NvQv+ylLAUw+Q==
X-Received: by 2002:a63:c64c:: with SMTP id x12mr832904pgg.293.1612472547106;
        Thu, 04 Feb 2021 13:02:27 -0800 (PST)
Received: from CWHIT-MBP1.hitronhub.home (76-14-108-251.rk.wavecable.com. [76.14.108.251])
        by smtp.gmail.com with ESMTPSA id r20sm7297804pgb.3.2021.02.04.13.02.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 13:02:26 -0800 (PST)
From:   Chris White <cdwhite13@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     cwhit@dolby.com, Keyur Parekh <kpare@dolby.com>
Subject: [PATCH] emulator: Periodic Advertising and Create BIG Command
Date:   Thu,  4 Feb 2021 13:02:22 -0800
Message-Id: <20210204210222.69767-1-cdwhite13@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Keyur Parekh <kpare@dolby.com>

This adds support for Periodic Advertising and the Create BIG HCI
command in the emulator. These changes are the first step in making
the emulator useful for testing the LE Audio broadcast feature.
---
 emulator/btdev.c | 82 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 9 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 17965f9b6..3f9201ba2 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -141,6 +141,12 @@ struct btdev {
 	uint8_t  le_scan_own_addr_type;
 	uint8_t  le_filter_dup;
 	uint8_t  le_adv_enable;
+        uint8_t  le_periodic_adv_enable;
+        uint16_t le_periodic_adv_properties;
+        uint16_t le_periodic_min_interval;
+        uint16_t le_periodic_max_interval;
+        uint8_t  le_periodic_data_len;
+        uint8_t  le_periodic_data[31];
 	uint8_t  le_ltk[16];
 	struct {
 		struct bt_hci_cmd_le_set_cig_params params;
@@ -3008,7 +3014,6 @@ static void le_send_adv_report(struct btdev *btdev, const struct btdev *remote,
 	} meta_event;
 
 	meta_event.subevent = BT_HCI_EVT_LE_ADV_REPORT;
-
 	memset(&meta_event.lar, 0, sizeof(meta_event.lar));
 	meta_event.lar.num_reports = 1;
 	meta_event.lar.event_type = type;
@@ -3934,22 +3939,57 @@ static int cmd_clear_adv_sets(struct btdev *dev, const void *data,
 static int cmd_set_per_adv_params(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-	/* TODO */
-	return -ENOTSUP;
+	const struct bt_hci_cmd_le_set_periodic_adv_params *cmd = data;
+	uint8_t status;
+
+	if (dev->le_periodic_adv_enable) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+	}
+	else {
+		status = BT_HCI_ERR_SUCCESS;
+		dev->le_periodic_adv_properties = le16_to_cpu(cmd->properties);
+		dev->le_periodic_min_interval = cmd->min_interval;
+		dev->le_periodic_max_interval = cmd->max_interval;
+	}
+
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_PERIODIC_ADV_PARAMS, &status,
+							sizeof(status));
+
+	return 0;
 }
 
 static int cmd_set_per_adv_data(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-	/* TODO */
-	return -ENOTSUP;
+	const struct bt_hci_cmd_le_set_periodic_adv_data *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	dev->le_periodic_data_len = cmd->data_len;
+	memcpy(dev->le_periodic_data, cmd->data, 31);
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_PERIODIC_ADV_DATA, &status,
+							sizeof(status));
+
+	return 0;
 }
 
 static int cmd_set_per_adv_enable(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-	/* TODO */
-	return -ENOTSUP;
+	const struct bt_hci_cmd_le_set_periodic_adv_enable *cmd = data;
+	uint8_t status;
+
+	if (dev->le_periodic_adv_enable == cmd->enable) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+	}
+	else {
+		dev->le_periodic_adv_enable = cmd->enable;
+		status = BT_HCI_ERR_SUCCESS;
+	}
+
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_PERIODIC_ADV_ENABLE, &status,
+							sizeof(status));
+
+	return 0;
 }
 
 static int cmd_set_ext_scan_params(struct btdev *dev, const void *data,
@@ -4470,9 +4510,32 @@ static int cmd_reject_cis(struct btdev *dev, const void *data, uint8_t len)
 static int cmd_create_big(struct btdev *dev, const void *data, uint8_t len)
 {
 	/* TODO */
-	return -ENOTSUP;
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_CREATE_BIG);
+
+	return 0;
 }
 
+static int cmd_create_big_complete(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_le_create_big *cmd = data;
+	int i;
+
+	for (i = 0; i < cmd->num_bis; i++) {
+		const struct bt_hci_bis *bis = &cmd->bis[i];
+		struct  bt_hci_evt_le_big_complete evt;
+
+		evt.big_id = cmd->big_id;
+		evt.num_bis = cmd->num_bis;
+		evt.phy = bis->phy;
+		memcpy(&evt.latency, &(bis->latency), 3);
+
+		le_meta_event(dev, BT_HCI_EVT_LE_BIG_COMPLETE, &evt,
+					sizeof(evt));
+	}
+
+	return 0;
+}
 static int cmd_create_big_test(struct btdev *dev, const void *data, uint8_t len)
 {
 	/* TODO */
@@ -4621,7 +4684,8 @@ static int cmd_set_host_feature(struct btdev *dev, const void *data,
 	CMD(BT_HCI_CMD_LE_REMOVE_CIG, cmd_remove_cig, NULL), \
 	CMD(BT_HCI_CMD_LE_ACCEPT_CIS, cmd_accept_cis, NULL), \
 	CMD(BT_HCI_CMD_LE_REJECT_CIS, cmd_reject_cis, NULL), \
-	CMD(BT_HCI_CMD_LE_CREATE_BIG, cmd_create_big, NULL), \
+	CMD(BT_HCI_CMD_LE_CREATE_BIG, cmd_create_big, \
+			cmd_create_big_complete), \
 	CMD(BT_HCI_CMD_LE_CREATE_BIG_TEST, cmd_create_big_test, NULL), \
 	CMD(BT_HCI_CMD_LE_TERM_BIG, cmd_term_big, NULL), \
 	CMD(BT_HCI_CMD_LE_BIG_CREATE_SYNC, cmd_big_create_sync, NULL), \
-- 
2.21.0 (Apple Git-122.2)

