Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467CCC433E6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 00:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0902322AAC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 00:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgLWA1c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 19:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgLWA1c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 19:27:32 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303ADC061793
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 16:26:52 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id i5so1399273pgo.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 16:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C2pZOr5Pj/yxGUKqlwUvnOKWDpBqQvQqPWcy7JPxuP8=;
        b=p+JSTCVwq0H1WaVkb+hLCURtHdzs/HeuRdNHRkMfRtCvwzpTx0X4x5KJoKe0cadYw+
         2/AwGSOvGhdOQN9bitP8Or+7taV9hx8XPI2RMhP6+3kvpeaRkO8dREtvKOmPg2USCfHe
         B9l+fP6tv53B/BqGvF8uMqXzYW9Lz9sqHCYasrUUzhCO/2MNXJ1aXNq/6X0H4Ssf1SbF
         3GpbhPuYefcWADl+OfIAlJynoS5qAd9dY86kjIhqxLQCpA7v6rEhWbE02w4dc7hXirEB
         04PFeLyuvL3eBHgmGMCf3ZRoyTiLcmLpK0A3kZ+9VMHa9p6z0G1stvrKBYVSntmZBN83
         H9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2pZOr5Pj/yxGUKqlwUvnOKWDpBqQvQqPWcy7JPxuP8=;
        b=qo4mVS6xTY49s5xhN5oLO3sz3UnTlK4cZQVwdS2M/A7nc9msWkob76Y7siCLoBU0ZB
         rL39sxfqLn3uKEb4XRogGm5EbSbfTn1GHzhII/0OoZi/SPoTcZyGJ3wTyTfkIlbCceTu
         szFc7JepO9zRS5JOBevQ3X9IK2D7CgIJCAKFKAYWF0gPN92X9AmGheQlW56xdMDvO7NF
         WWFNrfb3u7Qf1mM2947ZgO6NOjdFT7lq6RqxsOj7swk3utFrn0iU/3OK+OeI5pDufyeh
         zS05AIySOAWpXoLUAsZWDVTFNZPex6L/jI+OS+2GgL2mVQ8zdQQxbKAekYjFR6WA/jt4
         EjQA==
X-Gm-Message-State: AOAM530cQNmoGick6r9dBRzY/Wo8tCYgkZHTJe0krKi63PTv1cRFOngp
        /z4hGa9T+6CjF79MitKCqULt+6liJYY=
X-Google-Smtp-Source: ABdhPJzkJpQmRvk8haYUac10trSgJrx0LmVz8CJJb7WO7mK64ZYUpfi1/Y+2zMmKPyWnS/rTq0DxrA==
X-Received: by 2002:a63:5924:: with SMTP id n36mr10555382pgb.9.1608683211397;
        Tue, 22 Dec 2020 16:26:51 -0800 (PST)
Received: from localhost.localdomain (c-73-164-224-32.hsd1.or.comcast.net. [73.164.224.32])
        by smtp.gmail.com with ESMTPSA id 8sm5505566pfz.93.2020.12.22.16.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 16:26:50 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Google-Original-From: Tedd Ho-Jeong An <tedd.an@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     danielwinkler@google.com, tedd.an@intel.com
Subject: [PATCH 3/3] tools/mgmt-tester: Adds new test data with updated tx power
Date:   Tue, 22 Dec 2020 16:26:33 -0800
Message-Id: <20201223002633.187612-3-tedd.an@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201223002633.187612-1-tedd.an@intel.com>
References: <20201223002633.187612-1-tedd.an@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds new test data for the ext advertising test cases that
presets the advertising parameter and toggles the connectable flags.

When the adv instance is created, it updates the default tx power with
the value read from the controller. After toggling the connectable flag,
the host uses the tx_power stored in the adv list cache, which is the
value read from the controller, instead of the default tx power
value(127).
---
 tools/mgmt-tester.c | 88 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 80 insertions(+), 8 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index d9d7b3430..fe73a6d89 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -7592,6 +7592,24 @@ static const struct generic_data add_ext_advertising_success_15 = {
 	.expect_hci_len = sizeof(set_connectable_on_ext_adv_param),
 };
 
