Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566CF14F9FB
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824178; cv=none; b=Z+Ho55HD3Gjg/qfEWEFQl07EnEN0GZ1e/VYOI4Kihx0t4JKaD3rEn61yBv1hsZzgYbfmfuQ3TRTJHW0qpKAVR3MgESsvBSI28sfp5AD8fNNLx4RrKvqjqlhSVl4YbS3NinmGCK2jUrgzR+JGqM6YDZxTw50dHzt3waUMccl98WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824178; c=relaxed/simple;
	bh=LPxHNojHHxFjxK9cv7msPQBk8qsECJOcM/eoTcaQgaU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNTfI2m7u3vHDSln2f+CQbpz+YCg/0zrPuIEqYhNzMt8Rm9PDlBK5cHHg93tZadmfQcGpm0YODoxkBbUiCXyN4cjep5ORkyOWRqdN1rcNOOqxHP2kYFfLoDJ0ZVGVtT6qM+DlsZxRj+hiu7bmvxetXbJCQ4lJ4tRJQcySoI5vyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcBKp+Wz; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcBKp+Wz"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-525b44b7720so864524e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742824172; x=1743428972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoqDStSvbF51626ZKzLQc+ha0pNUc8/bT+FkhmUHUFY=;
        b=UcBKp+WzJefvh///AtM9/jSn9QHvkq6ZJ1F0NjdGN2gvhru4AAKKseKTe7miJl0ZH0
         6UpPwsv8gea1cVNNw1yMqWScB7rO+Ezje3SsQKyTaXqXLkcjyOAOh5xHHvZLulvrZR24
         qEq7q38Yvmhs/x0TfHUTcgWYHyXoyLofadAlr8rToh2XD4q3LmWbBn5ICYL3IiMS+LZe
         EFkPp3esAjPguOtVmIMakJXXqs94FxE0eNY9Nq3SlNZ3g380t7ycs/M2K3O3M0YJ04VS
         h8hTgYXn7XeWxDNHpZRWa0E2Ro5ncxrTwxtDLyyoMih7pFEVSxgJTwoaHVGpKzEmSX6R
         SVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742824172; x=1743428972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoqDStSvbF51626ZKzLQc+ha0pNUc8/bT+FkhmUHUFY=;
        b=GZ+eWlJakaNe6TFf5hl8rH0eyMJzKSaMK5Wdcdfz5xgG14Xt7niDNDLG01gKaTDfrE
         I5ItlyifgA90PgRJzCRK94cF0B+mhcWp276lvTPe92DO2mXnL/U8IFKXSbBBsbBi1Sl6
         JTYkR8PpfXUkTcto3yE06SZVwUq1hS/8zxb4f9BG+9jeutPLdgH74nUjUT/tIPz3nJk+
         B1qO6Vw9EdsTxtE7DNdQn3wFdeC8oQ7agB4f1tUqwcNKzK0dTezNwpDFxVa7FW64qTEZ
         KQbzV/ZX98L5bu3p7Bx/mEnl4luLbeoOvqXdpJgwV0WqDPFz+2YcRBvlZVCfkXAdFUjI
         45Yw==
X-Gm-Message-State: AOJu0YwGuNaHBrnyhi7I/6vnmK1ba0LNaVSLLP+IKcAyYhchSe3wnCnI
	Dw6+00pA38zHg/47p23VS/6kMhFuHmqmN3tJ7dQExEHPTwzAFCZi0YyIOWgj
X-Gm-Gg: ASbGncv/6wVF/D5tH2CFrLcbeC0GgYTlcnEq7rzS/4vWrg9H+l6bji52h4NJFRgdHn2
	MBpvIzEk1inDlNcBZSdsG5FKnvJfwjBNGibXFfBxtAX0fSrHkRV+rI/nJOP9ppnAAPQ97ob3mtC
	USgqrC1ZIkrMpzbUyYpjDBJP++9wuGJXFP+JO0zXDOU7jJyDmGZ/7suivraHpOFklVna+F9uLZk
	voWYvgRUgOzZfFetBJy7yQbgA/Zn8K5XI9suAb+25YiNRs5FtikvpjtnOphvajEiZ3TAQIN5AHK
	ueKYbXQ02wD5ickgLYivxDUu9VQYuepQ9EdZx+HqeKhULcjyp/hdO9YkukaP1JSX/mKmy3f/JZt
	31cOKrHVqdxQl6Q==
X-Google-Smtp-Source: AGHT+IHiBdTSYkmyrthtNe2jxMuyWdHKqD7LdWwwGKH4ncakvF7Irkt/cPjFRYU4ixvq31o8vDYaqA==
X-Received: by 2002:a05:6122:400f:b0:520:6773:e5c5 with SMTP id 71dfb90a1353d-525a851775bmr8864576e0c.7.1742824172208;
        Mon, 24 Mar 2025 06:49:32 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-525a73ed878sm1398381e0c.26.2025.03.24.06.49.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:49:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/5] mgmt-tester: Fix missing MGMT_SETTING_LL_PRIVACY
