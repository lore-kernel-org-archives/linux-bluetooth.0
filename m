Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64740C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 17:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD3F5206F7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 17:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wTIyu7eB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390767AbgKXRbu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 12:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbgKXRbu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 12:31:50 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DE9C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 09:31:48 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id r16so6116764qtn.19
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 09:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CxaVddQvULI61kSU5Y7AnX0+n/vs6G8AV3wj695Zgp4=;
        b=wTIyu7eB/MX9NrVRyJzP20eH2nrB86ebrpCVuEAydCtna4LDwXLNGaeLSHtrL/ReYE
         zocE9fB/0z0E2ZdbFzVZsfFd29odpLUF1HTJWDfhJcr8FLlBZGHNPiA2F4zYWp/faaW+
         NnuEdPiOE4bFe1Iw5KOMw1PmGzVJk7HvpYYOeRfsYLAICp9P9heOXGNH+ihK/iY7scr/
         vMDtE1GobFjpVcMIOaUGKjuylmdZBKi/8WK98PgShgowqd6f6oc8fng0pu//8S/+DCuA
         JOueuQ+Mlsyjn3XNaW5brxzUipooMq1U7VkxIK81S9s2zg2ViBfezXU7Ex2DAnaYliqN
         YjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CxaVddQvULI61kSU5Y7AnX0+n/vs6G8AV3wj695Zgp4=;
        b=ebSaNf5cDcCmL7nRJnu0GFSXOtSDEscIc76Uw3J90/bUymtba4GkBwiVc0Vmo2m1fK
         PlTIr2lY7A9+M0e6luT738Ws/KePTFdZE0A5R9sP4xzsGG2rlz+SaFS2ExMDI7S8bFVl
         FcVa+aV/8wlN0TSzQDXUaf0SGsBDo9CvsBr4PpYPQX5ueZuucozT3ix94kUq2P1djR6y
         tfwspYjMCiqhngcEptxshjcZaMPXSdpERzYFVlFkMNRELIelVJco8bjoYU/wjjwV5Tgt
         VC7LfWwZzA3Z6i1nLBBVds/FKvVs5HApDDnECqWE1V6QzmPaHB7e/jwWr+asgy6Vw725
         6IxQ==
X-Gm-Message-State: AOAM53093E1DCE+tCZBKThbHRl6/byjHuTkOmdb5ZlnIdQAs2b/g01C1
        ojXDpchLU0VurD9o++2djJk2ncOGMZ1x66cPm1vy
X-Google-Smtp-Source: ABdhPJyLzqSTFGshUlcVdCYDPVMg44qSy35f5T5x/7CSKaJ/0ecLYp9dqnzwqKTP+gFyyFaEPzfRyiyzL1A6JhDeOWkV
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a0c:9e43:: with SMTP id
 z3mr2106885qve.2.1606239107788; Tue, 24 Nov 2020 09:31:47 -0800 (PST)
Date:   Tue, 24 Nov 2020 09:31:23 -0800
In-Reply-To: <20201124173123.1272892-1-danielwinkler@google.com>
Message-Id: <20201124092549.Bluez.2.I9340eee6ec26b7160f69897c681fdfba166a6a67@changeid>
Mime-Version: 1.0
References: <20201124173123.1272892-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [Bluez PATCH 2/2] tools/mgmt-tester: Add tests for individual ext adv
 MGMT commands
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Daniel Winkler <danielwinkler@google.com>,
        Manish Mandlik <mmandlik@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The new extended advertising MGMT commands are paired, requiring both a
Set Parameters and Set Data command to configure a new advertisement.
This patch adds the following new tests to test these APIs:

1. Verify that if the adapter is unpowered, MGMT_OP_ADD_EXT_ADV_PARAMS
will return a rejected status.

2. Verify that MGMT_OP_ADD_EXT_ADV_PARAMS will return an invalid
parameters status if the data payload is malformed.

3. Verify that MGMT_OP_ADD_EXT_ADV_PARAMS is successful on BT4 if
request is valid by checking MGMT return value.

4. Verify that MGMT_OP_ADD_EXT_ADV_PARAMS is successful on BT5 if
request is valid by checking MGMT return value and that HCI traffic
contains a correct advertising parameters request.

5. Verify that if a MGMT_OP_ADD_EXT_ADV_DATA request is received for an
advertising instance that is unknown, i.e. MGMT_OP_ADD_EXT_ADV_PARAMS
was not yet called, an invalid parameters status is returned.

Tests 6-8 first call MGMT_OP_ADD_EXT_ADV_PARAMS successfully in setup to
then validate the contents of the subsequent MGMT_OP_ADD_EXT_ADV_DATA
call.

6. Verify that if MGMT_OP_ADD_EXT_ADV_DATA is passed an invalid tlv
structure, an invalid parameters status is returned.

