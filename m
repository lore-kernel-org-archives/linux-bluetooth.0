Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc: marcel <marcel@holtmann.org>, albert.o.ho@intel.com
Subject: [RFC 1/3] Bluetooth: Add initial skeleton for Intel BT USB support
Date: Mon, 10 Sep 2012 15:35:22 -0700
Message-ID: <2487417.xmkj2FQ8Wf@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds an initial skeleton for Intel BT USB support.

- Extension to execute of vendor specific initialization at early stage
  which is before normal BT controller initialization and after the USB
  is initialized.

- Add initial skeleton of Intel specific initialization functions

- Add Intel BT USB VID/PID

Outpu from /sys/kernel/debug/usb/devices:

T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=8087 ProdID=07dc Rev= 0.00
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/Makefile       |    2 +-
 drivers/bluetooth/btusb.c        |   29 ++++++++++++++
 drivers/bluetooth/btusb.h        |   31 +++++++++++++++
 drivers/bluetooth/btusb_intel.c  |   81 ++++++++++++++++++++++++++++++++++++++
 include/net/bluetooth/hci_core.h |    6 +++
 net/bluetooth/hci_core.c         |   16 ++++++++
 6 files changed, 164 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bluetooth/btusb.h
 create mode 100644 drivers/bluetooth/btusb_intel.c

diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 4afae20..57c7fe2 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_BT_HCIBT3C)	+= bt3c_cs.o
 obj-$(CONFIG_BT_HCIBLUECARD)	+= bluecard_cs.o
 obj-$(CONFIG_BT_HCIBTUART)	+= btuart_cs.o
 
-obj-$(CONFIG_BT_HCIBTUSB)	+= btusb.o
+obj-$(CONFIG_BT_HCIBTUSB)	+= btusb.o btusb_intel.o
 obj-$(CONFIG_BT_HCIBTSDIO)	+= btsdio.o
 
 obj-$(CONFIG_BT_ATH3K)		+= ath3k.o
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f637c25..029c5b7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -27,6 +27,8 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#include "btusb.h"
+
 #define VERSION "0.6"
 
 static bool ignore_dga;
@@ -47,6 +49,8 @@ static struct usb_driver btusb_driver;
 #define BTUSB_BROKEN_ISOC	0x20
 #define BTUSB_WRONG_SCO_MTU	0x40
 #define BTUSB_ATH3012		0x80
+#define BTUSB_INTEL			0x100
+#define BTUSB_DEV_INIT		0x8000
 
 static struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -190,6 +194,9 @@ static struct usb_device_id blacklist_table[] = {
 	/* Frontline ComProbe Bluetooth Sniffer */
 	{ USB_DEVICE(0x16d3, 0x0002), .driver_info = BTUSB_SNIFFER },
 
+	/* Intel Bluetooth device */
+	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_DEV_INIT | BTUSB_INTEL },
+
 	{ }	/* Terminating entry */
 };
 
@@ -235,6 +242,17 @@ struct btusb_data {
 	int suspend_count;
 };
 
+struct btusb_vendor_dev {
+	unsigned long info;
+	int (*vsdev_init)(struct hci_dev *hdev);
+	void (*vsdev_event)(struct hci_dev *hdev, struct sk_buff *skb);
+};
+
+static struct btusb_vendor_dev vendor_dev[] = {
+	{ BTUSB_INTEL, btusb_intel_init, btusb_intel_event },
+	{ 0 }
+};
+
 static int inc_tx(struct btusb_data *data)
 {
 	unsigned long flags;
@@ -1069,6 +1087,17 @@ static int btusb_probe(struct usb_interface *intf,
 		}
 	}
 
