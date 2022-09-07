Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E769CC38145
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Sep 2022 23:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiIGXtF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Sep 2022 19:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIGXtD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Sep 2022 19:49:03 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16680C7BB2
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 16:49:03 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id e68so3128639pfe.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Sep 2022 16:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=ZrsJv4jknp+UIazWFUuN1CyPTdJpNexWrQlalQ6qGSo=;
        b=N2+XwbtSBt94/GJKg3HYYVY49axoB1Jp9fSrAl/YaIcjFLj3XUqJj4crmYzi04vXSP
         HXvRUkLuurJVUojI7Wftag8vy5gfqjDQVysT4WcsShBpuixQZw0GYEw0u1hKRTF+pclM
         k1qlqu401PQ0NqMlR14WZAQcRCb5aeiKhPv+FU7V2zyI5iHAo22LxIpMS8g554Lnj4nq
         Ve7AfgVn8TylYDewo7gA8P94C2Fa70xjDc73YYXzi5txu6h2Je0nhvUPWudPCn48LTsq
         D9vB9Y8U8bM1GBZwMsh2BOOa+Eqcqe9MeX7hiy8nglXaphPhlwlQI6hp8rij3YUXzfNp
         9A4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=ZrsJv4jknp+UIazWFUuN1CyPTdJpNexWrQlalQ6qGSo=;
        b=dq/J1qf/GqCWMXpHzxRcftI4x3s79R3O5fipGzMxCFVz9ydbSlfnz4r04aCj0R/kqb
         fa1Eg/fJj1LpIqxEMnAQVNO7JX1CwODz45/+c32GIkmzU0yV5nTRChUs7qkHOYEqmNhk
         +xHb22tNVhJpHuumgRawb0lRkoMz83o2D7gTn7raE0xboA2mH+SyJCbz0QhFHyNrHEyL
         UB6I7MG24SOqOKDkoFMWiQGydQKZMINnqRADRDwk+LHdAxNq3fbUUn9lycBjoF93590b
         uGMYTtMVN5P0lVZVk51MnX/PitPmPESw6a0osdBuRBWvidxp4nH5UL1AODSKQAXwJbhr
         HI+Q==
X-Gm-Message-State: ACgBeo0DfhjWiCpow1VYY8jdPalYOT8R02mr1MKDGTUvPNjxncKZxTpA
        rESj+qlHjn6XDqnupuuwIH2oCKdr2q50vg==
X-Google-Smtp-Source: AA6agR7xQ+U6NRt6yotF8XXCo2AbNX1NtATg3141yEGWsdBqcBSrDCHdD6JrkNaTefZQwjuTnr5pqQ==
X-Received: by 2002:a63:5f0f:0:b0:434:fe5a:91c6 with SMTP id t15-20020a635f0f000000b00434fe5a91c6mr3303616pgb.188.1662594541995;
        Wed, 07 Sep 2022 16:49:01 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g9-20020aa79f09000000b005383a0d9699sm13690791pfr.144.2022.09.07.16.49.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:49:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mgmt-tester: Fix Get/Set PHY tests
Date:   Wed,  7 Sep 2022 16:49:00 -0700
Message-Id: <20220907234900.3258263-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following tests now that all supported PHYs are enabled
by default:

