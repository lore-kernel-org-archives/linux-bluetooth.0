Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820F51C878E
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 20:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732567645; cv=none; b=gRIHflgRME1ecN94p+8/ieqaYchSVtnikTpoSQAyz/He9RMQT7mhgeOAB+pfwuw4KZ1NvVwy7zs/msKF+BHJHiqEG8Vxq2JTDGOo5UqJelHZP00eeTAdkY6J+UcbfN+zh3hPrt9OOT4I80vlyIJxrh9NnewF0szQJ7CdPWnreaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732567645; c=relaxed/simple;
	bh=/h84s5CF+rY6LIvMZkMb/nPiH5Y6oeubbdMHGJ0R5OA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVgQ4hB0M8N9theN6/h+R9iYSfX4HE1ljNZ8QUBz8Lb3PQPcr0m4tqw8RyTjB7XoJ5uEah4roXvNq7+T9uCJPTSz20t6OnGhyEQR+aKAYRT4isZsOttHhx9bmIiFjTnJIpMpi9pPrCb0JUQuYA4NCvKIj/wkAy80c7WHZ91BT8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSGsOZGV; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSGsOZGV"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-84ff43e87cbso1498618241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 12:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732567641; x=1733172441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHjwFr2+nIwc/pp7uXWw6uoSIiwzcQyQ+W15cQE1vOM=;
        b=mSGsOZGVXEoPYeop77/urpPfCd/qedrAUkbyNwLWA3p+q+e7LMJ62TzyRJRkbb7SWm
         yXhG85zDacbnAL/Q5bQCaacEQkBpcUi7DCmO4FpymyFXavh298mstAw/90sdDDrW5mLt
         bkSCuI0MEVWDOow/SM5kW6stwG4WtSicPJvbGAPeH9ne/u6zNS4xNfnLH2CwtFspEty+
         v2fDBgkWs0WnPlebvZd9Fd6UEHglCrwec7ec36o2TxwfVYQRigz7OpnCC4+aTNCeYas6
         MAavRjvyzDapuHnYuyZrq+CJfMrZIY83/KFYytDNu6Nd3tZmrnlHN68YppuwqxztI+4m
         sHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732567641; x=1733172441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHjwFr2+nIwc/pp7uXWw6uoSIiwzcQyQ+W15cQE1vOM=;
        b=XmVN2bbB5B1FGwY95CwOfdZly2cEYyiOi48suq7w0IpaZN2Ps2JAO0UZ3Q9DAXGvHG
         bAUSFKJW1Uwl3myHl937UaR0QwLYUL/s6dbNvrUWkaYWjLqyD/j+Wg9MAGu6i1mcZCeE
         eDRdDiO2WPJMucugdS7805Nelz1nETd0cpqu7O4mFM37J6S9dIgFjpgyfjz/fWH4gmWc
         ILlo0Pkw2MZMs72jATXMwr07uuxXBI0V+AX8oMYu1Li4gazDuLmBEXBdOBS5MkCom1TB
         rEGSadX8JNjBMjouJgnLqrOCjMCvKBNHt1Ip4bsCoE5yIUnmw2BuVBt9QzV3VKJClaL0
         wLAA==
X-Gm-Message-State: AOJu0YyF9U8Y5Yz9it24/eMp8e/KGg3z3iGfU4GKVwmkgszMB9nOKJop
	wrPEZd/wacuCDx1/o9oefDdd8CtFJ8r5a6blcs7lDkpuZZQWPufgkzgtWw==
X-Gm-Gg: ASbGncv0Q/22wyDMjmfxWh7nmlTSVI6gzQ5REkNo1BBOzklWhgvxHZ1GFI8ol1ZwJN6
	RXIf9wpDZdcY2sczLiu0ILC8bit2HF3OG7QQ+x9wYHyBwRdoWvf8ee7bwt84W/b2U2l6kiaQPqi
	xnk1sMSEpvBAdB6jDhAOgMf6TWxXyaI/WnAyTU+ecT+0ERg8Nbzcs3O4C7aX1BGHQjvGnLYjsb/
	TTAZoiK9kmgvhxaDfHicMAomu84+ePp7Dy0xTkymoGv2Y44S03SaS3jAXr2eEol817GxZNc7+hO
	SK01L4RkzmIHekF+eg++XQ==
X-Google-Smtp-Source: AGHT+IHfblw8SUoTjo/5c5H4OgjhnRqL9axZKHJ8rQKCxFo2Z60mBMAh/Ea3h0KoOKZEO/DKtpy6wA==
X-Received: by 2002:a05:6102:54aa:b0:4af:c66:df06 with SMTP id ada2fe7eead31-4af0c66f5c4mr6690003137.18.1732567640388;
        Mon, 25 Nov 2024 12:47:20 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b4e8205fdsm73829241.1.2024.11.25.12.47.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 12:47:18 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] mgmt-tester: Fix LL Privacy tests
