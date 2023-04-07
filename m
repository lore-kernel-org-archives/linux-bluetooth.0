Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88F7C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Apr 2023 18:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjDGSop (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Apr 2023 14:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDGSoo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Apr 2023 14:44:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE16FB456
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Apr 2023 11:44:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q102so40392076pjq.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Apr 2023 11:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680893082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=U4L+XKYDZ0CFKSgbxqd9uViWwXH3MnZou/RSC3/Bhic=;
        b=KWww3lHnZgYtudoUbjOHgKCCzgGupfAsGwg2rahuv8UMxqeTE879jI6fVybq0MwOK4
         d28G56A32FlfzNV8sFjP3v59oiPd+bUtGm4FBYOhtL6+3tKPftG9YiYGEp6GfoUQGWcS
         Q6XqpkbdQo7W8b7jVNUBXlPMkt9lm/cNAI+zyZ8iNoI4JTXR6SsyWNbP/1O3OLClj8QH
         xpKYwgHsn64qR4s2ZwgyRE3G/luiIwNNWnNfXQsFleH9gvrukTYl95Pc7CIPtLzLWXye
         yN/rP0SFC4DNaIwXzzyPdjAjafHUYReF0AqrEh+c+bVCgIHWBGzZIW38ia0d9g/lIsRx
         /phA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680893082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U4L+XKYDZ0CFKSgbxqd9uViWwXH3MnZou/RSC3/Bhic=;
        b=F5Nl0TH7e361alvFLX25i+9ML3qbkREawVOZjdnl+eSCjZaHSDmWfl3KIywV2NQWrw
         1knu801D4RXbxNr9AQoNc4fljuP9iVzvI3l76iq/cU6ML56XCEnmLdzZN5Jc3kHousCg
         VMCIAv59W+Tvj9X1LmmwclgmHRZlUrdtYRSEWr7NGR69U2tgIXBhwzSMTxX4FtUZ6AQb
         DVXpBF6NLKiqCdnFmYlQJOT+1Fob77vONp2aTvrvzc9oC8xUmzYOFSMylLLnmHT9Ctdn
         H0k44hVtf0xgXbM2Ei5uShewhkFJC/CbdDQ2KJ8JzheaubPCIENrc87LER4yMGNLzULJ
         R03Q==
X-Gm-Message-State: AAQBX9cwyEhrRVLmCJi/+kWn8VkM6MCIyPpp/GotjAPC83yNANViTSjY
        ziW3tuE1Sc+7slzXB83wt8gYTPZLEBA=
X-Google-Smtp-Source: AKy350ZwgSOvlhmxokpf8e2jQqEflWJ3sc1XoeAAA1L6z/zzcVn43Xo6z8A/fYyv9c3yYoEeipO65g==
X-Received: by 2002:a17:90b:3e84:b0:23d:e2b:cf1f with SMTP id rj4-20020a17090b3e8400b0023d0e2bcf1fmr2843648pjb.16.1680893082404;
        Fri, 07 Apr 2023 11:44:42 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id r23-20020a17090aa09700b00240dee12285sm3021393pjp.34.2023.04.07.11.44.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 11:44:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RESEND BlueZ] mgmt-tester: Fix Get/Set PHY tests
Date:   Fri,  7 Apr 2023 11:44:40 -0700
Message-Id: <20230407184440.3291592-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
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
index c0784dab5b64..b819bccbc7c0 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -9445,7 +9445,7 @@ static const struct generic_data add_ext_advertising_conn_off_1m = {
 static const uint8_t get_phy_param[] = {
 	0xff, 0x7f, 0x00, 0x00,	/* All PHYs */
 	0xfe, 0x79,	0x00, 0x00, /* All PHYs except BR 1M 1SLOT, LE 1M TX & LE 1M RX */
-	0xff, 0x07, 0x00, 0x00, /* All BREDR PHYs and LE 1M TX & LE 1M RX */
+	0xff, 0x7f, 0x00, 0x00, /* All PHYs */
 };
 
 static const struct generic_data get_phy_success = {
@@ -9508,26 +9508,6 @@ static const uint8_t set_phy_all_param[] = {
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
@@ -9635,10 +9615,13 @@ static const struct generic_data start_discovery_le_ext_scan_enable = {
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
@@ -9653,8 +9636,8 @@ static const struct generic_data start_discovery_le_ext_scan_param = {
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
@@ -9686,6 +9669,15 @@ static const struct generic_data stop_discovery_le_ext_scan_disable = {
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
@@ -9698,8 +9690,8 @@ static const struct generic_data start_discovery_le_2m_scan_param = {
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
@@ -14167,9 +14159,6 @@ int main(int argc, char *argv[])
 	test_bredrle50("Set PHY coded Succcess", &set_phy_coded_success,
 					NULL, test_command_generic);
 
-	test_bredrle50("Set PHY 1m 2m coded Succcess", &set_phy_all_success,
-					NULL, test_command_generic);
-
 	test_bredrle50("Set PHY 2m tx success", &set_phy_2m_tx_success,
 					NULL, test_command_generic);
 
-- 
2.39.2

