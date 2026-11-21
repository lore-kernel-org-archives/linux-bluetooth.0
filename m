Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795276640;
	b=Jr+M23A1oFD5aopDZ4wqk1AA1HG+O3qCspSIBV5wylipcQytExeEpW5G9lPToau/QSBj
	 YycDdywxWWFd9dcele06LTUA61CMoIx/yNtFH0Vw+++2jOggpDhqpRTz4exk377xjXNBt
	 q4+0jEleVzEzlQuLzBc6vp/oBt4uQxMD2yAstM0S4wGx8JrH+Ce/DkOa4W1C7PsCqvI3Q
	 oHTJia6ACPZC8MepnQ/yXhWHfI8KalhQqubzFkdxp2NikQd2H5jQJvgrk0oVHZ8vacsyL
	 vV7Ax6L3ZJGjO1RLyybap8eGykypdfojWpGCoxhYVRYrUnrizXxinYGArsbEZlMIv7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795276640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7jYx29lk0VQ+rDyH5VI1Dp1pxPOIzH/Tyj7l1x2+Cvw=;
	b=BwsufYl86GxfT8d+HJeU1OHvxClAFIYxm3l7vmkJtliUKCoBm/5UQ+2D7obBoO+5vKSn
	 SAqlVUcfENI9TlLz1YY41tIxq+0h3e7GS0kalMC3/Pr12MmEWxMRRFAAoR89owYp7NTFX
	 EmUag/ZZC80c/fuId1GRt5mf5FMPC6SggagjcRScnlUAmTaGlUlk10YA2PwdwcRzbUqOz
	 scVw1K1ci1wNTgge2fX8Icy99S+OHPE4H9QCJPMll47yt9ZIo4vKTPJkKmowvhNa53+Ys
	 7wD59JkwVdrTGrkCs0xZKUtVGWDq0WA9yx19VagJGGdOKtT1SjSudk2W5dsad0gCenA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qWChVtZ0;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D95B606A320
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 15:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D95B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qWChVtZ0
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-385c497bf94so3835023eec.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 07:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795276638; x=1795881438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7jYx29lk0VQ+rDyH5VI1Dp1pxPOIzH/Tyj7l1x2+Cvw=;
        b=qWChVtZ0aUsopnqGgFXKl69UxHOk8YCl9EkEWEMNZiPzUm2AN8h0KmXppQKOTsuqHD
         Vr+ufazjphT67IO1MT6M70kvyP5LCLVEHSsFZJjo82qkRR2isOgZd1oq5+WpcSU3dVUW
         45vfvvGHFa9QyKky/DvBlUk11aVTZD6vGnTmxQp6IWXMRJMIUm06rdy7nb04RJ+3X+dq
         6/b6a3FGYMdGZRBYloBLopj/naVQw5jpIbx07hgRzhVpk0/HXG+o8s/jdLpnB1Qw7/8+
         brujktESsOCEpoOwHfmmEpzUm4flpP1A6woA4vhLYfxkn84Vwhf7Udn9V0NO6LXb7bA1
         FZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795276638; x=1795881438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7jYx29lk0VQ+rDyH5VI1Dp1pxPOIzH/Tyj7l1x2+Cvw=;
        b=G1wG/x06JduA1m2UJcd7k9zlZlzrxbfW+H3u/crsbZQxR4rdw2lZTG+QN6N3pxyl7C
         KWWadaBN8ythlS8sPLTC+YgvuKdVNkiN+N1Bi3PXsK+NKZM+5NgOuYBLOO6XUjwbSGXG
         52wUu29BUhOAmJ2xAA4pBKnN+zjHp+JBrGtNs9LA4FZxRoJ5jOZyXrw0aJOopkOkrnFH
         xgzqk0tWlut4yxvUqF2R3Mv+CGlVtPbdplsGnqic0cfApYFDffwzax5IubC8YPpajRGH
         +FN44lf47t9Zp91qWSoeukhua0+lSB1GcofmBrFUEIAduBZXFA3x+edomPEMlApVZRUK
         +RCg==
