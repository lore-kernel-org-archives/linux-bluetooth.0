Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE30D41687B
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001523; cv=none; b=ZT3yqtnQ89skMcEAxI/ODCOXeMrcWXGTMIx5lFkP6kk/ZfyrnRZvqj88aqNxU45HSVONmjBfojX3woigtL2aheGaPHcw/2dSMRYkVjlyevSMSImU/YjqKUKKg8ksvVX5XocC3lq9Irri4nLHj+yhw5dpO2Y5cihHzlmXN+SFiS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001523; c=relaxed/simple;
	bh=3TD5CiOYu0zb61pK32ouTV15jQbtShuI44fKw+GDUsc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TeaRk2gkChUeACPPioB5tLpI/iCOZo4ObyUMBHV8QXqMywSYsdOTuWHzpKMjlOQFqbZC5zOtUGe7el9jmnXi5fzEyshRa3640h3hJLtuj/tw3WRH3P9aBdMI9wURsGoGtVWWytYgKTjoTb3NjMGAVlUzMMpbFl6jDlKu/f+IrV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9YG64T4; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9YG64T4"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5e3e525cf4bso3425891e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 11:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792001520; x=1792606320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8huF8xRDkxD1qBYqG8rRuhPDNX3JIuuLdDiuw8YKVC0=;
        b=c9YG64T4yGpsr1bqKgNmVaXz4GE/qdd6Osmf5xCSfl+DXrpd5CdQ4G00wkCexb1tpP
         EJKVCe6GAYUfTsk9HKgIK/s9LDNbawUxwnz6CEvO/CKpKvSTBYyIS+ToQLLwEQwPm0x3
         0rur32xPsS3u1UTaEYs9vGo7z9CvBM1O8z242hUWgVWCHleh1aR4356Hc4YXxoJyzxWN
         htPMSs9vjZAndslWT9RBg/Wa+r0Hn4X8x5hio2W62+09qzUtpTr+Mh1n7DvgZUNCMQ4Y
         niooFKd78D+wTIL/nZNNaMJ/NHzXBoJ/fJsf7Z1ZU8+lastWph1vph1yUGPO8HnytlWh
         Ljjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792001520; x=1792606320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8huF8xRDkxD1qBYqG8rRuhPDNX3JIuuLdDiuw8YKVC0=;
        b=oLoNHDwuSP+sN4y4uunJBjXmxP+3eFiMCYftk1kjdx0oRF6NZwo9oCmAv3gb6diAWV
         KLwPJ84CC8sSVMsICK3qKgD1YByS1mTAgmCNbjOVkjSyDOfv8x8H+LgO9DCorT32mLOx
         8KnUz1SnrU24wcNXjIrL31NC+bqFY9Nvg74swzgrWC7nJ4igCG08wknnKu1HGTxBYNpg
         CI4dI3PMGiCMqg0pPWHSgXfcWDZvaAMzHC6eqWTKTcF202Pc10FLnWXbKB+ITH4A87ze
         A2ZGe3tKx0vcSTPuwg3+d9UUCipMcTf9mhCfnr3e4uVJ7G9f3XVUtCUu1UrNrpX3gZ5q
         8XHA==
X-Gm-Message-State: AFq9FYIHwHUnfB5MxwvqWVzRhjlwV8wUURKhnAFG8hfcOQ8WlIgFLwMh
	qa+dCSc9O8vClytDIG5G7zm2R4WfghksI8KBstMrObprakVI4Zzvv4hTtGoCrxdy
X-Gm-Gg: AYBFou2TfSq+cp5bS2nmMn6UrXShGzQCoJ3P3M00E1TWN+N8seYyPHzlqTpIcqovwLw
	S2F8Jf3fFWqzj4iV7olJcTqkt3F2bXhXyOd+DOJ5fb0p+mwKUGMyrUzGNeNV9wuYbZ2kkjJzen0
	fYzBVu4RA9bnOAAPEd3cQ5QmlPM9gktPEuG5/6f+J5CgsLZLY9i6UAQYxqqvOsddX8EFBId1c9c
	p34Bc5PHdLSO2Or1reb4K+xYdmm/oSk3D94fR3qcaK5ccioLTBJDyzDnYnfWOD4BEvm9jtY6foX
	q9Im4Mwl6Lvb+QZOsjnoTW1NuCpnbtYQWDouCv0Ykb5xznKorjdJ1Mbi0ub1R29mn+oy9ozedOT
	Kc3T6u7ieOYNplKm9jDC9D1PY7E/L43lbu/lsx27B5AtyUwl7A8bNchDkptXIJ/JO83A52yABWa
	obSihvhAqb1i70YDybCW2ey7g9LV6Bl4gEYjvLgamHwkjowWSDetUpZ9OH+5N3JkDEiACSu6D2y
	Gaouzxl9SM8Hqk6Bv+aZFiQrJuD775t/kkfRg5tQHEri8NtpAZZ3ZYHTSokBes96cFr/EDjhQo=
