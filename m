Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4443EC43219
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 17:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F65F615E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 17:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhJURuv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Oct 2021 13:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbhJURum (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Oct 2021 13:50:42 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7AFC06122B
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 10:48:10 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id c4so974036pgv.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 10:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hDNkaMXCEVr8swunzEouJdJQNUeB1/0uXEDbDUAhelM=;
        b=GAJDnaYI979IgznTvc0GMYqdfr8df6lRxAjgxfSJ8Ym8C8GZeUEiCGIQSFuAQ/lWhv
         8JuKciT4+ioFweRdZaC1d3TMXaU4HDmMtVpdibean8c2omNrXpa+XXXLGPBXbmqMn5xr
         seiVtn482tcsd7qnYpTUTLRzJjkfnqqUJN/4wVHx6TFZSfIUNpeVEH/9/KmmqbkhlNfB
         KXxHXB2tLP1UU5JzfhtpeQ32c1hsoZM/NLgokUdqHLIQVFZtEWj+kLqlRk2O7VuVueoZ
         fM+cC9DXH54r7uDINeOepxj+IL4J8tFsg8fz04N73DCEVwIH1U+DgAxIhYf8Jdb3V4lr
         vAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDNkaMXCEVr8swunzEouJdJQNUeB1/0uXEDbDUAhelM=;
        b=vMk2C3kDnbTJy1/KQVrPwaWCZPjF+XzBPiN7cXfVWE7WsHIcw7i1O+N7LsjUN44X5S
         C2wyKXn/IhCdDnX2n1NsUBk29xEHkdiK0pSn+/LRlaZpxjXRR4a9WoqozUghxLZ8pWwl
         m5wDtb56FHo6Ohe6MeRyKIJy6UO18U+Yz+HTznvZxhndZbSX6FRjAiPmqV2gbEZsw/Jg
         Yei38dx/A3lspxmK+VCvdqJgLJbqREBb8MHb7Xee7I1he6zx++wZR+DRR7dc1doO+cdG
         bV3k54Q7O5P/ip9WVntCPpLdDmAQxjSt0bAKp1g3UDyktwFKLGP8rkuYy1JffIG0p+Ej
         YJbA==
X-Gm-Message-State: AOAM5301ijMjHl9V9ZHhB0ITJ5wAV5UuohmQ95/UXVAjfUcBKRHI3y+S
        sKEbPPawt5QIfD6+BROq7hDelnvGoM1ObQ==
X-Google-Smtp-Source: ABdhPJx2mFmD7daLrMFZnc62tHviKlgAL7IgEoO2bSqJ+oGT5edwnpRL/oHVneJ3q1ap+7nPliKM7g==
X-Received: by 2002:aa7:96ab:0:b0:44c:f3e2:a7d1 with SMTP id g11-20020aa796ab000000b0044cf3e2a7d1mr7548310pfk.78.1634838488803;
        Thu, 21 Oct 2021 10:48:08 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:e439:7541:94af:b362])
        by smtp.gmail.com with ESMTPSA id g4sm5732586pgs.42.2021.10.21.10.48.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 10:48:08 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v13 5/5] tools/mgmt-tester: Add LL Privacy test cases
Date:   Thu, 21 Oct 2021 10:48:04 -0700
Message-Id: <20211021174804.340160-5-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211021174804.340160-1-hj.tedd.an@gmail.com>
References: <20211021174804.340160-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds LL Privacy related test cases.

Multi Ext Advertising - Success 3 (Add 2 Advs)
Multi Ext Advertising - Success 4 (Remove Adv)
Multi Ext Advertising - Success 5 (Remove all)
Multi Ext Advertising - Success 6 (Add w/o power on)
Multi Ext Advertising - Fail (Add MAX)

LL Privacy - Add Device 1 (Add to AL)
LL Privacy - Add Device 2 (Add to RL)
LL Privacy - Add Device 3 (Enable RL)
LL Privacy - Add Device 4 (2 Devices to AL)
LL Privacy - Add Device 5 (2 Devices to RL)
LL Privacy - Add Device 6 (RL is full)
LL Privacy - Add Device 7 (WL is full)
LL Privacy - Add Device 8 (Disable Adv)
LL Privacy - Add Device 9 (Multi Adv)
LL Privacy - Add Device 10 (Multi Dev and Multi Adv)

LL Privacy - Remove Device 1 (Remove from AL)
LL Privacy - Remove Device 2 (Remove from RL)
LL Privacy - Remove Device 3 (Disable RL)
LL Privacy - Remove Device 4 (Disable Adv)
LL Privacy - Remove Device 5 (Multi Adv)

LL Privacy - Start Discovery 1 (Disable RL)
LL Privacy - Start Discovery 2 (Disable RL)

LL Privacy - Advertising 1 (Scan Results)
LL Privacy - Acceptor 1
LL Privacy - Acceptor 2
---
 tools/mgmt-tester.c | 1998 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 1705 insertions(+), 293 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 08fd16985..4bbddb836 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -37,6 +37,7 @@
 #include "src/shared/util.h"
 #include "src/shared/tester.h"
 #include "src/shared/mgmt.h"
