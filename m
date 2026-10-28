Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793227774;
	b=nF6sg/KeGugFAV8SdpJgyclKrtmo0+Af7vCMmGKtt8JCvMgaE/QO5SLptNx7aa7synNs
	 ECfp+Kh3WxTiomWVkNEZN+9nu/NvvlndaGRMK+IKaAs/Ysqny3bmksWXYGcmoFkareYxL
	 mpg+DVg1gPRb965Jodutlcm3+Xlx44eN1+oRY7ZWC6IZ0BO+T8proSv+11A8PJJWgS5oy
	 F6j1QRCom5VS0f5xmZXBf+osM3vwyKu6ejZEyjGupVoMboQLZLCsZErUj2oQItes9IuCn
	 biOrb4G0GgfbNWgd/87RNOITBFytLG/Qd/uHUr58F5AAqTHwXbmCo8TONmlbMSy2ooQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227774;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Subject:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7iu6cjXR9ZBzoa1YaErcPheysU7ICcfQOQ6bTr1XBVo=;
	b=XR2zWUTYD83j1tgKDNaijPNMFeCbrMxmGjQOmi/Fk/2oEIZsfMVylS2wXvWfoYCeVWKQ
	 gnaAnhRDP10Zatdl7iwnQhpfsQPpUsPU8T4VcFWA28DLx1Xqs6Yd/eAKJe2Voahy+S/oH
	 UFGYUAzaL5owc7fDXP8ReY6g3M4D6swWES/r8KbmQN/uFUsSpVtGgU/gk5sLG3gLxIZku
	 QCPncEPNCO+zSK4MkW21kgys3ycRsAq/u9HS7H2ywNPy4rgEM/I5C7KnDuPME6uSVsxTq
	 Ht4T4JUAhJgyTOkCgpVrVGMDiHJ0ZFjNsqQ+vSRClYebr9ZOcSZxYY0oYx6U/3TZ1rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=ajkkEMtg;
	arc=none smtp.remote-ip=109.224.244.108
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC75606A320
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 22:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCC75606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=ajkkEMtg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1793227771; x=1793486971;
	bh=7iu6cjXR9ZBzoa1YaErcPheysU7ICcfQOQ6bTr1XBVo=;
	h=From:To:Cc:Date:Subject:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ajkkEMtgRAvcaqdd5iWGP/jNUg+/4Tv3hUmF0EIovMuTaYas/IEZLkpzMAAi1Yxbt
	 IK9mSrmbMzICJAUSJeoUy2eL/jVl4xkeMSGdS8WeRoMsAdkia7/ypYra43ov/bnZOj
	 kod5eH5WSRvVZqhAW7enT8K4iYIC3K2mfLTeaGeoGamyRGnA3eaewEeTK/fGYMkSZu
	 +3gW/2oAsKPN+eHWW8UfG/8KsJOPPXiQ/HAHPKSvsdBu0dmmw7Pjvl1ggO8vUp52Eu
	 B4V8xXmp3MIkINDMzkK/N5xg5hPRwfjVEwlxeizXFQ8vMrsVqCl2v0E/VCo+CH2Z1h
	 qwKCHgh+YftGg==
X-Pm-Submission-Id: 4jFMxN3dZvz2ScNh
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
 [PATCH 2/4] Bluetooth: hci_serdev: Track whether the serial port is open
Message-ID: <179322687811.94538.11949086384142524062.wcn3950-poweroff-v1-2@michaelmcallister.org>
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

QCA setup temporarily closes the serial port while enabling the supplies.
If enabling the supplies or reopening the port fails, PROTO_READY stays
set. Error cleanup can then flush or close an already-closed port.

Track the open state separately from protocol readiness. Use the same
open and close helpers in the transport and the QCA and Marvell drivers,
so setup retries do not close the port twice. Skip the serial flush when
the port is closed, while still flushing the protocol queues.

Close the port during unregister according to its actual open state.

Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
 drivers/bluetooth/hci_mrvl.c   |  4 ++--
 drivers/bluetooth/hci_qca.c    | 12 +++++------
 drivers/bluetooth/hci_serdev.c | 37 +++++++++++++++++++++++++++-------
 drivers/bluetooth/hci_uart.h   |  3 +++
 4 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/bluetooth/hci_mrvl.c b/drivers/bluetooth/hci_mrvl.c
index 5798a8db0..38d9add89 100644
--- a/drivers/bluetooth/hci_mrvl.c
+++ b/drivers/bluetooth/hci_mrvl.c
@@ -76,7 +76,7 @@ static int mrvl_open(struct hci_uart *hu)
 	hu->priv = mrvl;
 
 	if (hu->serdev) {
-		ret = serdev_device_open(hu->serdev);
+		ret = hci_uart_serdev_open(hu);
 		if (ret)
 			goto err;
 	}
@@ -95,7 +95,7 @@ static int mrvl_close(struct hci_uart *hu)
 	BT_DBG("hu %p", hu);
 
 	if (hu->serdev)
-		serdev_device_close(hu->serdev);
+		hci_uart_serdev_close(hu);
 
 	skb_queue_purge(&mrvl->txq);
 	skb_queue_purge(&mrvl->rawq);
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 8705c4543..3d9e6cd15 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1755,8 +1755,8 @@ static int qca_port_reopen(struct hci_uart *hu)
 	 * Without this, we will have RTS and CTS synchronization
 	 * issues.
 	 */
