Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956241;
	b=N3Lrlf0wr44fKJ8u43C2zNzZHfXWaNT+YMKCOVY0bdh2m4vkSrhUITLkHrMeQ5Qmom4i
	 iPJpNtP8E9dKNGt7BzzzaZoEUue9J5nW5CPNexDSWJnsuTzhDljuWC1TAinYfQhl1yK1W
	 szvBld5BCGzY1zWtok+L2oGyXL+sAeWktZw8bvVff81zfYY6XHeqRwfjFcyAGqHzILM1q
	 9VsU8KqW1btFrGr1K/r5pzPrsc3H41CB/lyk1oswstC8LjMLObCPDPImx7fW3wSGDadUm
	 M+Ack3fPr/v4dieCsi8t8qESdu4SFkYBUUCIRp4v5WloF6fATk4lMRc+6eka1Q0SeAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956241;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=wA9kX1l8k8mPIR5VUGFZzo6nrc+2PZtbNGIopEIJPyg=;
	b=KC/9AWjyqnoJNsR8JCWeRDoSN65RTE9gX9elDFmNqPofH5HRstxAX2TrK0oMJMXF1G00
	 eCmYBw4Ec6IEPg6zGxoHAS9YPQqnatf7TymDNCvncxGp3U8Kdq6zA+/OjwmT0zlIbx4nj
	 /fC1JQxx/OORlGHX13uc7FRNSV4fHavwIKNOg3NF1YRkz0eP1biO4y+i2knaVK/uY1tIc
	 SdQipITOw7vt+bEXFp9cIveJMRQT0siLXS4oHwL364UW8+Q0h941r3dlQ7SCq9+IclJsM
	 +eKlHWhIQ95mNhpFemnmB/gg9nYnYRW5/fsIAggyEUksXnEOWlqDaN6K/e6OhBMYNvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=FdgKokqK;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F9E60A2625;
	Sun, 25 Oct 2026 19:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78F9E60A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=FdgKokqK
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJNdOw518064
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:23:46 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJNdOw518064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956227;
	bh=wA9kX1l8k8mPIR5VUGFZzo6nrc+2PZtbNGIopEIJPyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FdgKokqKFF2S63LG+JG1kSfMOPrhBJj2XxtI1vEgW+cTZxsa7SaOpPjX5xVFgdP59
	 TpjRm1ZTl3SGMT/ohEBjj1vwUvrGAbahxdsOzj6qLmLAkwlTAG6qzdXa7GT/vLBUaR
	 ivnMi1S1O0CMieGqaQ0nDALnt8qXWjU7xT6MIx1E=
From: christian.koever-draxl@student.uibk.ac.at
To: yang.li@amlogic.com, marcel@holtmann.org, luiz.dentz@gmail.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH 3/7] Bluetooth: hci_aml: cope with a controller that is already running
Date: Sun, 25 Oct 2026 20:23:34 +0100
Message-ID: <20261025192338.209574-4-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: () -14.0 ALL_TRUSTED,RCV_SMTP_AUTH,RCV_SMTP_UIBK,U_RCPTS_11_PLUS
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

Several things stop the W1 (W155S2) in an S905W2 TV box from completing
setup reliably:

 - Dropping the enable line does not reset this controller. It keeps
   running whatever firmware it was last given, at the baud rate it was
   last told to use, so a warm reboot or a driver reload finds an HCI
   device at 4 Mbps that no longer understands TCI commands, and the
   download dies on the first TCI write. Read Local Version tells the
   two cases apart, as the ROM does not answer it, so probe for it and
   skip the download when firmware is already running.

 - Talking to a running controller first means sending it a TCI command
   at the ROM's 115200 baud, which arrives as noise at 4 Mbps. The
   firmware takes it for the start of a packet and swallows the next
   command as its payload. Retry the probe; every attempt completes
   more of the imagined packet until the controller listens again.

 - A single unanswered firmware segment aborted the bring-up. Segments
   are plain writes to controller RAM, so resync and send it again.

 - The fixed 60 ms wait after starting the firmware is too short for
   W1, which takes up to half a second. A version request sent too early
   is lost and blocks the command queue for HCI_CMD_TIMEOUT, so wait
   600 ms, then poll the firmware version until it answers.

 - Closing the HCI device dropped the enable line. Setup, which powers
   the controller up, only runs once per registration, and the dropped
   enable line leaves the controller unreachable until the combo chip
   is power cycled, so the adapter was lost after a single down/up
   cycle. Keep it powered in close and power it off on remove instead,
   tracking the state so remove and shutdown stay balanced. Rebinding
   the driver still loses the controller, as the hardware gives no way
   to reset it short of a power cycle.

