Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792802858;
	b=kzE2SzvZziGtzaZizL1PrlBO0gK4GDL710CFRrWz8PytkXFqMB41oVvnzxuPG/LghIgT
	 N65lC3DdULCM4h5UpWxhiAuq2rGcOaKtmjR64Tqo7O0wppynAORMbZaFy12VFOL+41qzq
	 Z/T/CuUV23cuHdK2DeBg2iwOUhT+Dd2kr8cdCLkTF6GQpXXPeR3UV1Qwh3iZBRU7/17b0
	 1uD/tOchJ/CMwFNZmwN5emSkusDXmwYzv6EkrhIK8NiZG6yQ6BKgUKpU3gRzWWRCDB01Q
	 r/sZ7jI5WM98zGRN9ZUJIVVeZJcLfkqrYX7U5UqaMxFg1EWUsV1P1ysDX1tsLQFbG9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792802858;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+v3pAR9SwEFWfYcKCCpCBOaA+n2FmfKQ3xgXRIMjox8=;
	b=NEE3xAOA11YTpECutTtbF9g5tNgNIZnulRbEBF6UoXH5JspBcdVd7y2gUWi8FlbTFc+n
	 vX+RWtJVRy4ZonQMKBSQ26eCbLzNesmOCWvsBvp7lY2lSWRcvchIxErZz1eaO5bGkz6N6
	 zG9eX214M5fCrGIThMZE3G/Cce3mTqVy/XmZwh+0FI3L06Dh+ahd4DrLJPndRBRlxYXim
	 0jlQIjLQUhjMCa7Q9LPu1qO/I5KXf0cNKXajBtJx9DE3PaWaxMSXPllSXfvtH1riKkxBd
	 K2s47X5Rq58FA7F30eCyYhbDDFaJRu19Jf64yUNxL5qkhxVbmL0Y+GLp3LQyBSnvy0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OT+ZaG0z;
	arc=none smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2F4606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 00:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C2F4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OT+ZaG0z
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67489c8202cso1498137d50.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 17:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792802857; x=1793407657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+v3pAR9SwEFWfYcKCCpCBOaA+n2FmfKQ3xgXRIMjox8=;
        b=OT+ZaG0zaBA/JHcDN8afuiNkvcxXUPpsYsC47sfX0OOK3JG8JyzSnJQmQMaYgY5RA1
         Gu4W9FbPPVVfqhLP6wBv6yUMmh//0n/IvC3esYOzqo/ntldinFt12uGknXYwN8ZG3hMc
         u1Kgpt/AKOtgBbVBMXpc3mF/EeWI30XyFhSdez3V1TnyzjvZbvq1r99TnSt/lwp/3wQi
         0tsxCy45Pi+BFNzgbJ7GV0Cp71+vNzEEzwFFffcVa9wCflKutJZSyltqG3jJKFw10qmJ
         J82e0bcyiBKZ+sgIS2u7yq5ABW6DCbaO2wr+8IychsaKO/SoppVpnLesH8J2ZRXLMP3N
         YbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792802857; x=1793407657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+v3pAR9SwEFWfYcKCCpCBOaA+n2FmfKQ3xgXRIMjox8=;
        b=uIFiwajP6qiJHBI0cw6nfiTrCUM7jnMKsMD5DUpov6pJyTC9Sz9YrhHltCZTURBzgw
         VueYg37u7KbQb9pSnhqtrnQS1e4s0va9z+cDU4VK+sUvB51oLzf19M61CzTxL3SsUt4t
         M8pIwIw7SNnO57J+/KPNCinZ+gv8zq1amO0CczRzT8LNsrW8mK2qlgHd2n3JNPu1D/m5
         DIg8BtJD1MWPf0rSe9B0wAjW746qWlg5lGMM8G7rLnlCTQi4SNfLlONj7P9QGk9ymgp6
         TrY+0y2EL67Sbu9XhIfQSVZCvvHYFNPfEILoyzNpjmfvNCHBy6uojT9cE9KRXxeD90jm
         /Nhw==
