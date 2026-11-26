Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661110;
	b=Bv8GTtwz6exbpSqM28JIpf7S+qp1nIVNCwxXHTyJIL90ib+OUy6Iuu9ppVGlv0QVl1n+
	 3w83pp4CyOTCgta6a8y6J2VjMORJhgM+9MTDmY1lLCyK0llMVT8NGokwlaYlB3KtahVGC
	 p30vaDrK1xY/9eXHU1ytrPTbyoxToZ3ZU0SmubgtZa7wP2h8P8ffYZ/vePP/xjkPOwPyx
	 7XTmqFSIYdDeWLrGTWTNgk7h5J6ClJ84mQnaAGEmqBExmkxTRhkSBBEES7t6hqXMKMT/n
	 CksMEoj1i8SXla0f13YFPZgY3kpPAYSoS3TWI5IKG2q0yw5QJkJo3yHQscBRNaTKBXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=/0xg9WnJ4xA4j3RnhckkeXOmdyeehSClwBqizSGK2+E=;
	b=tSD8Qbvr6MjVvEEMq4FUhhqnqgVYiuzYsHZh7aZ5MfCksGNXMRgAr2/tCWUuzVcd4Fjj
	 snW7tzkJxX+l9imCc1LAD6THtStDsBtttNssgBf9lPsuaN6AUd9qUVfiSsTVTw/r8UZ6g
	 NTCs2MQp/XbIBlCO9iulQ/anCKx4KhdPhrz6gkEHpIhONvZZrJG789KLj3kGJepcD83hj
	 fkdP7lCX65M/3n/feQRO5oP+t45+BnZNDneXr8B4x22SsD8IBUQyyS8O50JAgEkn3W/6O
	 50jIe+npbZlN7XNfMr2+vSvSpXfskBfLlxNR1JdEKhGIicY+yHmN6o6Sd3FCodG1xqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=YSZyFojK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FA1606A32C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41FA1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=YSZyFojK
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67dae7d3f7dso7753225d50.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 18:45:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661109; cv=none;
        d=google.com; s=arc-20260327;
        b=qkqzfxtUqiMTTFUxjUMOPqcsNTsgAQtPlEf4ZkVv37VQrIa7UPmGuHcSI147vspkzK
         Vji6NIWsuWpBz1nuObR6vDD9JryKsTT7Oe99j6QasZJ3Opbxc04ZGn5+3A1V3Sf+RQf/
         BqJbBRJS6Z7mEs5YRZUPy97bBRZNw/+nv40d22cOvs+l70QiFSoP5eDWk2aOyykydSJi
         l/Jy5i5mythsi/gyCjoMMfWLDqkRq9ZepmIQUhBjhPH/Y2WEw4hoGPoQ7fcfDBLQQPD0
         1ttqH/aXIHHLWSHbYvEmcuSSplxWXjXTQgVIrIOUPTPjGN5BhhgKN6unDVx7ktynCaxz
         +vJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/0xg9WnJ4xA4j3RnhckkeXOmdyeehSClwBqizSGK2+E=;
        fh=lI+JBhi1IVNPoQku9hilk8nTs4gRVS7p7tzu7a7JqBc=;
        b=OQzKrIksduQFb2WgSK+9xCm1VQFjUGHhU0Rn05Hcd5H1G/Hj+ZMhMN2B7Psa9ABj03
         sK4mRPwKGyBA8KnRzxkLwbU9Ig45nbrZNlpFr9gao1jI1nPzvdYvcE+Cd3/0n/tII5um
         uKN4omCm7JrHYIdXQU5saqajca1wWCHLsJwID2OJ9a7j7PPpeFAAgxN9KbmRTdxKXBJg
         231KBxAlPxzFRwTnSkWPINlTbEd1ZFvawa1FPDzIo2fgLyhUDYpIUfqbRE/u/vvjkQ0X
         8yct9+a0HAtbNxsZj3iUciZKm3smftlG+LY3nz0N4P33seok02AYbl5JNsQtxAVrS1Dz
         +8Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661109; x=1796265909; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/0xg9WnJ4xA4j3RnhckkeXOmdyeehSClwBqizSGK2+E=;
        b=YSZyFojKq3bG4WC8T2VFHphp90WVwR7sQy3s2Qq53CeOw3XNRFZpI+qpJ8Qn7ADhDL
         FoWn/llGclwpr+4muEtL7hKhwiI7VYdLwR+O578uaAIWwOdogiNtRPiD5fJqZoEQgxFm
         7yDkzZ7FAWOSyE0aq2XI+LAwnl7i/58KxcCHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661109; x=1796265909;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/0xg9WnJ4xA4j3RnhckkeXOmdyeehSClwBqizSGK2+E=;
        b=hmxwT/XpJDLAZODbnTdrq0FLpW2Q8lLZZmQ+qEKRDLAKMagkSt09Qq3WGPQxlBvAZS
         drb5qsh2j0HtVlseDyfq0g9tdNRlxDSZTdWGsUaSeDJjkZXLhgCpgFqkjdnvbSaEVrmY
         fGKt9DhAQFw8/1weelUIsj5QXzByhLHnwX1tuGKySrI9U/KqKXhpx+3d0OV77Ihv/SeZ
         voHDNHd0A73tzyhwFJQgZCB3UDCC1xhS0F8jmyxcofp5PIpl8v87KasGBRWnLLriSxHA
         vLOovUv5Uko9Imchj93aXM7+fppZUbtWB7UTxSv1VPqzK0J23KxNDi6x8MqBtCkw0vto
         bH+A==
