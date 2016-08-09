Return-Path: <marvell@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        <marcel@holtmann.org>, Ganapathi Bhat <gbhat@marvell.com>,
        Amitkumar Karwar
	<akarwar@marvell.com>
Subject: [PATCH v12 2/3] Bluetooth: hci_uart: check if hdev is present before using it
Date: Tue, 9 Aug 2016 22:02:32 +0530
Message-ID: <1470760353-2394-2-git-send-email-akarwar@marvell.com>
In-Reply-To: <1470760353-2394-1-git-send-email-akarwar@marvell.com>
References: <1470760353-2394-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ganapathi Bhat <gbhat@marvell.com>

The hdev struct might not have initialized in protocol receive handler.
This patch adds necessary checks.

Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/hci_ldisc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index d7184dc..2c88586 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -154,7 +154,9 @@ restart:
 
 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 		len = tty->ops->write(tty, skb->data, skb->len);
-		hdev->stat.byte_tx += len;
+
+		if (hdev)
+			hdev->stat.byte_tx += len;
 
 		skb_pull(skb, len);
 		if (skb->len) {
@@ -349,7 +351,7 @@ void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
 	/* tty_set_termios() return not checked as it is always 0 */
 	tty_set_termios(tty, &ktermios);
 
-	BT_DBG("%s: New tty speeds: %d/%d", hu->hdev->name,
+	BT_DBG("%s: New tty speeds: %d/%d", hu->hdev ? hu->hdev->name : "",
 	       tty->termios.c_ispeed, tty->termios.c_ospeed);
 }
 
-- 
1.8.1.4