X-Gm-Message-State: AFq9FYLr4G3C530eVmk2j9s10duDbNXcYWc1BAFjZVhyOPGZLGNK9+v5
	/puzZBEeEnP2VE88z+mRcvUqe580fwEFl4OYIofMhSdhsV+XNRa1fBcYLkcX6o72v54=
X-Gm-Gg: AYBFou2NIjN8DCengyFSGVJvI/MkuPuxQL6qVumMmUOJqbMh3s3PejxK8BmXWMgUe/o
	zJLyoIUMH/ryM13X1kL/M6/CEOjVAmoa95yYEY7d8p3TYC9HUKMrKXI4S8erTiyn9mr8lH8cycn
	G5tkao9dYLKzz0FAap2it9wVFv6ajJcpCyiAxWcfpbKuHidRlsJpujr5YiX+Q9ULX30gRleb+Cx
	V9oAXQaS6Njl7cg2Fcz5WAXxhcv6mSaNCKG+ZjOa4mqOVKqJ65bwK1LrkFOI6LGwPIqImPlJ9Kg
	EaxgD9/1LF62Z07milSMAfFqSxJ70x+JGlpJzJKxCbu3nepEoUPWDryjDjoEK/Vkdluv1+ZyaEM
	csg9WB+Ou8zAwMiqgQx2Zj7MH40XFwR9aSLQL1vuMQoabt9Ys8HMP7t+T/IBF3X5rjaVAVTtDFy
	OVmpCWoao9SRFeWlo1tnM4SEAB96yTZBVDj8Qy/uJecSWk9GuScrIXq8ZbLHJ5bxOMaIrSWvILo
	+CLviUgTjT3XQS8c9pc7CY7Awwt5YaEjd5dHBi+XtRzQns=
X-Received: by 2002:a05:690e:1387:b0:679:a4f8:e47e with SMTP id 956f58d0204a3-67a453831bemr717002d50.32.1792802857101;
        Fri, 23 Oct 2026 17:47:37 -0700 (PDT)
Received: from WillzDenali.lan ([2600:1702:7a80:3c5e::dff])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a45d2c319sm376282d50.0.2026.10.23.17.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:47:36 -0700 (PDT)
From: Brandon Williams <turbine.bmw@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Brandon Williams <turbine.bmw@gmail.com>
Subject: [PATCH BlueZ] mgmt-tester: Add LL Privacy tests for a device's changed IRK
Date: Fri, 23 Oct 2026 20:47:32 -0400
Message-ID: <20261024004732.57922-1-turbine.bmw@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests where a device in the resolving list gets a new IRK or loses
its IRK, as when it pairs again: once the first IRK is programmed, load
the device's new IRKs and check that Set Device Flags replaces its
resolving list entry and sets Device Privacy Mode again, or removes the
entry.

The kernel needs "Bluetooth: hci_sync: Reprogram the resolving list
when a peer's IRK changes" for these tests to pass; without it they
time out.

Assisted-by: Claude:claude-opus-5-5
---

Notes:
    These need the kernel patch "Bluetooth: hci_sync: Reprogram the
    resolving list when a peer's IRK changes", sent to this list. On
    bluetooth-next 47d4d9f67e92 under QEMU (arm64, TCG), both tests time
    out without it (10/10 runs) and pass with it (10/10); with it the full
    mgmt-tester run passes 516 of 517 ("Set powered on - Blocked by rfkill"
    skips itself, as the test kernel has no /dev/rfkill). make check passes.
    
    The setup sends Read Local OOB Data after Set Device Flags and loads
    the changed IRK from its reply: the command runs on the same cmd_sync
    queue as the passive scan update, so the first IRK is programmed by
    then and the test step only sees the update that the changed IRK
    causes.
    
    Tool use: written with an AI coding assistant (Claude Code, Claude
    Opus 5.5) together with the kernel patch; see its notes.
    I ran these tests with and without the kernel fix and read through the
    setup, including why it waits for the Read Local OOB Data reply.

 tools/mgmt-tester.c | 210 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 528d8f7d7..ea07d628e 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -11560,6 +11560,88 @@ static const struct generic_data ll_privacy_set_device_flag_1 = {
 	.expect_hci_list = ll_privacy_set_device_flags_1_hci_list,
 };
 