X-Forwarded-Encrypted: i=1; AL+hErFcbv3iG/z0nzJaAznYOlzrKEYD9S6xexI5KWJBjUu21KkPQ2noKgKzWU5Ap3MIuAJ/+6g5/jMpFUPDbBNqEpo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/W4KDIlKrlgJWrdhf13o3I9NDbOhYpkdh81OZpsBBIeFKBjcXF
	66FcOnM5YbM2ejtSeag2B1TTrmb/unq3735VHMUgGibLlnJFmwd/LvWDzsyceEdr75jzq4rhwJS
	gglA2awdC1d+y6/G8t+wUSk+E75erpqPplqCrlNy2rg==
X-Gm-Gg: AZFdTZcVU+n2+yiCLRCL8tz2XrTbQPYqpqcBKK+6UllErjBLrJADiRLaMvdhB/EvV2K
	jZ7JZnaC005KUWZMlJOnDq7QtbUBOtHzbnelbxQ81XmdHyRiKTpAUCmyUTsWFibL0w81Cw/jDgk
	O3mF5+OAbTDDkZhmyXFmlEBGUjlL3/+xv/FYv8SIB1Qh4+5R/W0f/TRbsu0oSCilNdNKa1T/myU
	l2OXZK9lBb3a+rQ5j5oS9Ws8nCrcHApstejWV71OysS2pkfEhCkyN7gIaCuXuXhYmEq2M+18aTb
	aIdgkkHnYpe7YrsazJJ3+RLf6HNgkup9T5ypNQFoZnYOMsyQrSCyq+7udP0E75oPDrY+HdCj4CO
	ygxADCn2OaNp0xFmd0wqZgQIqHP9LYViVbSc0c59CQ6XRX3tkvj9DXOQRkky9z26DAKhkn2aEt8
	8Yyk3vmpjMtdBsNE/qesATk6lxyIjDx0HMy1ls5tytEuebdfYnrqaS7dnoLm8D0jVW0jjK/okSv
	A9EEaTdVN1ZYf+8LE9QyremsnKgyzhwGTMo
X-Received: by 2002:a05:690e:438d:b0:67d:b9c2:3d39 with SMTP id
 956f58d0204a3-67df44556ecmr4098773d50.97.1795661109244; Wed, 25 Nov 2026
 18:45:09 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 20:45:08 -0600
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 20:45:08 -0600
X-Gm-Features: Aa3M54paIFJUchZVb6P5CQuzxQRXvyj5HLL0xeT27KaPRrHW7XTFKnxEJ06Kuhw
Message-ID: <CAFaZ9ep1MzprNHirA++5XpLuQC4PhibJr_FBWHxEt=Exvic1QA@mail.gmail.com>
Subject: [PATCH 6.6.y] Bluetooth: hci_uart: clear HCI_UART_SENDING when
 write_work is canceled