Tested on an S905W2 board: setup succeeds on cold boot and warm reboot,
and the adapter survives down/up cycles.

Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 drivers/bluetooth/hci_aml.c | 186 ++++++++++++++++++++++++++++++------
 1 file changed, 158 insertions(+), 28 deletions(-)

diff --git a/drivers/bluetooth/hci_aml.c b/drivers/bluetooth/hci_aml.c
index 5979b114f2e4..8561618867e8 100644
--- a/drivers/bluetooth/hci_aml.c
+++ b/drivers/bluetooth/hci_aml.c
@@ -24,6 +24,29 @@
 
 #define AML_FIRMWARE_OPERATION_SIZE		(248)
 #define AML_FIRMWARE_MAX_SIZE			(512 * 1024)
+#define AML_FIRMWARE_SEGMENT_RETRIES		(1)
+
+/* Probing for a controller that already runs firmware is expected to time
+ * out on a freshly powered one, so do not wait HCI_INIT_TIMEOUT for it.
+ */
+#define AML_PROBE_TIMEOUT			msecs_to_jiffies(500)
+
+/* Long enough for the controller to drop a partial frame received at the
+ * wrong rate.
+ */
+#define AML_RESYNC_MS				(100)
+#define AML_RESYNC_RETRIES			(4)
+
+/* An HCI command has an 8 bit length, so this always completes a partial one */
+#define AML_RESYNC_CHUNKS_CMD			(2)
+
+/* W1 takes up to half a second to start its firmware, and a version request
+ * sent before that is lost and blocks the command queue for HCI_CMD_TIMEOUT,
+ * so wait a little longer than that before asking, then keep asking.
+ */
+#define AML_STARTUP_DELAY_MS			(600)
+#define AML_STARTUP_POLL_MS			(60)
+#define AML_STARTUP_RETRIES			(5)
 
 /* TCI command */
 #define AML_TCI_CMD_READ			0xFEF0
@@ -100,6 +123,7 @@ struct aml_serdev {
 	struct clk *lpo_clk;
 	const struct aml_device_data *aml_dev_data;
 	const char *firmware_name;
+	bool powered;
 };
 
 struct aml_data {
@@ -214,11 +238,33 @@ static int aml_send_firmware_segment(struct hci_dev *hdev,
 			     op_addr, (u32 *)seg, seg_size);
 }
 