+static const char load_irks_le_public_param_2[] = {
+	0x01, 0x00,					/* Key Count */
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,		/* Key 1 - BDADDR */
+	0x01,						/* Key 1 - Type */
+	0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x00, /* Key 1 - Value */
+	0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x00,
+};
+
+static const char load_irks_none_param[] = {
+	0x00, 0x00,					/* Key Count */
+};
+
+static const uint8_t le_remove_from_resolv_list_param[] = {
+	0x00,						/* Type */
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,		/* BDADDR */
+};
+
+static const uint8_t le_add_to_resolv_list_param_new_irk[] = {
+	0x00,						/* Type */
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,		/* BDADDR */
+	0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x00,	/* Peer IRK */
+	0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x00,
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,	/* Local IRK */
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+};
+
+static const struct hci_cmd_data ll_privacy_set_device_flags_2_hci_list[] = {
+	{
+		.opcode = BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST,
+		.param = le_remove_from_resolv_list_param,
+		.len = sizeof(le_remove_from_resolv_list_param),
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST,
+		.param = le_add_to_resolv_list_param_new_irk,
+		.len = sizeof(le_add_to_resolv_list_param_new_irk),
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_SET_PRIV_MODE,
+		.param = le_set_priv_mode_param,
+		.len = sizeof(le_set_priv_mode_param),
+	},
+	{},
+};
+
+static const struct hci_cmd_data ll_privacy_set_device_flags_3_hci_list[] = {
+	{
+		.opcode = BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST,
+		.param = le_remove_from_resolv_list_param,
+		.len = sizeof(le_remove_from_resolv_list_param),
+	},
+	{},
+};
+
+static const struct generic_data ll_privacy_set_device_flag_2 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.send_opcode = MGMT_OP_SET_DEVICE_FLAGS,
+	.send_param = set_device_flags_param_1,
+	.send_len = sizeof(set_device_flags_param_1),
+	.expect_param = set_device_flags_rsp,
+	.expect_len = sizeof(set_device_flags_rsp),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_FLAGS_CHANGED,
+	.expect_alt_ev_param = device_flags_changed_params_1,
+	.expect_alt_ev_len = sizeof(device_flags_changed_params_1),
+	.expect_hci_list = ll_privacy_set_device_flags_2_hci_list,
+};
+
+static const struct generic_data ll_privacy_set_device_flag_3 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.send_opcode = MGMT_OP_SET_DEVICE_FLAGS,
+	.send_param = set_device_flags_param_1,
+	.send_len = sizeof(set_device_flags_param_1),
+	.expect_param = set_device_flags_rsp,
+	.expect_len = sizeof(set_device_flags_rsp),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_FLAGS_CHANGED,
+	.expect_alt_ev_param = device_flags_changed_params_1,
+	.expect_alt_ev_len = sizeof(device_flags_changed_params_1),
+	.expect_hci_list = ll_privacy_set_device_flags_3_hci_list,
+};
+
 static void setup_load_irks_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -12286,6 +12368,109 @@ static void setup_ll_privacy_add_device(const void *test_data)
 
 }
 