Date: Mon, 24 Mar 2025 09:49:19 -0400
Message-ID: <20250324134920.2111414-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324134920.2111414-1-luiz.dentz@gmail.com>
References: <20250324134920.2111414-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the tests which now requires MGMT_SETTING_LL_PRIVACY (bit
22).
---
 tools/mgmt-tester.c | 60 ++++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index ebb158d1f15a..030827cd51d1 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1509,6 +1509,7 @@ static const char set_ssp_invalid_param[] = { 0x02 };
 static const char set_ssp_garbage_param[] = { 0x01, 0x00 };
 static const char set_ssp_settings_param_1[] = { 0xc0, 0x00, 0x00, 0x00 };
 static const char set_ssp_settings_param_2[] = { 0xc1, 0x00, 0x00, 0x00 };
+static const char set_ssp_settings_param_3[] = { 0xc1, 0x00, 0x40, 0x00 };
 static const char set_ssp_on_write_ssp_mode_param[] = { 0x01 };
 
 static const struct generic_data set_ssp_on_success_test_1 = {
@@ -6077,8 +6078,8 @@ static const struct generic_data set_dev_id_power_off_on = {
 	.send_param = set_powered_on_param,
 	.send_len = sizeof(set_powered_on_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = set_ssp_settings_param_2,
-	.expect_len = sizeof(set_ssp_settings_param_2),
+	.expect_param = set_ssp_settings_param_3,
+	.expect_len = sizeof(set_ssp_settings_param_3),
 	.expect_settings_set = MGMT_SETTING_POWERED,
 	.expect_hci_command = BT_HCI_CMD_WRITE_EXT_INQUIRY_RESPONSE,
 	.expect_hci_param = write_eir_set_dev_id_success_1,
@@ -6094,8 +6095,8 @@ static const struct generic_data set_dev_id_ssp_off_on = {
 	.send_param = set_ssp_on_param,
 	.send_len = sizeof(set_ssp_on_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = set_ssp_settings_param_2,
-	.expect_len = sizeof(set_ssp_settings_param_2),
+	.expect_param = set_ssp_settings_param_3,
+	.expect_len = sizeof(set_ssp_settings_param_3),
 	.expect_hci_command = BT_HCI_CMD_WRITE_EXT_INQUIRY_RESPONSE,
 	.expect_hci_param = write_eir_set_dev_id_success_1,
 	.expect_hci_len = sizeof(write_eir_set_dev_id_success_1),
@@ -8214,13 +8215,17 @@ static const uint8_t set_ext_adv_data_test1[] = {
 	0x74, 0x65, 0x73, 0x74, 0x31,	/* "test1" */
 };
 
+static const char set_powered_ext_adv_instance_settings_param[] = {
+	0x81, 0x02, 0x40, 0x00,
+};
+
 static const struct generic_data add_ext_advertising_success_pwron_data = {
 	.send_opcode = MGMT_OP_SET_POWERED,
 	.send_param = set_powered_on_param,
 	.send_len = sizeof(set_powered_on_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = set_powered_adv_instance_settings_param,
-	.expect_len = sizeof(set_powered_adv_instance_settings_param),
+	.expect_param = set_powered_ext_adv_instance_settings_param,
+	.expect_len = sizeof(set_powered_ext_adv_instance_settings_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
 	.expect_hci_param = set_ext_adv_data_test1,
 	.expect_hci_len = sizeof(set_ext_adv_data_test1),
@@ -8239,7 +8244,7 @@ static const struct generic_data add_ext_advertising_success_pwron_enabled = {
 	.send_param = set_powered_on_param,
 	.send_len = sizeof(set_powered_on_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = set_powered_adv_instance_settings_param,
+	.expect_param = set_powered_ext_adv_instance_settings_param,
 	.expect_len = sizeof(set_powered_adv_instance_settings_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
 	.expect_hci_param = set_ext_adv_on_set_adv_enable_param,
@@ -8256,13 +8261,15 @@ static const uint8_t set_ext_adv_data_txpwr[] = {
 	0x00,			/* tx power */
 };
 
+static const char set_ext_adv_settings_param[] = { 0x81, 0x06, 0x40, 0x00 };
+
 static const struct generic_data add_ext_advertising_success_4 = {
 	.send_opcode = MGMT_OP_SET_ADVERTISING,
 	.send_param = set_adv_on_param,
 	.send_len = sizeof(set_adv_on_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = set_adv_settings_param_2,
-	.expect_len = sizeof(set_adv_settings_param_2),
+	.expect_param = set_ext_adv_settings_param,
+	.expect_len = sizeof(set_ext_adv_settings_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
 	.expect_hci_param = set_ext_adv_data_txpwr,
 	.expect_hci_len = sizeof(set_ext_adv_data_txpwr),
@@ -8273,8 +8280,8 @@ static const struct generic_data add_ext_advertising_success_5 = {
 	.send_param = set_adv_off_param,
 	.send_len = sizeof(set_adv_off_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = set_powered_adv_instance_settings_param,
-	.expect_len = sizeof(set_powered_adv_instance_settings_param),
+	.expect_param = set_powered_ext_adv_instance_settings_param,
+	.expect_len = sizeof(set_powered_ext_adv_instance_settings_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
 	.expect_hci_param = set_ext_adv_data_test1,
 	.expect_hci_len = sizeof(set_ext_adv_data_test1),
@@ -8545,13 +8552,16 @@ static uint8_t preset_connectable_on_ext_adv_param[] = {
 	0x00,					/* Scan req notification */
 };
 
+static const char set_connectable_settings_param_4[] = {
+						0x83, 0x02, 0x40, 0x00 };
+
 static const struct generic_data add_ext_advertising_success_16 = {
 	.send_opcode = MGMT_OP_SET_CONNECTABLE,
 	.send_param = set_connectable_on_param,
 	.send_len = sizeof(set_connectable_on_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = set_connectable_settings_param_3,
-	.expect_len = sizeof(set_connectable_settings_param_3),
+	.expect_param = set_connectable_settings_param_4,
+	.expect_len = sizeof(set_connectable_settings_param_4),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
 	.expect_hci_param = preset_connectable_on_ext_adv_param,
 	.expect_hci_len = sizeof(preset_connectable_on_ext_adv_param),
@@ -8575,25 +8585,29 @@ static uint8_t preset_connectable_off_ext_adv_param[] = {
 	0x00,					/* Scan req notification */
 };
 
+static const char set_le_settings_param_3[] = { 0x81, 0x02, 0x40, 0x00 };
+
 static const struct generic_data add_ext_advertising_success_17 = {
 	.send_opcode = MGMT_OP_SET_CONNECTABLE,
 	.send_param = set_connectable_off_param,
 	.send_len = sizeof(set_connectable_off_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = set_le_settings_param_2,
-	.expect_len = sizeof(set_le_settings_param_2),
+	.expect_param = set_le_settings_param_3,
+	.expect_len = sizeof(set_le_settings_param_3),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
 	.expect_hci_param = preset_connectable_off_ext_adv_param,
 	.expect_hci_len = sizeof(preset_connectable_off_ext_adv_param),
 };
 
+static const char set_le_settings_param_off_1[] = { 0x81, 0x00, 0x40, 0x00 };
+
 static const struct generic_data add_ext_advertising_le_off = {
 	.send_opcode = MGMT_OP_SET_LE,
 	.send_param = set_le_off_param,
 	.send_len = sizeof(set_le_off_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = set_le_settings_param_off,
-	.expect_len = sizeof(set_le_settings_param_off),
+	.expect_param = set_le_settings_param_off_1,
+	.expect_len = sizeof(set_le_settings_param_off_1),
 	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
 	.expect_alt_ev_param = advertising_instance1_param,
 	.expect_alt_ev_len = sizeof(advertising_instance1_param),
@@ -8875,8 +8889,8 @@ static const struct generic_data multi_ext_advertising_add_no_power = {
 	.send_param = set_powered_on_param,
 	.send_len = sizeof(set_powered_on_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = set_powered_adv_instance_settings_param,
-	.expect_len = sizeof(set_powered_adv_instance_settings_param),
+	.expect_param = set_powered_ext_adv_instance_settings_param,
+	.expect_len = sizeof(set_powered_ext_adv_instance_settings_param),
 	.expect_hci_list = multi_ext_adv_add_2_advs_hci_cmds,
 };
 
@@ -9403,8 +9417,8 @@ static const struct generic_data add_ext_advertising_conn_on_1m = {
 	.send_param = set_connectable_on_param,
 	.send_len = sizeof(set_connectable_on_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = set_connectable_settings_param_3,
-	.expect_len = sizeof(set_connectable_settings_param_3),
+	.expect_param = set_connectable_settings_param_4,
+	.expect_len = sizeof(set_connectable_settings_param_4),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
 	.expect_hci_param = preset_connectable_on_ext_pdu_adv_param,
 	.expect_hci_len = sizeof(preset_connectable_on_ext_pdu_adv_param),
@@ -9463,8 +9477,8 @@ static const struct generic_data add_ext_advertising_conn_off_1m = {
 	.send_param = set_connectable_off_param,
 	.send_len = sizeof(set_connectable_off_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = set_le_settings_param_2,
-	.expect_len = sizeof(set_le_settings_param_2),
+	.expect_param = set_le_settings_param_3,
+	.expect_len = sizeof(set_le_settings_param_3),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
 	.expect_hci_param = preset_connectable_off_ext_1m_adv_param,
 	.expect_hci_len = sizeof(preset_connectable_off_ext_1m_adv_param),
-- 
2.48.1

