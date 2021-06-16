Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC88C48BE6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 23:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C035761159
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 23:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhFPXjb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Jun 2021 19:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbhFPXja (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Jun 2021 19:39:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEEBC06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jun 2021 16:37:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ei4so2703582pjb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jun 2021 16:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SYkSnnoWxQuGu2Fyh4sjvV8DMjDqdZIovF0bVODvrII=;
        b=LODzVYLq9IsSKtnR0panVUeE1rgamB9Rcsv6tjVfz8GedHPI9DiZPwZq70egV2U1Fy
         +1Ckp9KGS34wC6jIfSA8IM54MxZUGyqMRoX1S7QHvJpkhuM42wREWVNR7SFTUasO88ue
         1WtdUblcciB3xxBW7X4el7CWCbRRBog21zrPhyh2g1Grlc+BtKc4kGt8e9gPLKxpfbCR
         VKU9kWKDsMzr/kvi6zLaWZpaRexfqP7Cdz1usojavkaSzuu6dWEUwGQaf+kNfR18fKzM
         76Ju2KvRYIEXTtgCyp1RH/naS9DwTwY5/WFVegNEGxXMSk3mOAcfpet9IiQJ1LjmQBX/
         0miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYkSnnoWxQuGu2Fyh4sjvV8DMjDqdZIovF0bVODvrII=;
        b=F1+flF8zFpJ/4caS1osfq0geQCLUmoBnsZndy4EGHO3rLSo6VWkMZeqDwbehpVh7qy
         to7o3Kr0JDEt/ac2MJ3/WJsXrP4XdOhL+jpnjlguSHYy5GbXAw7++mCM7thwLvytgf50
         dgv0gbgHgfySxck3wHGhaqlohhhGCfEL0A9BXz+sRxsvDyaRFJmupy+29WeNkZH9SYYH
         oF7/CmUkGemM/2jbE/06G7EZ/slLS/4I4AIsoviAxBmUiAfWL7rSF8fHwzGVvy4VOtp2
         ttaHh81403YqDyBRlTqc4vowaEeOrNAR5hDx0gg5gsdJexxwLIaEQz+x2vQmx0gNxrKL
         Dl6Q==
X-Gm-Message-State: AOAM531se5JPZ5AeKlRlOlWtg890KsOdA9udwecahYVwYRmUemF1NqYm
        w1svse8ecQi454drhIKji1gIKDvtEq4=
X-Google-Smtp-Source: ABdhPJxd2ElNBgcc9AZwNlT8R8NNl2MtQOxSyjObUzwxM4r/+FBovIJlvr/5SETsBgFifYWTycB25Q==
X-Received: by 2002:a17:902:b203:b029:11b:1549:da0d with SMTP id t3-20020a170902b203b029011b1549da0dmr1867556plr.48.1623886642532;
        Wed, 16 Jun 2021 16:37:22 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id u24sm3311059pfm.200.2021.06.16.16.37.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 16:37:20 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v2 2/2] tools/mgmt-tester: Add LL Privacy test cases
Date:   Wed, 16 Jun 2021 16:37:16 -0700
Message-Id: <20210616233716.1920026-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210616233716.1920026-1-hj.tedd.an@gmail.com>
References: <20210616233716.1920026-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds LL Privacy related test cases.

LL Privacy - Add Device 1 (Add to white list)
LL Privacy - Add Device 2 (Add to resolv List)
LL Privacy - Add Device 3 (Enable resolv List)
LL Privacy - Add Device 4 (2 Devices to white list)
LL Privacy - Add Device 5 (2 Devices to resolv list)
LL Privacy - Add Device 6 (Resolv list is full)
LL Privacy - Add Device 7 (White list is full)
LL Privacy - Add Device 8 (Disabling Advertising)

LL Privacy - Remove Device 1 (Remove from white list)
LL Privacy - Remove Device 2 (Remove from resolv list)
LL Privacy - Remove Device 3 (Disable resolv list)
LL Privacy - Remove Device 4 (Disabling advertising)

