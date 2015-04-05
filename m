Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_uart: Fix indentation issues for multi-line functions
Date: Sat,  4 Apr 2015 19:57:22 -0700
Message-Id: <1428202642-21621-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ldisc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index c577a40e790d..a3b906bcfca6 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -429,7 +429,8 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
  *
  * Return Value:    None
  */
-static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data, char *flags, int count)
+static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
+				 char *flags, int count)
 {
 	struct hci_uart *hu = tty->disc_data;
 
@@ -557,8 +558,8 @@ static int hci_uart_set_flags(struct hci_uart *hu, unsigned long flags)
  *
  * Return Value:    Command dependent
  */
-static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file * file,
-					unsigned int cmd, unsigned long arg)
+static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
+			      unsigned int cmd, unsigned long arg)
 {
 	struct hci_uart *hu = tty->disc_data;
 	int err = 0;
@@ -614,19 +615,19 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file * file,
  * We don't provide read/write/poll interface for user space.
  */
 static ssize_t hci_uart_tty_read(struct tty_struct *tty, struct file *file,
-					unsigned char __user *buf, size_t nr)
+				 unsigned char __user *buf, size_t nr)
 {
 	return 0;
 }
 
 static ssize_t hci_uart_tty_write(struct tty_struct *tty, struct file *file,
-					const unsigned char *data, size_t count)
+				  const unsigned char *data, size_t count)
 {
 	return 0;
 }
 
 static unsigned int hci_uart_tty_poll(struct tty_struct *tty,
-					struct file *filp, poll_table *wait)
+				      struct file *filp, poll_table *wait)
 {
 	return 0;
 }
-- 
2.1.0

