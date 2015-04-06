Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: btintel: Introduce generic Intel Bluetooth support
Date: Mon,  6 Apr 2015 00:52:11 -0700
Message-Id: <1428306734-14210-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The majority of Intel Bluetooth vendor commands are shared between USB
and UART transports. This creates a separate module that eventually
will hold all Intel specific commands, but for now just start with the
commands to change the Bluetooth public address and check for the
default address.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig   |   3 ++
 drivers/bluetooth/Makefile  |   1 +
 drivers/bluetooth/btintel.c | 101 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  41 ++++++++++++++++++
 4 files changed, 146 insertions(+)
 create mode 100644 drivers/bluetooth/btintel.c
 create mode 100644 drivers/bluetooth/btintel.h

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 93351b91bbb4..e4aff8ca7870 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -2,6 +2,9 @@
 menu "Bluetooth device drivers"
 	depends on BT
 
+config BT_INTEL
+	tristate
+
 config BT_BCM
 	tristate
 	select FW_LOADER
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 51c98546fa03..dd0d9c40b999 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_BT_HCIBTUART)	+= btuart_cs.o
 obj-$(CONFIG_BT_HCIBTUSB)	+= btusb.o
 obj-$(CONFIG_BT_HCIBTSDIO)	+= btsdio.o
 
+obj-$(CONFIG_BT_INTEL)		+= btintel.o
 obj-$(CONFIG_BT_ATH3K)		+= ath3k.o
 obj-$(CONFIG_BT_MRVL)		+= btmrvl.o
 obj-$(CONFIG_BT_MRVL_SDIO)	+= btmrvl_sdio.o
diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
new file mode 100644
index 000000000000..2d43d4279b00
--- /dev/null
+++ b/drivers/bluetooth/btintel.c
@@ -0,0 +1,101 @@
+/*
+ *
+ *  Bluetooth support for Intel devices
+ *
+ *  Copyright (C) 2015  Intel Corporation
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
+#include <linux/module.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "btintel.h"
+
+#define VERSION "0.1"
+
+#define BDADDR_INTEL (&(bdaddr_t) {{0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00}})
+
+int btintel_check_bdaddr(struct hci_dev *hdev)
+{
+	struct hci_rp_read_bd_addr *bda;
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		int err = PTR_ERR(skb);
+		BT_ERR("%s: Reading Intel device address failed (%d)",
+		       hdev->name, err);
+		return err;
+	}
+
+	if (skb->len != sizeof(*bda)) {
+		BT_ERR("%s: Intel device address length mismatch", hdev->name);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	bda = (struct hci_rp_read_bd_addr *)skb->data;
+	if (bda->status) {
+		BT_ERR("%s: Intel device address result failed (%02x)",
+		       hdev->name, bda->status);
+		kfree_skb(skb);
+		return -bt_to_errno(bda->status);
+	}
+
+	/* For some Intel based controllers, the default Bluetooth device
+	 * address 00:03:19:9E:8B:00 can be found. These controllers are
+	 * fully operational, but have the danger of duplicate addresses
+	 * and that in turn can cause problems with Bluetooth operation.
+	 */
+	if (!bacmp(&bda->bdaddr, BDADDR_INTEL)) {
+		BT_ERR("%s: Found Intel default device address (%pMR)",
+		       hdev->name, &bda->bdaddr);
+		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_check_bdaddr);
+
+int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	struct sk_buff *skb;
+	int err;
+
+	skb = __hci_cmd_sync(hdev, 0xfc31, 6, bdaddr, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		BT_ERR("%s: Changing Intel device address failed (%d)",
+		       hdev->name, err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_set_bdaddr);
+
+MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
+MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
+MODULE_VERSION(VERSION);
+MODULE_LICENSE("GPL");
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
new file mode 100644
index 000000000000..20be247d2ff6
--- /dev/null
+++ b/drivers/bluetooth/btintel.h
@@ -0,0 +1,41 @@
+/*
+ *
+ *  Bluetooth support for Intel devices
+ *
+ *  Copyright (C) 2015  Intel Corporation
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
+#if IS_ENABLED(CONFIG_BT_INTEL)
+
+int btintel_check_bdaddr(struct hci_dev *hdev);
+int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
+
+#else
+
+static inline int btintel_check_bdaddr(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif
-- 
2.1.0