LL Privacy - Start Discovery 1 (Disable resolv list)
LL Privacy - Start Discovery 2 (Disable resolv list)
---
 tools/mgmt-tester.c | 1050 +++++++++++++++++++++++++++++++------------
 1 file changed, 761 insertions(+), 289 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index fe39506f6..5d874f3a0 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -2094,24 +2094,6 @@ static const struct generic_data start_discovery_valid_param_power_off_1 = {
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
@@ -4163,71 +4145,6 @@ static const struct generic_data add_device_success_5 = {
 	.expect_hci_len = sizeof(le_scan_enable),
 };
 
-static const uint8_t add_device_success_param_6[] = {
-					0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
-					0x01,
-					0x02,
-};
-
-static const uint8_t le_add_to_white_list_param[] = {
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
-	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_WHITE_LIST,
-	.expect_hci_param = le_add_to_white_list_param,
-	.expect_hci_len = sizeof(le_add_to_white_list_param),
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
@@ -4347,36 +4264,6 @@ static const struct generic_data remove_device_success_6 = {
 	.expect_status = MGMT_STATUS_SUCCESS,
 };
 
-static const struct generic_data remove_device_success_7 = {
-	.send_opcode = MGMT_OP_REMOVE_DEVICE,
-	.send_param = remove_device_param_2,
-	.send_len = sizeof(remove_device_param_2),
-	.expect_param = remove_device_param_2,
-	.expect_len = sizeof(remove_device_param_2),
-	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST,
-	.expect_hci_param = le_add_to_white_list_param,
-	.expect_hci_len = sizeof(le_add_to_white_list_param),
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
-	.expect_hci_param = le_add_to_white_list_param,
-	.expect_hci_len = sizeof(le_add_to_white_list_param),
-	.expect_alt_ev = MGMT_EV_DEVICE_REMOVED,
-	.expect_alt_ev_param = remove_device_param_2,
-	.expect_alt_ev_len = sizeof(remove_device_param_2),
-};
-
 static const struct generic_data read_adv_features_invalid_param_test = {
 	.send_opcode = MGMT_OP_READ_ADV_FEATURES,
 	.send_param = dummy_data,
@@ -9067,6 +8954,7 @@ static const struct generic_data start_discovery_le_1m_coded_scan_param = {
 	.expect_alt_ev_len = sizeof(start_discovery_evt),
 };
 
+
 static void set_phy_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -9325,161 +9213,438 @@ static const struct generic_data set_exp_feat_unknown = {
 	.expect_status = MGMT_STATUS_NOT_SUPPORTED,
 };
 
-static const char load_irks_params[] = { 0x01, 0x00,
-			0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0x01,
-			0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
-			0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88 };
-
+static const uint8_t add_device_le_public_param_1[] = {
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+	0x02,					/* Action - Auto-Connect */
+};
 
-static void setup_load_irks_callback(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
-{
-	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
-		return;
-	}
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
 
-	tester_print("Load IRK completed");
-}
+static const uint8_t add_device_le_public_param_2[] = {
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+	0x00,					/* Action - Background scan */
+};
 
-static void setup_exp_feat_callback(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
-{
-	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
-		return;
-	}
+static const uint8_t add_device_rsp_le_public_2[] =  {
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+};
 
-	tester_print("LL Privacy Exp feature is enabled");
-}
+static const uint8_t add_device_le_public_param_3[] = {
+	0x33, 0x33, 0x33, 0x44, 0x55, 0x66,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+	0x00,					/* Action - Background scan */
+};
 
-static void setup_ll_privacy(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	unsigned char param[] = { 0x01 };
-	const uint8_t *ext_feat_param;
-	size_t ext_feat_len;
-	const char *irk_param;
-	size_t irk_len;
-	unsigned char privacy_param[] = { 0x01,
-			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
-			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
+static const uint8_t add_device_rsp_le_public_3[] =  {
+	0x33, 0x33, 0x33, 0x44, 0x55, 0x66,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+};
 
-	tester_print("Enabling LL Privacy feature");
+static const uint8_t add_device_le_public_param_4[] = {
+	0x44, 0x44, 0x44, 0x44, 0x55, 0x66,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+	0x00,					/* Action - Background scan */
+};
 
-	ext_feat_param = set_exp_feat_param_ll_privacy;
-	ext_feat_len = sizeof(set_exp_feat_param_ll_privacy);
+static const uint8_t add_device_rsp_le_public_4[] =  {
+	0x44, 0x44, 0x44, 0x44, 0x55, 0x66,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+};
 
-	irk_param = load_irks_params;
-	irk_len = sizeof(load_irks_params);
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
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
-					sizeof(param), &param,
-					NULL, NULL, NULL);
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
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_PRIVACY, data->mgmt_index,
-					sizeof(privacy_param), privacy_param,
-					NULL, NULL, NULL);
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
 
-	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
-					irk_len, irk_param,
-					setup_load_irks_callback, NULL, NULL);
+ static const uint8_t le_add_to_white_list_param[] = {
+	0x00,					/* Type */
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
+};
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, data->mgmt_index,
-					ext_feat_len, ext_feat_param,
-					setup_exp_feat_callback, NULL, NULL);
+static const uint8_t le_add_to_white_list_param_2[] = {
+	0x00,					/* Type */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,	/* Address */
+};
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
-					sizeof(param), param,
-					setup_powered_callback, NULL, NULL);
+static const uint8_t le_add_to_white_list_param_3[] = {
+	0x00,					/* Type */
+	0x33, 0x33, 0x33, 0x44, 0x55, 0x66,	/* Address */
+};
 