To: stable@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Pauli Virtanen <pav@iki.fi>

commit 1b0d946d6f08bd39211385bc703a440911b41e46 upstream.

HCI_UART_SENDING bit in tx_state means write_work is pending and blocks
queueing it again. Currently this bit is not cleared when canceling the
work in hci_uart_close(), which blocks future writes when device is
reopened later if write_work was pending.

Fix by clearing HCI_UART_SENDING when canceling the work.

Also make clearing of tx_skb safe by using disable_work_sync +
enable_work instead of just cancel_work_sync. hci_uart_flush() purges
the proto tx queue so we can cancel the pending write_work there,
instead of doing it just in hci_uart_close(). Re-enable and possibly
requeue the work after queue flush.

Fixes: c1bb9336ae6b ("Bluetooth: hci_uart: fix UAFs and race
conditions in close and init paths")
Link: https://lore.kernel.org/linux-bluetooth/07e0a28650773abec711ee492fdb1bf5d21a6c98.camel@iki.fi/
Cc: stable@vger.kernel.org
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ adapted to 6.6: no disable_work_sync()/enable_work(), use tx_lock
and HCI_UART_FLUSHING around cancel_work_sync() ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.12.y and 6.18.y already have this. 6.6 has no disable_work_sync() or
enable_work(), so instead of disabling write_work during the flush this
adds a tx_lock and an HCI_UART_FLUSHING bit. hci_uart_tx_wakeup() won't
queue write_work while a flush is running, the flush cancels and waits
for any running work, holds HCI_UART_SENDING while it frees tx_skb, then
clears both bits and replays a wakeup that came in meanwhile. That's the
sequence upstream gets from disable_work_sync() and enable_work().

The serdev follow-up, ee43bade37c4 ("Bluetooth: hci_serdev: serialize
flush with transmit work"), isn't in 6.12.y or 6.18.y yet, so it's not
included here.

Tested on v6.6.163:
- x86_64 allmodconfig W=1 build of drivers/bluetooth/, base vs patched,
  no new warnings
- x86_64 defconfig with BT_HCIUART, BT_HCIUART_SERDEV and BT_HCIUART_H4
  built in, boots under QEMU/KVM
- I don't have UART Bluetooth hardware, so the close/flush race itself
  is untested here. No existing selftest reaches it.

Since the locking here differs from upstream, a look from the Bluetooth
folks would be very welcome.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

 drivers/bluetooth/hci_ldisc.c  | 37 ++++++++++++++++++++++++----------
 drivers/bluetooth/hci_serdev.c |  1 +
 drivers/bluetooth/hci_uart.h   |  4 ++++
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 548e58e69eb7..8c43ffb30725 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -116,6 +116,8 @@ static inline struct sk_buff
*hci_uart_dequeue(struct hci_uart *hu)

 int hci_uart_tx_wakeup(struct hci_uart *hu)
 {
+	unsigned long flags;
+
 	/* This may be called in an IRQ context, so we can't sleep. Therefore
 	 * we try to acquire the lock only, and if that fails we assume the
 	 * tty is being closed because that is the only time the write lock is
@@ -129,13 +131,14 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
 	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 		goto no_schedule;

+	spin_lock_irqsave(&hu->tx_lock, flags);
 	set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
-	if (test_and_set_bit(HCI_UART_SENDING, &hu->tx_state))
-		goto no_schedule;
-
-	BT_DBG("");
-
-	schedule_work(&hu->write_work);
+	if (!test_bit(HCI_UART_FLUSHING, &hu->tx_state) &&
+	    !test_and_set_bit(HCI_UART_SENDING, &hu->tx_state)) {
+		BT_DBG("");
+		schedule_work(&hu->write_work);
+	}
+	spin_unlock_irqrestore(&hu->tx_lock, flags);

 no_schedule:
 	percpu_up_read(&hu->proto_lock);
@@ -176,7 +179,8 @@ static void hci_uart_write_work(struct work_struct *work)
 	}

 	clear_bit(HCI_UART_SENDING, &hu->tx_state);
-	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state))
+	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state) &&
+	    !test_bit(HCI_UART_FLUSHING, &hu->tx_state))
 		goto restart;

 	wake_up_bit(&hu->tx_state, HCI_UART_SENDING);
@@ -236,9 +240,16 @@ static int hci_uart_flush(struct hci_dev *hdev)
 {
 	struct hci_uart *hu  = hci_get_drvdata(hdev);
 	struct tty_struct *tty = hu->tty;
+	unsigned long flags;

 	BT_DBG("hdev %p tty %p", hdev, tty);

+	spin_lock_irqsave(&hu->tx_lock, flags);
+	set_bit(HCI_UART_FLUSHING, &hu->tx_state);
+	spin_unlock_irqrestore(&hu->tx_lock, flags);
+	cancel_work_sync(&hu->write_work);
+	set_bit(HCI_UART_SENDING, &hu->tx_state);
+
 	if (hu->tx_skb) {
 		kfree_skb(hu->tx_skb); hu->tx_skb = NULL;
 	}
@@ -254,6 +265,13 @@ static int hci_uart_flush(struct hci_dev *hdev)

 	percpu_up_read(&hu->proto_lock);

+	spin_lock_irqsave(&hu->tx_lock, flags);
+	clear_bit(HCI_UART_FLUSHING, &hu->tx_state);
+	clear_bit(HCI_UART_SENDING, &hu->tx_state);
+	spin_unlock_irqrestore(&hu->tx_lock, flags);
+	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state))
+		hci_uart_tx_wakeup(hu);
+
 	return 0;
 }

@@ -271,12 +289,8 @@ static int hci_uart_open(struct hci_dev *hdev)
 /* Close device */
 static int hci_uart_close(struct hci_dev *hdev)
 {
-	struct hci_uart *hu = hci_get_drvdata(hdev);
-
 	BT_DBG("hdev %p", hdev);

-	cancel_work_sync(&hu->write_work);
-
 	hci_uart_flush(hdev);
 	hdev->flush = NULL;
 	return 0;
@@ -516,6 +530,7 @@ static int hci_uart_tty_open(struct tty_struct *tty)

 	tty->disc_data = hu;
 	hu->tty = tty;
+	spin_lock_init(&hu->tx_lock);
 	tty->receive_room = 65536;

 	/* disable alignment support by default */
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 753343ca8489..835ec8f2f09e 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -313,6 +313,7 @@ int hci_uart_register_device_priv(struct hci_uart *hu,

 	if (percpu_init_rwsem(&hu->proto_lock))
 		return -ENOMEM;
+	spin_lock_init(&hu->tx_lock);

 	err = serdev_device_open(hu->serdev);
 	if (err)
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 39f39704be41..2687f76cc01b 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -12,6 +12,8 @@
 #define N_HCI	15
 #endif

+#include <linux/spinlock.h>
+
 /* Ioctls */
 #define HCIUARTSETPROTO		_IOW('U', 200, int)
 #define HCIUARTGETPROTO		_IOR('U', 201, int)
@@ -76,6 +78,7 @@ struct hci_uart {

 	struct sk_buff		*tx_skb;
 	unsigned long		tx_state;
+	spinlock_t		tx_lock;

 	unsigned int init_speed;
 	unsigned int oper_speed;
@@ -94,6 +97,7 @@ struct hci_uart {
 /* TX states  */
 #define HCI_UART_SENDING	1
 #define HCI_UART_TX_WAKEUP	2
+#define HCI_UART_FLUSHING	3

 int hci_uart_register_proto(const struct hci_uart_proto *p);
 int hci_uart_unregister_proto(const struct hci_uart_proto *p);
