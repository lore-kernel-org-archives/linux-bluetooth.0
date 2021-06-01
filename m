Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BA2C47093
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 20:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BEC7613CD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 20:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhFAUVK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Jun 2021 16:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbhFAUVJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Jun 2021 16:21:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23B0C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jun 2021 13:19:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso407091pji.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jun 2021 13:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BReF2G93QxleV7/aOfYUt0qAzTxqJk2dNOVnjd/DnpA=;
        b=Ap0DSdGRAcYmJqA41AQ58AvDxH3dAv07SXxz2h4oJS5O04r+ec2t9IcyfsIR/n9W1o
         RmrT1LV5Nymm7QPnwGHJVe+vgQ+wV8/iJxa6+nRHIJSh3CjeOUxgRh2kRxP1S+0LJF5e
         ne9UY+qNkpVn1SNXbtuKMjr7HZAGic7xYRnkjZUSZE8B0WF5tqDxXR+ttPkN49PtMTcs
         dEcGJu87c/8cB9AktKSpSHGj5iIfmmxXD5jhFCArSmzlyw7poObQ0dGknDki9P4ZqTMb
         wGzQJGETLb6XE+sSpF7HdG9Wg5pks7Tp8xKoAvzV5LQOlXEvFPJgtG6jSeSAQRwjGf/E
         TKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BReF2G93QxleV7/aOfYUt0qAzTxqJk2dNOVnjd/DnpA=;
        b=bICzDUqGaNZs+HRIOl3Z88f1+anwNRSdOU+fk/TTIiHF+oDDqxKrnHgX8a9wLm1W0w
         p/K1/70f92Swp6SkQNzy5Xz237+sNGT9zw9KCAWSoQgspqmsgGzslMU4J4h5dQ0Kmvyr
         Fk7fJ5EjLw8bYFXLL5bcbjKva2lbiL394MGaE1KfKS/kCCSBmp3/vwiK69R5zeETVtWs
         JDxi1Lnqvi/Txqe1nvJAFeGgwSReANxu5yp18KaEAf3BitE7qIdYTpldojY08LY9cSnH
         QV+4YsLT/9hkAhw0U1eWSz4CRx6qQC7FvNq2El5oMEeu/3GazWYxfmhnboPQkqWWeK6d
         ucoA==
X-Gm-Message-State: AOAM533xe+jOj0ZMqwmiE3Td7YHvYTk/+jMxx17LcSpK6f9fjnuLHbAx
        Z4zdmWbZzjGx2whZNxZVUF+BvSxdcYY=
X-Google-Smtp-Source: ABdhPJyj5oeYhRWPrTJ/+38vZocrxcF0nHA2ZfU+M8dW/YqWSj2z07ttDiGWi/Gxf4zpQ0Yr/k89LQ==
X-Received: by 2002:a17:90a:aa96:: with SMTP id l22mr1607090pjq.173.1622578766954;
        Tue, 01 Jun 2021 13:19:26 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id y129sm13399262pfy.123.2021.06.01.13.19.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 13:19:26 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 3/3] tools/mgmt-tester: Add tests for whitelist and resolving list
Date:   Tue,  1 Jun 2021 13:19:23 -0700
Message-Id: <20210601201923.899950-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210601201923.899950-1-hj.tedd.an@gmail.com>
References: <20210601201923.899950-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds test cases for checking the whitelist and resolving list
HCI commands when the LL Privacy feature is enabled.
---
 tools/mgmt-tester.c | 360 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 357 insertions(+), 3 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 0d7c6b9e1..d250e9600 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -2066,6 +2066,21 @@ static const struct generic_data start_discovery_valid_param_power_off_1 = {
 	.expect_len = sizeof(start_discovery_bredrle_param),
 };
 
