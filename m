Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB4E25E476
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823689; cv=none; b=QS8BAnWzO8IKT7qWiUmkWpARDEe/w072zXwg2iD0395ILVL2GRkwwc079ZtOAGCUNPURabOufaRttB9oCcFKvJM/mM4Dc1X7WZnSbCk2r4gn8c+vsmdUFWOPPruSJ7E7ZBJ9GxIhUpbfXaKGF/x1SXa1g7NUKTD3pGdfG+jP/uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823689; c=relaxed/simple;
	bh=LPxHNojHHxFjxK9cv7msPQBk8qsECJOcM/eoTcaQgaU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kB4Ww8IqTpAiFXePTI8L3El86ZSbNA/XN8VCb7XbU3g63F3+YgSY7EFjXlPmLtFSfCeo6k6y99bI+3eDL5mLZUtizZUrFDDXUeawVeLTihnVRPIQ1ybYWfxeYxTw7n0Qxc0XCkQHXWtTYVZhoBTClU7PKK8Ht1VFbIQM22ULOFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLjsJ5kp; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLjsJ5kp"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-525b44b7720so860592e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 06:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742823686; x=1743428486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoqDStSvbF51626ZKzLQc+ha0pNUc8/bT+FkhmUHUFY=;
        b=KLjsJ5kp1NBzfCsxD+Bj3xfgXraciUJQEpfsKPNOFTGxejDNG6FXnFhcZiqRF9lJyY
         nYoL2KzSd351k1umFawCdIRnqHrs3XNJ+g1Xc04mQOs2hU38C3nj+1JsmkF3mzauVc/E
         0ge4pOR5OL4OGZzY8NrBqN1CW0i/tH9D7S2sCtL8lpF3MW6eMkiZ9C0/ITpWBKZ2oaQU
         rUe0yiz2bqNz8JOOrLd0RLSbkIYAHFabRn29P0t0wSAsxuHfD6kfnxLDbLkOedNUmBPC
         fn6LfLDYA/VmGOKVCn/fVdKSya0jYdxkvoFkBNeKMPtybih/BXj+CJI+SKlP7HTkFDmW
         6IfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742823686; x=1743428486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoqDStSvbF51626ZKzLQc+ha0pNUc8/bT+FkhmUHUFY=;
        b=aiKCVfyMyZEd1TMUfQQAhA3uSEyJvb50AfzT/BMC2ofFcxeKXoft67nNFSCoLsevud
         Nnb1Q0a8VEkx6kbEuEArO5iTP6IafWiZHFSjIiGDOmrq4lewHyKK62ZZtbqdhlGM5zcb
         1WmsrOsLO1jI6qHFqwOfqawKkgGJyiabxjOLvvJwrg+BIygh1mSjoE7lUasfW4pzT/m4
         KeIRfUOFo7rA53ilV0bkrK9c8Vr+8zQZ7KB9cyNkUQGkPerGF2gy/4xjr0ZuKOxSHgph
         L16SyImmsEQgv1XeKxhWAi93JtWmcWQjvI1iLNx8CsikX7/JHMyn+nLyHFKqxcfq3q0I
         tPeQ==
X-Gm-Message-State: AOJu0YxfQ0vSvFzsKPfigWn+GbHIuuDpcYir5VjDf6kUZkGfg1f+k7A+
	MOkmYvdE63+6Tk86qPBBEKDMkgJ3Q6yFbIr6jXaCspdryulA6VNpE0qHiPcX
X-Gm-Gg: ASbGncsiuDpDJWEmLeAW5WXfMlUuIW4TjZ4WCoZW2ZAv5J06GcbSOsT/mbGD91u2vK3
	eXXLUvKyyUVEUqsPriWzjpX09SuyI+jdPvCCiR6Jv2UPEjtPiK1YGJ4C8HWfzFRrox5tERYy4c0
	W21SJyDWLpoTmuWkm5EzGbApbb79488Up2nraU+6OygoXLVy9c7TnnhxIQKw8NQr2svFj+5hOYo
	tzvAJPE//OY2yKRAC3V0EUkBSvLpBOV4/OzzcV7wHM0T80FqkVDk0NnYNeWouS0dDOhsT+A1qrR
	rnKrXu+2NtUEBrAUFegBVXS2wXVxx2YlNLVCy6+5h8AyoxZkAWHJJZ60Gg7dLxdmv4XtFZi5HAR
	zGaQkwpTNOMrIHg==
X-Google-Smtp-Source: AGHT+IHsSsYGwtGtYmqtLzSEe7SDylEeOlZqB5puV0TVIThlRhvoBmx9t96CrO06924nEOh19m2uRg==
X-Received: by 2002:a05:6102:6cf:b0:4c1:86bc:f959 with SMTP id ada2fe7eead31-4c50d4bc997mr7075064137.8.1742823686001;
        Mon, 24 Mar 2025 06:41:26 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bc11d7asm1564850137.12.2025.03.24.06.41.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:41:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/5] mgmt-tester: Fix missing MGMT_SETTING_LL_PRIVACY
Date: Mon, 24 Mar 2025 09:41:11 -0400
Message-ID: <20250324134112.2108216-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324134112.2108216-1-luiz.dentz@gmail.com>
References: <20250324134112.2108216-1-luiz.dentz@gmail.com>
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