X-Received: by 2002:a05:6122:1b09:b0:5c9:c60e:3a4a with SMTP id 71dfb90a1353d-5e91f55794bmr5775730e0c.22.1792001520482;
        Wed, 14 Oct 2026 11:12:00 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e91cb3e435sm11768582e0c.10.2026.10.14.11.11.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 11:12:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] mgmt-tester: Add LL Privacy host-resolved RPA scan checks
Date: Wed, 14 Oct 2026 14:11:53 -0400
Message-ID: <20261014181153.1559666-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Controllers with LL Privacy resolve RPAs themselves, so peers with an
IRK can be kept in the accept list and passive scanning shall use the
accept list filter policy.

Assisted-by: OpenCode:claude-opus-5.5
---
 tools/mgmt-tester.c | 84 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 13484a6632ff..631c906f3aa8 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -10758,6 +10758,70 @@ static const struct generic_data host_rpa_no_irk_autoconnect = {
 	.expect_hci_param_check_func = host_rpa_filtered_check,
 };
 
+static const uint8_t ll_privacy_rpa_filtered[] = {
+	0x00,			/* Own Address Type */
+	0x01,			/* Filter Policy - Accept List */
+	0x05,			/* PHYs - 1M and Coded */
+	0x00,			/* Type - Passive */
+	0x60, 0x00,		/* Interval */
+	0x30, 0x00,		/* Window */
+	0x00,			/* Type - Passive */
+	0x60, 0x00,		/* Interval */
+	0x30, 0x00,		/* Window */
+};
+
+static int ll_privacy_rpa_filtered_check(const void *param, uint16_t length)
+{
+	const struct bt_hci_cmd_le_set_ext_scan_params *cp = param;
+	const struct bt_hci_le_scan_phy *phy = (void *) cp->data;
+
+	if (length != sizeof(ll_privacy_rpa_filtered))
+		return -EINVAL;
+
+	return cp->filter_policy != 0x01 || phy[0].type != 0x00 ||
+							phy[1].type != 0x00;
+}
+
+static const struct generic_data ll_privacy_rpa_autoconnect = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_LOAD_IRKS,
+	.setup_send_param = load_irks_le_public_param_1,
+	.setup_send_len = sizeof(load_irks_le_public_param_1),
+	.send_opcode = MGMT_OP_ADD_DEVICE,
+	.send_param = add_device_le_public_param_1,
+	.send_len = sizeof(add_device_le_public_param_1),
+	.expect_param = add_device_rsp_le_public,
+	.expect_len = sizeof(add_device_rsp_le_public),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
+	.expect_alt_ev_param = add_device_le_public_param_1,
+	.expect_alt_ev_len = sizeof(add_device_le_public_param_1),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS,
+	.expect_hci_param = ll_privacy_rpa_filtered,
+	.expect_hci_len = sizeof(ll_privacy_rpa_filtered),
+	.expect_hci_param_check_func = ll_privacy_rpa_filtered_check,
+};
+
+static const struct generic_data ll_privacy_rpa_report = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_LOAD_IRKS,
+	.setup_send_param = load_irks_le_public_param_1,
+	.setup_send_len = sizeof(load_irks_le_public_param_1),
+	.send_opcode = MGMT_OP_ADD_DEVICE,
+	.send_param = host_rpa_report_param,
+	.send_len = sizeof(host_rpa_report_param),
+	.expect_param = add_device_rsp_le_public,
+	.expect_len = sizeof(add_device_rsp_le_public),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
+	.expect_alt_ev_param = host_rpa_report_param,
+	.expect_alt_ev_len = sizeof(host_rpa_report_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS,
+	.expect_hci_param = ll_privacy_rpa_filtered,
+	.expect_hci_len = sizeof(ll_privacy_rpa_filtered),
+	.expect_hci_param_check_func = ll_privacy_rpa_filtered_check,
+};
+
 static const struct generic_data host_rpa_no_irk_report = {
 	.setup_settings = settings_powered_le,
 	.send_opcode = MGMT_OP_ADD_DEVICE,
@@ -15856,6 +15920,26 @@ int main(int argc, char *argv[])
 	test_bredrle("Scan RPA - Background report without IRK",
 			&host_rpa_no_irk_report, NULL, test_command_generic);
 
+	/* LL Privacy
+	 * Setup: Enable LE, load IRK and Power On
+	 * Run: Add new device with auto-connect
+	 * Expect: Passive scanning uses the accept list since the controller
+	 *         resolves RPAs
+	 */
+	test_bredrle50("LL Privacy - Scan RPA - Auto-connect with IRK",
+				&ll_privacy_rpa_autoconnect,
+				setup_command_generic, test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LE, load IRK and Power On
+	 * Run: Add new device with background report
+	 * Expect: Passive scanning uses the accept list since the controller
+	 *         resolves RPAs
+	 */
+	test_bredrle50("LL Privacy - Scan RPA - Background report with IRK",
+				&ll_privacy_rpa_report,
+				setup_command_generic, test_command_generic);
+
 	/* LL Privacy
 	 * Setup: Enable LE and Power On
 	 * Run: Add new device
-- 
2.56.0