+#include "src/shared/queue.h"
 
 struct test_data {
 	tester_data_func_t test_setup;
@@ -57,6 +58,7 @@ struct test_data {
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	bool expect_hci_command_done;
+	struct queue *expect_hci_q;
 	int unmet_conditions;
 	int unmet_setup_conditions;
 	int sk;
@@ -76,6 +78,8 @@ static void test_post_teardown(const void *test_data)
 	if (data->sk >= 0)
 		close(data->sk);
 
+	queue_destroy(data->expect_hci_q, NULL);
+
 	hciemu_unref(data->hciemu);
 	data->hciemu = NULL;
 }
@@ -254,6 +258,16 @@ static void index_removed_callback(uint16_t index, uint16_t length,
 	tester_post_teardown_complete();
 }
 
+struct hci_cmd_data {
+	uint16_t opcode;
+	uint8_t len;
+	const void *param;
+};
+
+struct hci_entry {
+	const struct hci_cmd_data *cmd_data;
+};
+
 struct generic_data {
 	bool setup_le_states;
 	const uint8_t *le_states;
@@ -290,6 +304,7 @@ struct generic_data {
 	int (*expect_hci_param_check_func)(const void *param, uint16_t length);
 	uint8_t expect_hci_len;
 	const void * (*expect_hci_func)(uint8_t *len);
+	const struct hci_cmd_data *expect_hci_list;
 	bool expect_pin;
 	uint8_t pin_len;
 	const void *pin;
@@ -1738,6 +1753,7 @@ static uint16_t settings_powered_le[] = { MGMT_OP_SET_LE,
 					MGMT_OP_SET_POWERED, 0 };
 
 static const char set_adv_on_param[] = { 0x01 };
+static const char set_adv_on_param2[] = { 0x02 };
 static const char set_adv_settings_param_1[] = { 0x80, 0x06, 0x00, 0x00 };
 static const char set_adv_settings_param_2[] = { 0x81, 0x06, 0x00, 0x00 };
 static const char set_adv_on_set_adv_enable_param[] = { 0x01 };
@@ -2101,24 +2117,6 @@ static const struct generic_data start_discovery_valid_param_power_off_1 = {
 	.expect_len = sizeof(start_discovery_bredrle_param),
 };
 
-static const char set_resolv_off_param[] = { 0x00 };
-static const char set_resolv_on_param[] = { 0x01 };
-
-static const struct generic_data start_discovery_ll_privacy_disable_resolv = {
-	.send_opcode = MGMT_OP_START_DISCOVERY,
-	.send_param = start_discovery_le_param,
-	.send_len = sizeof(start_discovery_le_param),
-	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = start_discovery_le_param,
-	.expect_len = sizeof(start_discovery_le_param),
-	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
-	.setup_expect_hci_param = set_resolv_on_param,
-	.setup_expect_hci_len = sizeof(set_resolv_on_param),
-	.expect_hci_command = BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
-	.expect_hci_param = set_resolv_off_param,
-	.expect_hci_len = sizeof(set_resolv_off_param),
-};
-
 static const char stop_discovery_bredrle_param[] = { 0x07 };
 static const char stop_discovery_bredrle_invalid_param[] = { 0x06 };
 static const char stop_discovery_valid_hci[] = { 0x00, 0x00 };
@@ -4480,71 +4478,6 @@ static const struct generic_data add_device_success_5 = {
 	.expect_hci_len = sizeof(le_scan_enable),
 };
 
-static const uint8_t add_device_success_param_6[] = {
-					0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
-					0x01,
-					0x02,
-};
-
-static const uint8_t le_add_to_accept_list_param[] = {
-	0x00,					/* Type */
-	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
-};
-static const struct generic_data add_device_success_6 = {
-	.setup_settings = settings_powered_le,
-	.send_opcode = MGMT_OP_ADD_DEVICE,
-	.send_param = add_device_success_param_6,
-	.send_len = sizeof(add_device_success_param_6),
-	.expect_param = add_device_rsp_le,
-	.expect_len = sizeof(add_device_rsp_le),
-	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
-	.expect_alt_ev_param = add_device_success_param_6,
-	.expect_alt_ev_len = sizeof(add_device_success_param_6),
-	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
-	.expect_hci_param = le_add_to_accept_list_param,
-	.expect_hci_len = sizeof(le_add_to_accept_list_param),
-};
-
-static const uint8_t le_add_to_resolv_list_param[] = {
-	0x00,						/* Type */
-	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,		/* Address */
-	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,	/* Peer IRK */
-	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
-	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,	/* Local IRK */
-	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
-};
-
-static const struct generic_data add_device_success_7 = {
-	.send_opcode = MGMT_OP_ADD_DEVICE,
-	.send_param = add_device_success_param_6,
-	.send_len = sizeof(add_device_success_param_6),
-	.expect_param = add_device_rsp_le,
-	.expect_len = sizeof(add_device_rsp_le),
-	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
-	.expect_alt_ev_param = add_device_success_param_6,
-	.expect_alt_ev_len = sizeof(add_device_success_param_6),
-	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST,
-	.expect_hci_param = le_add_to_resolv_list_param,
-	.expect_hci_len = sizeof(le_add_to_resolv_list_param),
-};
-
-static const struct generic_data add_device_success_8 = {
-	.send_opcode = MGMT_OP_ADD_DEVICE,
-	.send_param = add_device_success_param_6,
-	.send_len = sizeof(add_device_success_param_6),
-	.expect_param = add_device_rsp_le,
-	.expect_len = sizeof(add_device_rsp_le),
-	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
-	.expect_alt_ev_param = add_device_success_param_6,
-	.expect_alt_ev_len = sizeof(add_device_success_param_6),
-	.expect_hci_command = BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
-	.expect_hci_param = set_resolv_on_param,
-	.expect_hci_len = sizeof(set_resolv_on_param),
-};
-
 static const uint8_t remove_device_nval_1[] = {
 					0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
 					0xff,
@@ -4664,36 +4597,6 @@ static const struct generic_data remove_device_success_6 = {
 	.expect_status = MGMT_STATUS_SUCCESS,
 };
 
-static const struct generic_data remove_device_success_7 = {
-	.send_opcode = MGMT_OP_REMOVE_DEVICE,
-	.send_param = remove_device_param_2,
-	.send_len = sizeof(remove_device_param_2),
-	.expect_param = remove_device_param_2,
-	.expect_len = sizeof(remove_device_param_2),
-	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST,
-	.expect_hci_param = le_add_to_accept_list_param,
-	.expect_hci_len = sizeof(le_add_to_accept_list_param),
-	.expect_alt_ev = MGMT_EV_DEVICE_REMOVED,
-	.expect_alt_ev_param = remove_device_param_2,
-	.expect_alt_ev_len = sizeof(remove_device_param_2),
-};
-
-static const struct generic_data remove_device_success_8 = {
-	.send_opcode = MGMT_OP_REMOVE_DEVICE,
-	.send_param = remove_device_param_2,
-	.send_len = sizeof(remove_device_param_2),
-	.expect_param = remove_device_param_2,
-	.expect_len = sizeof(remove_device_param_2),
-	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST,
-	.expect_hci_param = le_add_to_accept_list_param,
-	.expect_hci_len = sizeof(le_add_to_accept_list_param),
-	.expect_alt_ev = MGMT_EV_DEVICE_REMOVED,
-	.expect_alt_ev_param = remove_device_param_2,
-	.expect_alt_ev_len = sizeof(remove_device_param_2),
-};
-
 static const struct generic_data read_adv_features_invalid_param_test = {
 	.send_opcode = MGMT_OP_READ_ADV_FEATURES,
 	.send_param = dummy_data,
@@ -7495,6 +7398,54 @@ static void command_hci_callback(uint16_t opcode, const void *param,
 	test_condition_complete(data);
 }
 
+static bool match_hci_cmd_opcode(const void *data, const void *match_data)
+{
+	const struct hci_entry *entry = data;
+	uint16_t opcode = PTR_TO_UINT(match_data);
+
+	return entry->cmd_data->opcode == opcode;
+}
+
+static void command_hci_list_callback(uint16_t opcode, const void *param,
+					uint8_t length, void *user_data)
+{
+	struct test_data *data = user_data;
+	const struct hci_cmd_data *hci_cmd_data;
+	struct hci_entry *entry;
+	int ret;
+
+	tester_print("HCI Command 0x%04x length %u", opcode, length);
+
+	entry = queue_find(data->expect_hci_q, match_hci_cmd_opcode,
+							UINT_TO_PTR(opcode));
+	if (!entry)
+		return;
+
+	/* Save the hci cmd data before removing the queue entry */
+	hci_cmd_data = entry->cmd_data;
+
+	/* Remove the entry from the queue and free the entry */
+	queue_remove(data->expect_hci_q, entry);
+	free(entry);
+
+	if (length != hci_cmd_data->len) {
+		tester_warn("Invalid parameter size for HCI command");
+		tester_test_failed();
+		return;
+	}
+
+	ret = memcmp(param, hci_cmd_data->param, length);
+	if (ret != 0) {
+		tester_warn("Unexpected HCI command parameter value:");
+		util_hexdump('>', param, length, print_debug, "");
+		util_hexdump('!', hci_cmd_data->param, length, print_debug, "");
+		tester_test_failed();
+		return;
+	}
+
+	test_condition_complete(data);
+}
+
 static void setup_mgmt_cmd_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -8570,6 +8521,189 @@ static const struct generic_data multi_ext_advertising_add_second = {
 	.expect_hci_len = sizeof(set_ext_adv_data_test2),
 };
 
+static const char multi_ext_adv_hci_params_1[] = {
+	0x01,					/* handle */
+	0x10, 0x00,				/* evt_properties */
+	0x00, 0x08, 0x00,			/* min_interval */
+	0x00, 0x08, 0x00,			/* max_interval */
+	0x07,					/* channel_map */
+	0x01,					/* own_addr_type */
+	0x00,					/* peer_addr_type */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* peer_addr */
+	0x00,					/* filter_policy */
+	0x7f,					/* tx_power */
+	0x01,					/* primary_phy */
+	0x00,					/* secondary_max_skip */
+	0x01,					/* secondary_phy */
+	0x00,					/* sid */
+	0x00,					/* notif_enable */
+};
+
+static const char multi_ext_adv_hci_params_2[] = {
+	0x02,					/* handle */
+	0x10, 0x00,				/* evt_properties */
+	0x00, 0x08, 0x00,			/* min_interval */
+	0x00, 0x08, 0x00,			/* max_interval */
+	0x07,					/* channel_map */
+	0x01,					/* own_addr_type */
+	0x00,					/* peer_addr_type */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* peer_addr */
+	0x00,					/* filter_policy */
+	0x7f,					/* tx_power */
+	0x01,					/* primary_phy */
+	0x00,					/* secondary_max_skip */
+	0x01,					/* secondary_phy */
+	0x00,					/* sid */
+	0x00,					/* notif_enable */
+};
+
+static const uint8_t le_set_ext_adv_enable_inst_2[] = {
+	0x01, 0x01, 0x02, 0x64, 0x00, 0x00,
+};
+
+static const struct hci_cmd_data multi_ext_adv_add_second_hci_cmds[] = {
+	{
+		.opcode = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+		.len = sizeof(multi_ext_adv_hci_params_2),
+		.param = multi_ext_adv_hci_params_2,
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
+		.len = sizeof(set_ext_adv_data_test2),
+		.param = set_ext_adv_data_test2,
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
+		.len = sizeof(le_set_ext_adv_enable_inst_2),
+		.param = le_set_ext_adv_enable_inst_2,
+	},
+};
+
+static const struct generic_data multi_ext_advertising_add_second_2 = {
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_test2,
+	.send_len = sizeof(add_advertising_param_test2),
+	.expect_param = advertising_instance2_param,
+	.expect_len = sizeof(advertising_instance2_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_ADVERTISING_ADDED,
+	.expect_alt_ev_param = advertising_instance2_param,
+	.expect_alt_ev_len = sizeof(advertising_instance2_param),
+	.expect_hci_list = multi_ext_adv_add_second_hci_cmds,
+};
+
+/* add advertising command for a second instance */
+static const uint8_t add_advertising_param_test4[] = {
+	0x04,				/* adv instance */
+	0x00, 0x00, 0x00, 0x00,		/* flags: none */
+	0x00, 0x00,			/* duration: default */
+	0x01, 0x00,			/* timeout: 1 second */
+	0x07,				/* adv data len */
+	0x00,				/* scan rsp len */
+	/* adv data: */
+	0x06,				/* AD len */
+	0x08,				/* AD type: shortened local name */
+	0x74, 0x65, 0x73, 0x74, 0x32,	/* "test2" */
+};
+
+static const struct generic_data multi_ext_advertising_add_adv_4 = {
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_test4,
+	.send_len = sizeof(add_advertising_param_test4),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct hci_cmd_data multi_ext_adv_remove_adv_hci_cmds[] = {
+	{
+		.opcode = BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
+		.len = sizeof(set_ext_adv_disable_param_1),
+		.param = set_ext_adv_disable_param_1,
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_REMOVE_ADV_SET,
+		.len = sizeof(advertising_instance1_param),
+		.param = advertising_instance1_param,
+	},
+};
+
+static const struct generic_data multi_ext_advertising_remove = {
+	.send_opcode = MGMT_OP_REMOVE_ADVERTISING,
+	.send_param = advertising_instance1_param,
+	.send_len = sizeof(advertising_instance1_param),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
+	.expect_hci_list = multi_ext_adv_remove_adv_hci_cmds,
+};
+
+static const uint8_t advertising_instance0_param[] = {
+	0x00,
+};
+
+static const uint8_t set_ext_adv_remove_all_param[] = {
+	0x00, 0x00,
+};
+
+static const struct hci_cmd_data multi_ext_adv_remove_all_adv_hci_cmds[] = {
+	{
+		.opcode = BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
+		.len = sizeof(set_ext_adv_remove_all_param),
+		.param = set_ext_adv_remove_all_param,
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_CLEAR_ADV_SETS,
+	},
+};
+
+static const struct generic_data multi_ext_advertising_remove_all = {
+	.send_opcode = MGMT_OP_REMOVE_ADVERTISING,
+	.send_param = advertising_instance0_param,
+	.send_len = sizeof(advertising_instance0_param),
+	.expect_param = advertising_instance0_param,
+	.expect_len = sizeof(advertising_instance0_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
+	.expect_alt_ev_param = advertising_instance2_param,
+	.expect_alt_ev_len = sizeof(advertising_instance2_param),
+	.expect_hci_list = multi_ext_adv_remove_all_adv_hci_cmds,
+};
+
+static const struct hci_cmd_data multi_ext_adv_add_2_advs_hci_cmds[] = {
+	{
+		.opcode = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+		.len = sizeof(multi_ext_adv_hci_params_2),
+		.param = multi_ext_adv_hci_params_2,
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
+		.len = sizeof(set_ext_adv_data_test2),
+		.param = set_ext_adv_data_test2,
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+		.len = sizeof(multi_ext_adv_hci_params_1),
+		.param = multi_ext_adv_hci_params_1,
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
+		.len = sizeof(set_ext_adv_data_test1),
+		.param = set_ext_adv_data_test1,
+	},
+};
+
+static const struct generic_data multi_ext_advertising_add_no_power = {
+	.send_opcode = MGMT_OP_SET_POWERED,
+	.send_param = set_powered_on_param,
+	.send_len = sizeof(set_powered_on_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_powered_adv_instance_settings_param,
+	.expect_len = sizeof(set_powered_adv_instance_settings_param),
+	.expect_hci_list = multi_ext_adv_add_2_advs_hci_cmds,
+};
+
 static const struct generic_data add_ext_advertising_empty_scrsp = {
 	.setup_settings = settings_powered_le,
 	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
@@ -9484,6 +9618,7 @@ static const struct generic_data start_discovery_le_1m_coded_scan_param = {
 	.expect_alt_ev_len = sizeof(start_discovery_evt),
 };
 
+
 static void set_phy_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -9815,202 +9950,1089 @@ static const struct generic_data set_exp_feat_unknown = {
 	.expect_status = MGMT_STATUS_NOT_SUPPORTED,
 };
 
-static const char load_irks_params[] = { 0x01, 0x00,
-			0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0x01,
-			0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
-			0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88 };
+static const uint8_t add_device_le_public_param_1[] = {
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+	0x02,					/* Action - Auto-Connect */
+};
 
+static const uint8_t add_device_rsp_le_public[] =  {
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+};
+static const char load_irks_le_public_param_1[] = {
+	0x01, 0x00,					/* Key Count */
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,		/* Key 1 - BDADDR */
+	0x01,						/* Key 1 - Type */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, /* Key 1 - Value */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+};
 
-static void setup_load_irks_callback(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
-{
-	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
-		return;
-	}
+static const uint8_t add_device_le_public_param_2[] = {
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+	0x00,					/* Action - Background scan */
+};
 
-	tester_print("Load IRK completed");
-}
+static const uint8_t add_device_rsp_le_public_2[] =  {
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+};
 
-static void setup_exp_feat_callback(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
-{
-	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
-		return;
+static const uint8_t add_device_le_public_param_3[] = {
+	0x33, 0x33, 0x33, 0x44, 0x55, 0x66,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+	0x00,					/* Action - Background scan */
+};
+
+static const uint8_t add_device_rsp_le_public_3[] =  {
+	0x33, 0x33, 0x33, 0x44, 0x55, 0x66,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+};
+
+static const uint8_t add_device_le_public_param_4[] = {
+	0x44, 0x44, 0x44, 0x44, 0x55, 0x66,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+	0x00,					/* Action - Background scan */
+};
+
+static const uint8_t add_device_rsp_le_public_4[] =  {
+	0x44, 0x44, 0x44, 0x44, 0x55, 0x66,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+};
+
+static const char load_irks_2_devices_param[] = {
+	0x02, 0x00,					/* Key Count */
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,		/* Key 1 - BDADDR */
+	0x01,						/* Key 1 - Type */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, /* Key 1 - Value */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,		/* Key 2 - BDADDR */
+	0x01,						/* Key 2 - Type */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,	/* Key 2 - Value */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88
+};
+
+static const char load_irks_3_devices_param[] = {
+	0x03, 0x00,					/* Key Count */
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,		/* Key 1 - BDADDR */
+	0x01,						/* Key 1 - Type */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, /* Key 1 - Value */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,		/* Key 2 - BDADDR */
+	0x01,						/* Key 2 - Type */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,	/* Key 2 - Value */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+	0x33, 0x33, 0x33, 0x44, 0x55, 0x66,		/* Key 3 - BDADDR */
+	0x01,						/* Key 3 - Type */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,	/* Key 3 - Value */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+};
+
+static const char load_irks_4_devices_param[] = {
+	0x04, 0x00,					/* Key Count */
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,		/* Key 1 - BDADDR */
+	0x01,						/* Key 1 - Type */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, /* Key 1 - Value */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,		/* Key 2 - BDADDR */
+	0x01,						/* Key 2 - Type */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,	/* Key 2 - Value */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+	0x33, 0x33, 0x33, 0x44, 0x55, 0x66,		/* Key 3 - BDADDR */
+	0x01,						/* Key 3 - Type */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,	/* Key 3 - Value */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+	0x44, 0x44, 0x44, 0x44, 0x55, 0x66,		/* Key 4 - BDADDR */
+	0x01,						/* Key 4 - Type */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,	/* Key 4 - Value */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+};
+
+static const uint8_t le_add_to_accept_list_param[] = {
+	0x00,					/* Type */
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
+};
+
+static const uint8_t le_add_to_white_list_param_2[] = {
+	0x00,					/* Type */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,	/* Address */
+};
+
+static const uint8_t le_add_to_white_list_param_3[] = {
+	0x00,					/* Type */
+	0x33, 0x33, 0x33, 0x44, 0x55, 0x66,	/* Address */
+};
+
+static const uint8_t le_add_to_resolv_list_param[] = {
+	0x00,						/* Type */
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,		/* BDADDR */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,	/* Peer IRK */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,	/* Local IRK */
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+};
+
+static const uint8_t le_add_to_resolv_list_param_2[] = {
+	0x00,						/* Type */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,		/* BDADDR */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,	/* Peer IRK */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,	/* Local IRK */
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+};
+
+static const uint8_t le_add_to_resolv_list_param_4[] = {
+	0x00,						/* Type */
+	0x44, 0x44, 0x44, 0x44, 0x55, 0x66,		/* BDADDR */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,	/* Peer IRK */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,	/* Local IRK */
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+};
+
+static const char set_resolv_off_param[] = { 0x00 };
+static const char set_resolv_on_param[] = { 0x01 };
+
+static const struct generic_data ll_privacy_add_device_1 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_DEVICE,
+	.send_param = add_device_le_public_param_1,
+	.send_len = sizeof(add_device_le_public_param_1),
+	.expect_param = add_device_rsp_le,
+	.expect_len = sizeof(add_device_rsp_le),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
+	.expect_alt_ev_param = add_device_le_public_param_1,
+	.expect_alt_ev_len = sizeof(add_device_le_public_param_1),
+	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
+	.expect_hci_param = le_add_to_accept_list_param,
+	.expect_hci_len = sizeof(le_add_to_accept_list_param),
+};
+
+static uint16_t settings_le_privacy_ll_privacy[] = { MGMT_OP_SET_LE,
+					MGMT_OP_SET_PRIVACY,
+					MGMT_OP_SET_EXP_FEATURE , 0 };
+
+static const struct generic_data ll_privacy_add_device_2 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.send_opcode = MGMT_OP_ADD_DEVICE,
+	.send_param = add_device_le_public_param_1,
+	.send_len = sizeof(add_device_le_public_param_1),
+	.expect_param = add_device_rsp_le_public,
+	.expect_len = sizeof(add_device_rsp_le_public),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
+	.expect_alt_ev_param = add_device_le_public_param_1,
+	.expect_alt_ev_len = sizeof(add_device_le_public_param_1),
+	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST,
+	.expect_hci_param = le_add_to_resolv_list_param,
+	.expect_hci_len = sizeof(le_add_to_resolv_list_param),
+};
+
+static const struct hci_cmd_data ll_privacy_add_device_3_hci_list[] = {
+	{
+		.opcode = BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
+		.param = set_resolv_off_param,
+		.len = sizeof(set_resolv_off_param),
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST,
+		.param = le_add_to_resolv_list_param,
+		.len = sizeof(le_add_to_resolv_list_param),
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
+		.param = le_add_to_accept_list_param,
+		.len = sizeof(le_add_to_accept_list_param),
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
+		.param = set_resolv_on_param,
+		.len = sizeof(set_resolv_on_param),
+	},
+};
+
+static const struct generic_data ll_privacy_add_device_3 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.send_opcode = MGMT_OP_ADD_DEVICE,
+	.send_param = add_device_le_public_param_1,
+	.send_len = sizeof(add_device_le_public_param_1),
+	.expect_param = add_device_rsp_le,
+	.expect_len = sizeof(add_device_rsp_le),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
+	.expect_alt_ev_param = add_device_le_public_param_1,
+	.expect_alt_ev_len = sizeof(add_device_le_public_param_1),
+	.expect_hci_list = ll_privacy_add_device_3_hci_list,
+};
+
+static const struct generic_data ll_privacy_add_device_4 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.send_opcode = MGMT_OP_ADD_DEVICE,
+	.send_param = add_device_le_public_param_2,
+	.send_len = sizeof(add_device_le_public_param_2),
+	.expect_param = add_device_rsp_le_public_2,
+	.expect_len = sizeof(add_device_rsp_le_public_2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
+	.expect_alt_ev_param = add_device_le_public_param_2,
+	.expect_alt_ev_len = sizeof(add_device_le_public_param_2),
+	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
+	.expect_hci_param = le_add_to_white_list_param_2,
+	.expect_hci_len = sizeof(le_add_to_white_list_param_2),
+};
+
+static const struct generic_data ll_privacy_add_device_5 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.send_opcode = MGMT_OP_ADD_DEVICE,
+	.send_param = add_device_le_public_param_2,
+	.send_len = sizeof(add_device_le_public_param_2),
+	.expect_param = add_device_rsp_le_public_2,
+	.expect_len = sizeof(add_device_rsp_le_public_2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
+	.expect_alt_ev_param = add_device_le_public_param_2,
+	.expect_alt_ev_len = sizeof(add_device_le_public_param_2),
+	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST,
+	.expect_hci_param = le_add_to_resolv_list_param_2,
+	.expect_hci_len = sizeof(le_add_to_resolv_list_param_2),
+};
+
+static const struct generic_data ll_privacy_add_device_6 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.send_opcode = MGMT_OP_ADD_DEVICE,
+	.send_param = add_device_le_public_param_4,
+	.send_len = sizeof(add_device_le_public_param_4),
+	.expect_param = add_device_rsp_le_public_4,
+	.expect_len = sizeof(add_device_rsp_le_public_4),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
+	.expect_alt_ev_param = add_device_le_public_param_4,
+	.expect_alt_ev_len = sizeof(add_device_le_public_param_4),
+	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST,
+	.expect_hci_param = le_add_to_resolv_list_param_4,
+	.expect_hci_len = sizeof(le_add_to_resolv_list_param_4),
+};
+
+static const struct generic_data ll_privacy_add_device_7 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.send_opcode = MGMT_OP_ADD_DEVICE,
+	.send_param = add_device_le_public_param_3,
+	.send_len = sizeof(add_device_le_public_param_3),
+	.expect_param = add_device_rsp_le_public_3,
+	.expect_len = sizeof(add_device_rsp_le_public_3),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
+	.expect_alt_ev_param = add_device_le_public_param_3,
+	.expect_alt_ev_len = sizeof(add_device_le_public_param_3),
+	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
+	.expect_hci_param = le_add_to_white_list_param_3,
+	.expect_hci_len = sizeof(le_add_to_white_list_param_3),
+};
+
+static const char set_ext_adv_disable[] = {
+	0x00, 0x00,
+};
+
+static const struct generic_data ll_privacy_add_device_8 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.send_opcode = MGMT_OP_ADD_DEVICE,
+	.send_param = add_device_le_public_param_3,
+	.send_len = sizeof(add_device_le_public_param_3),
+	.expect_param = add_device_rsp_le_public_3,
+	.expect_len = sizeof(add_device_rsp_le_public_3),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
+	.expect_alt_ev_param = add_device_le_public_param_3,
+	.expect_alt_ev_len = sizeof(add_device_le_public_param_3),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
+	.expect_hci_param = set_ext_adv_disable,
+	.expect_hci_len = sizeof(set_ext_adv_disable),
+};
+
+static const struct hci_cmd_data ll_privacy_add_device_9_hci_list[] = {
+	{
+		.opcode = BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
+		.len = sizeof(set_ext_adv_disable),
+		.param = set_ext_adv_disable,
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST,
+		.len = sizeof(le_add_to_resolv_list_param),
+		.param = le_add_to_resolv_list_param
+	},
+};
+
+static const struct generic_data ll_privacy_add_device_9 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.send_opcode = MGMT_OP_ADD_DEVICE,
+	.send_param = add_device_le_public_param_1,
+	.send_len = sizeof(add_device_le_public_param_1),
+	.expect_param = add_device_rsp_le_public,
+	.expect_len = sizeof(add_device_rsp_le_public),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
+	.expect_alt_ev_param = add_device_le_public_param_1,
+	.expect_alt_ev_len = sizeof(add_device_le_public_param_1),
+	.expect_hci_list = ll_privacy_add_device_9_hci_list,
+};
+
+static const struct generic_data ll_privacy_remove_device_1 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.send_opcode = MGMT_OP_REMOVE_DEVICE,
+	.send_param = remove_device_param_2,
+	.send_len = sizeof(remove_device_param_2),
+	.expect_param = remove_device_param_2,
+	.expect_len = sizeof(remove_device_param_2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST,
+	.expect_hci_param = le_add_to_accept_list_param,
+	.expect_hci_len = sizeof(le_add_to_accept_list_param),
+	.expect_alt_ev = MGMT_EV_DEVICE_REMOVED,
+	.expect_alt_ev_param = remove_device_param_2,
+	.expect_alt_ev_len = sizeof(remove_device_param_2),
+};
+
+static const struct generic_data ll_privacy_remove_device_2 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.send_opcode = MGMT_OP_REMOVE_DEVICE,
+	.send_param = remove_device_param_2,
+	.send_len = sizeof(remove_device_param_2),
+	.expect_param = remove_device_param_2,
+	.expect_len = sizeof(remove_device_param_2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST,
+	.expect_hci_param = le_add_to_accept_list_param,
+	.expect_hci_len = sizeof(le_add_to_accept_list_param),
+	.expect_alt_ev = MGMT_EV_DEVICE_REMOVED,
+	.expect_alt_ev_param = remove_device_param_2,
+	.expect_alt_ev_len = sizeof(remove_device_param_2),
+};
+
+static const struct generic_data ll_privacy_remove_device_3 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.send_opcode = MGMT_OP_REMOVE_DEVICE,
+	.send_param = remove_device_param_2,
+	.send_len = sizeof(remove_device_param_2),
+	.expect_param = remove_device_param_2,
+	.expect_len = sizeof(remove_device_param_2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
+	.expect_hci_param = set_resolv_off_param,
+	.expect_hci_len = sizeof(set_resolv_off_param),
+	.expect_alt_ev = MGMT_EV_DEVICE_REMOVED,
+	.expect_alt_ev_param = remove_device_param_2,
+	.expect_alt_ev_len = sizeof(remove_device_param_2),
+};
+
+static const struct generic_data ll_privacy_remove_device_4 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.send_opcode = MGMT_OP_REMOVE_DEVICE,
+	.send_param = remove_device_param_2,
+	.send_len = sizeof(remove_device_param_2),
+	.expect_param = remove_device_param_2,
+	.expect_len = sizeof(remove_device_param_2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST,
+	.expect_hci_param = le_add_to_accept_list_param,
+	.expect_hci_len = sizeof(le_add_to_accept_list_param),
+	.expect_alt_ev = MGMT_EV_DEVICE_REMOVED,
+	.expect_alt_ev_param = remove_device_param_2,
+	.expect_alt_ev_len = sizeof(remove_device_param_2),
+};
+
+static const struct generic_data ll_privacy_remove_device_5 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.send_opcode = MGMT_OP_REMOVE_DEVICE,
+	.send_param = remove_device_param_2,
+	.send_len = sizeof(remove_device_param_2),
+	.expect_param = remove_device_param_2,
+	.expect_len = sizeof(remove_device_param_2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST,
+	.expect_hci_param = le_add_to_accept_list_param,
+	.expect_hci_len = sizeof(le_add_to_accept_list_param),
+	.expect_alt_ev = MGMT_EV_DEVICE_REMOVED,
+	.expect_alt_ev_param = remove_device_param_2,
+	.expect_alt_ev_len = sizeof(remove_device_param_2),
+};
+
+static const struct generic_data ll_privacy_start_discovery_ll_privacy_1 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
+	.setup_expect_hci_param = set_resolv_on_param,
+	.setup_expect_hci_len = sizeof(set_resolv_on_param),
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
+static const struct generic_data ll_privacy_start_discovery_ll_privacy_2 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.setup_expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST,
+	.setup_expect_hci_param = le_add_to_accept_list_param,
+	.setup_expect_hci_len = sizeof(le_add_to_accept_list_param),
+	.send_opcode = MGMT_OP_START_DISCOVERY,
+	.send_param = start_discovery_le_param,
+	.send_len = sizeof(start_discovery_le_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = start_discovery_le_param,
+	.expect_len = sizeof(start_discovery_le_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
+	.expect_hci_param = set_resolv_off_param,
+	.expect_hci_len = sizeof(set_resolv_off_param),
+	.expect_alt_ev = MGMT_EV_DISCOVERING,
+	.expect_alt_ev_param = start_discovery_le_evt,
+	.expect_alt_ev_len = sizeof(start_discovery_le_evt),
+};
+
+static const struct generic_data ll_privacy_advertising_1 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.send_opcode = MGMT_OP_SET_ADVERTISING,
+	.send_param = set_adv_on_param2,
+	.send_len = sizeof(set_adv_on_param2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_ignore_param = true,
+};
+
+static const struct generic_data ll_privacy_acceptor_1 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.io_cap = 0x04, /* KeyboardDisplay */
+	.client_io_cap = 0x04, /* KeyboardDisplay */
+	.client_auth_req = 0x05, /* Bonding - MITM */
+	.expect_alt_ev =  MGMT_EV_NEW_LONG_TERM_KEY,
+	.expect_alt_ev_len = sizeof(struct mgmt_ev_new_long_term_key),
+	.verify_alt_ev_func = verify_ltk,
+};
+
+static const struct generic_data ll_privacy_acceptor_2 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.io_cap = 0x04, /* KeyboardDisplay */
+	.client_io_cap = 0x04, /* KeyboardDisplay */
+	.just_works = true,
+	.expect_alt_ev =  MGMT_EV_NEW_LONG_TERM_KEY,
+	.expect_alt_ev_len = sizeof(struct mgmt_ev_new_long_term_key),
+	.verify_alt_ev_func = verify_ltk,
+};
+
+static const uint8_t unpair_clinet_1[] = {
+	0x00, 0x00, 0x01, 0x01, 0xaa, 0x00,	/* Address */
+	0x01,					/* Type */
+	0x01,					/* Disconnect */
+};
+
+static const uint8_t unpair_resp_param_1[] = {
+	0x00, 0x00, 0x01, 0x01, 0xaa, 0x00,	/* Address */
+	0x01,					/* Type */
+};
+
+static uint16_t settings_powered_le_sc_bondable_privacy_ll_privacy[] = {
+						MGMT_OP_SET_LE,
+						MGMT_OP_SET_SSP,
+						MGMT_OP_SET_BONDABLE,
+						MGMT_OP_SET_SECURE_CONN,
+						MGMT_OP_SET_PRIVACY,
+						MGMT_OP_SET_EXP_FEATURE,
+						MGMT_OP_SET_POWERED, 0 };
+
+static const struct generic_data ll_privacy_pair = {
+	.setup_settings = settings_powered_le_sc_bondable_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.send_opcode = MGMT_OP_PAIR_DEVICE,
+	.send_func = pair_device_send_param_func,
+	.addr_type_avail = true,
+	.addr_type = 0x01,
+	.client_enable_sc = true,
+	.client_enable_ssp = true,
+	.client_enable_adv = true,
+	.expect_sc_key = true,
+	.io_cap = 0x02, /* KeyboardOnly */
+	.client_io_cap = 0x02, /* KeyboardOnly */
+	.client_auth_req = 0x05, /* Bonding - MITM */
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_func = pair_device_expect_param_func,
+	.expect_alt_ev =  MGMT_EV_NEW_LONG_TERM_KEY,
+	.expect_alt_ev_len = sizeof(struct mgmt_ev_new_long_term_key),
+	.verify_alt_ev_func = verify_ltk,
+};
+
+static const struct generic_data ll_privacy_unpair = {
+	.setup_settings = settings_powered_le_sc_bondable_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.send_opcode = MGMT_OP_PAIR_DEVICE,
+	.send_func = pair_device_send_param_func,
+	.addr_type_avail = true,
+	.addr_type = 0x01,
+	.client_enable_sc = true,
+	.client_enable_ssp = true,
+	.client_enable_adv = true,
+	.expect_sc_key = true,
+	.io_cap = 0x02, /* KeyboardOnly */
+	.client_io_cap = 0x02, /* KeyboardOnly */
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_func = pair_device_expect_param_func,
+	.expect_alt_ev = MGMT_EV_DEVICE_UNPAIRED,
+	.expect_alt_ev_param = unpair_resp_param_1,
+	.expect_alt_ev_len = sizeof(unpair_resp_param_1),
+	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST,
+	.expect_hci_param = set_resolv_off_param,
+	.expect_hci_len = sizeof(set_resolv_off_param),
+};
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
+static void setup_remove_device_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	bool bthost = PTR_TO_INT(user_data);
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("Device is Removed");
+
+	if (bthost)
+		setup_bthost();
+}
+
+static void setup_add_adv_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct mgmt_rp_add_advertising *rp =
+				(struct mgmt_rp_add_advertising *) param;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("Add Advertising setup complete (instance %d)",
+								rp->instance);
+}
+
+static void setup_add_adv_callback_adv(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
+	struct mgmt_rp_add_advertising *rp =
+				(struct mgmt_rp_add_advertising *) param;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
 	}
 
-	tester_print("LL Privacy Exp feature is enabled");
+	tester_print("Add Advertising setup complete (instance %d)",
+								rp->instance);
+
+	/* Add another advertising */
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	setup_add_adv_param(cp, 2);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
+					sizeof(adv_param), adv_param,
+					setup_add_advertising_callback,
+					NULL, NULL);
 }
 
