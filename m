Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/5] Bluetooth: hci_uart: Add HCIUARTSETDEVTYPE ioctl
Date: Thu,  2 Apr 2015 16:37:32 +0200
Message-Id: <1427985456-31536-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1427985456-31536-1-git-send-email-frederic.danis@linux.intel.com>
References: <1427985456-31536-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows user space application to set the correct vendor specific
setup function.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_ldisc.c | 50 +++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_uart.h  |  4 ++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 1363dc6..cb7fcc6 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -467,9 +467,19 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	return 0;
 }
 
+struct hci_uart_devtype_t {
+	char type[HCI_UART_DEVTYPE_SIZE];
+	int (*setup)(struct hci_uart *hu);
+};
+
+struct hci_uart_devtype_t devtypes[] = {
+		{ "", 0 }
+};
+
 static int hci_uart_set_proto(struct hci_uart *hu, int id)
 {
 	struct hci_uart_proto *p;
+	int i;
 	int err;
 
 	p = hci_uart_get_proto(id);
@@ -482,6 +492,13 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
 	hu->proto = p;
 
+	/* Select vendor specific setup */
+	hu->proto->setup = NULL;
+	for (i = 0; devtypes[i].type[0]; i++) {
+		if (!strcmp(devtypes[i].type, hu->dev_type))
+			hu->proto->setup = devtypes[i].setup;
+	}
+
 	err = hci_uart_register_dev(hu);
 	if (err) {
 		p->close(hu);
@@ -507,6 +524,33 @@ static int hci_uart_set_flags(struct hci_uart *hu, unsigned long flags)
 	return 0;
 }
 
+static int hci_tty_ioctl_set_devtype(struct hci_uart *hu, unsigned int cmd,
+							unsigned long arg)
+{
+	unsigned int size = _IOC_SIZE(cmd);
+	char dev_type[HCI_UART_DEVTYPE_SIZE];
+	int i;
+	bool found = false;
+
+	if (size > HCI_UART_DEVTYPE_SIZE)
+		return -EINVAL;
+
+	if (copy_from_user(dev_type, (void __user *)arg, size))
+		return -EFAULT;
+
+	for (i = 0; devtypes[i].type[0]; i++) {
+		if (!strcmp(devtypes[i].type, dev_type))
+			found = true;
+	}
+
+	if (!found)
+		return -EINVAL;
+
+	strncpy(hu->dev_type, dev_type, size);
+
+	return 0;
+}
+
 /* hci_uart_tty_ioctl()
  *
  *    Process IOCTL system call for the tty device.
@@ -565,6 +609,12 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file * file,
 	case HCIUARTGETFLAGS:
 		return hu->hdev_flags;
 
+	case HCIUARTSETDEVTYPE:
+		err = hci_tty_ioctl_set_devtype(hu, cmd, arg);
+		if (err)
+			return err;
+		break;
+
 	default:
 		err = n_tty_ioctl_helper(tty, file, cmd, arg);
 		break;
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 074ed29..bd56409 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -33,6 +33,7 @@
 #define HCIUARTGETDEVICE	_IOR('U', 202, int)
 #define HCIUARTSETFLAGS		_IOW('U', 203, int)
 #define HCIUARTGETFLAGS		_IOR('U', 204, int)
+#define HCIUARTSETDEVTYPE	_IOW('U', 205, int)
 
 /* UART protocols */
 #define HCI_UART_MAX_PROTO	6
@@ -50,6 +51,8 @@
 #define HCI_UART_INIT_PENDING	3
 #define HCI_UART_EXT_CONFIG	4
 
+#define HCI_UART_DEVTYPE_SIZE	32
+
 struct hci_uart;
 
 struct hci_uart_proto {
@@ -68,6 +71,7 @@ struct hci_uart {
 	struct hci_dev		*hdev;
 	unsigned long		flags;
 	unsigned long		hdev_flags;
+	char			dev_type[HCI_UART_DEVTYPE_SIZE];
 
 	struct work_struct	init_ready;
 	struct work_struct	write_work;
-- 
1.9.1

