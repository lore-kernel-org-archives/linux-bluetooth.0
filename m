Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA374377545;
	Mon, 10 Aug 2026 07:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786345769; cv=none; b=ump+q9g3v8mLtNuZEmJxqyqdoi7p2gJ/Uix5rsCYTpZ6KFORkOoW1oX3n+VmKl8SmCIBvidRxrqnqxkjM4HmXLc+7WhCqtWUM/9A776WP0z3PHF8VJA8Dclz70qNnCiKgrhW8ebm8xttMgtgMiBNHK9x9RmR/ah5t5M/3YKRDcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786345769; c=relaxed/simple;
	bh=P5vFtYVPsjmocOMmCEGnPdPqqUzSZUUVkbcnkwzcuk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJ+wZTPNtSr7swW1xgqqlgsXj9y4atzmhH9zjll1vIVpzhlG8DyM6esXw3T1DAXBPg5quN4jMKxrjSbDEx1CNJHw0ks1xUEf0hLn3EKcZbK+UskOZBd/FvKtr31lPVzgkGV/l+g2qW2aoJkHDvKKtiko7pNspaOwIH4wLv3sJ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=j56gSqF4; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="j56gSqF4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786345743;
	bh=UYRluZzxGaSjOirVB2ast2VDDRh/iHi+PYJTiCs1VIM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=j56gSqF4Gy9TmE6zG6batu98Wx5VO16BrAmF6sNpMl3cz8mpc4gvATNufsJc6mrMW
	 A+5gdGfZAe+Ca7/FCKOcPL7RKEZsa/Nay7I41KNKtc8BOkWWTz6dPBT/qIJKpW1E8T
	 qtkXRO2Nr1yyklctubKa8NbN/9JT3QRyE+1iOLg4=
X-QQ-mid: esmtpgz12t1786345738taa639d42
X-QQ-Originating-IP: eDEhmzxroT9+iZopgTA2ATmCWNhgBbNSSoXU14uEenY=
Received: from PEN002676 ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 10 Aug 2026 15:08:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9524870747045469990
EX-QQ-RecipientCnt: 5
From: ZhaoJinming <zhaojinming@uniontech.com>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	zhaojinming@uniontech.com
Subject: [PATCH v2] Bluetooth: hci_serdev: Fix use-after-free in hci_uart_unregister_device()
Date: Mon, 10 Aug 2026 15:08:45 +0800
Message-ID: <D747A53C08BD2456+20260810-bluetooth-hci-serdev-uart-unregister-v2-1-690493a6ab95@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CABBYNZ+mwb4z_x-jwdJVftSLDGa3x_v6ghgUd2uND87q8fP1rg@mail.gmail.com>
References: <CABBYNZ+mwb4z_x-jwdJVftSLDGa3x_v6ghgUd2uND87q8fP1rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260810-bluetooth-hci-serdev-uart-unregister-ce37ebb29283
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OFOeSPWxxouH9aIZtTsKp8hLAXa3OkKH9iivzet75R+zt+0gY6vW8T5V
	8FTn8P1nGrXw3qJz5jgblziCLL8YKIjrjE6Wr6Y8xSUH/76T/wiT5uKhPNRauUjb2VCkgBE
	c97B1rBbhakSYavarhqaPHHyvkZNcNkZ263lQ/ljaCimkJ2O6UGVqLS9UyA0w2wwzfsrSxP
	X92T5GJ5ssKssgOK1Oc6WwfORjQtGC3ScoLSQZ5s+UAt0ZXm1WRIgKaIisnTEKr5PJBBstg
	/Lwrs6BIDWpVl2ZvKoZjxULCflatV/2ZjPxJchCSo4cJmPupwx2uYz3d8I1aOdPOzfvK47i
	WeAs1KPlXdhbb8OZPXj1cbbundUhNVH1k/C0d+yWTYsADkMpZO+gbF9F72Z6v/nJXEqIZkQ
	T0yy/XVdv7AgNuvnbL3YYYsl7PTaAvnPXEJFtWEsFBaC7uEgwKYjmXIVt2bbmwYKSCZuQA8
	EQp0eDvWUaktGOZrelZ0qRBJUqplukeGO39MRUqo08vGCSsG9vU5AB6sFFgRkW5SEyS9RfY
	ASx0EvyEw2GyiDIZuHlRpVwDn+jI55bS4Q0QWs2YvziHwwFKBEPgjAxOHWnOiFIh2Zuv2T2
	dtrZk1LjmZWy9J4AFdrP8F1nSyjW1ddO3xPJPDtaqpHcT8GtVFV4IX5fbiRYZHAlkPymNaY
	ZlABkZbSyp+0h6Pvc0SxNA3+dzHpArJXEwzjqiPYhLhEVv2BAnzoFYfS/vNI8bhBC91ui35
	oDY6lrmk2UzT2+PfjUuc6ulMsEE7doUoU3eH/xh0sfNFihwvqX3vFVFC2h2Bc0MVnK1fhAF
	ta3yVrx2S+RFnnzvQKm+xHEqaZxEq0C/NTJgc/J45cP0JTBrgFHT4NRIjGdXi/+uTIEqJiz
	4xv3rucdHbS1nVm1YbQX8vzgQw2Ymhm0ip4sHZv+cN69JvjL2F3/Bdzt6qb5zOA2UaNbSXS
	P159ckkx9q5Y4Mlw7xXDrkKdPqPJrTgLeRU5X91HNlEAzkD6B0OcemvI+Zq/eJ7TPZnL0TF
	ffzugR4b5CCv5tuO+x
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