Date: Mon, 25 Nov 2024 15:47:10 -0500
Message-ID: <20241125204711.719853-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125204711.719853-1-luiz.dentz@gmail.com>
References: <20241125204711.719853-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Now that LL Privacy is triggered via Set Device Flags tests that used
the Set Experimental features needs to be fixed so they work as
intended.
---
 tools/mgmt-tester.c | 655 +++++++++++++++++++++++++++-----------------
 1 file changed, 406 insertions(+), 249 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 1d5c82ae0745..ebb158d1f15a 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -9826,8 +9826,8 @@ static const uint8_t get_dev_flags_param[] = {
 static const uint8_t get_dev_flags_rsp_param[] = {
 	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
 	0x00,					/* Type */
-	0x01, 0x00, 0x00, 0x00,			/* Supported Flages */
-	0x00, 0x00, 0x00, 0x00,			/* Current Flages */
+	0x07, 0x00, 0x00, 0x00,			/* Supported Flags */
+	0x00, 0x00, 0x00, 0x00,			/* Current Flags */
 };
 
 static const struct generic_data get_dev_flags_success = {
@@ -9878,7 +9878,7 @@ static void setup_get_dev_flags(const void *test_data)
 static const uint8_t set_dev_flags_param[] = {
 	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
 	0x00,					/* Type */
-	0x01, 0x00, 0x00, 0x00,			/* Current Flages */
+	0x01, 0x00, 0x00, 0x00,			/* Current Flags */
 };
 
 static const uint8_t set_dev_flags_rsp_param[] = {
@@ -9889,8 +9889,8 @@ static const uint8_t set_dev_flags_rsp_param[] = {
 static const uint8_t dev_flags_changed_param[] = {
 	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
 	0x00,					/* Type */
-	0x01, 0x00, 0x00, 0x00,			/* Supported Flages */
-	0x01, 0x00, 0x00, 0x00,			/* Current Flages */
+	0x07, 0x00, 0x00, 0x00,			/* Supported Flags */
+	0x01, 0x00, 0x00, 0x00,			/* Current Flags */
 };
 
 static const struct generic_data set_dev_flags_success = {
@@ -9920,7 +9920,7 @@ static const struct generic_data set_dev_flags_fail_1 = {
 static const uint8_t set_dev_flags_param_fail_2[] = {
 	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
 	0x00,					/* Type */
-	0x03, 0x00, 0x00, 0x00,			/* Current Flages */
+	0xff, 0x00, 0x00, 0x00,			/* Current Flags */
 };
 
 static const struct generic_data set_dev_flags_fail_2 = {
@@ -9935,7 +9935,7 @@ static const struct generic_data set_dev_flags_fail_2 = {
 static const uint8_t set_dev_flags_param_fail_3[] = {
 	0x11, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
 	0x00,					/* Type */
-	0x01, 0x00, 0x00, 0x00,			/* Current Flages */
+	0x01, 0x00, 0x00, 0x00,			/* Current Flags */
 };
 
 static const uint8_t set_dev_flags_rsp_param_fail_3[] = {
@@ -9953,15 +9953,11 @@ static const struct generic_data set_dev_flags_fail_3 = {
 };
 
 static const uint8_t read_exp_feat_param_success[] = {
-	0x05, 0x00,				/* Feature Count */
+	0x04, 0x00,				/* Feature Count */
 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb,	/* UUID - Simultaneous */
 	0x27, 0x92, 0x96, 0x46, 0xc0, 0x42,	/* Central Peripheral */
 	0xb5, 0x10, 0x1b, 0x67,
 	0x00, 0x00, 0x00, 0x00,			/* Flags */
-	0x04, 0x00, 0x13, 0xac, 0x42, 0x02,	/* UUID - LL Privacy */
-	0xde, 0xb3, 0xea, 0x11, 0x73, 0xc2,
-	0x48, 0xa1, 0xc0, 0x15,
-	0x02, 0x00, 0x00, 0x00,			/* Flags */
 	0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f,	/* UUID - Codec Offload */
 	0x1a, 0x88, 0xb9, 0x4f, 0x7f, 0xee,
 	0xce, 0x5a, 0x69, 0xa6,
@@ -10004,24 +10000,6 @@ static const struct generic_data read_exp_feat_success_index_none = {
 	.expect_len = sizeof(read_exp_feat_param_success_index_none),
 };
 
-static uint16_t settings_powered_le_privacy[] = { MGMT_OP_SET_LE,
-						MGMT_OP_SET_PRIVACY,
-						MGMT_OP_SET_POWERED, 0 };
-
-static const uint8_t set_exp_feat_param_ll_privacy[] = {
-	0x04, 0x00, 0x13, 0xac, 0x42, 0x02,	/* UUID - LL Privacy */
-	0xde, 0xb3, 0xea, 0x11, 0x73, 0xc2,
-	0x48, 0xa1, 0xc0, 0x15,
-	0x01,					/* Action - enable */
-};
-
-static const uint8_t set_exp_feat_rsp_param_ll_privacy[] = {
-	0x04, 0x00, 0x13, 0xac, 0x42, 0x02,	/* UUID - LL Privacy */
-	0xde, 0xb3, 0xea, 0x11, 0x73, 0xc2,
-	0x48, 0xa1, 0xc0, 0x15,
-	0x03, 0x00, 0x00, 0x00,			/* Action - enable */
-};
-
 static const uint8_t set_exp_feat_param_offload_codec[] = {
 	0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f,	/* UUID - Codec Offload */
 	0x1a, 0x88, 0xb9, 0x4f, 0x7f, 0xee,
@@ -10036,17 +10014,6 @@ static const uint8_t set_exp_feat_rsp_param_offload_codec[] = {
 	0x01, 0x00, 0x00, 0x00,			/* Action - enable */
 };
 
-static const struct generic_data set_exp_feat_enable_ll_privacy = {
-	.send_opcode = MGMT_OP_SET_EXP_FEATURE,
-	.send_param = set_exp_feat_param_ll_privacy,
-	.send_len = sizeof(set_exp_feat_param_ll_privacy),
-	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = set_exp_feat_rsp_param_ll_privacy,
-	.expect_len = sizeof(set_exp_feat_rsp_param_ll_privacy),
-	.expect_alt_ev = MGMT_EV_EXP_FEATURE_CHANGE,
-	.expect_alt_ev_len = sizeof(struct mgmt_ev_exp_feature_changed),
-};
-
 static void read_exp_feature_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -10095,18 +10062,10 @@ static const struct generic_data set_exp_feat_disable = {
 	.expect_len = sizeof(set_exp_feat_rsp_param_disable),
 };
 
-static const struct generic_data set_exp_feat_rejected = {
-	.setup_settings = settings_powered_le_privacy,
-	.send_opcode = MGMT_OP_SET_EXP_FEATURE,
-	.send_param = set_exp_feat_param_ll_privacy,
-	.send_len = sizeof(set_exp_feat_param_ll_privacy),
-	.expect_status = MGMT_STATUS_REJECTED,
-};
-
 static const uint8_t set_exp_feat_param_invalid[] = {
-	0x04, 0x00, 0x13, 0xac, 0x42, 0x02,	/* UUID - LL Privacy */
-	0xde, 0xb3, 0xea, 0x11, 0x73, 0xc2,
-	0x48, 0xa1, 0xc0, 0x15,
+	0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f,	/* UUID - Codec Offload */
+	0x1a, 0x88, 0xb9, 0x4f, 0x7f, 0xee,
+	0xce, 0x5a, 0x69, 0xa6,
 	0xff,					/* Action - invalid */
 };
 
@@ -10177,11 +10136,6 @@ static const uint8_t add_device_le_public_param_4[] = {
 	0x00,					/* Action - Background scan */
 };
 
-static const uint8_t add_device_rsp_le_public_4[] =  {
-	0x44, 0x44, 0x44, 0x44, 0x55, 0x66,	/* BDADDR */
-	0x01,					/* Type - LE Public */
-};
-
 static const char load_irks_2_devices_param[] = {
 	0x02, 0x00,					/* Key Count */
 	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,		/* Key 1 - BDADDR */
@@ -10292,21 +10246,40 @@ static const struct generic_data ll_privacy_add_device_1 = {
 };
 
 static uint16_t settings_le_privacy_ll_privacy[] = { MGMT_OP_SET_LE,
-					MGMT_OP_SET_PRIVACY,
-					MGMT_OP_SET_EXP_FEATURE, 0 };
+					MGMT_OP_SET_PRIVACY, 0 };
 
-static const struct generic_data ll_privacy_add_device_2 = {
+static const uint8_t set_device_flags_param_1[] = {
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+	0x06, 0x00, 0x00, 0x00			/* Flags -
+						 * Device Privacy
+						 * Address Resolution
+						 */
+};
+
+static const uint8_t set_device_flags_rsp[] =  {
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* BDADDR */
+	0x01					/* Type - LE Public */
+};
+
+static const uint8_t device_flags_changed_params_1[] = {
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+	0x07, 0x00, 0x00, 0x00,			/* Supported Flags */
+	0x06, 0x00, 0x00, 0x00			/* Current Flags */
+};
+
+static const struct generic_data ll_privacy_set_flags_1 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
-	.send_opcode = MGMT_OP_ADD_DEVICE,
-	.send_param = add_device_le_public_param_1,
-	.send_len = sizeof(add_device_le_public_param_1),
-	.expect_param = add_device_rsp_le_public,
-	.expect_len = sizeof(add_device_rsp_le_public),
+	.send_opcode = MGMT_OP_SET_DEVICE_FLAGS,
+	.send_param = set_device_flags_param_1,
+	.send_len = sizeof(set_device_flags_param_1),
+	.expect_param = set_device_flags_rsp,
+	.expect_len = sizeof(set_device_flags_rsp),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
-	.expect_alt_ev_param = add_device_le_public_param_1,
-	.expect_alt_ev_len = sizeof(add_device_le_public_param_1),
+	.expect_alt_ev = MGMT_EV_DEVICE_FLAGS_CHANGED,
+	.expect_alt_ev_param = device_flags_changed_params_1,
+	.expect_alt_ev_len = sizeof(device_flags_changed_params_1),
 	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST,
 	.expect_hci_param = le_add_to_resolv_list_param,
 	.expect_hci_len = sizeof(le_add_to_resolv_list_param),
@@ -10323,11 +10296,6 @@ static const struct hci_cmd_data ll_privacy_add_device_3_hci_list[] = {
 		.param = le_add_to_resolv_list_param,
 		.len = sizeof(le_add_to_resolv_list_param),
 	},
-	{
-		.opcode = BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
-		.param = le_add_to_accept_list_param,
-		.len = sizeof(le_add_to_accept_list_param),
-	},
 	{
 		.opcode = BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
 		.param = set_resolv_on_param,
@@ -10336,24 +10304,22 @@ static const struct hci_cmd_data ll_privacy_add_device_3_hci_list[] = {
 	{},
 };
 
-static const struct generic_data ll_privacy_add_device_3 = {
+static const struct generic_data ll_privacy_set_flags_2 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
-	.send_opcode = MGMT_OP_ADD_DEVICE,
-	.send_param = add_device_le_public_param_1,
-	.send_len = sizeof(add_device_le_public_param_1),
-	.expect_param = add_device_rsp_le,
-	.expect_len = sizeof(add_device_rsp_le),
+	.send_opcode = MGMT_OP_SET_DEVICE_FLAGS,
+	.send_param = set_device_flags_param_1,
+	.send_len = sizeof(set_device_flags_param_1),
+	.expect_param = set_device_flags_rsp,
+	.expect_len = sizeof(set_device_flags_rsp),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
-	.expect_alt_ev_param = add_device_le_public_param_1,
-	.expect_alt_ev_len = sizeof(add_device_le_public_param_1),
+	.expect_alt_ev = MGMT_EV_DEVICE_FLAGS_CHANGED,
+	.expect_alt_ev_param = device_flags_changed_params_1,
+	.expect_alt_ev_len = sizeof(device_flags_changed_params_1),
 	.expect_hci_list = ll_privacy_add_device_3_hci_list,
 };
 
-static const struct generic_data ll_privacy_add_device_4 = {
+static const struct generic_data ll_privacy_add_device_2 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.send_opcode = MGMT_OP_ADD_DEVICE,
 	.send_param = add_device_le_public_param_2,
 	.send_len = sizeof(add_device_le_public_param_2),
@@ -10368,43 +10334,82 @@ static const struct generic_data ll_privacy_add_device_4 = {
 	.expect_hci_len = sizeof(le_add_to_white_list_param_2),
 };
 
-static const struct generic_data ll_privacy_add_device_5 = {
+static const uint8_t set_device_flags_param_2[] = {
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+	0x06, 0x00, 0x00, 0x00			/* Flags -
+						 * Device Privacy
+						 * Address Resolution
+						 */
+};
+
+static const uint8_t device_flags_changed_params_2[] = {
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+	0x07, 0x00, 0x00, 0x00,			/* Supported Flags */
+	0x06, 0x00, 0x00, 0x00			/* Current Flags */
+};
+
+static const uint8_t set_device_flags_rsp_2[] =  {
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,	/* BDADDR */
+	0x01					/* Type - LE Public */
+};
+
+static const struct generic_data ll_privacy_set_flags_3 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
-	.send_opcode = MGMT_OP_ADD_DEVICE,
-	.send_param = add_device_le_public_param_2,
-	.send_len = sizeof(add_device_le_public_param_2),
-	.expect_param = add_device_rsp_le_public_2,
-	.expect_len = sizeof(add_device_rsp_le_public_2),
+	.send_opcode = MGMT_OP_SET_DEVICE_FLAGS,
+	.send_param = set_device_flags_param_2,
+	.send_len = sizeof(set_device_flags_param_2),
+	.expect_param = set_device_flags_rsp_2,
+	.expect_len = sizeof(set_device_flags_rsp_2),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
-	.expect_alt_ev_param = add_device_le_public_param_2,
-	.expect_alt_ev_len = sizeof(add_device_le_public_param_2),
+	.expect_alt_ev = MGMT_EV_DEVICE_FLAGS_CHANGED,
+	.expect_alt_ev_param = device_flags_changed_params_2,
+	.expect_alt_ev_len = sizeof(device_flags_changed_params_2),
 	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST,
 	.expect_hci_param = le_add_to_resolv_list_param_2,
 	.expect_hci_len = sizeof(le_add_to_resolv_list_param_2),
 };
 
-static const struct generic_data ll_privacy_add_device_6 = {
+static const uint8_t set_device_flags_param_4[] = {
+	0x44, 0x44, 0x44, 0x44, 0x55, 0x66,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+	0x06, 0x00, 0x00, 0x00			/* Flags -
+						 * Device Privacy
+						 * Address Resolution
+						 */
+};
+
+static const uint8_t device_flags_changed_params_4[] = {
+	0x44, 0x44, 0x44, 0x44, 0x55, 0x66,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+	0x07, 0x00, 0x00, 0x00,			/* Supported Flags */
+	0x06, 0x00, 0x00, 0x00			/* Current Flags */
+};
+
+static const uint8_t set_device_flags_rsp_4[] =  {
+	0x44, 0x44, 0x44, 0x44, 0x55, 0x66,	/* BDADDR */
+	0x01					/* Type - LE Public */
+};
+
+static const struct generic_data ll_privacy_set_flags_4 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
-	.send_opcode = MGMT_OP_ADD_DEVICE,
-	.send_param = add_device_le_public_param_4,
-	.send_len = sizeof(add_device_le_public_param_4),
-	.expect_param = add_device_rsp_le_public_4,
-	.expect_len = sizeof(add_device_rsp_le_public_4),
+	.send_opcode = MGMT_OP_SET_DEVICE_FLAGS,
+	.send_param = set_device_flags_param_4,
+	.send_len = sizeof(set_device_flags_param_4),
+	.expect_param = set_device_flags_rsp_4,
+	.expect_len = sizeof(set_device_flags_rsp_4),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
-	.expect_alt_ev_param = add_device_le_public_param_4,
-	.expect_alt_ev_len = sizeof(add_device_le_public_param_4),
+	.expect_alt_ev = MGMT_EV_DEVICE_FLAGS_CHANGED,
+	.expect_alt_ev_param = device_flags_changed_params_4,
+	.expect_alt_ev_len = sizeof(device_flags_changed_params_4),
 	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST,
 	.expect_hci_param = le_add_to_resolv_list_param_4,
 	.expect_hci_len = sizeof(le_add_to_resolv_list_param_4),
 };
 
-static const struct generic_data ll_privacy_add_device_7 = {
+static const struct generic_data ll_privacy_add_device_3 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.send_opcode = MGMT_OP_ADD_DEVICE,
 	.send_param = add_device_le_public_param_3,
 	.send_len = sizeof(add_device_le_public_param_3),
@@ -10423,9 +10428,8 @@ static const char set_ext_adv_disable[] = {
 	0x00, 0x00,
 };
 
-static const struct generic_data ll_privacy_add_device_8 = {
+static const struct generic_data ll_privacy_add_4 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.send_opcode = MGMT_OP_ADD_DEVICE,
 	.send_param = add_device_le_public_param_3,
 	.send_len = sizeof(add_device_le_public_param_3),
@@ -10440,7 +10444,7 @@ static const struct generic_data ll_privacy_add_device_8 = {
 	.expect_hci_len = sizeof(set_ext_adv_disable),
 };
 
-static const struct hci_cmd_data ll_privacy_add_device_9_hci_list[] = {
+static const struct hci_cmd_data ll_privacy_set_flags_5_hci_list[] = {
 	{
 		.opcode = BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
 		.len = sizeof(set_ext_adv_disable),
@@ -10454,24 +10458,22 @@ static const struct hci_cmd_data ll_privacy_add_device_9_hci_list[] = {
 	{},
 };
 
-static const struct generic_data ll_privacy_add_device_9 = {
+static const struct generic_data ll_privacy_set_flags_5 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
-	.send_opcode = MGMT_OP_ADD_DEVICE,
-	.send_param = add_device_le_public_param_1,
-	.send_len = sizeof(add_device_le_public_param_1),
-	.expect_param = add_device_rsp_le_public,
-	.expect_len = sizeof(add_device_rsp_le_public),
+	.send_opcode = MGMT_OP_SET_DEVICE_FLAGS,
+	.send_param = set_device_flags_param_1,
+	.send_len = sizeof(set_device_flags_param_1),
+	.expect_param = set_device_flags_rsp,
+	.expect_len = sizeof(set_device_flags_rsp),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
-	.expect_alt_ev_param = add_device_le_public_param_1,
-	.expect_alt_ev_len = sizeof(add_device_le_public_param_1),
-	.expect_hci_list = ll_privacy_add_device_9_hci_list,
+	.expect_alt_ev = MGMT_EV_DEVICE_FLAGS_CHANGED,
+	.expect_alt_ev_param = device_flags_changed_params_1,
+	.expect_alt_ev_len = sizeof(device_flags_changed_params_1),
+	.expect_hci_list = ll_privacy_set_flags_5_hci_list,
 };
 
 static const struct generic_data ll_privacy_remove_device_1 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.send_opcode = MGMT_OP_REMOVE_DEVICE,
 	.send_param = remove_device_param_2,
 	.send_len = sizeof(remove_device_param_2),
@@ -10488,7 +10490,6 @@ static const struct generic_data ll_privacy_remove_device_1 = {
 
 static const struct generic_data ll_privacy_remove_device_2 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.send_opcode = MGMT_OP_REMOVE_DEVICE,
 	.send_param = remove_device_param_2,
 	.send_len = sizeof(remove_device_param_2),
@@ -10505,7 +10506,6 @@ static const struct generic_data ll_privacy_remove_device_2 = {
 
 static const struct generic_data ll_privacy_remove_device_3 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.send_opcode = MGMT_OP_REMOVE_DEVICE,
 	.send_param = remove_device_param_2,
 	.send_len = sizeof(remove_device_param_2),
@@ -10522,7 +10522,6 @@ static const struct generic_data ll_privacy_remove_device_3 = {
 
 static const struct generic_data ll_privacy_remove_device_4 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.send_opcode = MGMT_OP_REMOVE_DEVICE,
 	.send_param = remove_device_param_2,
 	.send_len = sizeof(remove_device_param_2),
@@ -10539,7 +10538,6 @@ static const struct generic_data ll_privacy_remove_device_4 = {
 
 static const struct generic_data ll_privacy_remove_device_5 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.send_opcode = MGMT_OP_REMOVE_DEVICE,
 	.send_param = remove_device_param_2,
 	.send_len = sizeof(remove_device_param_2),
@@ -10556,7 +10554,6 @@ static const struct generic_data ll_privacy_remove_device_5 = {
 
 static const struct generic_data ll_privacy_start_discovery_ll_privacy_1 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
 	.setup_expect_hci_param = set_resolv_on_param,
 	.setup_expect_hci_len = sizeof(set_resolv_on_param),
@@ -10573,7 +10570,6 @@ static const struct generic_data ll_privacy_start_discovery_ll_privacy_1 = {
 
 static const struct generic_data ll_privacy_start_discovery_ll_privacy_2 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.setup_expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST,
 	.setup_expect_hci_param = le_add_to_accept_list_param,
 	.setup_expect_hci_len = sizeof(le_add_to_accept_list_param),
@@ -10593,7 +10589,6 @@ static const struct generic_data ll_privacy_start_discovery_ll_privacy_2 = {
 
 static const struct generic_data ll_privacy_advertising_1 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.send_opcode = MGMT_OP_SET_ADVERTISING,
 	.send_param = set_adv_on_param2,
 	.send_len = sizeof(set_adv_on_param2),
@@ -10603,7 +10598,6 @@ static const struct generic_data ll_privacy_advertising_1 = {
 
 static const struct generic_data ll_privacy_acceptor_1 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.io_cap = 0x04, /* KeyboardDisplay */
 	.client_io_cap = 0x04, /* KeyboardDisplay */
 	.client_auth_req = 0x05, /* Bonding - MITM */
@@ -10614,7 +10608,6 @@ static const struct generic_data ll_privacy_acceptor_1 = {
 
 static const struct generic_data ll_privacy_acceptor_2 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.io_cap = 0x04, /* KeyboardDisplay */
 	.client_io_cap = 0x04, /* KeyboardDisplay */
 	.just_works = true,
@@ -10661,7 +10654,6 @@ static uint16_t settings_powered_le_sc_bondable_privacy_ll_privacy[] = {
 
 static const struct generic_data ll_privacy_pair_1 = {
 	.setup_settings = settings_powered_le_sc_bondable_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.send_opcode = MGMT_OP_PAIR_DEVICE,
 	.send_func = pair_device_send_param_func,
 	.addr_type_avail = true,
@@ -10682,7 +10674,6 @@ static const struct generic_data ll_privacy_pair_1 = {
 
 static const struct generic_data ll_privacy_pair_2 = {
 	.setup_settings = settings_powered_le_sc_bondable_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.send_opcode = MGMT_OP_PAIR_DEVICE,
 	.send_func = pair_device_send_param_func,
 	.addr_type_avail = true,
@@ -10706,7 +10697,6 @@ static const struct generic_data ll_privacy_pair_2 = {
 
 static const struct generic_data ll_privacy_unpair_1 = {
 	.setup_settings = settings_powered_le_sc_bondable_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.send_opcode = MGMT_OP_PAIR_DEVICE,
 	.send_func = pair_device_send_param_func,
 	.addr_type_avail = true,
@@ -10726,7 +10716,6 @@ static const struct generic_data ll_privacy_unpair_1 = {
 
 static const struct generic_data ll_privacy_unpair_2 = {
 	.setup_settings = settings_powered_le_sc_bondable_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.send_opcode = MGMT_OP_PAIR_DEVICE,
 	.send_func = pair_device_send_param_func,
 	.addr_type_avail = true,
@@ -10747,17 +10736,6 @@ static const struct generic_data ll_privacy_unpair_2 = {
 	.expect_hci_len = sizeof(add_to_al_client),
 };
 
-static const uint8_t set_device_flags_param_1[] = {
-	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* BDADDR */
-	0x01,					/* Type - LE Public */
-	0x02, 0x00, 0x00, 0x00			/* Flags - Device Privacy */
-};
-
-static const uint8_t set_device_flags_rsp[] =  {
-	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* BDADDR */
-	0x01					/* Type - LE Public */
-};
-
 static const uint8_t le_set_priv_mode_param[] = {
 	0x00,					/* Type */
 	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* BDADDR */
@@ -10783,16 +10761,8 @@ static const struct hci_cmd_data ll_privacy_set_device_flags_1_hci_list[] = {
 	{},
 };
 
-static const uint8_t device_flags_changed_params_1[] = {
-	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* BDADDR */
-	0x01,					/* Type - LE Public */
-	0x03, 0x00, 0x00, 0x00,			/* Supported Flags */
-	0x02, 0x00, 0x00, 0x00			/* Current Flags */
-};
-
 static const struct generic_data ll_privacy_set_device_flag_1 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
-	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.send_opcode = MGMT_OP_SET_DEVICE_FLAGS,
 	.send_param = set_device_flags_param_1,
 	.send_len = sizeof(set_device_flags_param_1),
@@ -10885,7 +10855,7 @@ static void setup_add_adv_callback_adv(uint8_t status, uint16_t length,
 					NULL, NULL);
 }
 
-static void setup_ll_privacy_with_irk1(const void *test_data)
+static void setup_ll_privacy_set_flags_1(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	unsigned char param[] = { 0x01 };
@@ -10895,13 +10865,30 @@ static void setup_ll_privacy_with_irk1(const void *test_data)
 					load_irks_le_public_param_1,
 					setup_load_irks_callback, NULL, NULL);
 
+	/* Set Powered On */
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
 					setup_powered_callback, NULL, NULL);
 
+	/* Add Device 1 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_1),
+					add_device_le_public_param_1,
+					setup_add_device_callback, NULL, NULL);
 }
 
-static void setup_ll_privacy_dev1_and_irk2(const void *test_data)
+static void setup_set_device_flags_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("Device Flags are set");
+}
+
+static void setup_ll_privacy_add_2(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	unsigned char param[] = { 0x01 };
@@ -10912,17 +10899,69 @@ static void setup_ll_privacy_dev1_and_irk2(const void *test_data)
 					load_irks_2_devices_param,
 					setup_load_irks_callback, NULL, NULL);
 
+	/* Set Powered On */
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+
+	/* Add Device 1 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_1),
+					add_device_le_public_param_1,
+					setup_add_device_callback, NULL, NULL);
+	/* Device 1 Flags */
+	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
+					sizeof(set_device_flags_param_1),
+					set_device_flags_param_1,
+					setup_set_device_flags_callback, NULL,
+					NULL);
+}
+
+static void setup_ll_privacy_set_flags_3(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+
+	/* Add IRKs of Device1 and Device2 */
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					sizeof(load_irks_2_devices_param),
+					load_irks_2_devices_param,
+					setup_load_irks_callback, NULL, NULL);
+
+	/* Set Powered On */
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+
 	/* Add Device 1 */
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_1),
 					add_device_le_public_param_1,
 					setup_add_device_callback, NULL, NULL);
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
-					sizeof(param), param,
-					setup_powered_callback, NULL, NULL);
+	/* Device 1 Flags */
+	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
+					sizeof(set_device_flags_param_1),
+					set_device_flags_param_1,
+					setup_set_device_flags_callback, NULL,
+					NULL);
+
+	/* Add Device 2 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_2),
+					add_device_le_public_param_2,
+					setup_add_device_callback, NULL, NULL);
 }
 
+static const uint8_t set_device_flags_param_3[] = {
+	0x33, 0x33, 0x33, 0x44, 0x55, 0x66,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+	0x06, 0x00, 0x00, 0x00			/* Flags -
+						 * Device Privacy
+						 * Address Resolution
+						 */
+};
+
 static void setup_ll_privacy_3_devices(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -10940,29 +10979,50 @@ static void setup_ll_privacy_3_devices(const void *test_data)
 					add_device_le_public_param_1,
 					setup_add_device_callback, NULL, NULL);
 
+	/* Device 1 Flags */
+	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
+					sizeof(set_device_flags_param_1),
+					set_device_flags_param_1,
+					setup_set_device_flags_callback, NULL,
+					NULL);
+
 	/* Add Device 2 */
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_2),
 					add_device_le_public_param_2,
 					setup_add_device_callback, NULL, NULL);
 
+	/* Device 2 Flags */
+	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
+					sizeof(set_device_flags_param_2),
+					set_device_flags_param_2,
+					setup_set_device_flags_callback, NULL,
+					NULL);
+
 	/* Add Device 3 */
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_3),
 					add_device_le_public_param_3,
 					setup_add_device_callback, NULL, NULL);
 
+	/* Device 3 Flags */
+	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
+					sizeof(set_device_flags_param_3),
+					set_device_flags_param_3,
+					setup_set_device_flags_callback, NULL,
+					NULL);
+
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
 					setup_powered_callback, NULL, NULL);
 }
 
-static void setup_ll_privacy_2_devices_extra_rl(const void *test_data)
+static void setup_ll_privacy_set_flags_4(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	unsigned char param[] = { 0x01 };
 
-	hciemu_set_central_le_rl_len(data->hciemu, 2);
+	hciemu_set_central_le_rl_len(data->hciemu, 4);
 
 	/* Add IRKs of 4 Devices */
 	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
@@ -10976,18 +11036,51 @@ static void setup_ll_privacy_2_devices_extra_rl(const void *test_data)
 					add_device_le_public_param_1,
 					setup_add_device_callback, NULL, NULL);
 
+	/* Device 1 Flags */
+	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
+					sizeof(set_device_flags_param_1),
+					set_device_flags_param_1,
+					setup_set_device_flags_callback, NULL,
+					NULL);
+
 	/* Add Device 2 */
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_2),
 					add_device_le_public_param_2,
 					setup_add_device_callback, NULL, NULL);
 
+	/* Device 2 Flags */
+	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
+					sizeof(set_device_flags_param_2),
+					set_device_flags_param_2,
+					setup_set_device_flags_callback, NULL,
+					NULL);
+
+	/* Add Device 3 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_3),
+					add_device_le_public_param_3,
+					setup_add_device_callback, NULL, NULL);
+
+	/* Device 3 Flags */
+	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
+					sizeof(set_device_flags_param_3),
+					set_device_flags_param_3,
+					setup_set_device_flags_callback, NULL,
+					NULL);
+
+	/* Add Device 4 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_4),
+					add_device_le_public_param_4,
+					setup_add_device_callback, NULL, NULL);
+
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
 					setup_powered_callback, NULL, NULL);
 }
 
-static void setup_ll_privacy_2_devices_extra_al(const void *test_data)
+static void setup_ll_privacy_add_3(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	unsigned char param[] = { 0x01 };
@@ -11000,21 +11093,36 @@ static void setup_ll_privacy_2_devices_extra_al(const void *test_data)
 					load_irks_3_devices_param,
 					setup_load_irks_callback, NULL, NULL);
 
+	/* Set Powered On */
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+
 	/* Add Device 1 */
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_1),
 					add_device_le_public_param_1,
 					setup_add_device_callback, NULL, NULL);
 
+	/* Device 1 Flags */
+	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
+					sizeof(set_device_flags_param_1),
+					set_device_flags_param_1,
+					setup_set_device_flags_callback, NULL,
+					NULL);
+
 	/* Add Device 2 */
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_2),
 					add_device_le_public_param_2,
 					setup_add_device_callback, NULL, NULL);
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
-					sizeof(param), param,
-					setup_powered_callback, NULL, NULL);
+	/* Device 2 Flags */
+	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
+					sizeof(set_device_flags_param_2),
+					set_device_flags_param_2,
+					setup_set_device_flags_callback, NULL,
+					NULL);
 }
 
 /* Enable LL Privacy and Add 2 devices */
@@ -11060,7 +11168,7 @@ static void setup_ll_privacy_device2_discovry(const void *test_data)
 }
 
 /* Enable LL Privacy and Add Advertising */
-static void setup_ll_privacy_adv(const void *test_data)
+static void setup_ll_privacy_add_4(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	struct mgmt_cp_add_advertising *cp;
@@ -11080,7 +11188,7 @@ static void setup_ll_privacy_adv(const void *test_data)
 }
 
 /* Enable LL Privacy and Add Advertising */
-static void setup_ll_privacy_2_advs(const void *test_data)
+static void setup_ll_privacy_set_flags_5(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	struct mgmt_cp_add_advertising *cp;
@@ -11090,21 +11198,30 @@ static void setup_ll_privacy_2_advs(const void *test_data)
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	setup_add_adv_param(cp, 1);
 
+	/* Add IRKs of Device1 */
 	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
 					sizeof(load_irks_le_public_param_1),
 					load_irks_le_public_param_1,
 					setup_load_irks_callback, NULL, NULL);
 
+	/* Set Powered On */
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
 					NULL, NULL, NULL);
 
+	/* Add Advertising Instance */
 	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
 					sizeof(adv_param), adv_param,
 					setup_add_adv_callback_adv, NULL, NULL);
+
+	/* Add Device 1 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_1),
+					add_device_le_public_param_1,
+					setup_add_device_callback, NULL, NULL);
 }
 
-static void setup_ll_privacy_dev_2_advs(const void *test_data)
+static void setup_ll_privacy_set_flags_6(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	struct mgmt_cp_add_advertising *cp;
@@ -11114,24 +11231,40 @@ static void setup_ll_privacy_dev_2_advs(const void *test_data)
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	setup_add_adv_param(cp, 1);
 
+	/* Add IRKs of Device1 and Device2 */
 	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
-					sizeof(load_irks_le_public_param_1),
-					load_irks_le_public_param_1,
+					sizeof(load_irks_2_devices_param),
+					load_irks_2_devices_param,
 					setup_load_irks_callback, NULL, NULL);
 
+	/* Set Powered On */
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
 					NULL, NULL, NULL);
 
+	/* Add Advertising Instance 1 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
+					sizeof(adv_param), adv_param,
+					setup_add_adv_callback_adv, NULL, NULL);
+
 	/* Add Device 2 */
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_2),
 					add_device_le_public_param_2,
 					setup_add_device_callback, NULL, NULL);
 
