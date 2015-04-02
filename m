Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 3/5] Bluetooth: hci_uart: Add HCIUARTSETBAUDRATE ioctl
Date: Thu,  2 Apr 2015 16:37:34 +0200
Message-Id: <1427985456-31536-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1427985456-31536-1-git-send-email-frederic.danis@linux.intel.com>
References: <1427985456-31536-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows user space application to set final speed requested for UART
device. UART port is open at init speed by user space application.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_ldisc.c | 4 ++++
 drivers/bluetooth/hci_uart.h  | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index e8412f8..4b09369 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -614,6 +614,10 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file * file,
 	case HCIUARTGETFLAGS:
 		return hu->hdev_flags;
 
+	case HCIUARTSETBAUDRATE:
+		hu->speed = arg;
+		break;
+
 	case HCIUARTSETDEVTYPE:
 		err = hci_tty_ioctl_set_devtype(hu, cmd, arg);
 		if (err)
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index bf6f0e5..dcbedaf 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -34,6 +34,7 @@
 #define HCIUARTSETFLAGS		_IOW('U', 203, int)
 #define HCIUARTGETFLAGS		_IOR('U', 204, int)
 #define HCIUARTSETDEVTYPE	_IOW('U', 205, int)
+#define HCIUARTSETBAUDRATE	_IOW('U', 206, int)
 
 /* UART protocols */
 #define HCI_UART_MAX_PROTO	6
@@ -72,6 +73,7 @@ struct hci_uart {
 	unsigned long		flags;
 	unsigned long		hdev_flags;
 	char			dev_type[HCI_UART_DEVTYPE_SIZE];
+	unsigned long		speed;
 
 	struct work_struct	init_ready;
 	struct work_struct	write_work;
-- 
1.9.1

