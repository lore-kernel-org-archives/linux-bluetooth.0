Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Ganapathi Bhat <gbhat@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH v9 2/3] Bluetooth: hci_uart: check if hdev is present before using it
Date: Fri, 29 Apr 2016 03:24:37 -0700
Message-ID: <1461925478-31851-2-git-send-email-akarwar@marvell.com>
In-Reply-To: <1461925478-31851-1-git-send-email-akarwar@marvell.com>
References: <1461925478-31851-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ganapathi Bhat <gbhat@marvell.com>

The hdev struct might not have initialized in protocal receive handler.
This patch adds necessary checks.

Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/hci_ldisc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 075a82d..3ee8c0c 100644
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

