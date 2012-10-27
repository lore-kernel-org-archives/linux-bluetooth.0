Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc: albert.o.ho@intel.com, johan.hedberg@intel.com, tedd.hj.an@gmail.com, tedd.an@intel.com
Subject: [RFC v2 2/2] Bluetooth: Add sample BT USB mini-driver
Date: Fri, 26 Oct 2012 18:23:15 -0700
Message-ID: <1642639.GigJRhv1iv@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds sample BT USB mini-driver

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btusb.c        |    3 +
 drivers/bluetooth/btusb_sample.c |  189 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 192 insertions(+)
 create mode 100644 drivers/bluetooth/btusb_sample.c

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d3f8e7d..53024f0 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -228,6 +228,9 @@ static struct usb_device_id blacklist_table[] = {
 	/* Frontline ComProbe Bluetooth Sniffer */
 	{ USB_DEVICE(0x16d3, 0x0002), .driver_info = (unsigned long) &sniffer },
 
+	/* BT USB mini driver sample */
+	{ USB_DEVICE(0x1234, 0x5678), .driver_info = (unsigned long) &ignore },
+
 	{ }	/* Terminating entry */
 };
 
diff --git a/drivers/bluetooth/btusb_sample.c b/drivers/bluetooth/btusb_sample.c
new file mode 100644
index 0000000..0462b4e
--- /dev/null
+++ b/drivers/bluetooth/btusb_sample.c
@@ -0,0 +1,189 @@
+/*
+ *
+ *  Bluetooth USB Mini Driver - Sample
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
+#include <linux/usb.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "btusb.h"
+
+/*
+ * This is sample BT USB mini-driver to demonstrate how a vendor can execute
+ * the vendor specific device initialization routine and handle vendor specific
+ * events.
+ *
+ * In this sample, it will send one vendor HCI command (but not limited to 1)
+ * as an example.
+ */
+
+#define VENDOR_HCI_SAMPLE_CMD_1   0xfc01
+
+/* mini-driver context */
+struct btusb_sample_data {
+	struct hci_dev		*hdev;
+
+	/* for synchronization */
+	struct completion	wait_evt_complete;
+};
+
+/*
+ * Entry point for device setup.
+ */
+int btusb_sample_setup(struct hci_dev *hdev)
+{
+	int ret;
+	struct btusb_sample_data *data;
+
+	/* initialize the sample data */
+	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		BT_ERR("failed to allocate the memory for data");
+		return -ENOMEM;
+	}
+
+	hdev->vendor_data = data;
+	data->hdev = hdev;
+
+	init_completion(&data->wait_evt_complete);
+
+	/* send command */
+	ret = hci_send_cmd(hdev, VENDOR_HCI_SAMPLE_CMD_1, 0, NULL);
+	if (ret < 0) {
+		BT_ERR("failed to send command: %d", ret);
+		kfree(data);
+		return ret;
+	}
+
+	/* waiting for event */
+	ret = wait_for_completion_interruptible(&data->wait_evt_complete);
+	if (ret < 0) {
+		BT_ERR("wait completion error: %d", ret);
+		kfree(data);
+		return ret;
+	}
+
+
+	/* done */
+	kfree(data);
+
+	return 0;
+}
+
+/*
+ * Vendor specific event handler
+ *
+ * During the vendor setup mode, this function is responsible for handling all
+ * received HCI events.
+ */
+void btusb_sample_event(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btusb_sample_data *data;
+	struct hci_event_hdr *hdr;
+	struct hci_ev_cmd_complete *cc;
+	u16 opcode;
+
+	data = hdev->vendor_data;
+
+	/* event header */
+	hdr = (void *)skb->data;
+	if (hdr->evt != HCI_EV_CMD_COMPLETE) {
+		BT_ERR("invalid event code: %02x", hdr->evt);
+		goto exit_error;
+	}
+	skb_pull(skb, sizeof(*hdr));
+
+	/* command complete event */
+	cc = (void *)skb->data;
+	opcode =le16_to_cpu(cc->opcode);
+	if (opcode != VENDOR_HCI_SAMPLE_CMD_1) {
+		BT_ERR("invalid opcode: %04x", opcode);
+		goto exit_error;
+	}
+	skb_pull(skb, sizeof(*cc));
+
+	/* check status */
+	if ((u8)skb->data[0]) {
+		BT_ERR("evt status failed: %02x", (u8)skb->data[0]);
+		goto exit_error;
+	}
+
+exit_error:
+	/* this is for handling the flow control */
+	del_timer(&hdev->cmd_timer);
+	atomic_set(&hdev->cmd_cnt, 1);
+
+	/* consume the event here */
+	kfree_skb(skb);
+
+	/* complete the wait */
+	complete(&data->wait_evt_complete);
+}
+
+/*
+ * Bind this mini-driver to btusb.ko
+ */
+int btusb_sample_bind(struct hci_dev *hdev)
+{
+	/* set the vendor_setup and vendor_event handlers */
+	hdev->vendor_setup = btusb_sample_setup;
+	hdev->vendor_event = btusb_sample_event;
+
+	return 0;
+}
+
+/*
+ * Unbind this mini-driver to btusb.ko
+ */
+void btusb_sample_unbind(struct hci_dev *hdev)
+{
+
+	return;
+}
+
+static const struct btusb_driver_info sample_info = {
+	.description	= "BT USB mini driver sample",
+	.bind		= btusb_sample_bind,
+	.unbind		= btusb_sample_unbind,
+};
+
+static const struct usb_device_id products[] = {
+	{
+		USB_DEVICE(0x1234, 0x5678),
+		.driver_info = (unsigned long) &sample_info,
+	},
+	{},	/* END */
+};
+MODULE_DEVICE_TABLE(usb, products);
+
+static struct usb_driver btusb_sample_minidriver = {
+	.name		= "btusb sample mini-driver",
+	.probe		= btusb_probe,
+	.disconnect	= btusb_disconnect,
+	.id_table	= products,
+};
+module_usb_driver(btusb_sample_minidriver);
+
+MODULE_AUTHOR("Tedd Ho-Jeong An <tedd.an@intel.com>");
+MODULE_DESCRIPTION("BT USB sample mini driver");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