-static void setup_ll_privacy(const void *test_data)
+// static void enable_le_privacy_ext_feature(const void *test_data)
+// {
+// 	struct test_data *data = tester_get_data();
+// 	unsigned char param[] = { 0x01 };
+// 	const uint8_t *ext_feat_param;
+// 	size_t ext_feat_len;
+// 	unsigned char privacy_param[] = { 0x01,
+// 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+// 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
+
+// 	tester_print("Enabling LL Privacy feature");
+
+// 	ext_feat_param = set_exp_feat_param_ll_privacy;
+// 	ext_feat_len = sizeof(set_exp_feat_param_ll_privacy);
+
+// 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+// 					sizeof(param), &param,
+// 					NULL, NULL, NULL);
+
+// 	mgmt_send(data->mgmt, MGMT_OP_SET_PRIVACY, data->mgmt_index,
+// 					sizeof(privacy_param), privacy_param,
+// 					NULL, NULL, NULL);
+
+// 	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, data->mgmt_index,
+// 					ext_feat_len, ext_feat_param,
+// 					setup_exp_feat_callback, NULL, NULL);
+// }
+
+static void setup_ll_privacy_with_irk1(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	unsigned char param[] = { 0x01 };
-	const uint8_t *ext_feat_param;
-	size_t ext_feat_len;
-	const char *irk_param;
-	size_t irk_len;
-	unsigned char privacy_param[] = { 0x01,
-			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
-			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
 
-	tester_print("Enabling LL Privacy feature");
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					sizeof(load_irks_le_public_param_1),
+					load_irks_le_public_param_1,
+					setup_load_irks_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
 
-	ext_feat_param = set_exp_feat_param_ll_privacy;
-	ext_feat_len = sizeof(set_exp_feat_param_ll_privacy);
+}
 
-	irk_param = load_irks_params;
-	irk_len = sizeof(load_irks_params);
+static void setup_ll_privacy_dev1_and_irk2(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
-					sizeof(param), &param,
+	/* Add IRKs of Device1 and Device2 */
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					sizeof(load_irks_2_devices_param),
+					load_irks_2_devices_param,
+					setup_load_irks_callback, NULL, NULL);
+
+	/* Add Device 1 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_1),
+					add_device_le_public_param_1,
+					setup_add_device_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+}
+
+static void setup_ll_privacy_3_devices(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+
+	/* Add IRKs of 4 Devices */
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					sizeof(load_irks_4_devices_param),
+					load_irks_4_devices_param,
+					setup_load_irks_callback, NULL, NULL);
+
+	/* Add Device 1 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_1),
+					add_device_le_public_param_1,
+					setup_add_device_callback, NULL, NULL);
+
+	/* Add Device 2 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_2),
+					add_device_le_public_param_2,
+					setup_add_device_callback, NULL, NULL);
+
+	/* Add Device 3 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_3),
+					add_device_le_public_param_3,
+					setup_add_device_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+}
+
+static void setup_ll_privacy_2_devices_extra_rl(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+
+	hciemu_set_central_le_rl_len(data->hciemu, 2);
+
+	/* Add IRKs of 4 Devices */
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					sizeof(load_irks_4_devices_param),
+					load_irks_4_devices_param,
+					setup_load_irks_callback, NULL, NULL);
+
+	/* Add Device 1 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_1),
+					add_device_le_public_param_1,
+					setup_add_device_callback, NULL, NULL);
+
+	/* Add Device 2 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_2),
+					add_device_le_public_param_2,
+					setup_add_device_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+}
+
+static void setup_ll_privacy_2_devices_extra_al(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+
+	hciemu_set_central_le_al_len(data->hciemu, 2);
+
+	/* Add IRKs of 3 Devices */
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					sizeof(load_irks_3_devices_param),
+					load_irks_3_devices_param,
+					setup_load_irks_callback, NULL, NULL);
+
+	/* Add Device 1 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_1),
+					add_device_le_public_param_1,
+					setup_add_device_callback, NULL, NULL);
+
+	/* Add Device 2 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_2),
+					add_device_le_public_param_2,
+					setup_add_device_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+}
+
+/* Enable LL Privacy and Add 2 devices */
+static void setup_ll_privacy_device2_discovry(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+	uint8_t disc_param[] = { 0x06 };
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+	/* Load IRKs */
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					sizeof(load_irks_2_devices_param),
+					load_irks_2_devices_param,
+					setup_load_irks_callback, NULL, NULL);
+
+	/* Load Device1 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_1),
+					add_device_le_public_param_1,
+					setup_add_device_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_2),
+					add_device_le_public_param_2,
+					setup_add_device_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_START_DISCOVERY, data->mgmt_index,
+					sizeof(disc_param), disc_param,
+					setup_discovery_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_STOP_DISCOVERY, data->mgmt_index,
+					sizeof(disc_param), disc_param,
+					setup_discovery_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_REMOVE_DEVICE, data->mgmt_index,
+					sizeof(add_device_rsp_le_public),
+					add_device_rsp_le_public,
+					setup_remove_device_callback,
+					NULL, NULL);
+}
+
+/* Enable LL Privacy and Add Advertising */
+static void setup_ll_privacy_adv(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char param[] = { 0x01 };
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
+
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	setup_add_adv_param(cp, 1);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
+					sizeof(adv_param), adv_param,
+					setup_add_adv_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+}
+
+/* Enable LL Privacy and Add Advertising */
+static void setup_ll_privacy_2_advs(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char param[] = { 0x01 };
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
+
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	setup_add_adv_param(cp, 1);
+
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					sizeof(load_irks_le_public_param_1),
+					load_irks_le_public_param_1,
+					setup_load_irks_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
 					NULL, NULL, NULL);
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_PRIVACY, data->mgmt_index,
-					sizeof(privacy_param), privacy_param,
+	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
+					sizeof(adv_param), adv_param,
+					setup_add_adv_callback_adv, NULL, NULL);
+}
+
+static void setup_ll_privacy_dev_2_advs(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char param[] = { 0x01 };
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
+
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	setup_add_adv_param(cp, 1);
+
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					sizeof(load_irks_le_public_param_1),
+					load_irks_le_public_param_1,
+					setup_load_irks_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
 					NULL, NULL, NULL);
 