7. Verify that if MGMT_OP_ADD_EXT_ADV_DATA contains a valid structure,
the hci traffic contain a correctly formed Adv Data hci request.

8. Verify that if MGMT_OP_ADD_EXT_ADV_DATA contains a valid structure,
the hci traffic contain a correctly formed Adv Scan Response hci
request.

Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

 tools/mgmt-tester.c | 293 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 293 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 79e653e9e..bef506134 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -5282,6 +5282,195 @@ static const struct generic_data read_controller_cap_success = {
 	.expect_status = MGMT_STATUS_SUCCESS,
 };
 
+static const char ext_adv_params_valid[] = {
+	0x01, /* instance */
+	0x00, 0xC0, 0x00, 0x00, /* flags, use tx power and intervals */
+	0x00, 0x00, /* duration */
+	0x00, 0x00, /* timeout */
+	0xA0, 0x00, 0x00, 0x00, /* min_interval */
+	0xA0, 0x00, 0x00, 0x00, /* max_interval */
+	0x7f, /* tx_power */
+};
+
+static const char ext_adv_hci_params_valid[] = {
+	0x01, /* handle */
+	0x10, 0x00, /* evt_properties */
+	0xA0, 0x00, 0x00, /* min_interval */
+	0xA0, 0x00, 0x00, /* max_interval */
+	0x07, /* channel_map */
+	0x01, /* own_addr_type */
+	0x00, /* peer_addr_type */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* peer_addr */
+	0x00, /* filter_policy */
+	0x7f, /* tx_power */
+	0x01, /* primary_phy */
+	0x00, /* secondary_max_skip */
+	0x01, /* secondary_phy */
+	0x00, /* sid */
+	0x00, /* notif_enable */
+};
+
+static const char ext_adv_params_mgmt_rsp_valid_50[] = {
+	0x01, /* instance */
+	0x00, /* tx_power defaults to 0 on BT5 platform*/
+	0x1f, /* max_adv_data_len */
+	0x1f, /* max_scan_rsp_len */
+};
+
+static const char ext_adv_params_mgmt_rsp_valid[] = {
+	0x01, /* instance */
+	0x7f, /* tx_power */
+	0x1f, /* max_adv_data_len */
+	0x1f, /* max_scan_rsp_len */
+};
+
+static const char ext_adv_data_mgmt_rsp_valid[] = {
+	0x01, /* instance */
+};
+
+static const uint8_t ext_adv_data_valid[] = {
+	0x01, /* instance */
+	0x04, /* Ad data len */
+	0x06, /* Scan response data len */
+	0x03, /* Section length */
+	0x19, /* GAP Appearance */
+	0x01,
+	0x23,
+	0x05, /* Section length */
+	0x08, /* ad type Short Name */
+	't',
+	'e',
+	's',
+	't',
+};
+
+static const char ext_adv_hci_ad_data_valid[] = {
+	0x01, /* handle */
+	0x03, /* operation */
+	0x01, /* minimize fragmentation */
+	0x04, /* data length */
+	0x03, /* Section length */
+	0x19, /* GAP Appearance */
+	0x01,
+	0x23,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const char ext_adv_hci_scan_rsp_data_valid[] = {
+	0x01, /* handle */
+	0x03, /* operation */
+	0x01, /* minimize fragmentation */
+	0x06,
+	0x05, /* Section length */
+	0x08, /* ad type Short Name */
+	't',
+	'e',
+	's',
+	't',
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const uint8_t ext_adv_data_invalid[] = {
+	0x01, /* instance */
+	0x04, /* Ad data len */
+	0x06, /* Scan response data len */
+	0x03, /* Section length */
+	0x19, /* GAP Appearance */
+	0x01,
+	0x23,
+	0x07, /* Section length purposefully two octets too long */
+	0x08, /* ad type Short Name */
+	't',
+	'e',
+	's',
+	't',
+};
+
+static const struct generic_data adv_params_fail_unpowered = {
+	.setup_settings = settings_le, /* Unpowered */
+	.send_opcode = MGMT_OP_ADD_EXT_ADV_PARAMS,
+	.send_param = ext_adv_params_valid,
+	.send_len = sizeof(ext_adv_params_valid),
+	.expect_status = MGMT_STATUS_REJECTED,
+};
+
+static const struct generic_data adv_params_fail_invalid_params = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_EXT_ADV_PARAMS,
+	.send_param = dummy_data,
+	.send_len = sizeof(dummy_data),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data adv_params_success = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_EXT_ADV_PARAMS,
+	.send_param = ext_adv_params_valid,
+	.send_len = sizeof(ext_adv_params_valid),
+	.expect_param = ext_adv_params_mgmt_rsp_valid,
+	.expect_len = sizeof(ext_adv_params_mgmt_rsp_valid),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
+static const struct generic_data adv_params_success_50 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_EXT_ADV_PARAMS,
+	.send_param = ext_adv_params_valid,
+	.send_len = sizeof(ext_adv_params_valid),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = ext_adv_params_mgmt_rsp_valid_50,
+	.expect_len = sizeof(ext_adv_params_mgmt_rsp_valid_50),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+	.expect_hci_param = ext_adv_hci_params_valid,
+	.expect_hci_len = sizeof(ext_adv_hci_params_valid),
+};
+
+static const struct generic_data adv_data_fail_no_params = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_EXT_ADV_DATA,
+	.send_param = ext_adv_data_valid,
+	.send_len = sizeof(ext_adv_data_valid),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data adv_data_success = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_EXT_ADV_DATA,
+	.send_param = ext_adv_data_valid,
+	.send_len = sizeof(ext_adv_data_valid),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = ext_adv_data_mgmt_rsp_valid,
+	.expect_len = sizeof(ext_adv_data_mgmt_rsp_valid),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
+	.expect_hci_param = ext_adv_hci_ad_data_valid,
+	.expect_hci_len = sizeof(ext_adv_hci_ad_data_valid),
+};
+
+static const struct generic_data adv_scan_rsp_success = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_EXT_ADV_DATA,
+	.send_param = ext_adv_data_valid,
+	.send_len = sizeof(ext_adv_data_valid),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = ext_adv_data_mgmt_rsp_valid,
+	.expect_len = sizeof(ext_adv_data_mgmt_rsp_valid),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_RSP_DATA,
+	.expect_hci_param = ext_adv_hci_scan_rsp_data_valid,
+	.expect_hci_len = sizeof(ext_adv_hci_scan_rsp_data_valid),
+};
+
+static const struct generic_data adv_data_invalid_params = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_EXT_ADV_DATA,
+	.send_param = ext_adv_data_invalid,
+	.send_len = sizeof(ext_adv_data_invalid),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
 static void client_cmd_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -6027,6 +6216,74 @@ static void setup_complete(uint8_t status, uint16_t length,
 		setup_bthost();
 }
 
