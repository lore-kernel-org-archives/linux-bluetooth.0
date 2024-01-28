Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3532B2E84F
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jan 2024 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706475964; cv=none; b=Vgt9HJZ+JrOCytVqc/QkNUc1E877XE5M8u/uG9f3OOuSlcxwnFqcd4mCVA9YgAsYJ+i7/eykKQPWXBv4LOZiiS6UM86KBk46o2+7OxVScw/lS8Sj/SI7vvqoVN8pyoJi/9wgonl2b7Wr4U0aZcE2s14TG3h9uVqOQ0gHaNxGeZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706475964; c=relaxed/simple;
	bh=IpqEIrw4O4ZCo0gjO9jyL5Ox1gf7y7rQFYFEFr6Zn+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TtNCpFK7gOkmhi7VqsiW4YvtZlk4FpBP9Gsu0m81Gs4DpDae0fB5vconKfQ3aDeLNqt26LI2PIO4ExrYWJaNTnaYqqYEjATpf7UXTMqeCV1mmgVX5lk6phypJ/QR3psdceHEe70etec6gPtXzc/57XyWBdIbrqGYVzYbu7gYUCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl; spf=pass smtp.mailfrom=v0yd.nl; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TNP9B6QVBz9scT;
	Sun, 28 Jan 2024 22:05:50 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
Subject: [PATCH BlueZ] mgmt-tester: Ensure rfkilling HCI disconnects devices
Date: Sun, 28 Jan 2024 22:05:47 +0100
Message-ID: <20240128210547.16141-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel was recently changed to introduce disconnecting of connected
BT devices before the adapter gets rfkilled (see kernel commit
"Bluetooth: Disconnect connected devices before rfkilling adapter").

Add a test to mgmt-tester to ensure that this logic works. It uses
async io to write to the rfkill device and then looks if the HCI
Disconnect command gets sent for the connected device.

The use async io is necessary because the rfkill write would block our
thread until the disconnect and adapter shutdown is finished. To finish
this disconnect though, the HCI emulator needs to respond to the HCI
Disconnect command. Because the emulator runs in the our mgmt-tester
thread too, it would be blocked by the write and couldn't reply,
resulting in a timeout and test failure.
---
 tools/mgmt-tester.c | 152 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 7dfd1b0c7..c2e2a9d31 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -21,6 +21,7 @@
 #include <fcntl.h>
 #include <errno.h>
 #include <unistd.h>
+#include <aio.h>
 
 #include <glib.h>
 
@@ -12760,6 +12761,147 @@ static void test_hci_devcd(const void *test_data)
 	tester_wait(test->dump_data->timeout + 1, verify_devcd, NULL);
 }
 