+	/* Add Device 2 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_2),
+					add_device_le_public_param_2,
+					setup_add_device_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
+					sizeof(adv_param), adv_param,
+					setup_add_adv_callback_adv, NULL, NULL);
+}
+
+static void setup_ll_privacy_adv_3_devices(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char param[] = { 0x01 };
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
+
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	setup_add_adv_param(cp, 1);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
+					sizeof(adv_param), adv_param,
+					setup_add_adv_callback, NULL, NULL);
+
+	/* Add IRKs of 4 Devices */
 	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
-					irk_len, irk_param,
+					sizeof(load_irks_4_devices_param),
+					load_irks_4_devices_param,
 					setup_load_irks_callback, NULL, NULL);
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, data->mgmt_index,
-					ext_feat_len, ext_feat_param,
-					setup_exp_feat_callback, NULL, NULL);
+	/* Add Device 1 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_1),
+					add_device_le_public_param_1,
+					setup_add_device_callback, NULL, NULL);
+
+	/* Add Device 2 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_2),
+					add_device_le_public_param_2,
+					setup_add_device_callback, NULL, NULL);
+
+	/* Add Device 3 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_3),
+					add_device_le_public_param_3,
+					setup_add_device_callback, NULL, NULL);
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
 					setup_powered_callback, NULL, NULL);
+}
+
+static void setup_ll_privacy_adv_1_device_2_advs(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char param[] = { 0x01 };
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
+
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	setup_add_adv_param(cp, 1);
+
+	/* Add IRKs of 4 Devices */
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					sizeof(load_irks_4_devices_param),
+					load_irks_4_devices_param,
+					setup_load_irks_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					NULL, NULL, NULL);
+
+	/* Add Device 1 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_1),
+					add_device_le_public_param_1,
+					setup_add_device_callback, NULL, NULL);
+
+	/* Add Device 2 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_2),
+					add_device_le_public_param_2,
+					setup_add_device_callback, NULL, NULL);
 
+	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
+					sizeof(adv_param), adv_param,
+					setup_add_adv_callback_adv, NULL, NULL);
 }
 
-static void setup_add_device_callback(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
+static void setup_add_2_advertisings(const void *test_data)
 {
-	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
-		return;
-	}
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
+	unsigned char param[] = { 0x01 };
 
-	tester_print("New Device is Added");
+	tester_print("Adding advertising instance while powered");
+
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	setup_add_adv_param(cp, 1);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+						sizeof(param), &param,
+						NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
+						sizeof(adv_param), adv_param,
+						setup_add_adv_callback_adv,
+						NULL, NULL);
 }
 
-static void setup_ll_privacy_device(const void *test_data)
+static void setup_add_2_advertisings_no_power(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 	unsigned char param[] = { 0x01 };
-	const uint8_t *ext_feat_param;
-	size_t ext_feat_len;
-	const char *irk_param;
-	size_t irk_len;
-	const uint8_t *dev_param;
-	size_t dev_len;
-	unsigned char privacy_param[] = { 0x01,
-			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
-			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
-
-	tester_print("Setup expected HCI command 0x%04x",
-					 test->setup_expect_hci_command);
-	hciemu_add_central_post_command_hook(data->hciemu,
-					command_setup_hci_callback, data);
-	test_add_setup_condition(data);
-
-	tester_print("Enabling LL Privacy feature");
 
-	ext_feat_param = set_exp_feat_param_ll_privacy;
-	ext_feat_len = sizeof(set_exp_feat_param_ll_privacy);
+	tester_print("Adding advertising instance while not powered");
 
-	irk_param = load_irks_params;
-	irk_len = sizeof(load_irks_params);
-
-	dev_param = add_device_success_param_6;
-	dev_len = sizeof(add_device_success_param_6);
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	setup_add_adv_param(cp, 1);
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
-					sizeof(param), &param,
-					NULL, NULL, NULL);
-
-	mgmt_send(data->mgmt, MGMT_OP_SET_PRIVACY, data->mgmt_index,
-					sizeof(privacy_param), privacy_param,
-					NULL, NULL, NULL);
+						sizeof(param), &param,
+						NULL, NULL, NULL);
 
-	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
-					irk_len, irk_param,
-					setup_load_irks_callback, NULL, NULL);
+	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
+						sizeof(adv_param), adv_param,
+						setup_add_adv_callback_adv,
+						NULL, NULL);
+}
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, data->mgmt_index,
-					ext_feat_len, ext_feat_param,
-					setup_exp_feat_callback, NULL, NULL);
+static void setup_ll_privacy_enable_powered(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+	struct bthost *bthost;
 
-	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
-					dev_len, dev_param,
-					setup_add_device_callback, NULL, NULL);
+	bthost = hciemu_client_get_host(data->hciemu);
+	bthost_set_scan_params(bthost, 0x01, 0x00, 0x00);
+	bthost_set_scan_enable(bthost, 0x01);
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
 					setup_powered_callback, NULL, NULL);
 }
 
-static const uint8_t add_device_success_param_4[] = {
-					0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
-					0x01,
-					0x02,
-};
-
-/* Enable LL Privacy and Add 2 devices */
-static void setup_ll_privacy_device2(const void *test_data)
+static void setup_ll_privacy_add_adv(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
 	unsigned char param[] = { 0x01 };
-	const uint8_t *ext_feat_param;
-	size_t ext_feat_len;
-	const char *irk_param;
-	size_t irk_len;
-	const uint8_t *dev_param, *dev2_param;
-	size_t dev_len, dev2_len;
-	unsigned char privacy_param[] = { 0x01,
-			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
-			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
-
-	tester_print("Enabling LL Privacy feature");
-
-	ext_feat_param = set_exp_feat_param_ll_privacy;
-	ext_feat_len = sizeof(set_exp_feat_param_ll_privacy);
-
-	irk_param = load_irks_params;
-	irk_len = sizeof(load_irks_params);
+	unsigned char set_adv_param[] = { 0x02 };
+	struct bthost *bthost;
 
-	dev_param = add_device_success_param_6;
-	dev_len = sizeof(add_device_success_param_6);
+	/* Setup bthost to enable the scan */
+	bthost = hciemu_client_get_host(data->hciemu);
+	bthost_set_scan_params(bthost, 0x01, 0x00, 0x00);
+	bthost_set_scan_enable(bthost, 0x01);
 
-	dev2_param = add_device_success_param_4;
-	dev2_len = sizeof(add_device_success_param_4);
+	mgmt_send(data->mgmt, MGMT_OP_SET_CONNECTABLE, data->mgmt_index,
+						sizeof(param), &param,
+						NULL, NULL, NULL);
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
-					sizeof(param), &param,
-					NULL, NULL, NULL);
+	mgmt_send(data->mgmt, MGMT_OP_SET_BONDABLE, data->mgmt_index,
+						sizeof(param), &param,
+						NULL, NULL, NULL);
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_PRIVACY, data->mgmt_index,
-					sizeof(privacy_param), privacy_param,
+	mgmt_send(data->mgmt, MGMT_OP_SET_IO_CAPABILITY, data->mgmt_index,
+					sizeof(test->io_cap), &test->io_cap,
 					NULL, NULL, NULL);
 
-	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
-					irk_len, irk_param,
-					setup_load_irks_callback, NULL, NULL);
-
-	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, data->mgmt_index,
-					ext_feat_len, ext_feat_param,
-					setup_exp_feat_callback, NULL, NULL);
-
-	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
-					dev_len, dev_param,
-					setup_add_device_callback, NULL, NULL);
-
-	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
-					dev2_len, dev2_param,
-					setup_add_device_callback, NULL, NULL);
+	mgmt_send(data->mgmt, MGMT_OP_SET_ADVERTISING, data->mgmt_index,
+						sizeof(set_adv_param),
+						&set_adv_param,
+						NULL, NULL, NULL);
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
@@ -10035,6 +11057,28 @@ static bool power_off(uint16_t index)
 	return true;
 }
 
