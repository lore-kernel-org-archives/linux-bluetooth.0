Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A8330AD13
	for <linux-bluetooth@vger.kernel.org>; Sun, 16 Nov 2025 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763301141; cv=pass; b=ROROKk3gnZMqNOpw4mqd/ybj8RT8Dt14JBO6x2c6ZDV4FL1+GrQlT5iCLCKahgQ3l0UD/7XZZZXdJ7D/tpGsQpDY0HxvY60s516EOoUDk542TZTQRnVJwY9IwnFEWV3EOhkMvF0XfZuXMUKEGVcIl0BK7xEMbNprs4xFsoaZFwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763301141; c=relaxed/simple;
	bh=H6mS7fIEt3dp846nTRJS8GYLwrcjYsSYralN5r2GqJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rM7503pVPyQ+wGdgxNLIvSBAkxgFq9Pd395bWv0yIsSelLTC5+N5nVXH8qHZ8DKWl3QBsg9oCzeSlF9pekouReqSp+6BksRJHbbU+BqTzoZjzQW7s/pGycDXfQ6vi4EYJTbMOsjMSZ3Bm7jdVV4Z0IajlnC7Ayl6jn4sg5WjO4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vUxuMw/x; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vUxuMw/x"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d8XNy3bvGzySH;
	Sun, 16 Nov 2025 15:52:02 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763301123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QFfk2Dr5zAn4oSUGe0lIqvLTIAaC/ISkB7y4SNagntg=;
	b=vUxuMw/xkzOtGyctNIOafFYgHD77v8rtZzUKAeoycKCuS7F4F2DdXIRfZyX7bko3+YKGIr
	kDg7GXFLdpBoOc906XfwlowXV+QuOH5vVFFi73YUGtrwmU15Op77C+Ban+QX1oxR38OeGJ
	6DKnPFowk/jlEQ3efYMTHlwdbold2/4=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763301123;
	b=LP/BK65tmFqKzRr9Eeu3JFDDQrjhYLQQNjUYxQ6MBa+5SVQErwEzKn+FjkK6vag5BlaVeC
	XAoVLI/u+hvMTgYCwFb1rHB/CrPO1kB3gDsFi5M3VO/wQdS14DqOV06Gk2VXzULRZ0jHa7
	k2C1cnZ0N7ny+ipTORg+rKORui4Uzj4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763301123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QFfk2Dr5zAn4oSUGe0lIqvLTIAaC/ISkB7y4SNagntg=;
	b=gxbnEX36nhseTnr3CzdPD29V/NkM5TsvCzqqMxy3ofDOhS7qUzapWW/Jly9imSxI7k7ks4
	uv97j8jfScEjVlZbm2Ch5H35ueiczVgeXHe+yTotvwNH+YIla0V1OFZhMK39zLoA+VBVX4
	b2rLgnFvZMfm24l/OiCIuvwcrEMDzqY=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] mgmt-tester: add tests for discoverable timeout
Date: Sun, 16 Nov 2025 15:51:58 +0200
Message-ID: <134dc6196bd704f56902f17ffc72119c9babd7bb.1763301095.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that the discoverable timeout can be set successfully and that the
timeout actually triggers:

Set discoverable on timeout - Success 1
Set discoverable on timeout - Success 2 (Timeout)
---