+static const uint8_t rfkill_hci_disconnect_device[] = {
+	0x2a, 0x00, /* handle */
+	0x15, /* reason: Power Off */
+};
+
+static const struct generic_data rfkill_disconnect_devices = {
+	.setup_settings = settings_powered_connectable_bondable,
+	.expect_hci_command = BT_HCI_CMD_DISCONNECT,
+	.expect_hci_param = rfkill_hci_disconnect_device,
+	.expect_hci_len = sizeof(rfkill_hci_disconnect_device),
+};
+
+enum rfkill_type {
+	RFKILL_TYPE_ALL = 0,
+	RFKILL_TYPE_WLAN,
+	RFKILL_TYPE_BLUETOOTH,
+	RFKILL_TYPE_UWB,
+	RFKILL_TYPE_WIMAX,
+	RFKILL_TYPE_WWAN,
+};
+
+enum rfkill_operation {
+	RFKILL_OP_ADD = 0,
+	RFKILL_OP_DEL,
+	RFKILL_OP_CHANGE,
+	RFKILL_OP_CHANGE_ALL,
+};
+
+struct rfkill_event {
+	uint32_t idx;
+	uint8_t type;
+	uint8_t op;
+	uint8_t soft;
+	uint8_t hard;
+};
+#define RFKILL_EVENT_SIZE_V1    8
+
+static void trigger_rfkill(void *user_data)
+{
+	struct aiocb *op = user_data;
+	int fd;
+	int latest_rfkill_idx;
+	struct rfkill_event write_event;
+
+	tester_print("Blocking hci device via rfkill");
+
+	fd = open("/dev/rfkill", O_RDWR|O_CLOEXEC|O_NOCTTY|O_NONBLOCK);
+	if (fd < 0) {
+		tester_warn("Failed to open rfkill control device: %s", strerror(errno));
+		tester_test_failed();
+		free(op);
+		return;
+	}
+
+	latest_rfkill_idx = -1;
+	while (1) {
+		struct rfkill_event event = { 0 };
+		ssize_t len;
+
+		len = read(fd, &event, sizeof(event));
+		if (len < RFKILL_EVENT_SIZE_V1)
+			break;
+
+		if (event.type == RFKILL_TYPE_BLUETOOTH)
+			latest_rfkill_idx = event.idx;
+	}
+
+	if (latest_rfkill_idx < 0) {
+		tester_warn("No rfkill device to block found");
+		tester_test_failed();
+		close(fd);
+		free(op);
+		return;
+	}
+
+	write_event.idx = latest_rfkill_idx;
+	write_event.op = RFKILL_OP_CHANGE;
+	write_event.soft = true;
+
+	op->aio_fildes = fd;
+	op->aio_buf = &write_event;
+	op->aio_nbytes = sizeof(write_event);
+
+	if (aio_write(op) != 0) {
+		tester_warn("Failed to write to rfkill control device: %s", strerror(errno));
+		tester_test_failed();
+		close(fd);
+		free(op);
+	}
+}
+
+static void finish_aio_write(void *user_data)
+{
+	struct aiocb *op = user_data;
+	struct test_data *data = tester_get_data();
+	int err;
+	size_t ret;
+
+	err = aio_error(op);
+	ret = aio_return(op);
+	if (err != 0) {
+		tester_warn("aio_error() return error: %s", strerror(err));
+		tester_test_failed();
+	} else if (ret != op->aio_nbytes) {
+		tester_warn("aio_return() returned write failed");
+		tester_test_failed();
+	}
+
+	close(op->aio_fildes);
+	free(op);
+	test_condition_complete(data);
+}
+
+static void test_disconnect_on_rfkill(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost;
+	const uint8_t *central_bdaddr;
+	uint8_t addr_type;
+	struct aiocb *op = new0(struct aiocb, 1);
+
+	bthost = hciemu_client_get_host(data->hciemu);
+	central_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
+	if (!central_bdaddr) {
+		tester_warn("No central bdaddr");
+		tester_test_failed();
+		return;
+	}
+
+	addr_type = data->hciemu_type == HCIEMU_TYPE_BREDRLE
+		? BDADDR_BREDR : BDADDR_LE_PUBLIC;
+
+	bthost_hci_connect(bthost, central_bdaddr, addr_type);
+
+	test_command_generic(test_data);
+
+	tester_wait(1, trigger_rfkill, (void *)op);
+	tester_wait(2, finish_aio_write, (void *)op);
+	test_add_condition(data);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -14925,5 +15067,15 @@ int main(int argc, char *argv[])
 	test_bredrle_full("HCI Devcoredump - Dump Timeout", &dump_timeout, NULL,
 				test_hci_devcd, 3);
 
+	/* Rfkill
+	 * Setup: Connect to device
+	 * Run: Block hci device via rfkill
+	 * Expect: Disconnect HCI command sent to device
+	 */
+	test_bredrle("Rfkill - disconnect devices",
+				&rfkill_disconnect_devices, NULL,
+				test_disconnect_on_rfkill);
+
+
 	return tester_run();
 }
-- 
2.43.0