X-Gm-Message-State: APuU4Z+r9r6TXFQT4zCkoEJmxGT8d1j/dTqmB5NpApdmeiDOBi2SigiR
	n49HekqIvupNxFYTQz/Q1FQjXgyCVFlWpSh7dCGnkBgFCpoRFGsVvMK7
X-Gm-Gg: AZFdTZcOcPRW02KVmsFKI6SMdYX1yu96BxNkT71rTcspphb17FYu4MmlTmREpJoKM1Q
	Fwrh2D1BipPXS6MDhTdztOny2GJE21yff5vLl+xp1HdvSoJAez51ATXM+GfOD2jlnNi+D+i+VDS
	I7KeG1U+YBcJovJE9jr9cYS/0NCINBJPUNzJL03A0mhpKIjT2SxvWtdODJohY+bnj8PM40febKs
	NKAimOexwutZR2WcTmrwEeY/oKHVyfC0WCg9+EmpxwxIaqlm7BtiY/vKl5D6lIpJqtza2JdYQkt
	6UGHr2e9DYuo0lbLzTcTwpt1TVRjEHIEsLHx1ut+izfo94Pdc2RnZrlv0MvcdIps6oL4xXdNz1d
	M55w6hX+lTqhym6BQaFyUg/+qHUbb4b8NnyWBUCBqOcFrepjdTeHBUSsadApSs25sgBw8qUXXWq
	YANuPj6zgJFUm1+l5/WOnA2nJBCiNDe5jpqSluG5WvWjC2weo9KUx1myahUDLSMzVhShAqrx9Zv
	Buv5Qhkn14AuaWakTFsJVnnff7ieXUdwJqkCcI1EWtfHju+HJwd8FhqWZmfG45y1VMnZ8ykeFgf
	+ZXiqIWAzroYVYYyCw9e1NhJ6InOm7QDwPOxQZUVIHJMtsboHvaBVFsegbU=
X-Received: by 2002:a05:7301:3a82:b0:374:ea35:9069 with SMTP id 5a478bee46e88-3856fb67380mr5886149eec.39.1795276637942;
        Sat, 21 Nov 2026 07:57:17 -0800 (PST)
