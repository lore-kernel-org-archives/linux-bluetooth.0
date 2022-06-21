Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3C7C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 20:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbiFUULE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 16:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353518AbiFUULC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 16:11:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5861D2E091
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 13:10:57 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso14592170pjk.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 13:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DZuWiFX86YG5w8CHcFMhXXjjNq24ZyEkc/G+V1bcB/k=;
        b=DSWxLB38vnWkGUdhYocQdgqQ2YazRcPFEjKAyewGGpZ6t3xRDU+i2eEVsXGN3y599s
         FTrUp53Oot0F4tzzcdK1aGcMRUEF0Qz7rz1XXvFYlyllkT+LSu2SbNKtfamOUlR+pqnI
         NYV5vCDBZm+DIU53u36RzZuQom7CI04gmu3RjCzrZJWEsBV6HvRbdkzb2nqS00lRgRtN
         BvD/n1+5JpflzverLVQn2xG4F4ylUf196elJ1MifiJgXmvjJLhS3anocCPtuc4bCUe99
         hAtb0LLQZ+/XZgCgCWSiDxck+Nj+q+vUOambbNvsofkUcVTGX43iq+m98KaEDU+Q+5Kw
         wUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DZuWiFX86YG5w8CHcFMhXXjjNq24ZyEkc/G+V1bcB/k=;
        b=ari/IWFTlvZO0Yl9BbFWiXqIIW+rOHx1TTlTrFANADnoUSqKuvXbue85ybQOibDrma
         dNKogIAtEW+lS+hszOh0q/gcGHIVPoIjxARTiwym49mkUmUHHdqFpJT7JDZBnWccKDHy
         D0THw0KtAIBUsQAdrLzIf0A8k7hcPmx7rfFSBFxcI0zaQn7UQ0GEZxKjx6YhB32oCqsR
         GiwCNfIXHO9VSA82eLI3AI/G8fFf7AqgqfZytzcFAPl8Or/cjdN7GIsSibT3wUO8cxiA
         qH3tUfL9+8L/qTW5o+Uw9SF78ijY8OHj2kuSQTCvTfrcjTSSQJfeNfEORqivV1H1GskW
         vHQA==
X-Gm-Message-State: AJIora/AD5pk3Sjh2oJQhJasjG16wgwNPft5jOt8hYas7viocqoIf2bq
        RE7wnoSv1dt+WPJcu3VAGVhsGxHgLpc=
X-Google-Smtp-Source: AGRyM1uAbAipb1iIk6aiYPih+smFFqaJrX5JKs/W8z1nsct5Mp4un6Zl/fXMMMYBMrEdwlGlvuEBRQ==
X-Received: by 2002:a17:903:11cd:b0:167:90e6:5d83 with SMTP id q13-20020a17090311cd00b0016790e65d83mr30158519plh.136.1655842256583;
        Tue, 21 Jun 2022 13:10:56 -0700 (PDT)
Received: from han1-ubuntu-dev.. (c-76-115-118-196.hsd1.or.comcast.net. [76.115.118.196])
        by smtp.gmail.com with ESMTPSA id t14-20020a63954e000000b0040c644e82efsm8307101pgn.43.2022.06.21.13.10.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 13:10:56 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] tools/mgmt-tester: Add test case for scan response data is not updating
Date:   Tue, 21 Jun 2022 13:10:54 -0700
Message-Id: <20220621201054.66411-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds a test case to test if the scan response data is updated
when the following scenarios are performed.

1. Add Extended Advertising Parameters Command
2. Add Extended Advertising Data Command w/ Scan Resp Data
3. Remove Advertising Command
4. Add Extended Advertising Parameters Command
5. Add Extended Advertising Data Command w/ Scan Resp Data
6. Host should set Scan Resp Data
---
 tools/mgmt-tester.c | 85 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 2b27394a1..f45a6c015 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -6156,6 +6156,23 @@ static void setup_pairing_acceptor(const void *test_data)
 	setup_bthost();
 }
 
+/* Generic callback for checking the mgmt evnet status
+ */
+static void generic_mgmt_status_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	bool bthost = PTR_TO_INT(user_data);
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	if (bthost)
+		setup_bthost();
+}
+
+
 static void setup_powered_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -6990,6 +7007,66 @@ static void setup_ext_adv_params(const void *test_data)
 					NULL, NULL);
 }
 
+static const uint8_t hci_set_ext_adv_data_name[] = {
+	0x01, /* Handle */
+	0x03, /* Operation */
+	0x01, /* Complete name */
+	0x06, 0x05, 0x08, 0x74, 0x65, 0x73, 0x74
+};
+
+static const struct generic_data add_ext_adv_scan_resp_off_on = {
+	.send_opcode = MGMT_OP_ADD_EXT_ADV_DATA,
+	.send_param = ext_adv_data_valid,
+	.send_len = sizeof(ext_adv_data_valid),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = ext_adv_data_mgmt_rsp_valid,
+	.expect_len = sizeof(ext_adv_data_mgmt_rsp_valid),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_RSP_DATA,
+	.expect_hci_param = hci_set_ext_adv_data_name,
+	.expect_hci_len = sizeof(hci_set_ext_adv_data_name),
+};
+
+static void setup_add_ext_adv_on_off(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+	int enable_bthost = 1;
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+					sizeof(param), &param,
+					NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), &param,
+					generic_mgmt_status_callback,
+					NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_EXT_ADV_PARAMS, data->mgmt_index,
+					sizeof(ext_adv_params_valid),
+					&ext_adv_params_valid,
+					generic_mgmt_status_callback,
+					NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_EXT_ADV_DATA, data->mgmt_index,
+					sizeof(ext_adv_data_valid),
+					&ext_adv_data_valid,
+					generic_mgmt_status_callback,
+					NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_REMOVE_ADVERTISING, data->mgmt_index,
+					sizeof(remove_advertising_param_1),
+					&remove_advertising_param_1,
+					generic_mgmt_status_callback,
+					NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_EXT_ADV_PARAMS, data->mgmt_index,
+					sizeof(ext_adv_params_valid),
+					&ext_adv_params_valid,
+					generic_mgmt_status_callback,
+					INT_TO_PTR(enable_bthost), NULL);
+
+}
+
 static void pin_code_request_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -13960,11 +14037,17 @@ int main(int argc, char *argv[])
 				setup_ext_adv_params,
 				test_command_generic);
 
-	test_bredrle50("zxcv Ext Adv MGMT - AD Scan Response (5.0) Success",
+	test_bredrle50("Ext Adv MGMT - AD Scan Response (5.0) Success",
 				&adv_scan_rsp_success,
 				setup_ext_adv_params,
 				test_command_generic);
 
+	test_bredrle50("Ext Adv MGMT - AD Scan Resp - Off and On",
+				&add_ext_adv_scan_resp_off_on,
+				setup_add_ext_adv_on_off,
+				test_command_generic);
+
+
 	/* MGMT_OP_SET_DEVICE_ID
 	 * Using Bluetooth SIG for source.
 	 */
-- 
2.34.1