-	serdev_device_close(hu->serdev);
-	ret = serdev_device_open(hu->serdev);
+	hci_uart_serdev_close(hu);
+	ret = hci_uart_serdev_open(hu);
 	if (ret) {
 		bt_dev_err(hu->hdev, "failed to open port");
 		return ret;
@@ -1780,12 +1780,12 @@ static int qca_regulator_init(struct hci_uart *hu)
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 
 	if (!qcadev->bt_power->vregs_on) {
-		serdev_device_close(hu->serdev);
+		hci_uart_serdev_close(hu);
 		ret = qca_regulator_enable(qcadev);
 		if (ret)
 			return ret;
 
-		ret = serdev_device_open(hu->serdev);
+		ret = hci_uart_serdev_open(hu);
 		if (ret) {
 			bt_dev_err(hu->hdev, "failed to open port");
 			return ret;
@@ -2061,8 +2061,8 @@ static int qca_setup(struct hci_uart *hu)
 		if (retries < MAX_INIT_RETRIES) {
 			bt_dev_warn(hdev, "Retry BT power ON:%d", retries);
 			if (hu->serdev) {
-				serdev_device_close(hu->serdev);
-				ret = serdev_device_open(hu->serdev);
+				hci_uart_serdev_close(hu);
+				ret = hci_uart_serdev_open(hu);
 				if (ret) {
 					bt_dev_err(hdev, "failed to open port");
 					return ret;
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 48ba017e2..05aa490a9 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -21,6 +21,29 @@
 
 #include "hci_uart.h"
 
+int hci_uart_serdev_open(struct hci_uart *hu)
+{
+	int err;
+
+	if (hu->serdev_open)
+		return 0;
+
+	err = serdev_device_open(hu->serdev);
+	if (!err)
+		hu->serdev_open = true;
+
+	return err;
+}
+
+void hci_uart_serdev_close(struct hci_uart *hu)
+{
+	if (!hu->serdev_open)
+		return;
+
+	hu->serdev_open = false;
+	serdev_device_close(hu->serdev);
+}
+
 static inline void hci_uart_tx_complete(struct hci_uart *hu, int pkt_type)
 {
 	struct hci_dev *hdev = hu->hdev;
@@ -102,7 +125,8 @@ static int hci_uart_flush(struct hci_dev *hdev)
 	}
 
 	/* Flush any pending characters in the driver and discipline. */
-	serdev_device_write_flush(hu->serdev);
+	if (hu->serdev_open)
+		serdev_device_write_flush(hu->serdev);
 
 	if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
 		hu->proto->flush(hu);
@@ -123,7 +147,7 @@ static int hci_uart_open(struct hci_dev *hdev)
 	 * BT OFF. Upon next BT ON UART port should be opened.
 	 */
 	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
-		err = serdev_device_open(hu->serdev);
+		err = hci_uart_serdev_open(hu);
 		if (err)
 			return err;
 		set_bit(HCI_UART_PROTO_READY, &hu->flags);
@@ -154,7 +178,7 @@ static int hci_uart_close(struct hci_dev *hdev)
 	 */
 	if (hci_test_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP)) {
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
-		serdev_device_close(hu->serdev);
+		hci_uart_serdev_close(hu);
 	}
 
 	return 0;
@@ -314,7 +338,7 @@ int hci_uart_register_device_priv(struct hci_uart *hu,
 	if (percpu_init_rwsem(&hu->proto_lock))
 		return -ENOMEM;
 
-	err = serdev_device_open(hu->serdev);
+	err = hci_uart_serdev_open(hu);
 	if (err)
 		goto err_rwsem;
 
@@ -385,7 +409,7 @@ int hci_uart_register_device_priv(struct hci_uart *hu,
 	clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 	p->close(hu);
 err_open:
-	serdev_device_close(hu->serdev);
+	hci_uart_serdev_close(hu);
 err_rwsem:
 	percpu_free_rwsem(&hu->proto_lock);
 	return err;
@@ -438,8 +462,7 @@ void hci_uart_unregister_device(struct hci_uart *hu)
 	 */
 	hu->proto->close(hu);
 
-	if (proto_ready)
-		serdev_device_close(hu->serdev);
+	hci_uart_serdev_close(hu);
 
 	hci_free_dev(hdev);
 
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 7fbe8dffa..2f8e346f3 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -66,6 +66,7 @@ struct hci_uart_proto {
 struct hci_uart {
 	struct tty_struct	*tty;
 	struct serdev_device	*serdev;
+	bool			serdev_open;
 	struct hci_dev		*hdev;
 	unsigned long		flags;
 	unsigned long		hdev_flags;
@@ -112,6 +113,8 @@ static inline int hci_uart_register_device(struct hci_uart *hu,
 }
 
 void hci_uart_unregister_device(struct hci_uart *hu);
+int hci_uart_serdev_open(struct hci_uart *hu);
+void hci_uart_serdev_close(struct hci_uart *hu);
 
 int hci_uart_tx_wakeup(struct hci_uart *hu);
 int hci_uart_wait_until_sent(struct hci_uart *hu);