-}
+static const uint8_t le_add_to_resolv_list_param[] = {
+	0x00,						/* Type */
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,		/* BDADDR */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,	/* Peer IRK */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,	/* Local IRK */
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+};
 
-static void setup_add_device_callback(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
-{
-	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
-		return;
-	}
+static const uint8_t le_add_to_resolv_list_param_2[] = {
+	0x00,						/* Type */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,		/* BDADDR */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,	/* Peer IRK */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,	/* Local IRK */
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+};
 
-	tester_print("New Device is Added");
-}
+static const uint8_t le_add_to_resolv_list_param_4[] = {
+	0x00,						/* Type */
+	0x44, 0x44, 0x44, 0x44, 0x55, 0x66,		/* BDADDR */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,	/* Peer IRK */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,	/* Local IRK */
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+};
 
-static void setup_ll_privacy_device(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	unsigned char param[] = { 0x01 };
-	const uint8_t *ext_feat_param;
-	size_t ext_feat_len;
-	const char *irk_param;
-	size_t irk_len;
-	const uint8_t *dev_param;
-	size_t dev_len;
-	unsigned char privacy_param[] = { 0x01,
-			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
-			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
+static const char set_resolv_off_param[] = { 0x00 };
+static const char set_resolv_on_param[] = { 0x01 };
 
-	tester_print("Setup expected HCI command 0x%04x",
-					 test->setup_expect_hci_command);
-	hciemu_add_master_post_command_hook(data->hciemu,
-					command_setup_hci_callback, data);
-	test_add_setup_condition(data);
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
+	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_WHITE_LIST,
+	.expect_hci_param = le_add_to_white_list_param,
+	.expect_hci_len = sizeof(le_add_to_white_list_param),
+};
 
-	tester_print("Enabling LL Privacy feature");
+static const struct generic_data ll_privacy_add_device_2 = {
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
 
-	ext_feat_param = set_exp_feat_param_ll_privacy;
-	ext_feat_len = sizeof(set_exp_feat_param_ll_privacy);
+static const struct generic_data ll_privacy_add_device_3 = {
+	.send_opcode = MGMT_OP_ADD_DEVICE,
+	.send_param = add_device_le_public_param_1,
+	.send_len = sizeof(add_device_le_public_param_1),
+	.expect_param = add_device_rsp_le,
+	.expect_len = sizeof(add_device_rsp_le),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
+	.expect_alt_ev_param = add_device_le_public_param_1,
+	.expect_alt_ev_len = sizeof(add_device_le_public_param_1),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
+	.expect_hci_param = set_resolv_on_param,
+	.expect_hci_len = sizeof(set_resolv_on_param),
+};
 
-	irk_param = load_irks_params;
-	irk_len = sizeof(load_irks_params);
+static const struct generic_data ll_privacy_add_device_4 = {
+	.send_opcode = MGMT_OP_ADD_DEVICE,
+	.send_param = add_device_le_public_param_2,
+	.send_len = sizeof(add_device_le_public_param_2),
+	.expect_param = add_device_rsp_le_public_2,
+	.expect_len = sizeof(add_device_rsp_le_public_2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
+	.expect_alt_ev_param = add_device_le_public_param_2,
+	.expect_alt_ev_len = sizeof(add_device_le_public_param_2),
+	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_WHITE_LIST,
+	.expect_hci_param = le_add_to_white_list_param_2,
+	.expect_hci_len = sizeof(le_add_to_white_list_param_2),
+};
 
-	dev_param = add_device_success_param_6;
-	dev_len = sizeof(add_device_success_param_6);
+static const struct generic_data ll_privacy_add_device_5 = {
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
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
-					sizeof(param), &param,
-					NULL, NULL, NULL);
+static const struct generic_data ll_privacy_add_device_6 = {
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
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_PRIVACY, data->mgmt_index,
-					sizeof(privacy_param), privacy_param,
-					NULL, NULL, NULL);
+static const struct generic_data ll_privacy_add_device_7 = {
+	.send_opcode = MGMT_OP_ADD_DEVICE,
+	.send_param = add_device_le_public_param_3,
+	.send_len = sizeof(add_device_le_public_param_3),
+	.expect_param = add_device_rsp_le_public_3,
+	.expect_len = sizeof(add_device_rsp_le_public_3),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
+	.expect_alt_ev_param = add_device_le_public_param_3,
+	.expect_alt_ev_len = sizeof(add_device_le_public_param_3),
+	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST,
+	.expect_hci_param = le_add_to_white_list_param_3,
+	.expect_hci_len = sizeof(le_add_to_white_list_param_3),
+};
 
-	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
-					irk_len, irk_param,
-					setup_load_irks_callback, NULL, NULL);
+static const char set_ext_adv_disable[] = {
+	0x00, 0x00,
+};
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, data->mgmt_index,
-					ext_feat_len, ext_feat_param,
-					setup_exp_feat_callback, NULL, NULL);
+static const struct generic_data ll_privacy_add_device_8 = {
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
 
-	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
-					dev_len, dev_param,
-					setup_add_device_callback, NULL, NULL);
+static const struct generic_data ll_privacy_remove_device_1 = {
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
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
-					sizeof(param), param,
-					setup_powered_callback, NULL, NULL);
-}
+static const struct generic_data ll_privacy_remove_device_2 = {
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
 
-static const uint8_t add_device_success_param_4[] = {
-					0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
-					0x01,
-					0x02,
+static const struct generic_data ll_privacy_remove_device_3 = {
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
 };
 
-/* Enable LL Privacy and Add 2 devices */
-static void setup_ll_privacy_device2(const void *test_data)
+static const struct generic_data ll_privacy_remove_device_4 = {
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
+static const struct generic_data ll_privacy_start_discovery_ll_privacy_1 = {
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
+	.setup_expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST,
+	.setup_expect_hci_param = le_add_to_white_list_param,
+	.setup_expect_hci_len = sizeof(le_add_to_white_list_param),
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
+static void enable_le_privacy_ext_feature(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	unsigned char param[] = { 0x01 };
 	const uint8_t *ext_feat_param;
 	size_t ext_feat_len;
-	const char *irk_param;
-	size_t irk_len;
-	const uint8_t *dev_param, *dev2_param;
-	size_t dev_len, dev2_len;
 	unsigned char privacy_param[] = { 0x01,
 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
@@ -9489,15 +9654,6 @@ static void setup_ll_privacy_device2(const void *test_data)
 	ext_feat_param = set_exp_feat_param_ll_privacy;
 	ext_feat_len = sizeof(set_exp_feat_param_ll_privacy);
 
-	irk_param = load_irks_params;
-	irk_len = sizeof(load_irks_params);
-
-	dev_param = add_device_success_param_6;
-	dev_len = sizeof(add_device_success_param_6);
-
-	dev2_param = add_device_success_param_4;
-	dev2_len = sizeof(add_device_success_param_4);
-
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 					sizeof(param), &param,
 					NULL, NULL, NULL);
@@ -9506,20 +9662,231 @@ static void setup_ll_privacy_device2(const void *test_data)
 					sizeof(privacy_param), privacy_param,
 					NULL, NULL, NULL);
 
-	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
-					irk_len, irk_param,
-					setup_load_irks_callback, NULL, NULL);
-
 	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, data->mgmt_index,
 					ext_feat_len, ext_feat_param,
 					setup_exp_feat_callback, NULL, NULL);
+}
+
+static void setup_ll_privacy_with_irk1(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
 
+	enable_le_privacy_ext_feature(test_data);
+
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					sizeof(load_irks_le_public_param_1),
+					load_irks_le_public_param_1,
+					setup_load_irks_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+
+}
+
+static void setup_ll_privacy_dev1_and_irk2(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+
+	enable_le_privacy_ext_feature(test_data);
+
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
+	enable_le_privacy_ext_feature(test_data);
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
+static void setup_ll_privacy_3_devices_2(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+
+	enable_le_privacy_ext_feature(test_data);
+
+	/* Add IRKs of 3 Devices */
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					sizeof(load_irks_3_devices_param),
+					load_irks_3_devices_param,
+					setup_load_irks_callback, NULL, NULL);
+
+	/* Add Device 1 */
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
-					dev_len, dev_param,
+					sizeof(add_device_le_public_param_1),
+					add_device_le_public_param_1,
 					setup_add_device_callback, NULL, NULL);
 
+	/* Add Device 2 */
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
-					dev2_len, dev2_param,
+					sizeof(add_device_le_public_param_2),
+					add_device_le_public_param_2,
+					setup_add_device_callback, NULL, NULL);
+
+	/* Add Device 4 - This device will not be added to resolving list since
+	 * no IRK for this device is added
+	 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_4),
+					add_device_le_public_param_4,
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
+	enable_le_privacy_ext_feature(test_data);
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
+	enable_le_privacy_ext_feature(test_data);
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
+	enable_le_privacy_ext_feature(test_data);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
+					sizeof(adv_param), adv_param,
+					setup_add_adv_callback, NULL, NULL);
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
 					setup_add_device_callback, NULL, NULL);
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
@@ -10399,13 +10766,6 @@ int main(int argc, char *argv[])
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
@@ -10805,26 +11165,6 @@ int main(int argc, char *argv[])
 	test_bredrle("Add Device - Success 5",
 				&add_device_success_5,
 				NULL, test_command_generic);
-	/* MGMT_OP_ADD_DEVICE
-	 * Add device and check the device is added to the whitelist
-	 */
-	test_bredrle50("Add Device - Success 6 - Add to whitelist",
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
@@ -10853,23 +11193,9 @@ int main(int argc, char *argv[])
 	/* MGMT_OP_REMOVE_DEVICE
 	 * Remove all devices
 	 */
-	test_bredrle50("Remove Device - Success 6 - All Devices",
+	test_bredrle50("Remove Device - Success 6 (All Devices)",
 				&remove_device_success_6,
 				setup_add_device, test_remove_device);
-	/* MGMT_OP_REMOVE_DEVICE
-	 * Remove the device and check the device is removed from the whilte
-	 * list as well.
-	 */
-	test_bredrle50("Remove Device - Success 7 - Remove from whitelist",
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
@@ -11684,6 +12010,152 @@ int main(int argc, char *argv[])
 				&set_exp_feat_unknown,
 				NULL, test_command_generic);
 
+	/* LL Privacy
+	 * Setup: Enable LE and Power On
+	 * Run: Add new device
+	 * Expect: Device is added to the white list
+	 */
+	test_bredrle50("LL Privacy - Add Device 1 (Add to white list)",
+				&ll_privacy_add_device_1,
+				NULL, test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy and add IRK of new device
+	 * Run: Add new device
+	 * Expect: Device is added to the resolving list
+	 */
+	test_bredrle50("LL Privacy - Add Device 2 (Add to resolv list)",
+				&ll_privacy_add_device_2,
+				setup_ll_privacy_with_irk1,
+				test_command_generic);
+	/* LL Privacy
+	 * Setup: Enable LL Privacy and add IRK of new device
+	 * Run: Add new device
+	 * Expect: Device is added to the resolving list and resolving list
+	 *         is enabled
+	 */
+	test_bredrle50("LL Privacy - Add Device 3 (Enable resolv list)",
+				&ll_privacy_add_device_3,
+				setup_ll_privacy_with_irk1,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy, add device1 with IRK, and add IRK of
+	 *        device2
+	 * Run: Add new device2
+	 * Expect: Device2 is added to the white list
+	 */
+	test_bredrle50("LL Privacy - Add Device 4 (2 Devices to white list)",
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
+	test_bredrle50("LL Privacy - Add Device 5 (2 Devices to resolv list)",
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
+	test_bredrle50("LL Privacy - Add Device 6 (Resolv list is full)",
+				&ll_privacy_add_device_6,
+				setup_ll_privacy_3_devices,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy, add 2 devices with IRKs and 1 device
+	 *        without IRK, and add IRK for device4
+	 * Run: Add new device4
+	 * Expect: Device4 is added but failed to add to white list, and it
+	 *         is removed from the resolv list.
+	 */
+	test_bredrle50("LL Privacy - Add Device 7 (White list is full)",
+				&ll_privacy_add_device_7,
+				setup_ll_privacy_3_devices_2,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy, and add advertising
+	 * Run: Add new device
+	 * Expect: Disable the advertising before adding new device to the
+	 *         white list and resolving list
+	 */
+	test_bredrle50("LL Privacy - Add Device 8 (Disable Advertising)",
+				&ll_privacy_add_device_8,
+				setup_ll_privacy_adv, test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy and add 2 devices and its IRK
+	 * Run: Remove one of devices
+	 * Expect: The device is removed from the white list
+	 */
+	test_bredrle50("LL Privacy - Remove Device 1 (Remove from white list)",
+				&ll_privacy_remove_device_1,
+				setup_ll_privacy_3_devices,
+				test_command_generic);
+	/* LL Privacy
+	 * Setup: Enable LL Privacy and add 2 devices and its IRK
+	 * Run: Remove one of devices
+	 * Expect: The device is removed from the resolving list
+	 */
+	test_bredrle50("LL Privacy - Remove Device 2 (Remove from resolv list)",
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
+	test_bredrle50("LL Privacy - Remove Device 3 (Disable resolv list)",
+				&ll_privacy_remove_device_3,
+				setup_ll_privacy_3_devices,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy, add advertising and add device
+	 * Run: Remove the device
+	 * Expect: Disable the advertising before removing the device from the
+	 *         white list and resolving list
+	 */
+	test_bredrle50("LL Privacy - Remove Device 4 (Disable Advertising)",
+				&ll_privacy_remove_device_4,
+				setup_ll_privacy_adv_3_devices,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy
+	 * Check if the resolving list is disabled before the scan parameter is
+	 * changed.
+	 */
+	test_bredrle50("LL Privacy - Start Discovery 1 (Disable resolve list)",
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
+	test_bredrle50("LL Privacy - Start Discovery 2 (Disable resolv list)",
+				&ll_privacy_start_discovery_ll_privacy_2,
+				setup_ll_privacy_device2_discovry,
+				test_command_generic);
 
 	return tester_run();
 }
-- 
2.26.3

