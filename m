Return-Path: <cyrus@holtmann.org>
From: Jiejing Zhang <kzjeef@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Cc: Jiejing Zhang <kzjeef@gmail.com>,
	Jiejing Zhang <jiejing.zhang@freescale.com>
Subject: [PATCH] Bluetooth: hci_uart: check the return value of recv()
Date: Thu,  7 Apr 2011 20:37:06 +0800
Message-Id: <1302179826-15745-1-git-send-email-kzjeef@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Check the return value of hu->proto->recv() in hci_uart_tty_receive()
the recv() may return error, check it, not add this to statistics.

Signed-off-by: Jiejing Zhang <jiejing.zhang@freescale.com>
---
 drivers/bluetooth/hci_ath.c   |    6 +++++-
 drivers/bluetooth/hci_ldisc.c |    6 ++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index bd34406..caf807e 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -201,8 +201,12 @@ static struct sk_buff *ath_dequeue(struct hci_uart *hu)
 /* Recv data */
 static int ath_recv(struct hci_uart *hu, void *data, int count)
 {
-	if (hci_recv_stream_fragment(hu->hdev, data, count) < 0)
+	int ret;
+	ret = hci_recv_stream_fragment(hu->hdev, data, count);
+	if (ret < 0) {
 		BT_ERR("Frame Reassembly Failed");
+		return ret;
+	}
 
 	return count;
 }
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 48ad2a7..320f718 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -359,6 +359,7 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
  */
 static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data, char *flags, int count)
 {
+	int ret;
 	struct hci_uart *hu = (void *)tty->disc_data;
 
 	if (!hu || tty != hu->tty)
@@ -368,8 +369,9 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data, char *f
 		return;
 
 	spin_lock(&hu->rx_lock);
-	hu->proto->recv(hu, (void *) data, count);
-	hu->hdev->stat.byte_rx += count;
+	ret = hu->proto->recv(hu, (void *) data, count);
+	if (ret > 0)
+		hu->hdev->stat.byte_rx += count;
 	spin_unlock(&hu->rx_lock);
 
 	tty_unthrottle(tty);
-- 
1.7.1