-	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
-					sizeof(adv_param), adv_param,
-					setup_add_adv_callback_adv, NULL, NULL);
+	/* Device 2 Flags */
+	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
+					sizeof(set_device_flags_param_2),
+					set_device_flags_param_2,
+					setup_set_device_flags_callback, NULL,
+					NULL);
+
+	/* Add Device 1 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_1),
+					add_device_le_public_param_1,
+					setup_add_device_callback, NULL, NULL);
 }
 
 static void setup_ll_privacy_adv_3_devices(const void *test_data)
@@ -11160,18 +11293,39 @@ static void setup_ll_privacy_adv_3_devices(const void *test_data)
 					add_device_le_public_param_1,
 					setup_add_device_callback, NULL, NULL);
 
+	/* Device 1 Flags */
+	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
+					sizeof(set_device_flags_param_1),
+					set_device_flags_param_1,
+					setup_set_device_flags_callback, NULL,
+					NULL);
+
 	/* Add Device 2 */
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_2),
 					add_device_le_public_param_2,
 					setup_add_device_callback, NULL, NULL);
 
+	/* Device 2 Flags */
+	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
+					sizeof(set_device_flags_param_2),
+					set_device_flags_param_2,
+					setup_set_device_flags_callback, NULL,
+					NULL);
+
 	/* Add Device 3 */
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_3),
 					add_device_le_public_param_3,
 					setup_add_device_callback, NULL, NULL);
 
