Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793227775;
	b=WS94COts3t9vZvDSv0j/9BlDhP/YvE5fiDNS+3tdKQGBtjmJJGsZq+YZGyRRkcNeLZN5
	 t2mDLYewig7hWKaQk9MXwELi5Y5d7pyW5atpCOhC2+pXOraCUQnnepr8waYcK8OUGM08U
	 FSV4IKww/FYbvPKz5CceK8h1EJOUX4tC6xinXdQQNX8YHplPryC1uSgyn61Pbbp13/L/0
	 56ZpOZk4ZYENG8W1nUPY9X+PPMwJ+3id0fcBYjcw6b+AKo++JqZlCKsoqNkEgeay+WAEg
	 QtnvwFr6X8dyZxQyFG2MeWahdr7GWy1BakQc5w8JAIfoS63hb8pjmYoyWRUYmqARMeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227775;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Subject:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ijEYCo7Cfg1QIcJ15F3bQEjTdW4e58wFOipZzpiQnhU=;
	b=5mKy/duO71IuD3i3GNncA08rLYdmiRdBMq+4jFbnvOu9qD4Cu8wPAymCyDJpgkSIFzzT
	 h8KhQAQMpRTy14FZVaSQlqOEuyCOvOAz/sgkcsaf3F69ohRexwOJ8FrwNL56QjFFZcn5z
	 2+/uBBcxnHaWY+yZJx3RetoRQh/HcSrdhkzXyhhk6wwDbmOAnrZ9zcHkLiKitLw8K4wrI
	 xnlCVf4qUIW6rLoNPuG9/4LgVt9LTX8x1bvcdu6Nr7gLbSNxrwTcpu7ZJc8IdCvE9V9iL
	 MaFvswSmuDnLbdaMqP6cbKShvRDpSmiFTYiKD2MsfUPDkgPKS+hJIjxWWQMx6y8LZ1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=qIcsNJ5K;
	arc=none smtp.remote-ip=109.224.244.108
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D30606A32C;
	Wed, 28 Oct 2026 22:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52D30606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=qIcsNJ5K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1793227772; x=1793486972;
	bh=ijEYCo7Cfg1QIcJ15F3bQEjTdW4e58wFOipZzpiQnhU=;
	h=From:To:Cc:Date:Subject:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=qIcsNJ5K5zNGjPHTVQrEe+Ekwj2+pRChW3jADwYGWpxzahDGfL7CwIV+azUk0/bWH
	 7pG5X+tu8aHu2p+uSoviC6BOcFU7yVI2PWXGT6eyzW+moNJNnSSLEDqJErexkQ/FUZ
	 IawqJSU1tBzpNYM/FBQXwHfXuHpt0NlNqYrYVGUkIdfpdGX0nIkSpj+VrU73BfVMaN
	 iMKq6WemDki27BSFiIDOr+Biix/5ReLusHFrIU9mB4HeMWLJ6w5s47IC9BeccY/Efn
	 VGnew8QrpScQlbvF3Y3TXktR78bhFY0T0JqCwK52irjOYvm18rvosPsv2ZaZ1sk+6h
	 4/3Vhn/0xZ9UQ==
X-Pm-Submission-Id: 4jFMxQ3th6z2Scn5
From: Michael McAllister <me@michaelmcallister.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-bluetooth@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
 Michael McAllister <me@michaelmcallister.org>
Date: Wed, 28 Oct 2026 22:34:38 +0000
Subject:
 [PATCH 3/4] Bluetooth: qca: Power off after unregistering the HCI device
Message-ID: <179322687811.94538.1081834386001081992.wcn3950-poweroff-v1-3@michaelmcallister.org>
In-Reply-To: <179322687810.94538.4628148055419456389.wcn3950-poweroff-v1-0@michaelmcallister.org>
References: <179322687810.94538.4628148055419456389.wcn3950-poweroff-v1-0@michaelmcallister.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

qca_serdev_remove() powers off the controller while HCI setup and
transmission can still be running. Leave power-off to qca_close(), which
runs after HCI unregistration and write-work cancellation, while the
serial transport is still available.

Use the serial port's open state for the power-pulse check. PROTO_READY
is already clear during protocol cleanup, even when the port is open.
The open-state check also skips serial I/O after a failed setup reopen.

Mark a newly allocated serdev controller as off until power-on is tried,
so registration failures do not send a power pulse before HCI allocation.

Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
 drivers/bluetooth/hci_qca.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 3d9e6cd15..3d688ab75 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -619,6 +619,7 @@ static int qca_open(struct hci_uart *hu)
 	hu->priv = qca;
 
 	if (hu->serdev) {
+		set_bit(QCA_BT_OFF, &qca->flags);
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 
 		switch (qcadev->btsoc_type) {
@@ -2252,11 +2253,7 @@ static void qca_power_off(struct hci_uart *hu)
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
@@ -2580,22 +2577,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
