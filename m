Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: bpa10x: Use separate h4_recv_buf helper
Date: Sat, 24 Mar 2018 10:19:53 +0100
Message-Id: <20180324091954.73229-2-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When adding the alignment and padding support for H:4 packet processing
for the Nokia driver, it broke the h4_recv_buf usage within bpa10x
driver. To fix this use a separate helper function and placing it into a
dedicated h4_recv.h header file.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig   |   3 +-
 drivers/bluetooth/bpa10x.c  |   2 +-
 drivers/bluetooth/h4_recv.h | 160 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+), 3 deletions(-)
 create mode 100644 drivers/bluetooth/h4_recv.h

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index d2abcb768ae8..de13c0e2bfc2 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -243,8 +243,7 @@ config BT_HCIBCM203X
 
 config BT_HCIBPA10X
 	tristate "HCI BPA10x USB driver"
-	depends on USB && BT_HCIUART
-	select BT_HCIUART_H4
+	depends on USB
 	help
 	  Bluetooth HCI BPA10x USB driver.
 	  This driver provides support for the Digianswer BPA 100/105 Bluetooth
diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 801ea4ca65e4..c6f7cc57db14 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -35,7 +35,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#include "hci_uart.h"
+#include "h4_recv.h"
 
 #define VERSION "0.11"
 
diff --git a/drivers/bluetooth/h4_recv.h b/drivers/bluetooth/h4_recv.h
new file mode 100644
index 000000000000..b432651f8236
--- /dev/null
+++ b/drivers/bluetooth/h4_recv.h
@@ -0,0 +1,160 @@
+/*
+ *
+ *  Generic Bluetooth HCI UART driver
+ *
+ *  Copyright (C) 2015-2018  Intel Corporation
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
+#include <asm/unaligned.h>
+
+struct h4_recv_pkt {
+	u8  type;	/* Packet type */
+	u8  hlen;	/* Header length */
+	u8  loff;	/* Data length offset in header */
+	u8  lsize;	/* Data length field size */
+	u16 maxlen;	/* Max overall packet length */
+	int (*recv)(struct hci_dev *hdev, struct sk_buff *skb);
+};
+
+#define H4_RECV_ACL \
+	.type = HCI_ACLDATA_PKT, \
+	.hlen = HCI_ACL_HDR_SIZE, \
+	.loff = 2, \
+	.lsize = 2, \
+	.maxlen = HCI_MAX_FRAME_SIZE \
+
+#define H4_RECV_SCO \
+	.type = HCI_SCODATA_PKT, \
+	.hlen = HCI_SCO_HDR_SIZE, \
+	.loff = 2, \
+	.lsize = 1, \
+	.maxlen = HCI_MAX_SCO_SIZE
+
+#define H4_RECV_EVENT \
+	.type = HCI_EVENT_PKT, \
+	.hlen = HCI_EVENT_HDR_SIZE, \
+	.loff = 1, \
+	.lsize = 1, \
+	.maxlen = HCI_MAX_EVENT_SIZE
+
+static inline struct sk_buff *h4_recv_buf(struct hci_dev *hdev,
+					  struct sk_buff *skb,
+					  const unsigned char *buffer,
+					  int count,
+					  const struct h4_recv_pkt *pkts,
+					  int pkts_count)
+{
+	while (count) {
+		int i, len;
+
+		if (!count)
+			break;
+
+		if (!skb) {
+			for (i = 0; i < pkts_count; i++) {
+				if (buffer[0] != (&pkts[i])->type)
+					continue;
+
+				skb = bt_skb_alloc((&pkts[i])->maxlen,
+						   GFP_ATOMIC);
+				if (!skb)
+					return ERR_PTR(-ENOMEM);
+
+				hci_skb_pkt_type(skb) = (&pkts[i])->type;
+				hci_skb_expect(skb) = (&pkts[i])->hlen;
+				break;
+			}
+
+			/* Check for invalid packet type */
+			if (!skb)
+				return ERR_PTR(-EILSEQ);
+
+			count -= 1;
+			buffer += 1;
+		}
+
+		len = min_t(uint, hci_skb_expect(skb) - skb->len, count);
+		skb_put_data(skb, buffer, len);
+
+		count -= len;
+		buffer += len;
+
+		/* Check for partial packet */
+		if (skb->len < hci_skb_expect(skb))
+			continue;
+
+		for (i = 0; i < pkts_count; i++) {
+			if (hci_skb_pkt_type(skb) == (&pkts[i])->type)
+				break;
+		}
+
+		if (i >= pkts_count) {
+			kfree_skb(skb);
+			return ERR_PTR(-EILSEQ);
+		}
+
+		if (skb->len == (&pkts[i])->hlen) {
+			u16 dlen;
+
+			switch ((&pkts[i])->lsize) {
+			case 0:
+				/* No variable data length */
+				dlen = 0;
+				break;
+			case 1:
+				/* Single octet variable length */
+				dlen = skb->data[(&pkts[i])->loff];
+				hci_skb_expect(skb) += dlen;
+
+				if (skb_tailroom(skb) < dlen) {
+					kfree_skb(skb);
+					return ERR_PTR(-EMSGSIZE);
+				}
+				break;
+			case 2:
+				/* Double octet variable length */
+				dlen = get_unaligned_le16(skb->data +
+							  (&pkts[i])->loff);
+				hci_skb_expect(skb) += dlen;
+
+				if (skb_tailroom(skb) < dlen) {
+					kfree_skb(skb);
+					return ERR_PTR(-EMSGSIZE);
+				}
+				break;
+			default:
+				/* Unsupported variable length */
+				kfree_skb(skb);
+				return ERR_PTR(-EILSEQ);
+			}
+
+			if (!dlen) {
+				/* No more data, complete frame */
+				(&pkts[i])->recv(hdev, skb);
+				skb = NULL;
+			}
+		} else {
+			/* Complete frame */
+			(&pkts[i])->recv(hdev, skb);
+			skb = NULL;
+		}
+	}
+
+	return skb;
+}
-- 
2.14.3

