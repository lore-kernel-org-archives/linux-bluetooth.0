Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 01/10] Bluetooth: btbcm: Introduce generic Broadcom Bluetooth support
Date: Sun,  5 Apr 2015 22:52:10 -0700
Message-Id: <1428299539-8273-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The majority of Broadcom Bluetooth vendor commands are shared between
USB and UART transports. This creates a separate module that eventually
will hold all Broadcom specific commands, but for now just start with
the commands to change the Bluetooth public address and check for the
default address.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig  |  3 ++
 drivers/bluetooth/Makefile |  1 +
 drivers/bluetooth/btbcm.c  | 99 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btbcm.h  | 41 +++++++++++++++++++
 4 files changed, 144 insertions(+)
 create mode 100644 drivers/bluetooth/btbcm.c
 create mode 100644 drivers/bluetooth/btbcm.h

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index f8a41975c30d..4fbe067cd33a 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -2,6 +2,9 @@
 menu "Bluetooth device drivers"
 	depends on BT
 
+config BT_BCM
+	tristate
+
 config BT_HCIBTUSB
 	tristate "HCI USB driver"
 	depends on USB
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 51f9d0c18963..51c98546fa03 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_BT_ATH3K)		+= ath3k.o
 obj-$(CONFIG_BT_MRVL)		+= btmrvl.o
 obj-$(CONFIG_BT_MRVL_SDIO)	+= btmrvl_sdio.o
 obj-$(CONFIG_BT_WILINK)		+= btwilink.o
+obj-$(CONFIG_BT_BCM)		+= btbcm.o
 
 btmrvl-y			:= btmrvl_main.o
 btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o
diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
new file mode 100644
index 000000000000..20c744a9a3f1
--- /dev/null
+++ b/drivers/bluetooth/btbcm.c
@@ -0,0 +1,99 @@
+/*
+ *
+ *  Bluetooth support for Broadcom devices
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
+#include "btbcm.h"
+
+#define VERSION "0.1"
+
+#define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
+
+int btbcm_check_bdaddr(struct hci_dev *hdev)
+{
+	struct hci_rp_read_bd_addr *bda;
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		int err = PTR_ERR(skb);
+		BT_ERR("%s: BCM: Reading device address failed (%d)",
+		       hdev->name, err);
+		return err;
+	}
+
+	if (skb->len != sizeof(*bda)) {
+		BT_ERR("%s: BCM: Device address length mismatch", hdev->name);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	bda = (struct hci_rp_read_bd_addr *)skb->data;
+	if (bda->status) {
+		BT_ERR("%s: BCM: Device address result failed (%02x)",
+		       hdev->name, bda->status);
+		kfree_skb(skb);
+		return -bt_to_errno(bda->status);
+	}
+
+	/* The address 00:20:70:02:A0:00 indicates a BCM20702A0 controller
+	 * with no configured address.
+	 */
+	if (!bacmp(&bda->bdaddr, BDADDR_BCM20702A0)) {
+		BT_INFO("%s: BCM: Using default device address (%pMR)",
+			hdev->name, &bda->bdaddr);
+		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btbcm_check_bdaddr);
+
+int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	struct sk_buff *skb;
+	int err;
+
+	skb = __hci_cmd_sync(hdev, 0xfc01, 6, bdaddr, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		BT_ERR("%s: BCM: Change address command failed (%d)",
+		       hdev->name, err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btbcm_set_bdaddr);
+
+MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
+MODULE_DESCRIPTION("Bluetooth support for Broadcom devices ver " VERSION);
+MODULE_VERSION(VERSION);
+MODULE_LICENSE("GPL");
diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
new file mode 100644
index 000000000000..813f7e7e191d
--- /dev/null
+++ b/drivers/bluetooth/btbcm.h
@@ -0,0 +1,41 @@
+/*
+ *
+ *  Bluetooth support for Broadcom devices
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
+#if IS_ENABLED(CONFIG_BT_BCM)
+
+int btbcm_check_bdaddr(struct hci_dev *hdev);
+int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
+
+#else
+
+static inline int btbcm_check_bdaddr(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif
-- 
2.1.0

