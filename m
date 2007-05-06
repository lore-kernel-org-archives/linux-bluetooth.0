Return-Path: <ohad@bencohen.org>
From: Ohad Ben-Cohen <ohad@bencohen.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 2.6.21] Bluetooth: add HCIUARTGETDEVICE to hci line discipline
MIME-Version: 1.0
Date: Sun, 6 May 2007 10:32:49 -0400
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705061032.50169.ohad@bencohen.org>
List-ID: <bluez-devel.lists.sourceforge.net>

From: Ohad Ben-Cohen <ohad@bencohen.org>

Adding HCIUARTGETDEVICE makes it possible to know the hci device number
that is attached to a given serial device.
This is required during the initialization process of some Bluetooth chips.

Signed-off-by: Ohad Ben-Cohen <ohad@bencohen.org>
---
 drivers/bluetooth/hci_ldisc.c |    5 +++++
 drivers/bluetooth/hci_uart.h  |    5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 0f4203b..75c1508 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -479,6 +479,11 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file * file,
 			return hu->proto->id;
 		return -EUNATCH;
 
+	case HCIUARTGETDEVICE:
+		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
+			return hu->hdev->id;
+		return -EUNATCH;
+
 	default:
 		err = n_tty_ioctl(tty, file, cmd, arg);
 		break;
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index b250e67..1097ce7 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -28,8 +28,9 @@
 #endif
 
 /* Ioctls */
-#define HCIUARTSETPROTO	_IOW('U', 200, int)
-#define HCIUARTGETPROTO	_IOR('U', 201, int)
+#define HCIUARTSETPROTO		_IOW('U', 200, int)
+#define HCIUARTGETPROTO		_IOR('U', 201, int)
+#define HCIUARTGETDEVICE	_IOR('U', 202, int)
 
 /* UART protocols */
 #define HCI_UART_MAX_PROTO	4
-- 
1.5.0.6
