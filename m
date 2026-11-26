Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795719603;
	b=hD6P93XyPOEsofR75TgynNl+khI85DIW5/LlWM47XZVu22sX9iTSwpOKoyFmS/7OeK64
	 mB53JGJ8rRPOZlP2IbSDMLVNbm2M4bK/BRYS/A09mrgDj8Y8MX+HQwUvUz2uzQjFzoPaA
	 CaI/z6Q36WUN0uSFMSVa72Pq+9MYFAdNycFQ9vW6ov/0G8EPNGSxZBALuo59NzYVPHeMq
	 sOBt/c1ZnDTPYGtfRacrOE2+2SJVnwag9vjyjRJb3dO3JMkyfwYz3MBGrhCOcDDH6L+u2
	 wGlVt9i2L8Sc4FxKdbQrimUBBQd8uCWx/h+tIQglIOGGKVIomfIFSXHC2tTzDWDZO5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795719603;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Subject:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2b6K6pvLLOQHdHQFNsRUOJnyQczbFVIGhymNPlQlyy8=;
	b=ZZH/99POAaXrM6bHWhN36ZLz0MKgAdtF6PtL4weVPEd64JvSjRJxOqk14c37b7X1imfY
	 It/1J8MpkhJurFk2t17AnTxyH4tq6QJYE9pnD3+ErvRI/5br3uNq3MQQ7yrXuf/Jh4eMD
	 Hopzqa0ktG0g4EAM9RORW/YRj/U6/lewO3S7zkb7s0LR9IeLoQxb3M6BENWksjA5s2A8w
	 9NvQezLrykJMiiXCh9H1P4L6+EwUYBKBfNoxyNAuENJftaXJJnJb6+eaWYiMNW1EEeiOf
	 qupB0QCRSNyaTCXXaGRED+WiF2Xa6fGrEPqBcbNLrhNsmRd73DLY1wNBHOlhtKFbAuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=KLR9WuaB;
	arc=none smtp.remote-ip=185.70.43.172
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BE8606A33C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 19:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33BE8606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=KLR9WuaB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1795719601; x=1795978801;
	bh=2b6K6pvLLOQHdHQFNsRUOJnyQczbFVIGhymNPlQlyy8=;
	h=From:To:Cc:Date:Subject:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=KLR9WuaBY7rtxnEXoOKqHWVBvL98XZIlP2lmfS7HIneGsUra70O8tiU5T5Mcf0w0Y
	 Qnx7RE0HA8on5KnslIrxi4zX+17MyGethw92BbwTo44RIHm42jAlKuV4GZV7xK7p3k
	 JiGDGOD8+7GsaA0LhaNKP4WI6KpwLoMyD/29JgzAx0sRT6vCeu1Dti4LNyGF93806X
	 1LgFenb94PiaIuLiii3Xc3Od3ZdiD9c1pUQfQQ6Tbwc2NcxtDiPfD0IG8X3P2BAVRn
	 +TF5F5rXvH31YEGOCFbaU1T4PW37HAsLzUevRqCrJxUv8mwt0foIc6FAbILbKTUhIG
	 msH3NJyxviTug==
X-Pm-Submission-Id: 4jb5TB3wPsz2ScWs
From: Michael McAllister <me@michaelmcallister.org>
To: marcel@holtmann.org, luiz.dentz@gmail.com
Cc: brgl@kernel.org, enderaoelyther@gmail.com, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 lumag@kernel.org, markus.probst@posteo.de, mka@chromium.org,
 phone-devel@vger.kernel.org, quic_bgodavar@quicinc.com,
 shuai.zhang@oss.qualcomm.com, zhaojinming@uniontech.com,
 me@michaelmcallister.org
Date: Thu, 26 Nov 2026 18:59:41 +0000
Subject:
 [PATCH v4 1/4] Bluetooth: hci_serdev: Track whether the serial port is open
