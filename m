Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681664;
	b=jxy1jDSeB+pRXHZbSSRKND7fTZ1kScPjbpCSz8NWI4i9Zuf/bHTLnqqkQx9MkRw3QoPT
	 WLkj3M6PS4IlBEsVwJZf9omg6ClPlrF9FK5XfTVNEJ11s6VIpVZBRSgpMx0VPVAl6Zqy5
	 38D8VbeOLJC8PG5I/pvGB9Fr56zAE8VOUFgDItiuSGJSOuiGAyj3hskGZrusbYg7Z6zyV
	 CozU3buoCTFK3A8c5xHmyUMffTtvEkioeuV79X4zCgtEo3bxdr4RXViHv1e2KRGG2yf1O
	 lLy2SyVuDLwyaDrbHWlAKd3qA28Gi1Hskei2CR9f8+qxrAjL1cCQmeK7+uVdZoLnd7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681664;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Message-ID:Subject:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dBssvc2k5xvOVZhwu2hvYvi1LDAvGX5GMKooO6dq4k8=;
	b=clF3sJ73zkR5CEUiI/QXDBcH3p4xYzcmmftBAOQspZWUOGN01o++Xk259P8+a5WcydS9
	 HW1tleH2SH87yyousN/DwLyt+dT9zIeQR0GsPyt+YzFwfAjCCphAQ6ZOyQOQRDwViCzi1
	 dSROE1Cjfw3x4oyRYWf4gi453yR50hEJcao2EeESnD87tj5ivc89pKNnYKvyk12CW9LOP
	 D/1J6kEIWbB9RCMdEbYHdDCrCnNua4uADcozXcvJQrZtGXPRi+UFHLKNhE+UwU/0U1DZB
	 +53kn9HQIetAowtbnihUsSMvEfi5xGoDpdkOK2uvuDos52803+/gFRhyDRbSmQRsXIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=z7sEzNEX;
	arc=none smtp.remote-ip=185.70.43.170
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A964606A8A2
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 18:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A964606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=z7sEzNEX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1794681661; x=1794940861;
	bh=dBssvc2k5xvOVZhwu2hvYvi1LDAvGX5GMKooO6dq4k8=;
	h=From:To:Cc:Date:Message-ID:Subject:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=z7sEzNEXt9BEqnZq787BqqlphVlmUkjHdEy6CpsGYLztCH2NpmQPN0bNGAZKmCeRl
	 6iKsLymznhDgxG3KA5q1duOQx7giP7NAZ7H91JW38Og7QZjemkCxH6pAkm8XguZh/C
	 hfLx3MXypXUIr28qNNch2/ye7d9EdyR3ccFY0hPkbJr+aMrlwgvc9s0eHzKEbw93G1
	 UdIrw1EAm+Jr1lmombTX5YqyXnWMC/h+T90lPZ0nSSTzpFvBLGb/pE3N+d1ZPkCtBy
	 9+qyevZ3Ufib8mctF9wqAv7WPDn0tHYxdBgFTwqskh/BS5s9q4N8kL4fOK6sKL+PEW
	 JlC55ns9mWHsg==
X-Pm-Submission-Id: 4jRjcp3nwMz1DF4s
From: Michael McAllister <me@michaelmcallister.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: brgl@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_bgodavar@quicinc.com, lumag@kernel.org, mka@chromium.org,
 me@michaelmcallister.org, markus.probst@posteo.de,
 shuai.zhang@oss.qualcomm.com
Date: Sat, 14 Nov 2026 18:39:54 -0000
Message-ID: <179468159400.2456.12381703314197227930.wcn3950-poweroff-v2-2@michaelmcallister.org>
Subject:
 [PATCH v2 2/4] Bluetooth: qca: Power off after unregistering the HCI device
In-Reply-To: <179468159400.2456.8302096233933976388.wcn3950-poweroff-v2-0@michaelmcallister.org>
References: <179322687810.94538.4628148055419456389.wcn3950-poweroff-v1-0@michaelmcallister.org>
 <179468159400.2456.8302096233933976388.wcn3950-poweroff-v2-0@michaelmcallister.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

qca_serdev_remove() powers off while HCI setup and UART writes can still
be running. Leave power-off to qca_close(), after HCI unregistration and
write-work cancellation, while the serial transport is still available.

Check the actual port state before sending the power-off pulse, since
PROTO_READY is already clear during protocol cleanup. Start serdev
controllers in QCA_BT_OFF so registration failure does not send a pulse
before HCI allocation or power-on.

