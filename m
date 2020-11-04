Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395D4C388F7
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 23:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F9620786
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 23:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSj75rtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbgKDXmn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 18:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732852AbgKDXmg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 18:42:36 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18CEC0613D2
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 15:42:34 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id t6so72640plq.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 15:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6NChTZTWnrvWHkaUljYKkJ1mGz7635riVFxovhAsZBY=;
        b=qSj75rtKdvs5RsFohOV4J/dJbx49tZafKZVSj/Sq29uTeK1p9q0Ufzq7wxw3ECcift
         b/gAqYNPFypjEvF1lyomaTsJdJvbIsaUMgWmHYC2eNXh9L28efGHftDX3hrS4ljcZc8C
         JXzx/CVnr48VHPOxfR5uPqnZSlZZ53xilb+1sk85w7eJzFnXokiT96f1rL81XqeQd7d3
         9JsoXFuxIy959qojzUOShC9gL4ZdeTEYelfJK8I0lLWk49G5ITyjOAzBGlpoRN4IK7Vm
         xZCtukT4Up5VpSDkrAzIYtfabudhBELOcnRF3eLQ7EgjSLQwdPbBFEsJIQjbmcwZIWUP
         9n0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6NChTZTWnrvWHkaUljYKkJ1mGz7635riVFxovhAsZBY=;
        b=NM2pDZRvfGGbuJ9+XaBdoxKUW7pq29eww3oCAcjV8KI2o+JfhST/unXmW0WCP+qTEj
         CZe3JmBZyF0DdlQ0Hidz64s2SAoXvVPM/z8/oH8NvpY7oxlyi1zsF+fogfjKRLsyClCv
         hIrjkk2ejkldElNN/2kBqPxmEl5m/1/EEm/zwnUTlqo7cJrL0J5FhVJsjuStiDCk69sA
         uYIlghEUxPppCjzZMaV/KzyB66kCl0OG6UMDspHA4jhgM7RB1kmko/gO1CYoSr50ML6X
         762wB0J5oHgdEfSHn4VhLngxZcxosXBmzzqViiHzO0mQXgLkJagJUssvZjFRzlauGW+i
         lWWg==
X-Gm-Message-State: AOAM531XgQrRVj86gUZA2aty8mJy6u+tSRrKpmKsnXdTdXaPSTxz5ve3
        mJjoLMNFZld1nJP+1BEcVGTjGJL/DXc+Hw==
X-Google-Smtp-Source: ABdhPJw6Sd7rJm9xmVR+oVEQQ9LKzCKlYKAuUU/PHHV6Eb4fdd5q5RmwIx0uMq0c5Xxb077GmfEwow==
X-Received: by 2002:a17:902:778d:b029:d6:489c:67ee with SMTP id o13-20020a170902778db02900d6489c67eemr362047pll.52.1604533354192;
        Wed, 04 Nov 2020 15:42:34 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 30sm3361513pgl.45.2020.11.04.15.42.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:42:33 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/8] mgmt-tester: Update set_connectable_off_adv_param
Date:   Wed,  4 Nov 2020 15:42:24 -0800
Message-Id: <20201104234228.2257427-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201104234228.2257427-1-luiz.dentz@gmail.com>
References: <20201104234228.2257427-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Parameters have been changed in the kernel which now uses the following:

< HCI Command: LE Set Advertising Parameters (0x08|0x0006) plen 15
        Min advertising interval: 62.500 msec (0x0064)
        Max advertising interval: 93.750 msec (0x0096)
        Type: Scannable undirected - ADV_SCAN_IND (0x02)
        Own address type: Random (0x01)
        Direct address type: Public (0x00)
        Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
        Channel map: 37, 38, 39 (0x07)
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
---
 tools/mgmt-tester.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 4775fb18a..55df2953c 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -898,10 +898,10 @@ static uint16_t settings_powered_le_connectable_advertising[] = {
 					MGMT_OP_SET_ADVERTISING,
 					MGMT_OP_SET_POWERED, 0 };
 