+/* Read HCI commands in the expect_hci_list and add it to the queue
+ */
+static void add_expect_hci_list(struct test_data *data)
+{
+	const struct generic_data *test = data->test_data;
+	const struct hci_cmd_data *hci_cmd_data;
+
+	/* Initialize the queue */
+	data->expect_hci_q = queue_new();
+
+	hci_cmd_data = test->expect_hci_list;
+	for (; hci_cmd_data->opcode; hci_cmd_data++) {
+		struct hci_entry *entry;
+
+		entry = new0(struct hci_entry, 1);
+		entry->cmd_data = hci_cmd_data;
+		queue_push_tail(data->expect_hci_q, entry);
+
+		test_add_condition(data);
+	}
+}
+
 static void test_command_generic(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -10073,6 +11117,14 @@ static void test_command_generic(const void *test_data)
 		hciemu_add_central_post_command_hook(data->hciemu,
 						command_hci_callback, data);
 		test_add_condition(data);
+	} else if (test->expect_hci_list) {
+		/* Use this when it needs to check more than 1 hci command.
+		 * However, it cannot be used with expect_hci_command.
+		 */
+		tester_print("Registering HCI command list callback");
+		hciemu_add_central_post_command_hook(data->hciemu,
+					command_hci_list_callback, data);
+		add_expect_hci_list(data);
 	}
 
 	if (test->send_opcode == 0x0000) {
@@ -10219,6 +11271,139 @@ static void test_pairing_acceptor(const void *test_data)
 	bthost_hci_connect(bthost, central_bdaddr, addr_type);
 }
 