-static int aml_send_firmware(struct hci_dev *hdev, u8 fw_type,
-			     u8 *fw, u32 fw_size, u32 offset)
+static const u8 aml_resync_pattern[256];
+
+/* A command that goes unanswered has usually been half received: the
+ * controller took what did arrive for the start of a packet and waits for
+ * the rest, so every following command is swallowed as its payload. Send
+ * enough bytes to complete whatever it is reassembling. Zero is not a valid
+ * H4 packet type, so what is left over afterwards is discarded.
+ */
+static void aml_resync(struct hci_uart *hu, unsigned int chunks)
+{
+	unsigned int i;
+
+	for (i = 0; i < chunks; i++)
+		serdev_device_write(hu->serdev, aml_resync_pattern,
+				    sizeof(aml_resync_pattern),
+				    MAX_SCHEDULE_TIMEOUT);
+
+	serdev_device_wait_until_sent(hu->serdev, 0);
+}
+
+static int aml_send_firmware(struct hci_dev *hdev, struct hci_uart *hu,
+			     u8 fw_type, u8 *fw, u32 fw_size, u32 offset)
 {
 	u32 seg_size = 0;
 	u32 seg_off = 0;
+	int err = 0;
+	int retry;
 
 	if (fw_size > AML_FIRMWARE_MAX_SIZE) {
 		bt_dev_err(hdev,
@@ -229,8 +275,22 @@ static int aml_send_firmware(struct hci_dev *hdev, u8 fw_type,
 	while (fw_size > 0) {
 		seg_size = (fw_size > AML_FIRMWARE_OPERATION_SIZE) ?
 			   AML_FIRMWARE_OPERATION_SIZE : fw_size;
-		if (aml_send_firmware_segment(hdev, fw_type, (fw + seg_off),
-					      seg_size, offset)) {
+		/* A segment is a plain write to controller RAM, so one that
+		 * goes unanswered can simply be sent again, after resyncing
+		 * the controller that is still waiting for its end.
+		 */
+		for (retry = 0; retry <= AML_FIRMWARE_SEGMENT_RETRIES; retry++) {
+			err = aml_send_firmware_segment(hdev, fw_type,
+							fw + seg_off,
+							seg_size, offset);
+			if (!err)
+				break;
+
+			bt_dev_warn(hdev, "Retrying firmware segment, type: %d, offset: 0x%x",
+				    fw_type, offset);
+			aml_resync(hu, AML_RESYNC_CHUNKS_CMD);
+		}
+		if (err) {
 			bt_dev_err(hdev, "Failed send firmware, type: %d, offset: 0x%x",
 			       fw_type, offset);
 			return -EINVAL;
@@ -242,6 +302,35 @@ static int aml_send_firmware(struct hci_dev *hdev, u8 fw_type,
 	return 0;
 }
 
+/* Dropping the enable line does not reset these controllers: they keep
+ * running the firmware they were last given, at the baud rate they were last
+ * told to use. A warm reboot or a driver reload therefore finds an HCI device
+ * at the operational rate that no longer understands TCI commands. Read Local
+ * Version tells the two cases apart: the ROM does not answer it, running
+ * firmware does.
+ */
+static bool aml_fw_already_running(struct hci_dev *hdev, struct hci_uart *hu)
+{
+	struct sk_buff *skb;
+	int i;
+
+	serdev_device_set_baudrate(hu->serdev, hu->proto->oper_speed);
+
+	for (i = 0; i < AML_RESYNC_RETRIES; i++) {
+		skb = __hci_cmd_sync_ev(hdev, HCI_OP_READ_LOCAL_VERSION, 0,
+					NULL, HCI_EV_CMD_COMPLETE,
+					AML_PROBE_TIMEOUT);
+		if (!IS_ERR(skb)) {
+			kfree_skb(skb);
+			return true;
+		}
+	}
+
+	serdev_device_set_baudrate(hu->serdev, hu->proto->init_speed);
+
+	return false;
+}
+
 static int aml_download_firmware(struct hci_dev *hdev, const char *fw_name)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
@@ -301,7 +390,7 @@ static int aml_download_firmware(struct hci_dev *hdev, const char *fw_name)
 	iccm_start = (u8 *)(firmware->data) + sizeof(struct aml_fw_len)
 			+ amldev->aml_dev_data->iccm_offset;
 	iccm_len = fw_len->iccm_len - amldev->aml_dev_data->iccm_offset;
-	ret = aml_send_firmware(hdev, FW_ICCM, iccm_start, iccm_len,
+	ret = aml_send_firmware(hdev, hu, FW_ICCM, iccm_start, iccm_len,
 				amldev->aml_dev_data->iccm_offset);
 	if (ret) {
 		bt_dev_err(hdev, "Failed to send FW_ICCM (%d)", ret);
@@ -311,7 +400,7 @@ static int aml_download_firmware(struct hci_dev *hdev, const char *fw_name)
 	/* Download DCCM */
 	dccm_start = (u8 *)(firmware->data) + sizeof(struct aml_fw_len) + fw_len->iccm_len;
 	dccm_len = fw_len->dccm_len;
-	ret = aml_send_firmware(hdev, FW_DCCM, dccm_start, dccm_len,
+	ret = aml_send_firmware(hdev, hu, FW_DCCM, dccm_start, dccm_len,
 				amldev->aml_dev_data->dccm_offset);
 	if (ret) {
 		bt_dev_err(hdev, "Failed to send FW_DCCM (%d)", ret);
@@ -508,6 +597,7 @@ static int aml_power_on(struct aml_serdev *amldev)
 	}
 
 	gpiod_set_value_cansleep(amldev->bt_en_gpio, 1);
+	amldev->powered = true;
 
 	/* Wait 20ms for bluetooth controller power on */
 	msleep(20);
@@ -516,6 +606,10 @@ static int aml_power_on(struct aml_serdev *amldev)
 
 static int aml_power_off(struct aml_serdev *amldev)
 {
+	if (!amldev->powered)
+		return 0;
+
+	amldev->powered = false;
 	gpiod_set_value_cansleep(amldev->bt_en_gpio, 0);
 
 	clk_disable_unprepare(amldev->lpo_clk);
@@ -568,7 +662,6 @@ static int aml_open(struct hci_uart *hu)
 
 static int aml_close(struct hci_uart *hu)
 {
-	struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
 	struct aml_data *aml_data = hu->priv;
 
 	skb_queue_purge(&aml_data->txq);
@@ -577,7 +670,13 @@ static int aml_close(struct hci_uart *hu)
 
 	hu->priv = NULL;
 
-	return aml_power_off(amldev);
+	/* The controller is left powered. Setup, which powers it on, only
+	 * runs once per registration, and dropping the enable line does not
+	 * reset it but leaves it unreachable until the combo chip is power
+	 * cycled, so powering off here would lose the controller on the next
+	 * open. It is powered off on remove and shutdown.
+	 */
+	return 0;
 }
 
 static int aml_flush(struct hci_uart *hu)
@@ -589,6 +688,55 @@ static int aml_flush(struct hci_uart *hu)
 	return 0;
 }
 
+/* Everything between powering the controller up and a usable HCI device */
+static int aml_setup_controller(struct hci_uart *hu, struct aml_serdev *amldev,
+				struct hci_dev *hdev)
+{
+	int err;
+	int i;
+
+	/* Try the fresh controller first: a ROM that has just been probed at
+	 * the wrong rate swallows the command that follows.
+	 */
+	err = aml_set_baudrate(hu, hu->proto->oper_speed);
+	if (err) {
+		msleep(AML_RESYNC_MS);
+
+		if (!aml_fw_already_running(hdev, hu))
+			return err;
+
+		bt_dev_info(hdev, "Controller is already running firmware");
+		return 0;
+	}
+
+	err = aml_download_firmware(hdev, amldev->firmware_name);
+	if (err)
+		return err;
+
+	err = aml_config_rf(hdev, amldev->aml_dev_data->is_coex);
+	if (err)
+		return err;
+
+	err = aml_start_chip(hdev);
+	if (err)
+		return err;
+
+	/* There is nothing to poll but the version command itself, and the
+	 * time to start varies: W1 takes up to half a second.
+	 */
+	msleep(AML_STARTUP_DELAY_MS);
+	for (i = 0; i < AML_STARTUP_RETRIES; i++) {
+		if (i)
+			msleep(AML_STARTUP_POLL_MS);
+
+		err = aml_dump_fw_version(hdev);
+		if (!err)
+			break;
+	}
+
+	return err;
+}
+
 static int aml_setup(struct hci_uart *hu)
 {
 	struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
@@ -613,26 +761,7 @@ static int aml_setup(struct hci_uart *hu)
 	if (err)
 		return err;
 
-	err = aml_set_baudrate(hu, amldev->serdev_hu.proto->oper_speed);
-	if (err)
-		return err;
-
-	err = aml_download_firmware(hdev, amldev->firmware_name);
-	if (err)
-		return err;
-
-	err = aml_config_rf(hdev, amldev->aml_dev_data->is_coex);
-	if (err)
-		return err;
-
-	err = aml_start_chip(hdev);
-	if (err)
-		return err;
-
-	/* Wait 60ms for controller startup */
-	msleep(60);
-
-	err = aml_dump_fw_version(hdev);
+	err = aml_setup_controller(hu, amldev, hdev);
 	if (err)
 		return err;
 
@@ -730,6 +859,7 @@ static void aml_serdev_remove(struct serdev_device *serdev)
 	struct aml_serdev *amldev = serdev_device_get_drvdata(serdev);
 
 	hci_uart_unregister_device(&amldev->serdev_hu);
+	aml_power_off(amldev);
 }
 
 static void aml_serdev_shutdown(struct serdev_device *serdev)
-- 
2.56.0

