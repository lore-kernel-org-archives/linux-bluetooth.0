Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_ldisc: Add support for compat_ioctl handling
Date: Fri, 22 Jan 2016 14:36:00 +0100
Message-Id: <1453469760-37045-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ldisc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 73202624133b..56619c7ec41d 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -731,6 +731,24 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
 	return err;
 }
 
+#ifdef CONFIG_COMPAT
+static long hci_uart_tty_compat_ioctl(struct tty_struct *tty, struct file *file,
+				      unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case HCIUARTSETPROTO:
+	case HCIUARTGETPROTO:
+	case HCIUARTGETDEVICE:
+	case HCIUARTSETFLAGS:
+	case HCIUARTGETFLAGS:
+		return hci_uart_tty_ioctl(tty, file, cmd,
+					  (unsigned long)compat_ptr(arg));
+	}
+
+	return -ENOIOCTLCMD;
+}
+#endif
+
 /*
  * We don't provide read/write/poll interface for user space.
  */
@@ -769,6 +787,9 @@ static int __init hci_uart_init(void)
 	hci_uart_ldisc.read		= hci_uart_tty_read;
 	hci_uart_ldisc.write		= hci_uart_tty_write;
 	hci_uart_ldisc.ioctl		= hci_uart_tty_ioctl;
+#ifdef CONFIG_COMPAT
+	hci_uart_ldisc.compat_ioctl	= hci_uart_tty_compat_ioctl;
+#endif
 	hci_uart_ldisc.poll		= hci_uart_tty_poll;
 	hci_uart_ldisc.receive_buf	= hci_uart_tty_receive;
 	hci_uart_ldisc.write_wakeup	= hci_uart_tty_wakeup;
-- 
2.5.0