+static void setup_set_unpowered_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	setup_bthost();
+}
+
+static void setup_set_le_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char power_param[] = { 0x00 };
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("Disabling power");
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+						sizeof(power_param),
+						&power_param,
+						setup_set_unpowered_callback,
+						NULL, NULL);
+}
+
+static void setup_ext_adv_not_powered(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+
+	tester_print("Enabling LE");
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+						sizeof(param), &param,
+						setup_set_le_callback,
+						NULL, NULL);
+}
+
+static void setup_set_ext_adv_params_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	setup_bthost();
+}
+
+static void setup_ext_adv_params(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	tester_print("Setting Extended Adv Params");
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_EXT_ADV_PARAMS, data->mgmt_index,
+					sizeof(ext_adv_params_valid),
+					&ext_adv_params_valid,
+					setup_set_ext_adv_params_callback,
+					NULL, NULL);
+}
+
 static void pin_code_request_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -10292,5 +10549,41 @@ int main(int argc, char *argv[])
 				&read_controller_cap_success,
 				NULL, test_50_controller_cap_response);
 
+	test_bredrle("Ext Adv MGMT Params - Unpowered",
+				&adv_params_fail_unpowered,
+				setup_ext_adv_not_powered,
+				test_command_generic);
+
+	test_bredrle("Ext Adv MGMT Params - Invalid parameters",
+				&adv_params_fail_invalid_params,
+				NULL, test_command_generic);
+
+	test_bredrle("Ext Adv MGMT Params - Success",
+				&adv_params_success,
+				NULL, test_command_generic);
+
+	test_bredrle50("Ext Adv MGMT Params - (5.0) Success",
+				&adv_params_success_50,
+				NULL, test_command_generic);
+
+	test_bredrle("Ext Adv MGMT - Data set without Params",
+				&adv_data_fail_no_params,
+				NULL, test_command_generic);
+
+	test_bredrle50("Ext Adv MGMT - AD Data (5.0) Invalid parameters",
+				&adv_data_invalid_params,
+				setup_ext_adv_params,
+				test_command_generic);
+
+	test_bredrle50("Ext Adv MGMT - AD Data (5.0) Success",
+				&adv_data_success,
+				setup_ext_adv_params,
+				test_command_generic);
+
+	test_bredrle50("Ext Adv MGMT - AD Scan Response (5.0) Success",
+				&adv_scan_rsp_success,
+				setup_ext_adv_params,
+				test_command_generic);
+
 	return tester_run();
 }
-- 
2.29.2.454.gaff20da3a2-goog

