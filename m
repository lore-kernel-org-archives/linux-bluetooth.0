Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E767C48BE8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 19:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A2B61369
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 19:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFOTcP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jun 2021 15:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOTcP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jun 2021 15:32:15 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330CFC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jun 2021 12:30:10 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g22so7211477pgk.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jun 2021 12:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Bg2zh2uLZ122lvXH3tuI9bG3DVkBrCR2CQFJYysQnZ8=;
        b=dtRQuohAA0RRc8ji7PoJjzT1EL/6eG6pJrNFYBxr942QUZyiw7216fHDGgJ6fHs9zZ
         baOBmi5z8pHhT3wiimjR/nZzxDqdg8+i8K9Sk4IzqZu386lpWdlwPsyrMcXnjVoukIVS
         OLgWeSb1EKFYoSjAUJHxSVCffo2+asLGTReIlLqArJWPHUmkqaFHjNLGZDLyOaifetTj
         OK2dHU0F2l2UcrpPmSZVCMIuhDiucO8vJKYMADWO094TAmUic3D2xcmby/Z7+OIX+WY9
         CnZQSYrdddj9+Pb1IAZbGs2b/s7F1A7XWUyMdnzBiOddJ05nD7s/RQtyodjbdXa4WcVr
         FmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bg2zh2uLZ122lvXH3tuI9bG3DVkBrCR2CQFJYysQnZ8=;
        b=O5yp6F6cqhqalARk/yJenbz3XVmMTmBFe4QtARuDgMKTsHDCwWOXf7aVB5gork3rSZ
         SBjPjuS1G7lpkK6clWBZzYCEIgmAFEKkmtHN/tngZm/Rk++x12OBoCweyciTWcYPLfYC
         GMPQFZ1DuWYswJ0VH4ih3fbQqTvB0DjzHfHf/IYZWjQcCjv3E9fR/5/tyx0sX+bn0JHJ
         GcjwkJ334UD81+mGVZ6BgdgKHtsRL24HV7PUiiGpQJNEGMDNw+AK78I2w4UFU9vL6qXn
         BIY6R4KlsuC2sacDryOSyZZL0okTmCqDhofkkK2L/SseCPzOJ/CvZ03jEABi5OqJPfMp
         CU/Q==
X-Gm-Message-State: AOAM533z0XUkFQkNiVlsjCa/+FoG9h7k5WWusTAyT5UY5TMm1rizx07u
        GB6pFfQg/0ZfSnB7xgbivYuVrCHG5J4=
X-Google-Smtp-Source: ABdhPJyD4CckM1OqFyKXVYZJpbyS6gZYsGCPug5tFJ6/u1kjP7z/bawGTArOYwj8r2yeMJWAXrcKWw==
X-Received: by 2002:a62:8f81:0:b029:2e9:c6d9:df67 with SMTP id n123-20020a628f810000b02902e9c6d9df67mr5904069pfd.52.1623785409166;
        Tue, 15 Jun 2021 12:30:09 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id b129sm8613372pfg.19.2021.06.15.12.30.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 12:30:08 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH 2/2] tools/mgmt-tester: Add LL Privacy test cases
Date:   Tue, 15 Jun 2021 12:30:07 -0700
Message-Id: <20210615193007.1854488-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210615193007.1854488-1-hj.tedd.an@gmail.com>
References: <20210615193007.1854488-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds LL Privacy related test cases.

Add Device - Add to Whitelist
Add Device - Add to Resolv List
Add Device - Enable Resolv List
Add Device - 2 Devices to white list
Add Device - 2 Devices to resolv list
Add Device - Resolv list is full
Add Device - White list is full
Add Device - Disabling Advertising

Remove Device - Remove from white list
Remove Device - Remove from resolv list
Remove Device - Disable resolv list
Remove Device - Overwrite IRK
Remove Device - Disabling advertising

Start Discovery - Disable resolv list
---
 tools/mgmt-tester.c | 817 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 689 insertions(+), 128 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index fe39506f6..03137cb61 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4163,27 +4163,133 @@ static const struct generic_data add_device_success_5 = {
 	.expect_hci_len = sizeof(le_scan_enable),
 };
 