+struct irk_change {
+	const void *param;
+	uint16_t len;
+};
+
+static const struct irk_change new_irk = {
+	.param = load_irks_le_public_param_2,
+	.len = sizeof(load_irks_le_public_param_2),
+};
+
+static const struct irk_change no_irk = {
+	.param = load_irks_none_param,
+	.len = sizeof(load_irks_none_param),
+};
+
+static bool first_irk_programmed;
+
+static bool setup_first_irk_hook(const void *data, uint16_t len,
+							void *user_data)
+{
+	/* Skip the local identity programmed at power on */
+	if (len == sizeof(le_add_to_resolv_list_param) &&
+			!memcmp(data, le_add_to_resolv_list_param, len))
+		first_irk_programmed = true;
+
+	return true;
+}
+
+static void setup_irk_changed_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("Device's IRK changed");
+
+	hciemu_del_hook(data->hciemu, HCIEMU_HOOK_PRE_CMD,
+					BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST);
+	test_setup_condition_complete(data);
+}
+
+static void setup_resolv_list_done_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct irk_change *change = user_data;
+	struct test_data *data = tester_get_data();
+
+	/* Read Local OOB Data completes after the resolving list updates
+	 * queued before it, so the first IRK is programmed by now.
+	 */
+	if (status != MGMT_STATUS_SUCCESS || !first_irk_programmed) {
+		tester_warn("First IRK not programmed in the resolving list");
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("First IRK programmed in the resolving list");
+
+	/* The device pairs again with a new IRK or without one */
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					change->len, change->param,
+					setup_irk_changed_callback, NULL, NULL);
+}
+
+static void setup_ll_privacy_irk_change(const void *test_data,
+					const struct irk_change *change)
+{
+	struct test_data *data = tester_get_data();
+
+	test_add_setup_condition(data);
+	first_irk_programmed = false;
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_CMD,
+					BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST,
+					setup_first_irk_hook, data);
+
+	setup_ll_privacy_add_device(test_data);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
+					sizeof(set_device_flags_param_1),
+					set_device_flags_param_1,
+					setup_set_device_flags_callback,
+					NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_READ_LOCAL_OOB_DATA, data->mgmt_index,
+					0, NULL,
+					setup_resolv_list_done_callback,
+					(void *) change, NULL);
+}
+
+static void setup_ll_privacy_new_irk(const void *test_data)
+{
+	setup_ll_privacy_irk_change(test_data, &new_irk);
+}
+
+static void setup_ll_privacy_no_irk(const void *test_data)
+{
+	setup_ll_privacy_irk_change(test_data, &no_irk);
+}
+
 static bool power_off(uint16_t index)
 {
 	int sk, err;
@@ -16285,6 +16470,31 @@ int main(int argc, char *argv[])
 				setup_ll_privacy_add_device,
 				test_command_generic);
 
+	/* LL Privacy
+	 * Setup: Enable LL Privacy, add IRK of new device, Add Device, Set
+	 *        Device Flags, then load a new IRK for the device once the
+	 *        first one is in the resolving list
+	 * Run: Set Device Flags
+	 * Expect: The device's resolving list entry is replaced with the new
+	 *         IRK and Device Privacy Mode is set again.
+	 */
+	test_bredrle50("LL Privacy - Set Device Flag 2 (New IRK)",
+				&ll_privacy_set_device_flag_2,
+				setup_ll_privacy_new_irk,
+				test_command_generic);
+
+	/* LL Privacy
+	 * Setup: Enable LL Privacy, add IRK of new device, Add Device, Set
+	 *        Device Flags, then remove the device's IRK once the first
+	 *        one is in the resolving list
+	 * Run: Set Device Flags
+	 * Expect: The device is removed from the resolving list.
+	 */
+	test_bredrle50("LL Privacy - Set Device Flag 3 (IRK Removed)",
+				&ll_privacy_set_device_flag_3,
+				setup_ll_privacy_no_irk,
+				test_command_generic);
+
 	/* HCI Devcoredump
 	 * Setup : Power on
 	 * Run: Trigger devcoredump via force_devcoredump
-- 
2.56.0