+static uint8_t preset_connectable_on_ext_adv_param[] = {
+	0x01,					/* Handle */
+	0x13, 0x00,				/* Event type */
+	0x00, 0x08, 0x00,			/* min_interval */
+	0x00, 0x08, 0x00,			/* max_interval */
+	0x07,					/* channel_map */
+	0x00,					/* own_addr_type */
+	0x00,					/* peer_addr_type */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* peer_addr */
+	0x00,					/* filter_policy */
+	0x00,					/* Tx power */
+	0x01,					/* Primary PHY */
+	0x00,					/* primary adv max skip */
+	0x01,					/* Secondary PHY */
+	0x00,					/* adv sid*/
+	0x00,					/* Scan req notification */
+};
+
 static const struct generic_data add_ext_advertising_success_16 = {
 	.send_opcode = MGMT_OP_SET_CONNECTABLE,
 	.send_param = set_connectable_on_param,
@@ -7600,8 +7618,26 @@ static const struct generic_data add_ext_advertising_success_16 = {
 	.expect_param = set_connectable_settings_param_3,
 	.expect_len = sizeof(set_connectable_settings_param_3),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
-	.expect_hci_param = set_connectable_on_ext_adv_param,
-	.expect_hci_len = sizeof(set_connectable_on_ext_adv_param),
+	.expect_hci_param = preset_connectable_on_ext_adv_param,
+	.expect_hci_len = sizeof(preset_connectable_on_ext_adv_param),
+};
+
+static uint8_t preset_connectable_off_ext_adv_param[] = {
+	0x01,					/* Handle */
+	0x10, 0x00,				/* Event type */
+	0x00, 0x08, 0x00,			/* min_interval */
+	0x00, 0x08, 0x00,			/* max_interval */
+	0x07,					/* channel_map */
+	0x01,					/* own_addr_type */
+	0x00,					/* peer_addr_type */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* peer_addr */
+	0x00,					/* filter_policy */
+	0x00,					/* Tx power */
+	0x01,					/* Primary PHY */
+	0x00,					/* primary adv max skip */
+	0x01,					/* Secondary PHY */
+	0x00,					/* adv sid*/
+	0x00,					/* Scan req notification */
 };
 
 static const struct generic_data add_ext_advertising_success_17 = {
@@ -7612,8 +7648,8 @@ static const struct generic_data add_ext_advertising_success_17 = {
 	.expect_param = set_le_settings_param_2,
 	.expect_len = sizeof(set_le_settings_param_2),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
-	.expect_hci_param = set_connectable_off_ext_adv_param,
-	.expect_hci_len = sizeof(set_connectable_off_ext_adv_param),
+	.expect_hci_param = preset_connectable_off_ext_adv_param,
+	.expect_hci_len = sizeof(preset_connectable_off_ext_adv_param),
 };
 
 static const struct generic_data add_ext_advertising_le_off = {
@@ -8240,6 +8276,24 @@ static void setup_add_advertising_1m(const void *test_data)
 						NULL, NULL);
 }
 
+static uint8_t preset_connectable_on_ext_pdu_adv_param[] = {
+	0x01,					/* Handle */
+	0x01, 0x00,				/* Event type */
+	0x00, 0x08, 0x00,			/* min_interval */
+	0x00, 0x08, 0x00,			/* max_interval */
+	0x07,					/* channel_map */
+	0x00,					/* own_addr_type */
+	0x00,					/* peer_addr_type */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* peer_addr */
+	0x00,					/* filter_policy */
+	0x00,					/* Tx power */
+	0x01,					/* Primary PHY */
+	0x00,					/* primary adv max skip */
+	0x01,					/* Secondary PHY */
+	0x00,					/* adv sid*/
+	0x00,					/* Scan req notification */
+};
+
 static const struct generic_data add_ext_advertising_conn_on_1m = {
 	.send_opcode = MGMT_OP_SET_CONNECTABLE,
 	.send_param = set_connectable_on_param,
@@ -8248,8 +8302,8 @@ static const struct generic_data add_ext_advertising_conn_on_1m = {
 	.expect_param = set_connectable_settings_param_3,
 	.expect_len = sizeof(set_connectable_settings_param_3),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
-	.expect_hci_param = set_connectable_on_ext_pdu_adv_param,
-	.expect_hci_len = sizeof(set_connectable_on_ext_pdu_adv_param),
+	.expect_hci_param = preset_connectable_on_ext_pdu_adv_param,
+	.expect_hci_len = sizeof(preset_connectable_on_ext_pdu_adv_param),
 };
 
 static void setup_add_advertising_connectable_1m(const void *test_data)
@@ -8282,6 +8336,24 @@ static void setup_add_advertising_connectable_1m(const void *test_data)
 						NULL, NULL);
 }
 
+static uint8_t preset_connectable_off_ext_1m_adv_param[] = {
+	0x01,					/* Handle */
+	0x00, 0x00,				/* Event type */
+	0x00, 0x08, 0x00,			/* min_interval */
+	0x00, 0x08, 0x00,			/* max_interval */
+	0x07,					/* channel_map */
+	0x01,					/* own_addr_type */
+	0x00,					/* peer_addr_type */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* peer_addr */
+	0x00,					/* filter_policy */
+	0x00,					/* Tx power */
+	0x01,					/* Primary PHY */
+	0x00,					/* primary adv max skip */
+	0x01,					/* Secondary PHY */
+	0x00,					/* adv sid*/
+	0x00,					/* Scan req notification */
+};
+
 static const struct generic_data add_ext_advertising_conn_off_1m = {
 	.send_opcode = MGMT_OP_SET_CONNECTABLE,
 	.send_param = set_connectable_off_param,
@@ -8290,8 +8362,8 @@ static const struct generic_data add_ext_advertising_conn_off_1m = {
 	.expect_param = set_le_settings_param_2,
 	.expect_len = sizeof(set_le_settings_param_2),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
-	.expect_hci_param = set_connectable_off_ext_1m_adv_param,
-	.expect_hci_len = sizeof(set_connectable_off_ext_1m_adv_param),
+	.expect_hci_param = preset_connectable_off_ext_1m_adv_param,
+	.expect_hci_len = sizeof(preset_connectable_off_ext_1m_adv_param),
 };
 
 static const uint8_t get_phy_param[] = {
-- 
2.25.1

