Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: hci_uart: Add support Intel address configuration
Date: Sat,  4 Apr 2015 16:13:02 -0700
Message-Id: <1428189183-12932-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When using vendor detection, this adds support for the Intel specific
address configuration command.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig     |  9 ++++++++
 drivers/bluetooth/Makefile    |  1 +
 drivers/bluetooth/hci_intel.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_ldisc.c |  5 +++++
 drivers/bluetooth/hci_uart.h  |  7 ++++++-
 5 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bluetooth/hci_intel.c

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 364f080768d0..4356f718ea3d 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -94,6 +94,15 @@ config BT_HCIUART_3WIRE
 
 	  Say Y here to compile support for Three-wire UART protocol.
 
+config BT_HCIUART_INTEL
+	bool "Intel protocol support"
+	depends on BT_HCIUART
+	help
+	  The Intel protocol support enables Bluetooth HCI over serial
+	  port interface for Intel Bluetooth controllers.
+
+	  Say Y here to compile support for Intel protocol.
+
 config BT_HCIBCM203X
 	tristate "HCI BCM203x USB driver"
 	depends on USB
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 9fe8a875a827..adb99457d016 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -29,6 +29,7 @@ hci_uart-$(CONFIG_BT_HCIUART_BCSP)	+= hci_bcsp.o
 hci_uart-$(CONFIG_BT_HCIUART_LL)	+= hci_ll.o
 hci_uart-$(CONFIG_BT_HCIUART_ATH3K)	+= hci_ath.o
 hci_uart-$(CONFIG_BT_HCIUART_3WIRE)	+= hci_h5.o
+hci_uart-$(CONFIG_BT_HCIUART_INTEL)	+= hci_intel.o
 hci_uart-objs				:= $(hci_uart-y)
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
new file mode 100644
index 000000000000..b7bd50a41080
--- /dev/null
+++ b/drivers/bluetooth/hci_intel.c
@@ -0,0 +1,48 @@
+/*
+ *
+ *  Bluetooth HCI UART driver for Intel devices
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
+int intel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
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
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index b1e8083044ce..03f9defac39d 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -290,6 +290,11 @@ static int hci_uart_setup(struct hci_dev *hdev)
 	ver = (struct hci_rp_read_local_version *)skb->data;
 
 	switch (le16_to_cpu(ver->manufacturer)) {
+#ifdef CONFIG_BT_HCIUART_INTEL
+	case 2:
+		hdev->set_bdaddr = intel_set_bdaddr;
+		break;
+#endif
 	}
 
 done:
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 22a5f7c74266..687aa7e9eb2e 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -35,7 +35,7 @@
 #define HCIUARTGETFLAGS		_IOR('U', 204, int)
 
 /* UART protocols */
-#define HCI_UART_MAX_PROTO	6
+#define HCI_UART_MAX_PROTO	7
 
 #define HCI_UART_H4	0
 #define HCI_UART_BCSP	1
@@ -43,6 +43,7 @@
 #define HCI_UART_H4DS	3
 #define HCI_UART_LL	4
 #define HCI_UART_ATH3K	5
+#define HCI_UART_INTEL	6
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
@@ -118,3 +119,7 @@ int ath_deinit(void);
 int h5_init(void);
 int h5_deinit(void);
 #endif
+
+#ifdef CONFIG_BT_HCIUART_INTEL
+int intel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
+#endif
-- 
2.1.0