-static uint8_t set_connectable_off_adv_param[] = {
-		0x00, 0x08,				/* min_interval */
-		0x00, 0x08,				/* max_interval */
-		0x03,					/* type */
+static uint8_t set_connectable_off_scan_adv_param[] = {
+		0x64, 0x00,				/* min_interval */
+		0x96, 0x00,				/* max_interval */
+		0x02,					/* type */
 		0x01,					/* own_addr_type */
 		0x00,					/* direct_addr_type */
 		0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* direct_addr */
@@ -919,8 +919,8 @@ static const struct generic_data set_connectable_off_le_test_2 = {
 	.expect_len = sizeof(set_connectable_off_le_settings_2),
 	.expect_settings_unset = MGMT_SETTING_CONNECTABLE,
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
-	.expect_hci_param = set_connectable_off_adv_param,
-	.expect_hci_len = sizeof(set_connectable_off_adv_param),
+	.expect_hci_param = set_connectable_off_scan_adv_param,
+	.expect_hci_len = sizeof(set_connectable_off_scan_adv_param),
 };
 
 static uint16_t settings_powered_le_discoverable[] = {
@@ -946,8 +946,8 @@ static const struct generic_data set_connectable_off_le_test_3 = {
 	.expect_len = sizeof(set_connectable_off_le_settings_2),
 	.expect_settings_unset = MGMT_SETTING_CONNECTABLE,
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
-	.expect_hci_param = set_connectable_off_adv_param,
-	.expect_hci_len = sizeof(set_connectable_off_adv_param),
+	.expect_hci_param = set_connectable_off_scan_adv_param,
+	.expect_hci_len = sizeof(set_connectable_off_scan_adv_param),
 };
 
 static const struct generic_data set_connectable_off_le_test_4 = {
@@ -961,8 +961,8 @@ static const struct generic_data set_connectable_off_le_test_4 = {
 	.expect_len = sizeof(set_connectable_off_le_settings_2),
 	.expect_settings_unset = MGMT_SETTING_CONNECTABLE,
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
-	.expect_hci_param = set_connectable_off_adv_param,
-	.expect_hci_len = sizeof(set_connectable_off_adv_param),
+	.expect_hci_param = set_connectable_off_scan_adv_param,
+	.expect_hci_len = sizeof(set_connectable_off_scan_adv_param),
 };
 
 static const char set_fast_conn_on_param[] = { 0x01 };
@@ -4738,17 +4738,6 @@ static uint16_t settings_powered_le_connectable[] = {
 						MGMT_OP_SET_LE,
 						MGMT_OP_SET_CONNECTABLE, 0 };
 
-static uint8_t set_connectable_off_scan_adv_param[] = {
-		0x00, 0x08,				/* min_interval */
-		0x00, 0x08,				/* max_interval */
-		0x02,					/* type */
-		0x01,					/* own_addr_type */
-		0x00,					/* direct_addr_type */
-		0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* direct_addr */
-		0x07,					/* channel_map */
-		0x00,					/* filter_policy */
-};
-
 static const struct generic_data add_advertising_success_13 = {
 	.setup_settings = settings_powered_le,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
@@ -4762,6 +4751,17 @@ static const struct generic_data add_advertising_success_13 = {
 	.expect_hci_len = sizeof(set_connectable_off_scan_adv_param),
 };
 
+static uint8_t set_connectable_off_adv_param[] = {
+		0x64, 0x00,				/* min_interval */
+		0x96, 0x00,				/* max_interval */
+		0x03,					/* type */
+		0x01,					/* own_addr_type */
+		0x00,					/* direct_addr_type */
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* direct_addr */
+		0x07,					/* channel_map */
+		0x00,					/* filter_policy */
+};
+
 static const struct generic_data add_advertising_success_14 = {
 	.setup_settings = settings_powered_le,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-- 
2.26.2