+	/* Device 3 Flags */
+	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
+					sizeof(set_device_flags_param_3),
+					set_device_flags_param_3,
+					setup_set_device_flags_callback, NULL,
+					NULL);
+
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
 					setup_powered_callback, NULL, NULL);
@@ -11203,12 +11357,26 @@ static void setup_ll_privacy_adv_1_device_2_advs(const void *test_data)
 					add_device_le_public_param_1,
 					setup_add_device_callback, NULL, NULL);
 
+	/* Device 1 Flags */
+	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
+					sizeof(set_device_flags_param_1),
+					set_device_flags_param_1,
+					setup_set_device_flags_callback, NULL,
+					NULL);
+
 	/* Add Device 2 */
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_2),
 					add_device_le_public_param_2,
 					setup_add_device_callback, NULL, NULL);
 
+	/* Device 2 Flags */
+	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
+					sizeof(set_device_flags_param_2),
+					set_device_flags_param_2,
+					setup_set_device_flags_callback, NULL,
+					NULL);
+
 	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
 					sizeof(adv_param), adv_param,
 					setup_add_adv_callback_adv, NULL, NULL);
@@ -14542,14 +14710,6 @@ int main(int argc, char *argv[])
 				&read_exp_feat_success_index_none,
 				NULL, test_command_generic);
 
