Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	marcel@holtmann.org
Cc: johan.hedberg@intel.com, albert.o.ho@intel.com,
	tedd.hj.an@gmail.com
Subject: [RFC 2/2] Bluetooth: Add BT USB mini driver template
Date: Fri, 21 Sep 2012 18:59:53 -0700
Message-ID: <2904542.YtJ1Wo3BEY@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds BT USB mini driver template.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/Makefile         |    1 +
 drivers/bluetooth/btusb.c          |    3 ++
 drivers/bluetooth/btusb_template.c |   78 ++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)
 create mode 100644 drivers/bluetooth/btusb_template.c

diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 4afae20..b4daa01 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_BT_HCIBLUECARD)	+= bluecard_cs.o
 obj-$(CONFIG_BT_HCIBTUART)	+= btuart_cs.o
 
 obj-$(CONFIG_BT_HCIBTUSB)	+= btusb.o
+obj-$(CONFIG_BT_HCIBTUSB)	+= btusb_template.o
 obj-$(CONFIG_BT_HCIBTSDIO)	+= btsdio.o
 
 obj-$(CONFIG_BT_ATH3K)		+= ath3k.o
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index afa1558..864eb77 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -235,6 +235,9 @@ static struct usb_device_id blacklist_table[] = {
 	/* Frontline ComProbe Bluetooth Sniffer */
 	{ USB_DEVICE(0x16d3, 0x0002), .driver_info = (unsigned long) &sniffer },
 
+	/* BT USB mini driver template */
+	{ USB_DEVICE(0x1234, 0x5678), .driver_info = (unsigned long) &ignore },
+
 	{ }	/* Terminating entry */
 };
 
diff --git a/drivers/bluetooth/btusb_template.c b/drivers/bluetooth/btusb_template.c
new file mode 100644
index 0000000..1e1d2da
--- /dev/null
+++ b/drivers/bluetooth/btusb_template.c
@@ -0,0 +1,78 @@
+/*
+ *
+ *  Bluetooth USB Mini Driver - Template
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
+int btusb_template_init(struct hci_dev *hdev)
+{
+	/*
+	 * TOOD: Implement vendor specific initialization
+	 */
+	return 0;
+}
+
+void btusb_template_event(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	/*
+	 * TODO: Implement vendor specific event handler routine
+	 */
+	return;
+}
+
+static const struct btusb_driver_info template_info = {
+	.description	= "BT USB mini driver template",
+	.vsdev_init	= btusb_template_init,
+	.vsdev_event	= btusb_template_event,
+};
+
+static const struct usb_device_id products[] = {
+	{
+		USB_DEVICE(0x1234, 0x5678),
+		.driver_info = (unsigned long) &template_info,
+	},
+	{},	/* END */
+};
+MODULE_DEVICE_TABLE(usb, products);
+
+static struct usb_driver btusb_template_minidriver = {
+	.name		= "btusb_template mini driver",
+	.probe		= btusb_probe,
+	.disconnect	= btusb_disconnect,
+#ifdef CONFIG_PM
+	.suspend	= btusb_suspend,
+	.resume		= btusb_resume,
+#endif
+	.id_table	= products,
+	.supports_autosuspend = 1,
+	.disable_hub_initiated_lpm = 1,
+};
+module_usb_driver(btusb_template_minidriver);
+
+MODULE_AUTHOR("Tedd Ho-Jeong An <tedd.an@intel.com>");
+MODULE_DESCRIPTION("Sample BT USB mini driver");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5


