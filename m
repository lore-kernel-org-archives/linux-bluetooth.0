Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4A212D152
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Feb 2024 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218597; cv=none; b=ejcgrm5NqH0uQIw4P0y0H/BpqzEU4/Jdgz3uneKpgUZxAo+yfbvkHtdkUVXOw6lBkFBfVH6/dlvgxrmqXseLpHk2Yz3wsOGD11hddbFPKvRgQrpOtKZ1AdtzjHCY2gCipgq8UzhbYiWtzyQq5o6t8XeuUFkmNlGmypS+6OUFVzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218597; c=relaxed/simple;
	bh=DnMD8gUxu30juBFpQz9aXRAA2HnRTVzZQ4qj1UTY0js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECG0t20fwY1vYGI07IWACsTLPhueo3Jz7G3cV6d3YsQmdTDcoLueVx0n+j0uBDI7VpkbahJUyYi/k1vT7xXxY/hmQjFi3HAtmi3t5FKQloT43wi3eKCR/6JhRgwjFRmDijdgZrQdDB+MeMYxsFISirSCrLXgsgWT7YsxFQCVFkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl; spf=pass smtp.mailfrom=v0yd.nl; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TTgpl5LN1z9swV;
	Tue,  6 Feb 2024 12:23:11 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
Subject: [PATCH BlueZ v2 4/4] mgmt-tester: Add a test for connecting sequentially
Date: Tue,  6 Feb 2024 12:22:53 +0100
Message-ID: <20240206112253.76446-5-verdre@v0yd.nl>
In-Reply-To: <20240206112253.76446-1-verdre@v0yd.nl>
References: <20240206112253.76446-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TTgpl5LN1z9swV

The kernel was recently changed to only connect to ACL devices
sequentially (see kernel commit "Bluetooth: hci_conn: Only do
ACL connections sequentially"), similar to how it already behaves
for LE devices.

Add some testing for this behavior to mgmt-tester and make sure
that new "HCI Create Connection" commands only get sent after
the previous "Pair Device" MGMT command has failed.
---
 tools/mgmt-tester.c | 106 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 767cd5cda..ac3045e13 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -12767,6 +12767,103 @@ static void test_hci_devcd(const void *test_data)
 	tester_wait(test->dump_data->timeout + 1, verify_devcd, NULL);
 }
 
+static const struct generic_data sequential_connect = {
+	.setup_settings = settings_powered_bondable,
+	.pin = pair_device_pin,
+	.pin_len = sizeof(pair_device_pin),
+	.client_pin = pair_device_pin,
+	.client_pin_len = sizeof(pair_device_pin),
+};
+
+struct pair_devices_data {
+	struct test_data *test_data;
+	unsigned int n_conn_failed_evts;
+	unsigned int n_create_conn_cmds;
+};
+
+static void pair_device_command_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct pair_devices_data *pd_data = user_data;
+
+	if (status != MGMT_STATUS_CONNECT_FAILED) {
+		tester_warn("Unexpected status got %d expected %d",
+			    status, MGMT_STATUS_CONNECT_FAILED);
+		tester_test_failed();
+		free(pd_data);
+		return;
+	}
+
+	tester_print("Connect failed for Pair Device");
+
+	pd_data->n_conn_failed_evts++;
+	if (pd_data->n_conn_failed_evts != pd_data->n_create_conn_cmds) {
+		tester_test_failed();
+		free(pd_data);
+		return;
+	}
+
+	if (pd_data->n_conn_failed_evts == 3) {
+		test_condition_complete(pd_data->test_data);
+		free(pd_data);
+	}
+}
+
+static bool connect_multiple_create_conn(const void *data, uint16_t len,
+					void *user_data)
+{
+	struct pair_devices_data *pd_data = user_data;
+	const uint8_t *status = data;
+
+	if (*status == 0) {
+		tester_print("Create connection finished");
+
+		pd_data->n_create_conn_cmds++;
+		if (pd_data->n_conn_failed_evts != pd_data->n_create_conn_cmds - 1) {
+			tester_test_failed();
+			free(pd_data);
+		}
+	} else {
+		tester_print("Create connection failed: 0x%02x", *status);
+		tester_test_failed();
+		free(pd_data);
+	}
+
+	return true;
+}
+
+static void test_sequential_connect(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct pair_devices_data *pd_data;
+	static uint8_t param[8] = {
+		0x31, 0xAB, 0xCD, 0x32, 0x34, 0x73, /* random bdaddr so we fail to connect */
+		BDADDR_BREDR,
+		0x03, /* NoInputNoOutput */
+	 };
+
+	pd_data = new0(struct pair_devices_data, 1);
+	pd_data->test_data = data;
+	pd_data->n_conn_failed_evts = 0;
+	pd_data->n_create_conn_cmds = 0;
+
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_CMD,
+			BT_HCI_CMD_CREATE_CONN,
+			connect_multiple_create_conn, pd_data);
+
+	mgmt_send_nowait(data->mgmt, MGMT_OP_PAIR_DEVICE, data->mgmt_index,
+			 sizeof(param), param,
+			 pair_device_command_callback, pd_data, NULL);
+	param[2] = 0x09; /* change bdaddr a bit */
+	mgmt_send_nowait(data->mgmt, MGMT_OP_PAIR_DEVICE, data->mgmt_index,
+			 sizeof(param), param,
+			 pair_device_command_callback, pd_data, NULL);
+	param[2] = 0x10; /* change bdaddr a bit */
+	mgmt_send_nowait(data->mgmt, MGMT_OP_PAIR_DEVICE, data->mgmt_index,
+			 sizeof(param), param,
+			 pair_device_command_callback, pd_data, NULL);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -14932,5 +15029,14 @@ int main(int argc, char *argv[])
 	test_bredrle_full("HCI Devcoredump - Dump Timeout", &dump_timeout, NULL,
 				test_hci_devcd, 3);
 
+	/* Sequential connect
+	 * Setup: Power on
+	 * Run: Try connecting to multiple devices
+	 * Expect: Connects time out sequentially
+	 */
+	test_bredrle_full("Sequential connect",
+				&sequential_connect, NULL,
+				test_sequential_connect, 7);
+
 	return tester_run();
 }
-- 
2.43.0

