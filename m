Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@nokia.com>
Subject: [PATCH] Bluetooth: Add HCIUARTSETFLAGS and HCIUARTGETFLAGS ioctls
Date: Mon, 12 Jul 2010 11:37:04 -0300
Message-Id: <1278945424-11047-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch introduces two new ioctls: HCIUARTSETFLAGS and
HCIUARTGETFLAGS. The only flag available for now is HCI_UART_RAW_DEVICE
which allows to initialize a UART device into RAW mode from userspace.
This is particularly useful for experimenting with Bluetooth controllers
that don't yet have proper support in BlueZ.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 drivers/bluetooth/hci_ldisc.c |   12 ++++++++++++
 drivers/bluetooth/hci_uart.h  |    7 ++++++-
 fs/compat_ioctl.c             |    2 ++
 3 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index e8beffe..a57dbfc 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -395,6 +395,9 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	if (!reset)
 		set_bit(HCI_QUIRK_NO_RESET, &hdev->quirks);
 
+	if (test_bit(HCI_UART_RAW_DEVICE, &hu->hdev_flags))
+		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
+
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
 		hci_free_dev(hdev);
@@ -475,6 +478,15 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file * file,
 			return hu->hdev->id;
 		return -EUNATCH;
 
+	case HCIUARTSETFLAGS:
+		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
+			return -EBUSY;
+		hu->hdev_flags = arg;
+		break;
+
+	case HCIUARTGETFLAGS:
+		return hu->hdev_flags;
+
 	default:
 		err = n_tty_ioctl_helper(tty, file, cmd, arg);
 		break;
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 50113db..9694d9d 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -31,6 +31,8 @@
 #define HCIUARTSETPROTO		_IOW('U', 200, int)
 #define HCIUARTGETPROTO		_IOR('U', 201, int)
 #define HCIUARTGETDEVICE	_IOR('U', 202, int)
+#define HCIUARTSETFLAGS		_IOW('U', 203, int)
+#define HCIUARTGETFLAGS		_IOR('U', 204, int)
 
 /* UART protocols */
 #define HCI_UART_MAX_PROTO	5
@@ -41,6 +43,8 @@
 #define HCI_UART_H4DS	3
 #define HCI_UART_LL	4
 
+#define HCI_UART_RAW_DEVICE	0
+
 struct hci_uart;
 
 struct hci_uart_proto {
@@ -57,6 +61,7 @@ struct hci_uart {
 	struct tty_struct	*tty;
 	struct hci_dev		*hdev;
 	unsigned long		flags;
+	unsigned long		hdev_flags;
 
 	struct hci_uart_proto	*proto;
 	void			*priv;
@@ -66,7 +71,7 @@ struct hci_uart {
 	spinlock_t		rx_lock;
 };
 
-/* HCI_UART flag bits */
+/* HCI_UART proto flag bits */
 #define HCI_UART_PROTO_SET	0
 
 /* TX states  */
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 547452d..8ea5e33 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -604,6 +604,8 @@ static int ioc_settimeout(unsigned int fd, unsigned int cmd,
 #define HCIUARTSETPROTO		_IOW('U', 200, int)
 #define HCIUARTGETPROTO		_IOR('U', 201, int)
 #define HCIUARTGETDEVICE	_IOR('U', 202, int)
+#define HCIUARTSETFLAGS		_IOW('U', 203, int)
+#define HCIUARTGETFLAGS		_IOR('U', 204, int)
 
 #define BNEPCONNADD	_IOW('B', 200, int)
 #define BNEPCONNDEL	_IOW('B', 201, int)
-- 
1.7.0.4