+static const char set_resolv_off_param[] = { 0x00 };
+static const char set_resolv_on_param[] = { 0x01 };
+
+static const struct generic_data start_discovery_ll_privacy_disable_resolv = {
+	.send_opcode = MGMT_OP_START_DISCOVERY,
+	.send_param = start_discovery_le_param,
+	.send_len = sizeof(start_discovery_le_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = start_discovery_le_param,
+	.expect_len = sizeof(start_discovery_le_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
+	.expect_hci_param = set_resolv_off_param,
+	.expect_hci_len = sizeof(set_resolv_off_param),
+};
+
 static const char stop_discovery_bredrle_param[] = { 0x07 };
 static const char stop_discovery_bredrle_invalid_param[] = { 0x06 };
 static const char stop_discovery_valid_hci[] = { 0x00, 0x00 };
@@ -4049,7 +4064,7 @@ static const struct generic_data add_device_success_1 = {
 static const uint8_t add_device_success_param_2[] = {
 					0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
 					0x01,
-					0x00,
+					0x02,
 };
 static const uint8_t add_device_rsp_le[] =  {
 					0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
@@ -4117,6 +4132,65 @@ static const struct generic_data add_device_success_5 = {
 	.expect_hci_len = sizeof(le_scan_enable),
 };
 
+static const uint8_t le_add_to_white_list_param[] = {
+	0x00,					/* Type */
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
+};
+static const struct generic_data add_device_success_6 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_DEVICE,
+	.send_param = add_device_success_param_2,
+	.send_len = sizeof(add_device_success_param_2),
+	.expect_param = add_device_rsp_le,
+	.expect_len = sizeof(add_device_rsp_le),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
+	.expect_alt_ev_param = add_device_success_param_2,
+	.expect_alt_ev_len = sizeof(add_device_success_param_2),
+	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_WHITE_LIST,
+	.expect_hci_param = le_add_to_white_list_param,
+	.expect_hci_len = sizeof(le_add_to_white_list_param),
+};
+
+static const uint8_t le_add_to_resolv_list_param[] = {
+	0x00,						/* Type */
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,		/* Address */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,	/* Peer IRK */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,	/* Local IRK */
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+};
+
+static const struct generic_data add_device_success_7 = {
+	.send_opcode = MGMT_OP_ADD_DEVICE,
+	.send_param = add_device_success_param_2,
+	.send_len = sizeof(add_device_success_param_2),
+	.expect_param = add_device_rsp_le,
+	.expect_len = sizeof(add_device_rsp_le),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
+	.expect_alt_ev_param = add_device_success_param_2,
+	.expect_alt_ev_len = sizeof(add_device_success_param_2),
+	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST,
+	.expect_hci_param = le_add_to_resolv_list_param,
+	.expect_hci_len = sizeof(le_add_to_resolv_list_param),
+};
+
+static const struct generic_data add_device_success_8 = {
+	.send_opcode = MGMT_OP_ADD_DEVICE,
+	.send_param = add_device_success_param_2,
+	.send_len = sizeof(add_device_success_param_2),
+	.expect_param = add_device_rsp_le,
+	.expect_len = sizeof(add_device_rsp_le),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
+	.expect_alt_ev_param = add_device_success_param_2,
+	.expect_alt_ev_len = sizeof(add_device_success_param_2),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
+	.expect_hci_param = set_resolv_on_param,
+	.expect_hci_len = sizeof(set_resolv_on_param),
+};
+
 static const uint8_t remove_device_nval_1[] = {
 					0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
 					0xff,
@@ -4225,6 +4299,47 @@ static const struct generic_data remove_device_success_5 = {
 	.expect_alt_ev_len = sizeof(remove_device_param_2),
 };
 
+static const uint8_t remove_device_param_all[7] =  { 0x00 };
+
+static const struct generic_data remove_device_success_6 = {
+	.send_opcode = MGMT_OP_REMOVE_DEVICE,
+	.send_param = remove_device_param_all,
+	.send_len = sizeof(remove_device_param_all),
+	.expect_param = remove_device_param_all,
+	.expect_len = sizeof(remove_device_param_all),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
+static const struct generic_data remove_device_success_7 = {
+	.send_opcode = MGMT_OP_REMOVE_DEVICE,
+	.send_param = remove_device_param_2,
+	.send_len = sizeof(remove_device_param_2),
+	.expect_param = remove_device_param_2,
+	.expect_len = sizeof(remove_device_param_2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST,
+	.expect_hci_param = le_add_to_white_list_param,
+	.expect_hci_len = sizeof(le_add_to_white_list_param),
+	.expect_alt_ev = MGMT_EV_DEVICE_REMOVED,
+	.expect_alt_ev_param = remove_device_param_2,
+	.expect_alt_ev_len = sizeof(remove_device_param_2),
+};
+
+static const struct generic_data remove_device_success_8 = {
+	.send_opcode = MGMT_OP_REMOVE_DEVICE,
+	.send_param = remove_device_param_2,
+	.send_len = sizeof(remove_device_param_2),
+	.expect_param = remove_device_param_2,
+	.expect_len = sizeof(remove_device_param_2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST,
+	.expect_hci_param = le_add_to_white_list_param,
+	.expect_hci_len = sizeof(le_add_to_white_list_param),
+	.expect_alt_ev = MGMT_EV_DEVICE_REMOVED,
+	.expect_alt_ev_param = remove_device_param_2,
+	.expect_alt_ev_len = sizeof(remove_device_param_2),
+};
+
 static const struct generic_data read_adv_features_invalid_param_test = {
 	.send_opcode = MGMT_OP_READ_ADV_FEATURES,
 	.send_param = dummy_data,
@@ -6870,7 +6985,7 @@ static void command_setup_hci_callback(uint16_t opcode, const void *param,
 		return;
 
 	if (length != setup_expect_hci_len) {
-		tester_warn("Invalid parameter size for HCI command");
+		tester_warn("Invalid parameter size for HCI command (%d)", length);
 		tester_test_failed();
 		return;
 	}
@@ -6903,7 +7018,7 @@ static void command_hci_callback(uint16_t opcode, const void *param,
 		expect_hci_param = test->expect_hci_func(&expect_hci_len);
 
 	if (length != expect_hci_len) {
-		tester_warn("Invalid parameter size for HCI command");
+		tester_warn("Invalid parameter size for HCI command (%d)", length);
 		tester_test_failed();
 		return;
 	}
@@ -9218,6 +9333,201 @@ static const struct generic_data set_exp_feat_unknown = {
 	.expect_status = MGMT_STATUS_NOT_SUPPORTED,
 };
 
+static const char load_irks_params[] = { 0x01, 0x00,
+			0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0x01,
+			0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+			0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88 };
+
+
+static void setup_load_irks_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("Load IRK completed");
+}
+
+static void setup_exp_feat_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("LL Privacy Exp feature is enabled");
+}
+
+static void setup_ll_privacy(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+	const uint8_t *ext_feat_param;
+	size_t ext_feat_len;
+	const char *irk_param;
+	size_t irk_len;
+	unsigned char privacy_param[] = { 0x01,
+			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
+
+	tester_print("Enabling LL Privacy feature");
+
+	ext_feat_param = set_exp_feat_param_ll_privacy;
+	ext_feat_len = sizeof(set_exp_feat_param_ll_privacy);
+
+	irk_param = load_irks_params;
+	irk_len = sizeof(load_irks_params);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+					sizeof(param), &param,
+					NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_PRIVACY, data->mgmt_index,
+					sizeof(privacy_param), privacy_param,
+					NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					irk_len, irk_param,
+					setup_load_irks_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE , data->mgmt_index,
+					ext_feat_len, ext_feat_param,
+					setup_exp_feat_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+
+}
+
+static void setup_add_device_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("New Device is Added");
+}
+
+static void setup_ll_privacy_device(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+	const uint8_t *ext_feat_param;
+	size_t ext_feat_len;
+	const char *irk_param;
+	size_t irk_len;
+	const uint8_t *dev_param;
+	size_t dev_len;
+	unsigned char privacy_param[] = { 0x01,
+			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
+
+	tester_print("Enabling LL Privacy feature");
+
+	ext_feat_param = set_exp_feat_param_ll_privacy;
+	ext_feat_len = sizeof(set_exp_feat_param_ll_privacy);
+
+	irk_param = load_irks_params;
+	irk_len = sizeof(load_irks_params);
+
+	dev_param = add_device_success_param_2;
+	dev_len = sizeof(add_device_success_param_2);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+					sizeof(param), &param,
+					NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_PRIVACY, data->mgmt_index,
+					sizeof(privacy_param), privacy_param,
+					NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					irk_len, irk_param,
+					setup_load_irks_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE , data->mgmt_index,
+					ext_feat_len, ext_feat_param,
+					setup_exp_feat_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					dev_len, dev_param,
+					setup_add_device_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+}
+
+static const uint8_t add_device_success_param_4[] = {
+					0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
+					0x01,
+					0x02,
+};
+
+/* Enable LL Privacy and Add 2 devices */
+static void setup_ll_privacy_device2(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+	const uint8_t *ext_feat_param;
+	size_t ext_feat_len;
+	const char *irk_param;
+	size_t irk_len;
+	const uint8_t *dev_param, *dev2_param;
+	size_t dev_len, dev2_len;
+	unsigned char privacy_param[] = { 0x01,
+			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
+
+	tester_print("Enabling LL Privacy feature");
+
+	ext_feat_param = set_exp_feat_param_ll_privacy;
+	ext_feat_len = sizeof(set_exp_feat_param_ll_privacy);
+
+	irk_param = load_irks_params;
+	irk_len = sizeof(load_irks_params);
+
+	dev_param = add_device_success_param_2;
+	dev_len = sizeof(add_device_success_param_2);
+
+	dev2_param = add_device_success_param_4;
+	dev2_len = sizeof(add_device_success_param_4);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+					sizeof(param), &param,
+					NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_PRIVACY, data->mgmt_index,
+					sizeof(privacy_param), privacy_param,
+					NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					irk_len, irk_param,
+					setup_load_irks_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE , data->mgmt_index,
+					ext_feat_len, ext_feat_param,
+					setup_exp_feat_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					dev_len, dev_param,
+					setup_add_device_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					dev2_len, dev2_param,
+					setup_add_device_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+}
+
 static bool power_off(uint16_t index)
 {
 	int sk, err;
@@ -10090,6 +10400,13 @@ int main(int argc, char *argv[])
 	test_bredrle("Start Discovery - Power Off 1",
 				&start_discovery_valid_param_power_off_1,
 				NULL, test_command_generic);
+	/* MGMT_OP_START_DISCOVERY
+	 * Check if the resolving list is disabled before the scan parameter is
+	 * changed.
+	 */
+	test_bredrle50("Start Discovery - Disable Resolve List",
+				&start_discovery_ll_privacy_disable_resolv,
+				setup_ll_privacy_device, test_command_generic);
 
 	test_bredrle("Stop Discovery - Success 1",
 				&stop_discovery_success_test_1,
@@ -10489,6 +10806,26 @@ int main(int argc, char *argv[])
 	test_bredrle("Add Device - Success 5",
 				&add_device_success_5,
 				NULL, test_command_generic);
+	/* MGMT_OP_ADD_DEVICE
+	 * Add device and check the device is added to the whitelist
+	 */
+	test_bredrle50("Add Device - Success 6 - Add to whitelist",
+				&add_device_success_6,
+				NULL, test_command_generic);
+	/* MGMT_OP_ADD_DEVICE
+	 * Add device and check the device is added to the resolve list
+	 * when the LL Privacy is enabled
+	 */
+	test_bredrle50("Add Device - Success 7 - Add to resolv list",
+				&add_device_success_7,
+				setup_ll_privacy, test_command_generic);
+	/* MGMT_OP_ADD_DEVICE
+	 * Add device and check the Resolving List is enabled for the device
+	 * when the LL Privacy is enabled
+	 */
+	test_bredrle50("Add Device - Success 8 - Enable resolv list",
+				&add_device_success_8,
+				setup_ll_privacy, test_command_generic);
 
 	test_bredrle("Remove Device - Invalid Params 1",
 				&remove_device_fail_1,
@@ -10514,6 +10851,23 @@ int main(int argc, char *argv[])
 	test_le("Remove Device - Success 5",
 				&remove_device_success_5,
 				setup_add_device, test_remove_device);
+	test_le("Remove Device - Success 6 - All Devices",
+				&remove_device_success_6,
+				setup_add_device, test_remove_device);
+	/* MGMT_OP_REMOVE_DEVICE
+	 * Remove the device and check the device is removed from the whilte
+	 * list as well.
+	 */
+	test_bredrle50("Remove Device - Success 7 - Remove from whitelist",
+				&remove_device_success_7,
+				setup_ll_privacy_device2, test_command_generic);
+	/* MGMT_OP_REMOVE_DEVICE
+	 * Remove the device and check the device is removed from the resolving
+	 * list as well when the LL Privacy is enabled.
+	 */
+	test_bredrle50("Remove Device - Success 8 - Remove from resolv list",
+				&remove_device_success_8,
+				setup_ll_privacy_device2, test_command_generic);
 
 	test_bredrle("Read Advertising Features - Invalid parameters",
 				&read_adv_features_invalid_param_test,
-- 
2.26.3