+
+static void check_le_ext_adv_discovery(void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *adv_addr;
+	struct bthost *bthost;
+
+	adv_addr = hciemu_get_central_adv_addr(data->hciemu, 0x00);
+	if (!adv_addr) {
+		tester_warn("No EXT ADV Address");
+		tester_test_failed();
+		return;
+	}
+
+	bthost = hciemu_client_get_host(data->hciemu);
+	if (bthost_search_ext_adv_addr(bthost, adv_addr))
+		tester_test_passed();
+	else
+		tester_test_failed();
+
+	test_condition_complete(data);
+}
+
+static void test_ll_privacy_bthost_scan_report(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	test_command_generic(test_data);
+	tester_wait(1, check_le_ext_adv_discovery, NULL);
+	test_add_condition(data);
+}
+
+static void test_pairing_acceptor_ll_privacy_le_random(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const uint8_t *adv_addr;
+	struct bthost *bthost;
+
+	if (test->expect_alt_ev) {
+		unsigned int id;
+
+		tester_print("Registering %s notification",
+					mgmt_evstr(test->expect_alt_ev));
+		id = mgmt_register(data->mgmt_alt, test->expect_alt_ev,
+					data->mgmt_index,
+					command_generic_event_alt, NULL, NULL);
+		data->mgmt_alt_ev_id = id;
+		test_add_condition(data);
+	}
+
+	adv_addr = hciemu_get_central_adv_addr(data->hciemu, 0x00);
+	if (!adv_addr) {
+		tester_warn("No EXT ADV Address");
+		tester_test_failed();
+		return;
+	}
+
+	tester_print("Ext Adv Address: %02x:%02x:%02x:%02x:%02x:%02x",
+			adv_addr[0], adv_addr[1], adv_addr[2],
+			adv_addr[3], adv_addr[4], adv_addr[5]);
+
+	bthost = hciemu_client_get_host(data->hciemu);
+	bthost_set_connect_cb(bthost, pairing_new_conn, data);
+
+	bthost_hci_ext_connect(bthost, adv_addr, BDADDR_LE_RANDOM);
+}
+
+static void unpair_device_command_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	tester_print("%s (0x%04x): %s (0x%02x)",
+		     mgmt_opstr(MGMT_OP_UNPAIR_DEVICE),
+		     MGMT_OP_UNPAIR_DEVICE, mgmt_errstr(status), status);
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_warn("Unexpected status got %d expected %d",
+						status, MGMT_STATUS_SUCCESS);
+		tester_test_failed();
+		return;
+	}
+	test_condition_complete(data);
+}
+
+static void unpair_device(void *user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	tester_print("Sending %s (0x%04x)", mgmt_opstr(MGMT_OP_UNPAIR_DEVICE),
+							MGMT_OP_UNPAIR_DEVICE);
+
+	/* Send Unpair command */
+	mgmt_send(data->mgmt, MGMT_OP_UNPAIR_DEVICE, data->mgmt_index,
+		  sizeof(unpair_clinet_1), unpair_clinet_1,
+		  unpair_device_command_callback, NULL, NULL);
+	test_add_condition(data);
+}
+
+static void new_link_key_evt_callback(uint16_t index, uint16_t length,
+							const void *param,
+							void *user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	tester_print("New %s event received", mgmt_evstr(MGMT_EV_NEW_LINK_KEY));
+
+	mgmt_unregister(data->mgmt, data->mgmt_discov_ev_id);
+
+	/* TODO: validate the event */
+	test_condition_complete(data);
+
+	/* Wait 1 sec for pairing command complete event */
+	tester_wait(1, unpair_device, NULL);
+}
+
+static void test_ll_privacy_unpair(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned int id;
+
+	test_command_generic(test_data);
+
+	tester_print("Registering New Link Key notification");
+	id = mgmt_register(data->mgmt, MGMT_EV_NEW_LINK_KEY,
+			   data->mgmt_index, new_link_key_evt_callback,
+			   NULL, NULL);
+	/* Reuse the variable */
+	data->mgmt_discov_ev_id = id;
+	test_add_condition(data);
+}
+
 static void connected_event(uint16_t index, uint16_t length, const void *param,
 							void *user_data)
 {
@@ -11246,13 +12431,6 @@ int main(int argc, char *argv[])
 	test_bredrle("Start Discovery - Power Off 1",
 				&start_discovery_valid_param_power_off_1,
 				NULL, test_command_generic);
-	/* MGMT_OP_START_DISCOVERY
-	 * Check if the resolving list is disabled before the scan parameter is
-	 * changed.
-	 */
-	test_bredrle50("Start Discovery - Disable Resolve List",
-				&start_discovery_ll_privacy_disable_resolv,
-				setup_ll_privacy_device, test_command_generic);
 
 	test_bredrle("Stop Discovery - Success 1",
 				&stop_discovery_success_test_1,
@@ -11671,26 +12849,6 @@ int main(int argc, char *argv[])
 	test_bredrle("Add Device - Success 5",
 				&add_device_success_5,
 				NULL, test_command_generic);
-	/* MGMT_OP_ADD_DEVICE
-	 * Add device and check the device is added to the accept list
-	 */
-	test_bredrle50("Add Device - Success 6 - Add to accept list",
-				&add_device_success_6,
-				NULL, test_command_generic);
-	/* MGMT_OP_ADD_DEVICE
-	 * Add device and check the device is added to the resolve list
-	 * when the LL Privacy is enabled
-	 */
-	test_bredrle50("Add Device - Success 7 - Add to resolv list",
-				&add_device_success_7,
-				setup_ll_privacy, test_command_generic);
-	/* MGMT_OP_ADD_DEVICE
-	 * Add device and check the Resolving List is enabled for the device
-	 * when the LL Privacy is enabled
-	 */
-	test_bredrle50("Add Device - Success 8 - Enable resolv list",
-				&add_device_success_8,
-				setup_ll_privacy, test_command_generic);
 
 	test_bredrle("Remove Device - Invalid Params 1",
 				&remove_device_fail_1,
@@ -11722,20 +12880,6 @@ int main(int argc, char *argv[])
 	test_bredrle50("Remove Device - Success 6 - All Devices",
 				&remove_device_success_6,
 				setup_add_device, test_remove_device);
-	/* MGMT_OP_REMOVE_DEVICE
-	 * Remove the device and check the device is removed from the whilte
-	 * list as well.
-	 */
-	test_bredrle50("Remove Device - Success 7 - Remove from accept list",
-				&remove_device_success_7,
-				setup_ll_privacy_device2, test_command_generic);
-	/* MGMT_OP_REMOVE_DEVICE
-	 * Remove the device and check the device is removed from the resolving
-	 * list as well when the LL Privacy is enabled.
-	 */
-	test_bredrle50("Remove Device - Success 8 - Remove from resolv list",
-				&remove_device_success_8,
-				setup_ll_privacy_device2, test_command_generic);
 
 	test_bredrle("Read Advertising Features - Invalid parameters",
 				&read_adv_features_invalid_param_test,
@@ -12297,6 +13441,55 @@ int main(int argc, char *argv[])
 					&multi_ext_advertising_add_second,
 					setup_add_advertising_duration,
 					test_command_generic, 3);
+	/* Multi Ext Advertising
+	 * Setup: Power on and the first ext advertising
+	 * Run: Add the second ext advertising
+	 * Expect: The second ext advertising is added.
+	 */
+	test_bredrle50("Multi Ext Advertising - Success 3 (Add 2 Advs)",
+					&multi_ext_advertising_add_second_2,
+					setup_add_advertising,
+					test_command_generic);
+
+	/* Multi Ext Advertising
+	 * Setup: Power on and add two ext advertising
+	 * Run: Remove the advertising
+	 * Expect: Received the removed event
+	 */
+	test_bredrle50("Multi Ext Advertising - Success 4 (Remove Adv)",
+					&multi_ext_advertising_remove,
+					setup_add_2_advertisings,
+					test_command_generic);
+
+	/* Multi Ext Advertising
+	 * Setup: Power on and add max advertisings
+	 * Run: Remove all advertisings
+	 * Expect:
+	 */
+	test_bredrle50("Multi Ext Advertising - Success 5 (Remove all)",
+					&multi_ext_advertising_remove_all,
+					setup_add_2_advertisings,
+					test_command_generic);
+
+	/* Multi Ext Advertising
+	 * Setup: Add multiple advertising before power on
+	 * Run: Power on
+	 * Expect: All advertising are set
+	 */
+	test_bredrle50("Multi Ext Advertising - Success 6 (Add w/o power on)",
+					&multi_ext_advertising_add_no_power,
+					setup_add_2_advertisings_no_power,
+					test_command_generic);
+
+	/* Multi Ext Advertising
+	 * Setup: Power on and add max advertisings
+	 * Run: Add another advertising
+	 * Expect: Received error - Invalid Parameter
+	 */
+	test_bredrle50("Multi Ext Advertising - Fail (Add MAX)",
+					&multi_ext_advertising_add_adv_4,
+					setup_add_2_advertisings,
+					test_command_generic);
 
 	test_bredrle50("Get PHY Success", &get_phy_success,
 					NULL, test_command_generic);
@@ -12417,7 +13610,7 @@ int main(int argc, char *argv[])
 				setup_ext_adv_params,
 				test_command_generic);
 
-	test_bredrle50("Ext Adv MGMT - AD Scan Response (5.0) Success",
+	test_bredrle50("zxcv Ext Adv MGMT - AD Scan Response (5.0) Success",
 				&adv_scan_rsp_success,
 				setup_ext_adv_params,
 				test_command_generic);
@@ -12674,6 +13867,225 @@ int main(int argc, char *argv[])
 				&set_exp_feat_unknown,
 				NULL, test_command_generic);
 
+	/* LL Privacy
+	 * Setup: Enable LE and Power On
+	 * Run: Add new device
+	 * Expect: Device is added to the accept list
+	 */
+	test_bredrle50("LL Privacy - Add Device 1 (Add to AL)",
+				&ll_privacy_add_device_1,
+				NULL, test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy and add IRK of new device
+	 * Run: Add new device
+	 * Expect: Device is added to the resolving list
+	 */
+	test_bredrle50("LL Privacy - Add Device 2 (Add to RL)",
+				&ll_privacy_add_device_2,
+				setup_ll_privacy_with_irk1,
+				test_command_generic);
+	/* LL Privacy
+	 * Setup: Enable LL Privacy and add IRK of new device
+	 * Run: Add new device
+	 * Expect: Device is added to the resolving list and resolving list
+	 *         is enabled
+	 */
+	test_bredrle50("LL Privacy - Add Device 3 (Enable RL)",
+				&ll_privacy_add_device_3,
+				setup_ll_privacy_with_irk1,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy, add device1 with IRK, and add IRK of
+	 *        device2
+	 * Run: Add new device2
+	 * Expect: Device2 is added to the accept list
+	 */
+	test_bredrle50("LL Privacy - Add Device 4 (2 Devices to AL)",
+				&ll_privacy_add_device_4,
+				setup_ll_privacy_dev1_and_irk2,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy, add device1 with IRK, and add IRK of
+	 *        device2
+	 * Run: Add new device2
+	 * Expect: Device2 is added to the resolv list
+	 */
+	test_bredrle50("LL Privacy - Add Device 5 (2 Devices to RL)",
+				&ll_privacy_add_device_5,
+				setup_ll_privacy_dev1_and_irk2,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy, add 3 devices with IRKs, and add IRK of
+	 *        device4
+	 * Run: Add new device4
+	 * Expect: Device4 is added but failed to add to resolv list because
+	 *         btdev resolv list is full.
+	 */
+	test_bredrle50("LL Privacy - Add Device 6 (RL is full)",
+				&ll_privacy_add_device_6,
+				setup_ll_privacy_2_devices_extra_rl,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy, add 2 devices with IRKs and 1 device
+	 *        without IRK, and add IRK for device4
+	 * Run: Add new device4
+	 * Expect: Device4 is added but failed to add to accept list, and it
+	 *         is removed from the resolv list.
+	 */
+	test_bredrle50("LL Privacy - Add Device 7 (AL is full)",
+				&ll_privacy_add_device_7,
+				setup_ll_privacy_2_devices_extra_al,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy, and add advertising
+	 * Run: Add new device
+	 * Expect: Disable the advertising before adding new device to the
+	 *         accept list and resolving list
+	 */
+	test_bredrle50("LL Privacy - Add Device 8 (Disable Adv)",
+				&ll_privacy_add_device_8,
+				setup_ll_privacy_adv, test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy, and add 2 advertisings
+	 * Run: Add new device
+	 * Expect: Disable the advertising before adding new device to the
+	 *         accept list and resolving list
+	 */
+	test_bredrle50("LL Privacy - Add Device 9 (Multi Adv)",
+				&ll_privacy_add_device_9,
+				setup_ll_privacy_2_advs, test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy, and add 1 device and add 2 advertisings
+	 * Run: Add new device
+	 * Expect: Disable the advertising before adding new device to the
+	 *         accept list and resolving list
+	 */
+	test_bredrle50("LL Privacy - Add Device 10 (Multi Dev and Multi Adv)",
+				&ll_privacy_add_device_9,
+				setup_ll_privacy_dev_2_advs,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy and add 2 devices and its IRK
+	 * Run: Remove one of devices
+	 * Expect: The device is removed from the accept list
+	 */
+	test_bredrle50("LL Privacy - Remove Device 1 (Remove from AL)",
+				&ll_privacy_remove_device_1,
+				setup_ll_privacy_3_devices,
+				test_command_generic);
+	/* LL Privacy
+	 * Setup: Enable LL Privacy and add 2 devices and its IRK
+	 * Run: Remove one of devices
+	 * Expect: The device is removed from the resolving list
+	 */
+	test_bredrle50("LL Privacy - Remove Device 2 (Remove from RL)",
+				&ll_privacy_remove_device_2,
+				setup_ll_privacy_3_devices,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy and add a device and its IRK
+	 * Run: Remove device
+	 * Expect: Device is removed and disable the resolving list before
+	 *         removing the device from the list.
+	 */
+	test_bredrle50("LL Privacy - Remove Device 3 (Disable RL)",
+				&ll_privacy_remove_device_3,
+				setup_ll_privacy_3_devices,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy, add advertising and add device
+	 * Run: Remove the device
+	 * Expect: Disable the advertising before removing the device from the
+	 *         accept list and resolving list
+	 */
+	test_bredrle50("LL Privacy - Remove Device 4 (Disable Adv)",
+				&ll_privacy_remove_device_4,
+				setup_ll_privacy_adv_3_devices,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy, add advertisings and add device
+	 * Run: Remove the device
+	 * Expect: Disable the advertising before removing the device from the
+	 *         accept list and resolving list
+	 */
+	test_bredrle50("LL Privacy - Remove Device 5 (Multi Adv)",
+				&ll_privacy_remove_device_5,
+				setup_ll_privacy_adv_1_device_2_advs,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy
+	 * Check if the resolving list is disabled before the scan parameter is
+	 * changed.
+	 */
+	test_bredrle50("LL Privacy - Start Discovery 1 (Disable RL)",
+				&ll_privacy_start_discovery_ll_privacy_1,
+				setup_ll_privacy_dev1_and_irk2,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy, Add 2 devices with IRKs and remove one of
+	 *        the device
+	 * Run: Start Discovery
+	 * Expect: Resolving list is disabled.
+	 */
+	test_bredrle50("LL Privacy - Start Discovery 2 (Disable RL)",
+				&ll_privacy_start_discovery_ll_privacy_2,
+				setup_ll_privacy_device2_discovry,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable Privacy, LL Privacy, and enable advertising
+	 * Run: bthost scan the advertising
+	 * Expect: bthost receives the advertising with random address
+	 */
+	test_bredrle50("LL Privacy - Advertising 1 (Scan Result)",
+				&ll_privacy_advertising_1,
+				setup_ll_privacy_enable_powered,
+				test_ll_privacy_bthost_scan_report);
+
+	/* LL Privacy
+	 * Setup: Enable Privacy, LL Privacy, and enable advertising
+	 * Run: Connect from bthost
+	 * Expect: Pair success
+	 */
+	test_bredrle50("LL Privacy - Acceptor 1",
+				&ll_privacy_acceptor_1,
+				setup_ll_privacy_add_adv,
+				test_pairing_acceptor_ll_privacy_le_random);
+
+	/* LL Privacy
+	 * Setup: Enable Privacy, LL Privacy, and enable advertising
+	 * Run: Connect from bthost
+	 * Expect: Pair success
+	 */
+	test_bredrle50("LL Privacy - Acceptor 2",
+				&ll_privacy_acceptor_2,
+				setup_ll_privacy_add_adv,
+				test_pairing_acceptor_ll_privacy_le_random);
+
+
+	test_bredrle50("LL Privacy - Pair",
+				&ll_privacy_pair,
+				NULL,
+				test_command_generic);
+
+	test_bredrle50("LL Privacy - Unpair",
+				&ll_privacy_unpair,
+				NULL,
+				test_ll_privacy_unpair);
 
 	return tester_run();
 }
-- 
2.25.1