Message-ID: <179571958165.81221.3058707179497995247.wcn3950-poweroff-v4-1@michaelmcallister.org>
In-Reply-To: <179571958163.81221.3368253997777320112.wcn3950-poweroff-v4-0@michaelmcallister.org>
References: <179484638195.54009.1916641645532262287.wcn3950-poweroff-v3-0@michaelmcallister.org>
 <hvwqozj3r7n7igxw5qogu7xxya4fkhqanb334sroj37ufzdizu@qarvtlkkulmj> <179571958163.81221.3368253997777320112.wcn3950-poweroff-v4-0@michaelmcallister.org>
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

HCI_UART_PROTO_READY is cleared before protocol close during unregister,
even though the serial port stays open. QCA needs to distinguish that
case from a port left closed by a failed setup reopen before sending
its power-off pulse.

Track the port state in the transport and QCA open/close helpers. Keep
the existing PROTO_READY handling for setup failures and use the actual
open state when flushing or closing the port during unregister.

Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
 drivers/bluetooth/hci_qca.c    |  4 ++--
 drivers/bluetooth/hci_serdev.c | 36 +++++++++++++++++++++++++++-------
 drivers/bluetooth/hci_uart.h   |  3 +++
 3 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index d51db761f..0f893f16a 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1758,14 +1758,14 @@ static void qca_port_close(struct hci_uart *hu)
 	 * hci_uart_close() or hci_uart_unregister_device().
 	 */
 	if (test_and_clear_bit(HCI_UART_PROTO_READY, &hu->flags))
-		serdev_device_close(hu->serdev);
+		hci_uart_serdev_close(hu);
 }
 
 static int qca_port_open(struct hci_uart *hu)
 {
 	int ret;
 
-	ret = serdev_device_open(hu->serdev);
+	ret = hci_uart_serdev_open(hu);
 	if (!ret)
 		set_bit(HCI_UART_PROTO_READY, &hu->flags);
 
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index dfa921afc..d4b8c3b61 100644
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
@@ -145,7 +168,7 @@ static int hci_uart_open(struct hci_dev *hdev)
 	 * BT OFF. Upon next BT ON UART port should be opened.
 	 */
 	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
-		err = serdev_device_open(hu->serdev);
+		err = hci_uart_serdev_open(hu);
 		if (err)
 			return err;
 		set_bit(HCI_UART_PROTO_READY, &hu->flags);
@@ -187,7 +210,7 @@ static int hci_uart_close(struct hci_dev *hdev)
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 		percpu_up_write(&hu->proto_lock);
 
-		serdev_device_close(hu->serdev);
+		hci_uart_serdev_close(hu);
 
 		clear_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
 		enable_work(&hu->write_work);
@@ -351,7 +374,7 @@ int hci_uart_register_device_priv(struct hci_uart *hu,
 	if (percpu_init_rwsem(&hu->proto_lock))
 		return -ENOMEM;
 
-	err = serdev_device_open(hu->serdev);
+	err = hci_uart_serdev_open(hu);
 	if (err)
 		goto err_rwsem;
 
@@ -422,7 +445,7 @@ int hci_uart_register_device_priv(struct hci_uart *hu,
 	clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 	p->close(hu);
 err_open:
-	serdev_device_close(hu->serdev);
+	hci_uart_serdev_close(hu);
 err_rwsem:
 	percpu_free_rwsem(&hu->proto_lock);
 	return err;
@@ -470,7 +493,7 @@ void hci_uart_unregister_device(struct hci_uart *hu)
 		hu->tx_skb = NULL;
 	}
 
-	if (proto_ready)
+	if (hu->serdev_open)
 		serdev_device_write_flush(hu->serdev);
 
 	/* Close the protocol before freeing hdev (intrinsically purges queues).
@@ -479,8 +502,7 @@ void hci_uart_unregister_device(struct hci_uart *hu)
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
-- 
2.39.5

