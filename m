Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681662;
	b=Es2R8gdjBaa8jVnW54xRHG7ZcXjc0IfnczhWOY5FWKkHZRzlBPofZRI56Ao9u3Rqmqcn
	 07nNS+4sBVopAqIbv4DG5ov7g3+MKRpUeX5yS3qovw9CByD7VQEtzHdq9yyw+aS/MC1ef
	 kjnjpiyTo+iJPLLI0vW58gtYDrGFFDMMWhK7ba92vwkx5a2lSQ5trqkajQ2nzKeADkBsy
	 kYXuoFTme08mSu2ctfNHALTzmYUD76sXcsSZMnCgYxwjOSjGBp3BIk+1Bp5Cyrm6rFbtq
	 51EY2HVyeD5Tng8g9c47VQgvzkHDYGvr2HwzlsvYdsDh1gfIOUqP1OIANj1ljPIEoYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681662;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Message-ID:Subject:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Tcxp/JxXxNyBEDivUfIkOmF6MNmha+MdTEFSSv1CfnY=;
	b=WhD8Ht24J6V74aQps9RdtrJAbsUWxFT7SUN9wZUPYnL6KTRL6ZqEhPgBSp71BPQeab2C
	 q6nErV/KTq1Fpi35Wt34jN5T070OCz6P344b0T7/1BCweD8KiigdBFs5rAElwbdKyt24N
	 txVUUSAvBpbVFzmUwsaqVVnkp3BlDYF0F5EbaLUykTZqMt0CKF2FbD4F3U/vMwpId/Uos
	 Vo6j3QBFA00wzUgWCHXG6rpXGomjohJXOC18NKYkNRp23doqkCZdCPqb2KL4tCAWuhWL9
	 P0gcIOa5/ETcGn1Z5BdZgkae3AGE7ru+DUj9GqUVL9qO0sCmw/6KeECZIkJ0F0NsX6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=GxkNbuit;
	arc=none smtp.remote-ip=79.135.106.113
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3723606A33D;
	Sat, 14 Nov 2026 18:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3723606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=GxkNbuit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1794681659; x=1794940859;
	bh=Tcxp/JxXxNyBEDivUfIkOmF6MNmha+MdTEFSSv1CfnY=;
	h=From:To:Cc:Date:Message-ID:Subject:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GxkNbuitHjbcnJomAbg8SPEhaXsFrxqKqLxyo/1yn0K/Nu8G4PNpiCtHoov1cdi90
	 dzxAOJeK69fqakDTplJozEnLmfYNaZbclk/FaVvNT+jOcebAAC494qn+wLO7zhHWl0
	 ie73aaVcg14Bj9hJxOqXK2iFcYy2t7/RERYq83dy7/RPAgg4Bceln//6X/VUcxAeJP
	 QOtxCOEvgiZiLxCocew/LyAb0QDf/yP71KaYrkByX0yj4iw/03r0HyC63qWLFWsAiP
	 69WujoY5yyoZKeA9cY9E/jPbUd8JFvyryBLSL/CeN+QBOgleRnb61X6ikBUPS7z+su
	 jXwGn/zSDQhnA==
X-Pm-Submission-Id: 4jRjcn008hz1DFF0
From: Michael McAllister <me@michaelmcallister.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: brgl@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_bgodavar@quicinc.com, lumag@kernel.org, mka@chromium.org,
 me@michaelmcallister.org, markus.probst@posteo.de,
 shuai.zhang@oss.qualcomm.com
Date: Sat, 14 Nov 2026 18:39:54 -0000
Message-ID: <179468159400.2456.9911175648212863511.wcn3950-poweroff-v2-1@michaelmcallister.org>
Subject:
 [PATCH v2 1/4] Bluetooth: hci_serdev: Track whether the serial port is open
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

HCI_UART_PROTO_READY is cleared before protocol close during unregister,
even though the serial port stays open. QCA needs to distinguish that
case from a port left closed by a failed setup reopen before sending
its power-off pulse.

Track the port state in the transport and QCA open/close helpers. Keep
the existing PROTO_READY handling for setup failures and use the actual
open state when closing the port during unregister.

Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
 drivers/bluetooth/hci_qca.c    |  4 ++--
 drivers/bluetooth/hci_serdev.c | 34 ++++++++++++++++++++++++++++------
 drivers/bluetooth/hci_uart.h   |  3 +++
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index d693e2842..28e84fc24 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1762,14 +1762,14 @@ static void qca_port_close(struct hci_uart *hu)
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
index d2c48df34..3d10d8d75 100644
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
@@ -125,7 +148,7 @@ static int hci_uart_open(struct hci_dev *hdev)
 	 * BT OFF. Upon next BT ON UART port should be opened.
 	 */
 	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
-		err = serdev_device_open(hu->serdev);
+		err = hci_uart_serdev_open(hu);
 		if (err)
 			return err;
 		set_bit(HCI_UART_PROTO_READY, &hu->flags);
@@ -156,7 +179,7 @@ static int hci_uart_close(struct hci_dev *hdev)
 	 */
 	if (hci_test_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP)) {
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
-		serdev_device_close(hu->serdev);
+		hci_uart_serdev_close(hu);
 	}
 
 	return 0;
@@ -316,7 +339,7 @@ int hci_uart_register_device_priv(struct hci_uart *hu,
 	if (percpu_init_rwsem(&hu->proto_lock))
 		return -ENOMEM;
 
-	err = serdev_device_open(hu->serdev);
+	err = hci_uart_serdev_open(hu);
 	if (err)
 		goto err_rwsem;
 
@@ -387,7 +410,7 @@ int hci_uart_register_device_priv(struct hci_uart *hu,
 	clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 	p->close(hu);
 err_open:
-	serdev_device_close(hu->serdev);
+	hci_uart_serdev_close(hu);
 err_rwsem:
 	percpu_free_rwsem(&hu->proto_lock);
 	return err;
@@ -440,8 +463,7 @@ void hci_uart_unregister_device(struct hci_uart *hu)
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