-	/* MGMT_OP_SET_EXP_FEATURE
-	 * Enable LL Privacy
-	 */
-	test_bredrle50("Set Exp Feature - Enable LL Privacy",
-				&set_exp_feat_enable_ll_privacy,
-				setup_set_exp_feature_alt,
-				test_command_generic);
-
 	/* MGMT_OP_SET_EXP_FEATURE
 	 * Offload Codec
 	 */
@@ -14565,12 +14725,6 @@ int main(int argc, char *argv[])
 				&set_exp_feat_disable,
 				NULL, test_command_generic);
 
-	/* MGMT_OP_SET_EXP_FEATURE
-	 * Rejected - If the power is on, the command should be rejected
-	 */
-	test_bredrle50("Set Exp Feature - Rejected",
-				&set_exp_feat_rejected,
-				NULL, test_command_generic);
 
 	/* MGMT_OP_SET_EXP_FEATURE
 	 * Invalid parameter
@@ -14596,58 +14750,15 @@ int main(int argc, char *argv[])
 				&ll_privacy_add_device_1,
 				NULL, test_command_generic);
 
-	/* LL Privacy
-	 * Setup: Enable LL Privacy and add IRK of new device
-	 * Run: Add new device
-	 * Expect: Device is added to the resolving list
-	 */
-	test_bredrle50("LL Privacy - Add Device 2 (Add to RL)",
-				&ll_privacy_add_device_2,
-				setup_ll_privacy_with_irk1,
-				test_command_generic);
-	/* LL Privacy
-	 * Setup: Enable LL Privacy and add IRK of new device
-	 * Run: Add new device
-	 * Expect: Device is added to the resolving list and resolving list
-	 *         is enabled
-	 */
-	test_bredrle50("LL Privacy - Add Device 3 (Enable RL)",
-				&ll_privacy_add_device_3,
-				setup_ll_privacy_with_irk1,
-				test_command_generic);
-
 	/* LL Privacy
 	 * Setup: Enable LL Privacy, add device1 with IRK, and add IRK of
 	 *        device2
 	 * Run: Add new device2
 	 * Expect: Device2 is added to the accept list
 	 */