hci_uart_unregister_device() frees the HCI device (hci_free_dev)
before cancelling write_work via cancel_work_sync(). If write_work
is executing concurrently on another CPU, it can access hu->hdev
and write to hdev->stat after the memory has been freed.

Additionally, HCI_UART_PROTO_READY is not cleared until after
cancel_work_sync, so the write_wakeup serdev callback can still
schedule write_work via hci_uart_tx_wakeup() even after
hci_free_dev has freed the device.

Fix this by mirroring the same ordering used in the tty/ldisc path
(hci_uart_tty_close, hci_ldisc.c:565-593):
1. Save the PROTO_READY state and clear it under the write lock so
   a concurrent hci_uart_tx_wakeup() cannot re-schedule write_work
2. Cancel write_work (no new work can be scheduled and no work is
   in flight)
3. Unregister the HCI device
4. Close the protocol (may access hu->hdev and the serdev device)
5. Close the serdev port (safe now that write_work is quiesced and
   protocol is done)
6. Free the HCI device

Also free any partially transmitted frame (hu->tx_skb) left over by
write_work once the transmit path is quiesced, since hci_uart_close()
would skip hci_uart_flush() because HCI_UART_PROTO_READY is cleared.

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
Fix a use-after-free in hci_uart_unregister_device() where the HCI
device could be freed (hci_free_dev) before write_work was cancelled,
allowing a concurrently running write_work to access hu->hdev after
the memory had been freed.

The teardown sequence is reordered to mirror the tty/ldisc path
(hci_uart_tty_close) and to account for the serdev-specific teardown:
the serdev port is closed only after write_work and the protocol are
fully torn down, and any partially transmitted frame is freed once the
transmit path is quiesced.

Changes in v2:
- Clear HCI_UART_PROTO_READY under percpu_down_write() to prevent a
  concurrent hci_uart_tx_wakeup() from re-scheduling write_work via
  the write_wakeup callback once the device is torn down.
- Cancel write_work before closing the serdev device to avoid a
  use-after-free in the serdev/TTY backend.
- Close the serdev device after the protocol close, since some protocol
  close handlers (e.g. qca_close) still access the serdev device.
- Free any partially transmitted frame (hu->tx_skb) after write_work is
  quiesced.
---
 drivers/bluetooth/hci_serdev.c | 46 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 593d9cefbbf925b4d3f8d37a12420a99e08a9477..13346c205591056eaca6e4f0dae53db398064230 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -395,20 +395,54 @@ EXPORT_SYMBOL_GPL(hci_uart_register_device_priv);
 void hci_uart_unregister_device(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
+	bool proto_ready;
 
+	/* Wait for init_ready to finish to prevent registration races */
 	cancel_work_sync(&hu->init_ready);
-	if (test_bit(HCI_UART_REGISTERED, &hu->flags))
-		hci_unregister_dev(hdev);
-	hci_free_dev(hdev);
 
+	proto_ready = test_bit(HCI_UART_PROTO_READY, &hu->flags);
+	if (proto_ready) {
+		/* Clear HCI_UART_PROTO_READY under the write lock so a
+		 * concurrent hci_uart_tx_wakeup() cannot re-schedule
+		 * write_work via the write_wakeup callback once the device
+		 * is torn down.
+		 */
+		percpu_down_write(&hu->proto_lock);
+		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
+		percpu_up_write(&hu->proto_lock);
+	}
+
+	/* Unconditionally cancel write_work AFTER clearing PROTO_READY.
+	 * This ensures that concurrent protocol timers cannot requeue
+	 * write_work, permanently preventing double-free races and UAFs,
+	 * and guarantees no write_work is in flight before the serdev
+	 * device is closed.
+	 */
 	cancel_work_sync(&hu->write_work);
 
+	/* Free any partially transmitted frame left over by write_work now
+	 * that the transmit path is fully quiesced. hci_uart_close() would
+	 * skip hci_uart_flush() because HCI_UART_PROTO_READY is cleared.
+	 */
+	if (hu->tx_skb) {
+		kfree_skb(hu->tx_skb);
+		hu->tx_skb = NULL;
+	}
+
+	if (test_bit(HCI_UART_REGISTERED, &hu->flags))
+		hci_unregister_dev(hdev);
+
+	/* Close the protocol before freeing hdev (intrinsically purges queues).
+	 * Some protocol close handlers (e.g. qca_close) may still access the
+	 * serdev device, so keep the serdev port open until this completes.
+	 */
 	hu->proto->close(hu);
 
-	if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
-		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
+	if (proto_ready)
 		serdev_device_close(hu->serdev);
-	}
+
+	hci_free_dev(hdev);
+
 	percpu_free_rwsem(&hu->proto_lock);
 }
 EXPORT_SYMBOL_GPL(hci_uart_unregister_device);

---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260810-bluetooth-hci-serdev-uart-unregister-ce37ebb29283

Best regards,
-- 
ZhaoJinming <zhaojinming@uniontech.com>