Start Discovery LE - (Ext Scan Param)   Failed
Get PHY Success                         Failed
Set PHY 1m 2m coded Succcess            Timed out
---
 tools/mgmt-tester.c | 49 ++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 5747ab84bedb..38562b873dd4 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -9402,7 +9402,7 @@ static const struct generic_data add_ext_advertising_conn_off_1m = {
 static const uint8_t get_phy_param[] = {
 	0xff, 0x7f, 0x00, 0x00,	/* All PHYs */
 	0xfe, 0x79,	0x00, 0x00, /* All PHYs except BR 1M 1SLOT, LE 1M TX & LE 1M RX */
-	0xff, 0x07, 0x00, 0x00, /* All BREDR PHYs and LE 1M TX & LE 1M RX */
+	0xff, 0x7f, 0x00, 0x00, /* All PHYs */
 };
 
 static const struct generic_data get_phy_success = {
@@ -9465,26 +9465,6 @@ static const uint8_t set_phy_all_param[] = {
 	0xff, 0x7f,	0x00, 0x00	/* All PHYs */
 };
 
-static const uint8_t set_default_phy_all_param[] = {
-	0x00, 		/* preference is there for tx and rx */
-	0x07,		/* 1m 2m coded tx */
-	0x07,		/* 1m 2m coded rx */
-};
-
-static const struct generic_data set_phy_all_success = {
-	.setup_settings = settings_powered_le,
-	.send_opcode = MGMT_OP_SET_PHY_CONFIGURATION,
-	.send_param = set_phy_all_param,
-	.send_len = sizeof(set_phy_all_param),
-	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_hci_command = BT_HCI_CMD_LE_SET_DEFAULT_PHY,
-	.expect_hci_param = set_default_phy_all_param,
-	.expect_hci_len = sizeof(set_default_phy_all_param),
-	.expect_alt_ev = MGMT_EV_PHY_CONFIGURATION_CHANGED,
-	.expect_alt_ev_param = set_phy_all_param,
-	.expect_alt_ev_len = sizeof(set_phy_all_param),
-};
-
 static const uint8_t set_phy_2m_tx_param[] = {
 	0xff, 0x0f,	0x00, 0x00	/* 1mtxrx, 2m tx */
 };
@@ -9592,10 +9572,13 @@ static const struct generic_data start_discovery_le_ext_scan_enable = {
 	.expect_alt_ev_len = sizeof(start_discovery_le_evt),
 };
 
-static const char start_discovery_valid_ext_scan_param[] = {
+static const char start_discovery_ext_scan_param[] = {
 	0x01,			/* Own Addr type*/
 	0x00,			/* Scan filter policy*/
-	0x01,			/*Phys - 1m */
+	0x05,			/* Phys - 1m and Coded*/
+	0x01,			/* Type */
+	0x12, 0x00,		/* Interval */
+	0x12, 0x00,		/* Window */
 	0x01,			/* Type */
 	0x12, 0x00,		/* Interval */
 	0x12, 0x00,		/* Window */
@@ -9610,8 +9593,8 @@ static const struct generic_data start_discovery_le_ext_scan_param = {
 	.expect_param = start_discovery_le_param,
 	.expect_len = sizeof(start_discovery_le_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS,
-	.expect_hci_param = start_discovery_valid_ext_scan_param,
-	.expect_hci_len = sizeof(start_discovery_valid_ext_scan_param),
+	.expect_hci_param = start_discovery_ext_scan_param,
+	.expect_hci_len = sizeof(start_discovery_ext_scan_param),
 	.expect_alt_ev = MGMT_EV_DISCOVERING,
 	.expect_alt_ev_param = start_discovery_le_evt,
 	.expect_alt_ev_len = sizeof(start_discovery_le_evt),
@@ -9643,6 +9626,15 @@ static const struct generic_data stop_discovery_le_ext_scan_disable = {
 	.expect_alt_ev_len = sizeof(stop_discovery_evt),
 };
 
+static const char start_discovery_2m_ext_scan_param[] = {
+	0x01,			/* Own Addr type*/
+	0x00,			/* Scan filter policy*/
+	0x01,			/* Phys - 1m and Coded*/
+	0x01,			/* Type */
+	0x12, 0x00,		/* Interval */
+	0x12, 0x00,		/* Window */
+};
+
 static const struct generic_data start_discovery_le_2m_scan_param = {
 	.setup_settings = settings_powered_le,
 	.setup_send_opcode = MGMT_OP_SET_PHY_CONFIGURATION,
@@ -9655,8 +9647,8 @@ static const struct generic_data start_discovery_le_2m_scan_param = {
 	.expect_param = start_discovery_bredrle_param,
 	.expect_len = sizeof(start_discovery_bredrle_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS,
-	.expect_hci_param = start_discovery_valid_ext_scan_param,
-	.expect_hci_len = sizeof(start_discovery_valid_ext_scan_param),
+	.expect_hci_param = start_discovery_2m_ext_scan_param,
+	.expect_hci_len = sizeof(start_discovery_2m_ext_scan_param),
 	.expect_alt_ev = MGMT_EV_DISCOVERING,
 	.expect_alt_ev_param = start_discovery_evt,
 	.expect_alt_ev_len = sizeof(start_discovery_evt),
@@ -13973,9 +13965,6 @@ int main(int argc, char *argv[])
 	test_bredrle50("Set PHY coded Succcess", &set_phy_coded_success,
 					NULL, test_command_generic);
 
-	test_bredrle50("Set PHY 1m 2m coded Succcess", &set_phy_all_success,
-					NULL, test_command_generic);
-
 	test_bredrle50("Set PHY 2m tx success", &set_phy_2m_tx_success,
 					NULL, test_command_generic);
 
-- 
2.37.2

