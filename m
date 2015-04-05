Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_uart: Remove unneeded cast of tty->disc_data
Date: Sat,  4 Apr 2015 19:57:21 -0700
Message-Id: <1428202642-21621-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Casting the tty->disc_data to (void *) is not needed at all. So just
remove this cast and assign the object without a cast.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ldisc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index b6d1ff4fbba6..c577a40e790d 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -362,7 +362,7 @@ static int hci_uart_tty_open(struct tty_struct *tty)
  */
 static void hci_uart_tty_close(struct tty_struct *tty)
 {
-	struct hci_uart *hu = (void *)tty->disc_data;
+	struct hci_uart *hu = tty->disc_data;
 	struct hci_dev *hdev;
 
 	BT_DBG("tty %p", tty);
@@ -401,7 +401,7 @@ static void hci_uart_tty_close(struct tty_struct *tty)
  */
 static void hci_uart_tty_wakeup(struct tty_struct *tty)
 {
-	struct hci_uart *hu = (void *)tty->disc_data;
+	struct hci_uart *hu = tty->disc_data;
 
 	BT_DBG("");
 
@@ -431,7 +431,7 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
  */
 static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data, char *flags, int count)
 {
-	struct hci_uart *hu = (void *)tty->disc_data;
+	struct hci_uart *hu = tty->disc_data;
 
 	if (!hu || tty != hu->tty)
 		return;
@@ -560,7 +560,7 @@ static int hci_uart_set_flags(struct hci_uart *hu, unsigned long flags)
 static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file * file,
 					unsigned int cmd, unsigned long arg)
 {
-	struct hci_uart *hu = (void *)tty->disc_data;
+	struct hci_uart *hu = tty->disc_data;
 	int err = 0;
 
 	BT_DBG("");
-- 
2.1.0