-static const uint8_t add_device_success_param_6[] = {
+static const uint8_t add_device_le_public_param_1[] = {
 					0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
 					0x01,
 					0x02,
 };
 
-static const uint8_t le_add_to_white_list_param[] = {
+static const uint8_t add_device_rsp_le_public[] =  {
+					0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
+					0x01,
+};
+static const char load_irks_le_public_param_1[] = { 0x01, 0x00,
+			0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0x01,
+			0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+			0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88 };
+
+static const uint8_t add_device_le_public_param_2[] = {
+					0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
+					0x01,
+					0x00,
+};
+
+static const uint8_t add_device_rsp_le_public_2[] =  {
+					0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
+					0x01,
+};
+
+static const char load_irks_le_public_param_2[] = { 0x01, 0x00,
+			0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x01,
+			0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+			0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88 };
+
+static const uint8_t add_device_le_public_param_3[] = {
+					0x33, 0x33, 0x33, 0x44, 0x55, 0x66,
+					0x01,
+					0x00,
+};
+
+static const uint8_t add_device_rsp_le_public_3[] =  {
+					0x33, 0x33, 0x33, 0x44, 0x55, 0x66,
+					0x01,
+};
+
+static const uint8_t add_device_le_public_param_4[] = {
+					0x44, 0x44, 0x44, 0x44, 0x55, 0x66,
+					0x01,
+					0x00,
+};
+
+static const uint8_t add_device_rsp_le_public_4[] =  {
+					0x44, 0x44, 0x44, 0x44, 0x55, 0x66,
+					0x01,
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
+ static const uint8_t le_add_to_white_list_param[] = {
 	0x00,					/* Type */
 	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
 };
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
 static const struct generic_data add_device_success_6 = {
 	.setup_settings = settings_powered_le,
 	.send_opcode = MGMT_OP_ADD_DEVICE,
-	.send_param = add_device_success_param_6,
-	.send_len = sizeof(add_device_success_param_6),
+	.send_param = add_device_le_public_param_1,
+	.send_len = sizeof(add_device_le_public_param_1),
 	.expect_param = add_device_rsp_le,
 	.expect_len = sizeof(add_device_rsp_le),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
-	.expect_alt_ev_param = add_device_success_param_6,
-	.expect_alt_ev_len = sizeof(add_device_success_param_6),
+	.expect_alt_ev_param = add_device_le_public_param_1,
+	.expect_alt_ev_len = sizeof(add_device_le_public_param_1),
 	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_WHITE_LIST,
 	.expect_hci_param = le_add_to_white_list_param,
 	.expect_hci_len = sizeof(le_add_to_white_list_param),
@@ -4198,16 +4304,25 @@ static const uint8_t le_add_to_resolv_list_param[] = {
 	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
 };
 
+static const uint8_t le_add_to_resolv_list_param_2[] = {
+	0x00,						/* Type */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,		/* Address */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,	/* Peer IRK */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,	/* Local IRK */
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+};
+
 static const struct generic_data add_device_success_7 = {
 	.send_opcode = MGMT_OP_ADD_DEVICE,
-	.send_param = add_device_success_param_6,
-	.send_len = sizeof(add_device_success_param_6),
-	.expect_param = add_device_rsp_le,
-	.expect_len = sizeof(add_device_rsp_le),
+	.send_param = add_device_le_public_param_1,
+	.send_len = sizeof(add_device_le_public_param_1),
+	.expect_param = add_device_rsp_le_public,
+	.expect_len = sizeof(add_device_rsp_le_public),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
-	.expect_alt_ev_param = add_device_success_param_6,
-	.expect_alt_ev_len = sizeof(add_device_success_param_6),
+	.expect_alt_ev_param = add_device_le_public_param_1,
+	.expect_alt_ev_len = sizeof(add_device_le_public_param_1),
 	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST,
 	.expect_hci_param = le_add_to_resolv_list_param,
 	.expect_hci_len = sizeof(le_add_to_resolv_list_param),
@@ -4215,19 +4330,107 @@ static const struct generic_data add_device_success_7 = {
 
 static const struct generic_data add_device_success_8 = {
 	.send_opcode = MGMT_OP_ADD_DEVICE,
-	.send_param = add_device_success_param_6,
-	.send_len = sizeof(add_device_success_param_6),
+	.send_param = add_device_le_public_param_1,
+	.send_len = sizeof(add_device_le_public_param_1),
 	.expect_param = add_device_rsp_le,
 	.expect_len = sizeof(add_device_rsp_le),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
-	.expect_alt_ev_param = add_device_success_param_6,
-	.expect_alt_ev_len = sizeof(add_device_success_param_6),
+	.expect_alt_ev_param = add_device_le_public_param_1,
+	.expect_alt_ev_len = sizeof(add_device_le_public_param_1),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
 	.expect_hci_param = set_resolv_on_param,
 	.expect_hci_len = sizeof(set_resolv_on_param),
 };
 
+static const struct generic_data add_device_success_9 = {
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
+
+static const struct generic_data add_device_success_10 = {
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
+static const uint8_t le_add_to_resolv_list_param_4[] = {
+	0x00,						/* Type */
+	0x44, 0x44, 0x44, 0x44, 0x55, 0x66,		/* Address */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,	/* Peer IRK */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,	/* Local IRK */
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+};
+
+static const struct generic_data add_device_success_11 = {
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
+static const struct generic_data add_device_success_12 = {
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
+
+static const char set_ext_adv_disable[] = {
+	0x00, 0x00,
+};
+
+static const struct generic_data add_device_success_13 = {
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
 static const uint8_t remove_device_nval_1[] = {
 					0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
 					0xff,
@@ -4377,6 +4580,51 @@ static const struct generic_data remove_device_success_8 = {
 	.expect_alt_ev_len = sizeof(remove_device_param_2),
 };
 
+static const struct generic_data remove_device_success_9 = {
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
+static const struct generic_data remove_device_success_10 = {
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
+static const struct generic_data remove_device_success_11 = {
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
@@ -9067,6 +9315,25 @@ static const struct generic_data start_discovery_le_1m_coded_scan_param = {
 	.expect_alt_ev_len = sizeof(start_discovery_evt),
 };
 
+static const struct generic_data start_discovery_le_disable_resolv_param = {
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
+
 static void set_phy_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -9325,12 +9592,6 @@ static const struct generic_data set_exp_feat_unknown = {
 	.expect_status = MGMT_STATUS_NOT_SUPPORTED,
 };
 
-static const char load_irks_params[] = { 0x01, 0x00,
-			0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0x01,
-			0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
-			0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88 };
-
-
 static void setup_load_irks_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -9353,14 +9614,54 @@ static void setup_exp_feat_callback(uint8_t status, uint16_t length,
 	tester_print("LL Privacy Exp feature is enabled");
 }
 
-static void setup_ll_privacy(const void *test_data)
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
 	unsigned char privacy_param[] = { 0x01,
 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
@@ -9370,9 +9671,6 @@ static void setup_ll_privacy(const void *test_data)
 	ext_feat_param = set_exp_feat_param_ll_privacy;
 	ext_feat_len = sizeof(set_exp_feat_param_ll_privacy);
 
-	irk_param = load_irks_params;
-	irk_len = sizeof(load_irks_params);
-
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 					sizeof(param), &param,
 					NULL, NULL, NULL);
@@ -9381,29 +9679,46 @@ static void setup_ll_privacy(const void *test_data)
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
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
-					sizeof(param), param,
-					setup_powered_callback, NULL, NULL);
+static void add_device_with_irk(const void *test_data,
+				const uint8_t *dev_param, size_t dev_param_len,
+				const char *irk_param, size_t irk_param_len)
+{
+	struct test_data *data = tester_get_data();
+
+	if (irk_param && irk_param_len) {
+		mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					irk_param_len, irk_param,
+					setup_load_irks_callback, NULL, NULL);
+	}
 
+	if (dev_param && dev_param_len) {
+		mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					dev_param_len, dev_param,
+					setup_add_device_callback, NULL, NULL);
+	}
 }
 
-static void setup_add_device_callback(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
+static void setup_ll_privacy_with_irk1(const void *test_data)
 {
-	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
-		return;
-	}
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+
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
 
-	tester_print("New Device is Added");
 }
 
 static void setup_ll_privacy_device(const void *test_data)
@@ -9411,51 +9726,80 @@ static void setup_ll_privacy_device(const void *test_data)
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
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
 
-	tester_print("Setup expected HCI command 0x%04x",
+	if (test->setup_expect_hci_command) {
+		tester_print("Setup expected HCI command 0x%04x",
 					 test->setup_expect_hci_command);
-	hciemu_add_master_post_command_hook(data->hciemu,
+		hciemu_add_master_post_command_hook(data->hciemu,
 					command_setup_hci_callback, data);
-	test_add_setup_condition(data);
+		test_add_setup_condition(data);
+	}
 
-	tester_print("Enabling LL Privacy feature");
+	enable_le_privacy_ext_feature(test_data);
 
-	ext_feat_param = set_exp_feat_param_ll_privacy;
-	ext_feat_len = sizeof(set_exp_feat_param_ll_privacy);
+	add_device_with_irk(test_data, add_device_le_public_param_1,
+					sizeof(add_device_le_public_param_1),
+					load_irks_le_public_param_1,
+					sizeof(load_irks_le_public_param_1));
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+}
 
-	irk_param = load_irks_params;
-	irk_len = sizeof(load_irks_params);
+static void setup_ll_privacy_dev1_and_irk2(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
 
-	dev_param = add_device_success_param_6;
-	dev_len = sizeof(add_device_success_param_6);
+	enable_le_privacy_ext_feature(test_data);
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
-					sizeof(param), &param,
-					NULL, NULL, NULL);
+	/* Add IRKs of Device1 and Device2 */
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					sizeof(load_irks_2_devices_param),
+					load_irks_2_devices_param,
+					setup_load_irks_callback, NULL, NULL);
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_PRIVACY, data->mgmt_index,
-					sizeof(privacy_param), privacy_param,
-					NULL, NULL, NULL);
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
 
+static void setup_ll_privacy_3_devices(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+
+	enable_le_privacy_ext_feature(test_data);
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
 
+	/* Add Device 2 */
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
-					dev_len, dev_param,
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
@@ -9463,63 +9807,172 @@ static void setup_ll_privacy_device(const void *test_data)
 					setup_powered_callback, NULL, NULL);
 }
 
-static const uint8_t add_device_success_param_4[] = {
-					0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
-					0x01,
-					0x02,
-};
+static void setup_ll_privacy_3_devices_2(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
 
-/* Enable LL Privacy and Add 2 devices */
-static void setup_ll_privacy_device2(const void *test_data)
+	enable_le_privacy_ext_feature(test_data);
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
+static void setup_ll_privacy_overwrite_irk(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
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
 
-	tester_print("Enabling LL Privacy feature");
+	enable_le_privacy_ext_feature(test_data);
 
-	ext_feat_param = set_exp_feat_param_ll_privacy;
-	ext_feat_len = sizeof(set_exp_feat_param_ll_privacy);
+	/* Add IRK of Device 1 */
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					sizeof(load_irks_le_public_param_1),
+					load_irks_le_public_param_1,
+					setup_load_irks_callback, NULL, NULL);
 
-	irk_param = load_irks_params;
-	irk_len = sizeof(load_irks_params);
+	/* Add Device 1 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_1),
+					add_device_le_public_param_1,
+					setup_add_device_callback, NULL, NULL);
 
-	dev_param = add_device_success_param_6;
-	dev_len = sizeof(add_device_success_param_6);
+	/* Add IRK of Device 2 */
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					sizeof(load_irks_le_public_param_2),
+					load_irks_le_public_param_2,
+					setup_load_irks_callback, NULL, NULL);
 
-	dev2_param = add_device_success_param_4;
-	dev2_len = sizeof(add_device_success_param_4);
+	/* Add Device 2 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_2),
+					add_device_le_public_param_2,
+					setup_add_device_callback, NULL, NULL);
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
-					sizeof(param), &param,
-					NULL, NULL, NULL);
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+}
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_PRIVACY, data->mgmt_index,
-					sizeof(privacy_param), privacy_param,
-					NULL, NULL, NULL);
+/* Enable LL Privacy and Add 2 devices */
+static void setup_ll_privacy_device2_discovry(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+	uint8_t disc_param[] = { 0x06 };
 
+	enable_le_privacy_ext_feature(test_data);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+	/* Load IRKs */
 	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
-					irk_len, irk_param,
+					sizeof(load_irks_2_devices_param),
+					load_irks_2_devices_param,
 					setup_load_irks_callback, NULL, NULL);
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, data->mgmt_index,
-					ext_feat_len, ext_feat_param,
-					setup_exp_feat_callback, NULL, NULL);
+	/* Load Device1 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_1),
+					add_device_le_public_param_1,
+					setup_add_device_callback, NULL, NULL);
 
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
-					dev_len, dev_param,
+					sizeof(add_device_le_public_param_2),
+					add_device_le_public_param_2,
 					setup_add_device_callback, NULL, NULL);
 
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
+static void setup_ll_privacy_adv_dev(const void *test_data)
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
+	/* Load IRKs */
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					sizeof(load_irks_le_public_param_1),
+					load_irks_le_public_param_1,
+					setup_load_irks_callback, NULL, NULL);
+
+	/* Load Device1 */
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
-					dev2_len, dev2_param,
+					sizeof(add_device_le_public_param_1),
+					add_device_le_public_param_1,
 					setup_add_device_callback, NULL, NULL);
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
@@ -10806,25 +11259,88 @@ int main(int argc, char *argv[])
 				&add_device_success_5,
 				NULL, test_command_generic);
 	/* MGMT_OP_ADD_DEVICE
-	 * Add device and check the device is added to the whitelist
+	 * Setup: Enable LE and Power On
+	 * Run: Add new device
+	 * Expect: Device is added to the white list
 	 */
-	test_bredrle50("Add Device - Success 6 - Add to whitelist",
+	test_bredrle50("Add Device - Success 6 (Add to white list)",
 				&add_device_success_6,
 				NULL, test_command_generic);
 	/* MGMT_OP_ADD_DEVICE
-	 * Add device and check the device is added to the resolve list
-	 * when the LL Privacy is enabled
+	 * Setup: Enable LL Privacy and add IRK of new device
+	 * Run: Add new device
+	 * Expect: Device is added to the resolving list
 	 */
-	test_bredrle50("Add Device - Success 7 - Add to resolv list",
+	test_bredrle50("Add Device - Success 7 (Add to resolv list)",
 				&add_device_success_7,
-				setup_ll_privacy, test_command_generic);
+				setup_ll_privacy_with_irk1,
+				test_command_generic);
 	/* MGMT_OP_ADD_DEVICE
-	 * Add device and check the Resolving List is enabled for the device
-	 * when the LL Privacy is enabled
+	 * Setup: Enable LL Privacy and add IRK of new device
+	 * Run: Add new device
+	 * Expect: Device is added to the resolving list and resolving list
+	 *         is enabled
 	 */
-	test_bredrle50("Add Device - Success 8 - Enable resolv list",
+	test_bredrle50("Add Device - Success 8 (Enable resolv list)",
 				&add_device_success_8,
-				setup_ll_privacy, test_command_generic);
+				setup_ll_privacy_with_irk1,
+				test_command_generic);
+
+	/* MGMT_OP_ADD_DEVICE
+	 * Setup: Enable LL Privacy, add device1 with IRK, and add IRK of
+	 *        device2
+	 * Run: Add new device2
+	 * Expect: Device2 is added to the white list
+	 */
+	test_bredrle50("Add Device - Success 9 (2 Devices to white list)",
+				&add_device_success_9,
+				setup_ll_privacy_dev1_and_irk2,
+				test_command_generic);
+
+	/* MGMT_OP_ADD_DEVICE
+	 * Setup: Enable LL Privacy, add device1 with IRK, and add IRK of
+	 *        device2
+	 * Run: Add new device2
+	 * Expect: Device2 is added to the resolv list
+	 */
+	test_bredrle50("Add Device - Success 10 (2 Devices to resolv list)",
+				&add_device_success_10,
+				setup_ll_privacy_dev1_and_irk2,
+				test_command_generic);
+
+	/* MGMT_OP_ADD_DEVICE
+	 * Setup: Enable LL Privacy, add 3 devices with IRKs, and add IRK of
+	 *        device4
+	 * Run: Add new device4
+	 * Expect: Device4 is added but failed to add to resolv list because
+	 *         btdev resolv list is full.
+	 */
+	test_bredrle50("Add Device - Success 11 (Resolv list is full)",
+				&add_device_success_11,
+				setup_ll_privacy_3_devices,
+				test_command_generic);
+
+	/* MGMT_OP_ADD_DEVICE
+	 * Setup: Enable LL Privacy, add 2 devices with IRKs and 1 device
+	 *        without IRK, and add IRK for device4
+	 * Run: Add new device4
+	 * Expect: Device4 is added but failed to add to white list, and it
+	 *         is removed from the resolv list.
+	 */
+	test_bredrle50("Add Device - Success 12 (White list is full)",
+				&add_device_success_12,
+				setup_ll_privacy_3_devices_2,
+				test_command_generic);
+
+	/* MGMT_OP_ADD_DEVICE
+	 * Setup: Enable LL Privacy, and add advertising
+	 * Run: Add new device
+	 * Expect: Disable the advertising before adding new device to the
+	 *         white list and resolving list
+	 */
+	test_bredrle50("Add Device - Success 13 (Disable Advertising)",
+				&add_device_success_13,
+				setup_ll_privacy_adv, test_command_generic);
 
 	test_bredrle("Remove Device - Invalid Params 1",
 				&remove_device_fail_1,
@@ -10853,23 +11369,57 @@ int main(int argc, char *argv[])
 	/* MGMT_OP_REMOVE_DEVICE
 	 * Remove all devices
 	 */
-	test_bredrle50("Remove Device - Success 6 - All Devices",
+	test_bredrle50("Remove Device - Success 6 (All Devices)",
 				&remove_device_success_6,
 				setup_add_device, test_remove_device);
 	/* MGMT_OP_REMOVE_DEVICE
-	 * Remove the device and check the device is removed from the whilte
-	 * list as well.
+	 * Setup: Enable LL Privacy and add 2 devices and its IRK
+	 * Run: Remove one of devices
+	 * Expect: The device is removed from the white list
 	 */
-	test_bredrle50("Remove Device - Success 7 - Remove from whitelist",
+	test_bredrle50("Remove Device - Success 7 (Remove from white list)",
 				&remove_device_success_7,
-				setup_ll_privacy_device2, test_command_generic);
+				setup_ll_privacy_3_devices,
+				test_command_generic);
 	/* MGMT_OP_REMOVE_DEVICE
-	 * Remove the device and check the device is removed from the resolving
-	 * list as well when the LL Privacy is enabled.
+	 * Setup: Enable LL Privacy and add 2 devices and its IRK
+	 * Run: Remove one of devices
+	 * Expect: The device is removed from the resolving list
 	 */
-	test_bredrle50("Remove Device - Success 8 - Remove from resolv list",
+	test_bredrle50("Remove Device - Success 8 (Remove from resolv list)",
 				&remove_device_success_8,
-				setup_ll_privacy_device2, test_command_generic);
+				setup_ll_privacy_3_devices,
+				test_command_generic);
+	/* MGMT_OP_REMOVE_DEVICE
+	 * Setup: Enable LL Privacy and add a device and its IRK
+	 * Run: Remove device
+	 * Expect: Device is removed and disable the resolving list before
+	 *         removing the device from the list.
+	 */
+	test_bredrle50("Remove Device - Success 9 (Disable resolv list)",
+				&remove_device_success_9,
+				setup_ll_privacy_3_devices,
+				test_command_generic);
+	/* MGMT_OP_REMOVE_DEVICE
+	 * Setup: Enable LL Privacy, and add a device and its IRK, then
+	 *        overwrite the irk with device2 and add device2
+	 * Run: Remove the first device
+	 * Expect: Device is removed and device1 is removed from the resolv
+	 *         list.
+	 */
+	test_bredrle50("Remove Device - Success 10 (Overwrite IRK)",
+				&remove_device_success_10,
+				setup_ll_privacy_overwrite_irk,
+				test_command_generic);
+	/* MGMT_OP_REMOVE_DEVICE
+	 * Setup: Enable LL Privacy, add advertising and add device
+	 * Run: Remove the device
+	 * Expect: Disable the advertising before removing the device from the
+	 *         white list and resolving list
+	 */
+	test_bredrle50("Remove Device - Success 11 (Disable Advertising)",
+				&remove_device_success_11,
+				setup_ll_privacy_adv_dev, test_command_generic);
 
 	test_bredrle("Read Advertising Features - Invalid parameters",
 				&read_adv_features_invalid_param_test,
@@ -11472,6 +12022,17 @@ int main(int argc, char *argv[])
 				&start_discovery_le_1m_coded_scan_param,
 				setup_phy_configuration, test_command_generic);
 
+	/* MGMT_OP_START_DISCOVERY
+	 * Setup: Enable LL Privacy, Add 2 devices with IRKs and remove one of
+	 *        the device
+	 * Run: Start Discovery
+	 * Expect: Resolving list is disabled.
+	 */
+	test_bredrle50("Start Discovery - (Disable Resolv List)",
+				&start_discovery_le_disable_resolv_param,
+				setup_ll_privacy_device2_discovry,
+				test_command_generic);
+
 	test_bredrle50("Ext Device Found - Advertising data - Zero padded",
 				&device_found_gtag,
 				NULL, test_device_found);
-- 
2.26.3