-	test_bredrle50("LL Privacy - Add Device 4 (2 Devices to AL)",
-				&ll_privacy_add_device_4,
-				setup_ll_privacy_dev1_and_irk2,
-				test_command_generic);
-
-	/* LL Privacy
-	 * Setup: Enable LL Privacy, add device1 with IRK, and add IRK of
-	 *        device2
-	 * Run: Add new device2
-	 * Expect: Device2 is added to the resolv list
-	 */
-	test_bredrle50("LL Privacy - Add Device 5 (2 Devices to RL)",
-				&ll_privacy_add_device_5,
-				setup_ll_privacy_dev1_and_irk2,
-				test_command_generic);
-
-	/* LL Privacy
-	 * Setup: Enable LL Privacy, add 3 devices with IRKs, and add IRK of
-	 *        device4
-	 * Run: Add new device4
-	 * Expect: Device4 is added but failed to add to resolv list because
-	 *         btdev resolv list is full.
-	 */
-	test_bredrle50("LL Privacy - Add Device 6 (RL is full)",
-				&ll_privacy_add_device_6,
-				setup_ll_privacy_2_devices_extra_rl,
+	test_bredrle50("LL Privacy - Add Device 2 (2 Devices to AL)",
+				&ll_privacy_add_device_2,
+				setup_ll_privacy_add_2,
 				test_command_generic);
 
 	/* LL Privacy
@@ -14657,9 +14768,9 @@ int main(int argc, char *argv[])
 	 * Expect: Device4 is added but failed to add to accept list, and it
 	 *         is removed from the resolv list.
 	 */
-	test_bredrle50("LL Privacy - Add Device 7 (AL is full)",
-				&ll_privacy_add_device_7,
-				setup_ll_privacy_2_devices_extra_al,
+	test_bredrle50("LL Privacy - Add Device 3 (AL is full)",
+				&ll_privacy_add_device_3,
+				setup_ll_privacy_add_3,
 				test_command_generic);
 
 	/* LL Privacy
@@ -14668,31 +14779,77 @@ int main(int argc, char *argv[])
 	 * Expect: Disable the advertising before adding new device to the
 	 *         accept list and resolving list
 	 */
-	test_bredrle50("LL Privacy - Add Device 8 (Disable Adv)",
-				&ll_privacy_add_device_8,
-				setup_ll_privacy_adv, test_command_generic);
+	test_bredrle50("LL Privacy - Add Device 4 (Disable Adv)",
+				&ll_privacy_add_4,
+				setup_ll_privacy_add_4,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy and add IRK of new device
+	 * Run: Set Device Flags: DEVICE_FLAG_ADDRESS_RESOLUTION
+	 * Expect: Device is added to the resolving list
+	 */
+	test_bredrle50("LL Privacy - Set Flags 1 (Add to RL)",
+				&ll_privacy_set_flags_1,
+				setup_ll_privacy_set_flags_1,
+				test_command_generic);
+	/* LL Privacy
+	 * Setup: Enable LL Privacy and add IRK of new device
+	 * Run: Set Device Flags: DEVICE_FLAG_ADDRESS_RESOLUTION
+	 * Expect: Device is added to the resolving list and resolving list
+	 *         is enabled
+	 */
+	test_bredrle50("LL Privacy - Set Flags 2 (Enable RL)",
+				&ll_privacy_set_flags_2,
+				setup_ll_privacy_set_flags_1,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy, add device1 with IRK, and add IRK of
+	 *        device2
+	 * Run: Set Device Flags: DEVICE_FLAG_ADDRESS_RESOLUTION
+	 * Expect: Device2 is added to the resolv list
+	 */
+	test_bredrle50("LL Privacy - Set Flags 3 (2 Devices to RL)",
+				&ll_privacy_set_flags_3,
+				setup_ll_privacy_set_flags_3,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy, add 3 devices with IRKs, and add IRK of
+	 *        device4
+	 * Run: Set Device Flags: DEVICE_FLAG_ADDRESS_RESOLUTION
+	 * Expect: Device4 is added but failed to add to resolv list because
+	 *         btdev resolv list is full.
+	 */
+	test_bredrle50("LL Privacy - Set Flags 4 (RL is full)",
+				&ll_privacy_set_flags_4,
+				setup_ll_privacy_set_flags_4,
+				test_command_generic);
 
 	/* LL Privacy
 	 * Setup: Enable LL Privacy, and add 2 advertisings
-	 * Run: Add new device
+	 * Run: Set Device Flags: DEVICE_FLAG_ADDRESS_RESOLUTION
 	 * Expect: Disable the advertising before adding new device to the
 	 *         accept list and resolving list
 	 */
-	test_bredrle50("LL Privacy - Add Device 9 (Multi Adv)",
-				&ll_privacy_add_device_9,
-				setup_ll_privacy_2_advs, test_command_generic);
+	test_bredrle50("LL Privacy - Set Flags 5 (Multi Adv)",
+				&ll_privacy_set_flags_5,
+				setup_ll_privacy_set_flags_5,
+				test_command_generic);
 
 	/* LL Privacy
 	 * Setup: Enable LL Privacy, and add 1 device and add 2 advertisings
-	 * Run: Add new device
+	 * Run: Set Device Flags: DEVICE_FLAG_ADDRESS_RESOLUTION
 	 * Expect: Disable the advertising before adding new device to the
 	 *         accept list and resolving list
 	 */
-	test_bredrle50("LL Privacy - Add Device 10 (Multi Dev and Multi Adv)",
-				&ll_privacy_add_device_9,
-				setup_ll_privacy_dev_2_advs,
+	test_bredrle50("LL Privacy - Set Flags 6 (Multi Dev and Multi Adv)",
+				&ll_privacy_set_flags_5,
+				setup_ll_privacy_set_flags_6,
 				test_command_generic);
 
+
 	/* LL Privacy
 	 * Setup: Enable LL Privacy and add 2 devices and its IRK
 	 * Run: Remove one of devices
@@ -14752,7 +14909,7 @@ int main(int argc, char *argv[])
 	 */
 	test_bredrle50("LL Privacy - Start Discovery 1 (Disable RL)",
 				&ll_privacy_start_discovery_ll_privacy_1,
-				setup_ll_privacy_dev1_and_irk2,
+				setup_ll_privacy_set_flags_3,
 				test_command_generic);
 
 	/* LL Privacy
-- 
2.47.0

