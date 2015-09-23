Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 4/5] Bluetooth: Remove useless rx_lock spinlock
Date: Wed, 23 Sep 2015 18:18:10 +0200
Message-Id: <1443025091-1864-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1443025091-1864-1-git-send-email-frederic.danis@linux.intel.com>
References: <1443025091-1864-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

rx_lock spinlock is only used in hci_uart_tty_receive() which is the
receive_buf ldisc callback.

hci_uart_tty_receive() is protected from re-entrance by its only
caller (flush_to_ldisc() in drivers/tty/tty_buffer.c) which held a
mutex (buf->lock) for this section.
This lock allows "safe use of the line discipline's receive_buf()
method by excluding the buffer work and any pending flush from using
the flip buffer." (comments from tty_buffer_lock_exclusive() in
drivers/tty/tty_buffer.c)

So, no need to double protect this resource with rx_lock.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_ldisc.c | 8 +++-----
 drivers/bluetooth/hci_uart.h  | 1 -
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 0d5a05a..ad66c69 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -470,8 +470,6 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 	INIT_WORK(&hu->init_ready, hci_uart_init_work);
 	INIT_WORK(&hu->write_work, hci_uart_write_work);
 
-	spin_lock_init(&hu->rx_lock);
-
 	/* Flush any pending characters in the driver and line discipline. */
 
 	/* FIXME: why is this needed. Note don't use ldisc_ref here as the
@@ -569,14 +567,14 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 	if (!test_bit(HCI_UART_PROTO_SET, &hu->flags))
 		return;
 
-	spin_lock(&hu->rx_lock);
+	/* It does not need a lock here as it is already protected by a mutex in
+	 * tty caller
+	 */
 	hu->proto->recv(hu, data, count);
 
 	if (hu->hdev)
 		hu->hdev->stat.byte_rx += count;
 
-	spin_unlock(&hu->rx_lock);
-
 	tty_unthrottle(tty);
 }
 
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 495b9ef..2f7bb35 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -85,7 +85,6 @@ struct hci_uart {
 
 	struct sk_buff		*tx_skb;
 	unsigned long		tx_state;
-	spinlock_t		rx_lock;
 
 	unsigned int init_speed;
 	unsigned int oper_speed;
-- 
1.9.1