Drain HCI setup before clearing protocol readiness, so a setup reopen
cannot re-enable UART write work after cancellation. Leave HCI flush
and close callbacks to the transport teardown during unregister; the
port stays open until protocol close has sent the power-off pulse.

Flush controller TX after stopping UART work, before protocol and port
close, so previously accepted bytes are discarded rather than drained.

Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
 drivers/bluetooth/hci_qca.c    | 24 ++----------------------
 drivers/bluetooth/hci_serdev.c | 18 ++++++++++++++----
 2 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 28e84fc24..ddbeb0787 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -620,6 +620,7 @@ static int qca_open(struct hci_uart *hu)
 	hu->priv = qca;
 
 	if (hu->serdev) {
+		set_bit(QCA_BT_OFF, &qca->flags);
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 
 		switch (qcadev->btsoc_type) {
@@ -2285,11 +2286,7 @@ static void qca_power_off(struct hci_uart *hu)
 	case QCA_WCN3990:
 	case QCA_WCN3991:
 	case QCA_WCN3998:
-		/* Both of these write to the serial port which may have
-		 * already been closed by hci_uart_close(), which closes
-		 * the port if HCI_QUIRK_NON_PERSISTENT_SETUP is set.
-		 */
-		if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+		if (hu->serdev_open) {
 			host_set_baudrate(hu, 2400);
 			qca_send_power_pulse(hu, false);
 		}
@@ -2618,23 +2615,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 static void qca_serdev_remove(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
-	struct qca_power *power = qcadev->bt_power;
-
-	switch (qcadev->btsoc_type) {
-	case QCA_WCN3988:
-	case QCA_WCN3990:
-	case QCA_WCN3991:
-	case QCA_WCN3998:
-	case QCA_WCN6750:
-	case QCA_QCA2066:
-	case QCA_WCN6855:
-	case QCA_WCN7850:
-		if (power->vregs_on)
-			qca_power_off(&qcadev->serdev_hu);
-		break;
-	default:
-		break;
-	}
 
 	hci_uart_unregister_device(&qcadev->serdev_hu);
 }
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 3d10d8d75..e279a7d61 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -120,6 +120,9 @@ static int hci_uart_flush(struct hci_dev *hdev)
 
 	BT_DBG("hdev %p serdev %p", hdev, hu->serdev);
 
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return 0;
+
 	if (hu->tx_skb) {
 		kfree_skb(hu->tx_skb); hu->tx_skb = NULL;
 	}
@@ -167,6 +170,9 @@ static int hci_uart_close(struct hci_dev *hdev)
 
 	BT_DBG("hdev %p", hdev);
 
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return 0;
+
 	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
 		return 0;
 
@@ -425,6 +431,10 @@ void hci_uart_unregister_device(struct hci_uart *hu)
 	/* Wait for init_ready to finish to prevent registration races */
 	cancel_work_sync(&hu->init_ready);
 
+	/* Drain HCI setup before clearing protocol readiness. */
+	if (test_bit(HCI_UART_REGISTERED, &hu->flags))
+		hci_unregister_dev(hdev);
+
 	proto_ready = test_bit(HCI_UART_PROTO_READY, &hu->flags);
 	if (proto_ready) {
 		/* Clear HCI_UART_PROTO_READY under the write lock so a
@@ -446,16 +456,16 @@ void hci_uart_unregister_device(struct hci_uart *hu)
 	cancel_work_sync(&hu->write_work);
 
 	/* Free any partially transmitted frame left over by write_work now
-	 * that the transmit path is fully quiesced. hci_uart_close() would
-	 * skip hci_uart_flush() because HCI_UART_PROTO_READY is cleared.
+	 * that the transmit path is fully quiesced. The HCI close and flush
+	 * callbacks leave transport teardown to us during unregister.
 	 */
 	if (hu->tx_skb) {
 		kfree_skb(hu->tx_skb);
 		hu->tx_skb = NULL;
 	}
 
-	if (test_bit(HCI_UART_REGISTERED, &hu->flags))
-		hci_unregister_dev(hdev);
+	if (hu->serdev_open)
+		serdev_device_write_flush(hu->serdev);
 
 	/* Close the protocol before freeing hdev (intrinsically purges queues).
 	 * Some protocol close handlers (e.g. qca_close) may still access the
-- 
2.39.5

