Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: hci_uart: Add support Broadcom address configuration
Date: Sat,  4 Apr 2015 16:13:03 -0700
Message-Id: <1428189183-12932-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When using vendor detection, this adds support for the Broadcom
specific address configuration command.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig     |  9 ++++++++
 drivers/bluetooth/Makefile    |  1 +
 drivers/bluetooth/hci_bcm.c   | 48 +++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_ldisc.c |  5 +++++
 drivers/bluetooth/hci_uart.h  |  7 ++++++-
 5 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bluetooth/hci_bcm.c

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 4356f718ea3d..e8630b605aa9 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -103,6 +103,15 @@ config BT_HCIUART_INTEL
 
 	  Say Y here to compile support for Intel protocol.
 
+config BT_HCIUART_BCM
+	bool "Broadcom protocol support"
+	depends on BT_HCIUART
+	help
+	  The Broadcom protocol support enables Bluetooth HCI over serial
+	  port interface for Broadcom Bluetooth controllers.
+
+	  Say Y here to compile support for Broadcom protocol.
+
 config BT_HCIBCM203X
 	tristate "HCI BCM203x USB driver"
 	depends on USB
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index adb99457d016..51f9d0c18963 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -30,6 +30,7 @@ hci_uart-$(CONFIG_BT_HCIUART_LL)	+= hci_ll.o
 hci_uart-$(CONFIG_BT_HCIUART_ATH3K)	+= hci_ath.o
 hci_uart-$(CONFIG_BT_HCIUART_3WIRE)	+= hci_h5.o
 hci_uart-$(CONFIG_BT_HCIUART_INTEL)	+= hci_intel.o
+hci_uart-$(CONFIG_BT_HCIUART_BCM)	+= hci_bcm.o
 hci_uart-objs				:= $(hci_uart-y)
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
new file mode 100644
index 000000000000..1a5817bda7c6
--- /dev/null
+++ b/drivers/bluetooth/hci_bcm.c
@@ -0,0 +1,48 @@
+/*
+ *
+ *  Bluetooth HCI UART driver for Broadcom devices
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
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/skbuff.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "hci_uart.h"
+
+int bcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
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
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 03f9defac39d..b6d1ff4fbba6 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -295,6 +295,11 @@ static int hci_uart_setup(struct hci_dev *hdev)
 		hdev->set_bdaddr = intel_set_bdaddr;
 		break;
 #endif
+#ifdef CONFIG_BT_HCIUART_BCM
+	case 15:
+		hdev->set_bdaddr = bcm_set_bdaddr;
+		break;
+#endif
 	}
 
 done:
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 687aa7e9eb2e..4dc8ab3009a9 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -35,7 +35,7 @@
 #define HCIUARTGETFLAGS		_IOR('U', 204, int)
 
 /* UART protocols */
-#define HCI_UART_MAX_PROTO	7
+#define HCI_UART_MAX_PROTO	8
 
 #define HCI_UART_H4	0
 #define HCI_UART_BCSP	1
@@ -44,6 +44,7 @@
 #define HCI_UART_LL	4
 #define HCI_UART_ATH3K	5
 #define HCI_UART_INTEL	6
+#define HCI_UART_BCM	7
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
@@ -123,3 +124,7 @@ int h5_deinit(void);
 #ifdef CONFIG_BT_HCIUART_INTEL
 int intel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 #endif
+
+#ifdef CONFIG_BT_HCIUART_BCM
+int bcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
+#endif
-- 
2.1.0

