Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846398;
	b=z0JPl44bqVj6U4wu+MHUw+KvmzvwiPpXMM2CTNUWo3vryzJrf5p8hgSDJJLGLvPDupp5
	 +WyNmfaOO42bEgfOQWHc/UvaltyL+xBSdNqpyFlosd3FHRNwEwzAaFn37xK5AXMQtZ3Tn
	 iGDPJDeAFQhoQJvLu8aVBR+f7wEWpPtjMc+mcE0cbAbss4r2pKtswfGn0vs+Yxmht+k7S
	 phpPYCqEd+9Uj5tDG1epPbobjyVGh5CZ16Fy7MmonTTVdsEq4paUFI35SjsPkwMdDciON
	 hDxUdqY9Oo+Jx303MQLAynRwuhwDJDTS0thy9CoMv1mPb0souJXE08KKbPpsmzXq+/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846398;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Subject:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IKFLJN5aB3P9pUBCzlXCHDzNmJt0sIUsS/JvzDgQUc4=;
	b=BIvIAld012ldPPXM6npmQTYIx+f8xAHD/YeefiGnE3WTKRlmwgWPbWtnYp4qP7V5TNJO
	 wxEETU/o05Ia9bsRfmoIQUjZmuJEW8XEywWn5MvIIUgflg/j2yAHguZnWsMjD2o7uaW8q
	 q3ULLh5kFqBnmcGiUuSYHq6gp8rLWjn9rJVJLKWhzEzLc577f6zjgWlsluMJ70HqpVSPb
	 JaDsIPJc7wt6aPjTC7mxDTseNvHjtk0L74wLH/ZN2mpHyGeNSWiscOE6QwyXC68Jv2NwK
	 /dWGZxZzg2LxbaqRG+uTkbCP6YrK5gD/mrRoeHJOj7DtNbtfOZI0B3rg9jfVsP6dVtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=r6ET9iTB;
	arc=none smtp.remote-ip=185.70.43.172
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BA5606A890
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 16:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58BA5606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=r6ET9iTB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1794846395; x=1795105595;
	bh=IKFLJN5aB3P9pUBCzlXCHDzNmJt0sIUsS/JvzDgQUc4=;
	h=From:To:Cc:Date:Subject:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=r6ET9iTB33yuvE5VK1qK6eq4QiyNJSTubAuLzRbw4FQpEZbBmNXqYYfaXiLpjmlmc
	 dQPmmzNMV6Rg310G7AIX3hPtAENtVKe9GoeTOkO0zEPozt1RHuZwAG/LuV/6PiD4Vl
	 AXa+Ok8+5R3L4h447BtlUr9bJIe1Xe3nOBCZPmyTUTIR9NLAdGdLZoECgIoBxBe4ux
	 DwOS77jNuMTsPGVu9omLDjAXz4jjrVbeIGpGU3WfC+eJgJLATE4t6f514gTId/ZCSV
	 kXjIDjPzEHpoQzUICySIHmFRSAN1G5xl56o6+D8KdYtJlx/NBZ5vZgKwOA0G+gZXjb
	 LJe9PPQxjmFBg==
X-Pm-Submission-Id: 4jStXm33Fjz1DF5G
From: Michael McAllister <me@michaelmcallister.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: brgl@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_bgodavar@quicinc.com, lumag@kernel.org, mka@chromium.org,
 me@michaelmcallister.org, markus.probst@posteo.de,
 shuai.zhang@oss.qualcomm.com, enderaoelyther@gmail.com
Date: Mon, 16 Nov 2026 16:26:21 +0000
Subject:
 [PATCH v3 2/5] Bluetooth: hci_serdev: Track whether the serial port is open
Message-ID: <179484638195.54009.8903355214693287470.wcn3950-poweroff-v3-2@michaelmcallister.org>
In-Reply-To: <179484638195.54009.1916641645532262287.wcn3950-poweroff-v3-0@michaelmcallister.org>
References: <179484638195.54009.1916641645532262287.wcn3950-poweroff-v3-0@michaelmcallister.org>
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
index e0e969228..f86d417b8 100644
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
@@ -128,7 +151,7 @@ static int hci_uart_open(struct hci_dev *hdev)
 	 * BT OFF. Upon next BT ON UART port should be opened.
 	 */
 	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
-		err = serdev_device_open(hu->serdev);
+		err = hci_uart_serdev_open(hu);
 		if (err)
 			return err;
 		set_bit(HCI_UART_PROTO_READY, &hu->flags);
@@ -162,7 +185,7 @@ static int hci_uart_close(struct hci_dev *hdev)
 	 */
 	if (hci_test_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP)) {
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
-		serdev_device_close(hu->serdev);
+		hci_uart_serdev_close(hu);
 	}
 
 	return 0;
@@ -322,7 +345,7 @@ int hci_uart_register_device_priv(struct hci_uart *hu,
 	if (percpu_init_rwsem(&hu->proto_lock))
 		return -ENOMEM;
 
-	err = serdev_device_open(hu->serdev);
+	err = hci_uart_serdev_open(hu);
 	if (err)
 		goto err_rwsem;
 
@@ -393,7 +416,7 @@ int hci_uart_register_device_priv(struct hci_uart *hu,
 	clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 	p->close(hu);
 err_open:
-	serdev_device_close(hu->serdev);
+	hci_uart_serdev_close(hu);
 err_rwsem:
 	percpu_free_rwsem(&hu->proto_lock);
 	return err;
@@ -447,8 +470,7 @@ void hci_uart_unregister_device(struct hci_uart *hu)
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