Received: from G7XWH7K1F3 ([2408:8256:2e80:7371:8549:3fe7:526f:af9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm20136479eec.6.2026.11.21.07.57.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Nov 2026 07:57:17 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael McAllister <me@michaelmcallister.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>
Subject: [PATCH v3] Bluetooth: hci_serdev: stop write_work before closing the port
Date: Sat, 21 Nov 2026 23:56:48 +0800
Message-ID: <20261121155648.1151-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With HCI_QUIRK_NON_PERSISTENT_SETUP, hci_uart_close() closes the serdev
port without keeping write_work off. The hci_uart_flush() call right
before closing re-enables write_work and may replay a recorded wakeup,
and hci_uart_tx_wakeup() queues it from any caller that passed the
HCI_UART_PROTO_READY test, such as the serdev write_wakeup callback.
write_work can then call ttyport_write_buf() while ttyport_close()
releases the tty, so it writes through a released tty.

Move the flush into __hci_uart_flush() with a resume_tx argument.
hci_uart_close() passes false when it is about to close the port, so
write_work stays disabled and HCI_UART_SENDING stays set after the
flush. It then clears HCI_UART_PROTO_READY under percpu_down_write(),
which waits for any hci_uart_tx_wakeup() already past its
HCI_UART_PROTO_READY test, and closes the port. Only then does it clear
HCI_UART_TX_WAKEUP, re-enable write_work and clear HCI_UART_SENDING: the
next open reuses hu and does not reset tx_state, and a stale SENDING
would stop every later wakeup from queuing write_work.

Found by code review. Compile-tested with W=1.

Fixes: de8892df72be ("Bluetooth: hci_serdev: Close UART port if NON_PERSISTENT_SETUP is set")
Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
v3:
- Add __hci_uart_flush() with a resume_tx argument and call it from
  hci_uart_close() instead of repeating the flush. write_work is
  re-enabled only after serdev_device_close() (Loic Poulain's review of
  v2).
v2:
- Clear HCI_UART_SENDING and HCI_UART_TX_WAKEUP after cancelling
  write_work. A pending write_work cancelled there left SENDING set, so
  the next power-on never queued write_work (Sashiko's review of v1).

v2: https://lore.kernel.org/linux-bluetooth/20261120062048.40310-1-enderaoelyther@gmail.com/
v1: https://lore.kernel.org/linux-bluetooth/20261118124821.3990-1-enderaoelyther@gmail.com/

Merging with Michael McAllister's hci_serdev v3 series (Patchwork
14989810-14989814):
https://lore.kernel.org/linux-bluetooth/179484638195.54009.16928291772826938293.wcn3950-poweroff-v3-1@michaelmcallister.org/
- 1/5 adds "if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) return 0;" at the
  top of hci_uart_flush() and hci_uart_close(). The flush check has to
  stay in hci_uart_flush(), not move into __hci_uart_flush().
- Once hci_uart_close() is past its own check, __hci_uart_flush() must
  always run disable_work_sync(), which the enable_work() after
  serdev_device_close() balances. Otherwise write_work is not disabled
  during the close and the enable underflows the disable count.
- 2/5: use hci_uart_serdev_close(hu) in place of
  serdev_device_close(hu->serdev) in the close_port branch.

This needs ee43bade37c4, which no stable branch has yet, and
disable_work_sync() from v6.10. With the flush body of ee43bade37c4
backported it applies as is to 7.3.y and 6.18.y and, with the older
test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks) context line, to
6.12.y; 6.6.y has no disable_work_sync().

No new W=1, sparse or smatch warnings.

AI assistance was used.

 drivers/bluetooth/hci_serdev.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 194f11251cc5..9f038ab65a73 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -91,7 +91,7 @@ static void hci_uart_write_work(struct work_struct *work)
 /* ------- Interface to HCI layer ------ */
 
 /* Reset device */
-static int hci_uart_flush(struct hci_dev *hdev)
+static void __hci_uart_flush(struct hci_dev *hdev, bool resume_tx)
 {
 	struct hci_uart *hu  = hci_get_drvdata(hdev);
 
@@ -112,11 +112,19 @@ static int hci_uart_flush(struct hci_dev *hdev)
 		hu->proto->flush(hu);
 	}
 
+	if (!resume_tx)
+		return;
+
 	/* Resume TX and replay a wakeup recorded while it was stopped. */
 	enable_work(&hu->write_work);
 	clear_bit(HCI_UART_SENDING, &hu->tx_state);
 	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state))
 		hci_uart_tx_wakeup(hu);
+}
+
+static int hci_uart_flush(struct hci_dev *hdev)
+{
+	__hci_uart_flush(hdev, true);
 
 	return 0;
 }
@@ -150,22 +158,34 @@ static int hci_uart_open(struct hci_dev *hdev)
 static int hci_uart_close(struct hci_dev *hdev)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
+	bool close_port;
 
 	BT_DBG("hdev %p", hdev);
 
 	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
 		return 0;
 
-	hci_uart_flush(hdev);
+	close_port = hci_test_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
+
+	/* Keep write_work disabled until the port is closed. */
+	__hci_uart_flush(hdev, !close_port);
 	hdev->flush = NULL;
 
 	/* When QUIRK HCI_QUIRK_NON_PERSISTENT_SETUP is set by driver,
 	 * BT SOC is completely powered OFF during BT OFF, holding port
 	 * open may drain the battery.
 	 */
-	if (hci_test_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP)) {
+	if (close_port) {
+		/* Drain wakeups that passed the PROTO_READY test. */
+		percpu_down_write(&hu->proto_lock);
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
+		percpu_up_write(&hu->proto_lock);
+
 		serdev_device_close(hu->serdev);
+
+		clear_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
+		enable_work(&hu->write_work);
+		clear_bit(HCI_UART_SENDING, &hu->tx_state);
 	}
 
 	return 0;

base-commit: cf357cfc025e7f72851479ed3fb60d5f16413c1b
-- 
2.56.1