Notes:
    These tests can be used to observe a deadlock in kernel of the type:
    
    [T1]                                                [T2]
    hci_dev_lock()
                                                        discov_off()
                                                           hci_dev_lock()
      mgmt_index_removed()
        cancel_delayed_work_sync(&hdev->discov_off)
        -> deadlock
    
    This requires specific timing. Adding sleep in mgmt_index_removed()
    makes it hit:
    
    diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
    index c11cdef42b6f..34a44e92779c 100644
    --- a/net/bluetooth/mgmt.c
    +++ b/net/bluetooth/mgmt.c
    @@ -9487,6 +9487,8 @@ void mgmt_index_removed(struct hci_dev *hdev)
            struct mgmt_ev_ext_index ev;
            struct cmd_lookup match = { NULL, hdev, MGMT_STATUS_INVALID_INDEX };
    
    +       usleep_range(11*1000*1000, 12*1000*1000);
    +
            if (hci_test_quirk(hdev, HCI_QUIRK_RAW_DEVICE))
                    return;
    
    Then mgmt-tester -s "Set discoverable on timeout - Success 1" triggers
    
    ======================================================
    WARNING: possible circular locking dependency detected
    6.18.0-rc2-00379-g183db933c900-dirty #1006 Not tainted
    ------------------------------------------------------
    mgmt-tester/44 is trying to acquire lock:
    ffff888002138830 ((work_completion)(&(&hdev->discov_off)->work)){+.+.}-{0:0}, at: __flush_work+0x4dc/0xc90
    
    but task is already holding lock:
    ffff8880021380b0 (&hdev->lock){+.+.}-{4:4}, at: hci_unregister_dev+0x2e8/0x4d0
    
    which lock already depends on the new lock.
    
    the existing dependency chain (in reverse order) is:
    
    -> #1 (&hdev->lock){+.+.}-{4:4}:
           __mutex_lock+0x1a6/0x21f0
           discov_off+0x7c/0x1c0
           process_one_work+0x7ed/0x13c0
           worker_thread+0x601/0xff0
           kthread+0x3e6/0x860
           ret_from_fork+0x3da/0x570
           ret_from_fork_asm+0x19/0x30
    
    -> #0 ((work_completion)(&(&hdev->discov_off)->work)){+.+.}-{0:0}:
           __lock_acquire+0x14be/0x2610
           lock_acquire+0xf2/0x2a0
           __flush_work+0x4f9/0xc90
           cancel_delayed_work_sync+0xae/0xe0
           mgmt_index_removed+0x246/0x2d0
           hci_unregister_dev+0x2f0/0x4d0
           vhci_release+0x188/0x260
           __fput+0x35b/0x9e0
           fput_close_sync+0xde/0x190
           __x64_sys_close+0x96/0x100
           do_syscall_64+0x72/0x300
           entry_SYSCALL_64_after_hwframe+0x74/0x7c
    
    other info that might help us debug this:
    
     Possible unsafe locking scenario:
    
           CPU0                    CPU1
           ----                    ----
      lock(&hdev->lock);
                                   lock((work_completion)(&(&hdev->discov_off)->work));
                                   lock(&hdev->lock);
      lock((work_completion)(&(&hdev->discov_off)->work));
    
     *** DEADLOCK ***
    
    2 locks held by mgmt-tester/44:
     #0: ffff8880021380b0 (&hdev->lock){+.+.}-{4:4}, at: hci_unregister_dev+0x2e8/0x4d0
     #1: ffffffffa0992c00 (rcu_read_lock){....}-{1:3}, at: __flush_work+0xdc/0xc90

 tools/mgmt-tester.c | 63 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 3 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 663879a8f..90dfa3527 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -343,6 +343,7 @@ struct generic_data {
 	const void * (*expect_func)(uint16_t *len);
 	uint32_t expect_settings_set;
 	uint32_t expect_settings_unset;
+	uint32_t expect_settings_spontaneous;
 	uint16_t expect_alt_ev;
 	const void *expect_alt_ev_param;
 	bool (*verify_alt_ev_func)(const void *param, uint16_t length);
@@ -1206,6 +1207,7 @@ static const struct generic_data set_bondable_on_invalid_index_test = {
 
 static const uint8_t set_discoverable_on_param[] = { 0x01, 0x00, 0x00 };
 static const uint8_t set_discoverable_timeout_param[] = { 0x01, 0x0a, 0x00 };
+static const uint8_t set_discoverable_timeout_1_param[] = { 0x01, 0x01, 0x00 };
 static const uint8_t set_discoverable_invalid_param[] = { 0x02, 0x00, 0x00 };
 static const uint8_t set_discoverable_off_param[] = { 0x00, 0x00, 0x00 };
 static const uint8_t set_discoverable_offtimeout_param[] = { 0x00, 0x01, 0x00 };
@@ -1307,6 +1309,36 @@ static const struct generic_data set_discoverable_on_success_test_2 = {
 	.expect_hci_len = sizeof(set_discoverable_on_scan_enable_param),
 };
 
+static const struct generic_data set_discoverable_on_timeout_success_test_1 = {
+	.setup_settings = settings_powered_connectable,
+	.send_opcode = MGMT_OP_SET_DISCOVERABLE,
+	.send_param = set_discoverable_timeout_param,
+	.send_len = sizeof(set_discoverable_timeout_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_discoverable_on_settings_param_2,
+	.expect_len = sizeof(set_discoverable_on_settings_param_2),
+	.expect_hci_command = BT_HCI_CMD_WRITE_SCAN_ENABLE,
+	.expect_hci_param = set_discoverable_on_scan_enable_param,
+	.expect_hci_len = sizeof(set_discoverable_on_scan_enable_param),
+};
+
+static const struct generic_data set_discoverable_on_timeout_success_test_2 = {
+	.setup_settings = settings_powered_connectable,
+	.send_opcode = MGMT_OP_SET_DISCOVERABLE,
+	.send_param = set_discoverable_timeout_1_param,
+	.send_len = sizeof(set_discoverable_timeout_1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_settings_set = MGMT_SETTING_DISCOVERABLE,
+	.expect_settings_spontaneous = MGMT_SETTING_POWERED |
+					MGMT_SETTING_CONNECTABLE |
+					MGMT_SETTING_BREDR,
+	.expect_param = set_discoverable_on_settings_param_2,
+	.expect_len = sizeof(set_discoverable_on_settings_param_2),
+	.expect_hci_command = BT_HCI_CMD_WRITE_SCAN_ENABLE,
+	.expect_hci_param = set_discoverable_on_scan_enable_param,
+	.expect_hci_len = sizeof(set_discoverable_on_scan_enable_param),
+};
+
 static uint8_t set_discov_on_le_param[] = { 0x0b, 0x06, 0x00, 0x00 };
 static uint8_t set_discov_adv_data[32] = { 0x06, 0x02, 0x01, 0x06,
 								0x02, 0x0a, };
@@ -7333,12 +7365,27 @@ static void command_generic_new_settings(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	uint32_t settings;
 
-	tester_print("New settings event received");
+	if (length != 4) {
+		tester_warn("Invalid parameter size for new settings event");
+		tester_test_failed();
+		return;
+	}
+
+	settings = get_le32(param);
+	tester_print("New settings 0x%08x received (local)", settings);
 
 	mgmt_unregister(data->mgmt, data->mgmt_settings_id);
 
-	tester_test_failed();
+	if (!test->expect_settings_spontaneous) {
+		tester_test_failed();
+		return;
+	}
+
+	if (settings == test->expect_settings_spontaneous)
+		test_condition_complete(data);
 }
 
 static void command_generic_new_settings_alt(uint16_t index, uint16_t length,
@@ -11592,7 +11639,8 @@ static void test_command_generic(const void *test_data)
 
 	index = test->send_index_none ? MGMT_INDEX_NONE : data->mgmt_index;
 
-	if (test->expect_settings_set || test->expect_settings_unset) {
+	if (test->expect_settings_set || test->expect_settings_unset ||
+					test->expect_settings_spontaneous) {
 		tester_print("Registering new settings notification");
 
 		id = mgmt_register(data->mgmt, MGMT_EV_NEW_SETTINGS, index,
@@ -11603,6 +11651,9 @@ static void test_command_generic(const void *test_data)
 				command_generic_new_settings_alt, NULL, NULL);
 		data->mgmt_alt_settings_id = id;
 		test_add_condition(data);
+
+		if (test->expect_settings_spontaneous)
+			test_add_condition(data);
 	}
 
 	if (test->expect_alt_ev) {
@@ -13146,6 +13197,12 @@ int main(int argc, char *argv[])
 	test_bredrle("Set discoverable on - Success 2",
 				&set_discoverable_on_success_test_2,
 				NULL, test_command_generic);
+	test_bredrle("Set discoverable on timeout - Success 1",
+				&set_discoverable_on_timeout_success_test_1,
+				NULL, test_command_generic);
+	test_bredrle_full("Set discoverable on timeout - Success 2 (Timeout)",
+				&set_discoverable_on_timeout_success_test_2,
+				NULL, test_command_generic, 8);
 	test_le("Set discoverable on (LE) - Success 1",
 				&set_discov_on_le_success_1,
 				NULL, test_command_generic);
-- 
2.51.1