+	/* vendor specific device initialization */
+	if (id->driver_info & BTUSB_DEV_INIT) {
+		for (i = 0; vendor_dev[i].info; i++) {
+			if (id->driver_info & vendor_dev[i].info) {
+				hdev->vsdev_init = vendor_dev[i].vsdev_init;
+				hdev->vsdev_event = vendor_dev[i].vsdev_event;
+				break;
+			}
+		}
+	}
+
 	err = hci_register_dev(hdev);
 	if (err < 0) {
 		hci_free_dev(hdev);
diff --git a/drivers/bluetooth/btusb.h b/drivers/bluetooth/btusb.h
new file mode 100644
index 0000000..f03040f
--- /dev/null
+++ b/drivers/bluetooth/btusb.h
@@ -0,0 +1,31 @@
+/*
+ *
+ *  Generic Bluetooth USB driver
+ *
+ *  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#ifndef __BTUSB_H
+#define __BTUSB_H
+
+/* Intel specific device initialization callbacks */
+int btusb_intel_init(struct hci_dev *hdev);
+void btusb_intel_event(struct hci_dev *hdev, struct sk_buff *skb);
+
+#endif /* __BTUSB_H */
diff --git a/drivers/bluetooth/btusb_intel.c b/drivers/bluetooth/btusb_intel.c
new file mode 100644
index 0000000..51c019d
--- /dev/null
+++ b/drivers/bluetooth/btusb_intel.c
@@ -0,0 +1,81 @@
+/*
+ *
+ *  Bluetooth USB Driver - Intel device initialization
+ *
+ *  Copyright (C) 2012  Intel Corporation
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "btusb.h"
+
+/* patch state */
+enum intel_patch_state {
+	INTEL_PATCH_PRE,
+	INTEL_PATCH_VER,
+	INTEL_PATCH_PREP_PATCH,
+	INTEL_PATCH_PATCHING,
+	INTEL_PATCH_POST,
+	INTEL_PATCH_COMPLETED,
+	INTEL_PATCH_ERROR
+};
+
+struct intel_patch_data {
+	struct hci_dev		*hdev;
+
+	int			state;
+};
+
+int btusb_intel_init(struct hci_dev *hdev)
+{
+	struct intel_patch_data *data;
+
+	BT_INFO("Intel BT USB: device initialization - patching device");
+
+	/* initialize the data structure */
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		BT_ERR("failed to allocate the memory for patch data");
+		return -ENOMEM;
+	}
+	hdev->vsdev_init_data = data;
+
+	data->hdev = hdev;
+	data->state = INTEL_PATCH_PRE;
+
+	kfree(data);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btusb_intel_init);
+
+void btusb_intel_event(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct intel_patch_data *data = hdev->vsdev_init_data;
+
+	BT_DBG("Intel BT USB: HCI event handler state=%d", data->state);
+
+	del_timer(&hdev->cmd_timer);
+	atomic_set(&hdev->cmd_cnt, 1);
+	kfree_skb(skb);
+	return;
+}
+EXPORT_SYMBOL_GPL(btusb_intel_event);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6a3337e..cde0ddd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -275,6 +275,12 @@ struct hci_dev {
 	int (*send)(struct sk_buff *skb);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
 	int (*ioctl)(struct hci_dev *hdev, unsigned int cmd, unsigned long arg);
+
+	int  			vsdev_init_completed;
+	void 			*vsdev_init_data;
+
+	int  (*vsdev_init)(struct hci_dev *hdev);
+	void (*vsdev_event)(struct hci_dev *hdev, struct sk_buff *skb);
 };
 
 struct hci_conn {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e407051..4b23812 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -685,6 +685,17 @@ int hci_dev_open(__u16 dev)
 		set_bit(HCI_INIT, &hdev->flags);
 		hdev->init_last_cmd = 0;
 
+		if (hdev->vsdev_init && !hdev->vsdev_init_completed) {
+			ret = hdev->vsdev_init(hdev);
+			BT_DBG("vsdev_init completed: %d", ret);
+			/* set this flag so vsdev_init() execute only once */
+			hdev->vsdev_init_completed = 1;
+			/* make sure to use generic event handler */
+			hdev->vsdev_event = NULL;
+			if (ret < 0)
+				goto done;
+		}
+
 		ret = __hci_request(hdev, hci_init_req, 0, HCI_INIT_TIMEOUT);
 
 		if (lmp_host_le_capable(hdev))
@@ -2119,6 +2130,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 
 	return 0;
 }
+EXPORT_SYMBOL(hci_send_cmd);
 
 /* Get data from the previously sent command */
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
@@ -2800,7 +2812,11 @@ static void hci_rx_work(struct work_struct *work)
 		switch (bt_cb(skb)->pkt_type) {
 		case HCI_EVENT_PKT:
 			BT_DBG("%s Event packet", hdev->name);
+			/* send packet to device init event handler */
+			if (hdev->vsdev_init_completed || !hdev->vsdev_event)
 			hci_event_packet(hdev, skb);
+			else
+				hdev->vsdev_event(hdev, skb);
 			break;
 
 		case HCI_ACLDATA_PKT:
-- 
1.7.9.5
