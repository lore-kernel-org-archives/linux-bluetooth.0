Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B94361959
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194487; cv=none; b=diZCDHRD0CjNV4KYjulgIkHeb16DAntIlpBY3Juiy44AcA7EmLNUBImvNsIsi2lU+CiJUTdkmdKuxj+9urxwXdl0XvC+337p8JKaBScsxeVRaAzm9TfgWIfrRW+TZpvJr/k0h6d/l0QY7Bu8x2ojjY+H5xtivLv4PPjdLbGUxfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194487; c=relaxed/simple;
	bh=fs45yQpZ4dz6NkieeXgXW2tSZDlUOjcYrLUpFPBtXt4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELY4tXRY0m1h5S6f5cu9wXSr8lhZsviZbPwwpzTYwo+38ZoSlNva0zbKlsmg4t+CnaNLHDwFYvVd91WNv4LlMe86MhLiHl3TEqeqXRjg+akbLx/CAO/1jJBso4ovBkzRxzYsIZjNPuDL9icr5uwWrPNolrcjy/PY9YTaowW+IP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyPIkYBE; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyPIkYBE"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5bfc5b77c02so2984525e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 09:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788194485; x=1788799285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p12s2PyCKB/SGw9dleGzLRT8/uh2Rw7VrrvkpbROw4A=;
        b=ZyPIkYBEK52yMvUPybf1lAhC81I3Eo1Ireon11ISSnVyluj5203BQvpDfCboWqmKEW
         HIRNJuuU3dhhlZOPBCizvUstbN7SW4vZ7GFmjXDAwjI5rRFVgmS1F2mWl0fOzptzRZqr
         QFtf5ZiuRmyym0yANnzVnWnRWaharAFpmIGitUOYNxuu5e1pjl6g4RNjeCXU6/q2UOIo
         0vX6LA1O8WlMIj4k3TrlWZmuz6PcPtbv1vS5oRMOddgseDz1YB8MP365Dh67LhStKY5w
         suSlassGoIQGFFwZPGyu8JK3udv5H2lem2k9owKMJPa8RmNmuskRSz1tcKXyBXIIZ8Ok
         +4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788194485; x=1788799285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=p12s2PyCKB/SGw9dleGzLRT8/uh2Rw7VrrvkpbROw4A=;
        b=jzpsKjMtJ42aQuuLD8tpm6tqp3X60HiQX5O/vFiFD7inpgkLyknrNYbloFI8l5Kkwd
         7huDAtZuFsf0S3ta9dQbFvhAMSs6MAaVcCm19WYbzNppZ6G1fzGWtzI81glGa8wpfTmz
         OOgpADFCUPSA6myWEuIax6z4rvkpL4GscoXlmAzDtNPDGO3M36YkEENS5AUD6kRd1qtb
         D3EIP0wZF2Pt4CcJYWxZ94SrTzGaaCvyR756f/aDfdhyFoHO3mOa0mtkorqJHii3OZAt
         yut2YGKvIC8WsJoCavfqYAic/KR+9eerEUCACcD8pX0zIa7JQqgFkoYqeP5UOUDGWc3y
         e5sw==
X-Gm-Message-State: AFuF++mJPxOjP95V3dbOX8NlE5maR/AtWoK9Wmcl1BpUg+/VkaGd5+AQ
	2syqhry1gBnJf5bOqNWwTspd97sQNTlNS0rtByl/moZlkTNNXbQwYgEV34La/fNY4Dn/+A==
X-Gm-Gg: AR+sD11og2ML1Rq/f77jxhRyaOHdOA+Jrund62ESUb5QSg7y2FBhjBRJX5vMMS8Pjj+
	oXVhmhU2KZ2SEEp8+kKqy4z2l7ni7fGUqw2kx4u3yCUh4Q9ThZ7uYZb9gw8MZDQEUcyan10u80d
	yn62lbG45vEJjGJK1fZ/7Pe5IaEHnSLD9pGw0og9Le3Cc2mMIoyGLD2tPa5QvX6pjSqj18/cVkW
	eh1KMYc3mxuKaniBD+iAPAPYz0Ib7knWqUUMGhT+d856ujeVbURmnh5Tcctj7c/6k9LPyxZet/8
	zM47SyYohQ17FAVrKW4BsfuMOWG4g+M5kos6nErpTsPpdvsdnYCJLBmTaZPtXvNyMY/cQgQzaWd
	b4uko8A293bk7UruCp0FyA+Fj5rZtM9uEjZeSDWlerw9TxerC9K6E4Phz6s2c1ClnlHXeuQEruf
	K2CGE//S4xP1G4WSMhgECsV3ovjr4C2qHdeSM087HahVlk3PGW2qygQ3+yLJ0Tcl4vb93XXafsh
	Po3bz3Rq6+OZQfdJzcBfEBRrw04ObZKWztHiyjGeEh3LiqrYt3ub1Q=
X-Received: by 2002:ac5:c5d5:0:b0:5c6:4bab:4cb2 with SMTP id 71dfb90a1353d-5c68146bb8amr9807955e0c.6.1788194484421;
        Mon, 31 Aug 2026 09:41:24 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c724263c41sm8759775e0c.16.2026.08.31.09.41.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:41:23 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: Move H:4 reassembly into the Bluetooth core
Date: Mon, 31 Aug 2026 12:41:10 -0400
Message-ID: <20260831164112.778064-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831164112.778064-1-luiz.dentz@gmail.com>
References: <20260831164112.778064-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

h4_recv_buf() is currently implemented in hci_h4.c which is only built as
part of the hci_uart module, and only when CONFIG_BT_HCIUART_H4 is
enabled. That makes the H:4 reassembly logic unusable by drivers which do
not depend on hci_uart, e.g. btusb which needs it to implement Bulk
Serialization Mode.

Move the transport agnostic part into the Bluetooth core as
h4_recv_skb(), which takes a struct hci_dev instead of a struct hci_uart,
along with struct h4_recv_pkt and the H4_RECV_* helpers, and keep
h4_recv_buf() as a thin wrapper for the hci_uart protocols.

Since every Bluetooth driver already depends on the bluetooth module this
introduces no new module dependency and no new Kconfig symbol.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_h4.c     | 123 ++-----------------------
 drivers/bluetooth/hci_uart.h   |  39 +-------
 include/net/bluetooth/hci_h4.h |  60 +++++++++++++
 net/bluetooth/Makefile         |   2 +-
 net/bluetooth/hci_h4.c         | 160 +++++++++++++++++++++++++++++++++
 5 files changed, 229 insertions(+), 155 deletions(-)
 create mode 100644 include/net/bluetooth/hci_h4.h
 create mode 100644 net/bluetooth/hci_h4.c

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 767372707498..cbdf51458ec3 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -29,6 +29,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/hci_h4.h>
 
 #include "hci_uart.h"
 
@@ -112,8 +113,9 @@ static int h4_recv(struct hci_uart *hu, const void *data, int count)
 	if (!h4)
 		return -ENODEV;
 
-	h4->rx_skb = h4_recv_buf(hu, h4->rx_skb, data, count,
-				 h4_recv_pkts, ARRAY_SIZE(h4_recv_pkts));
+	h4->rx_skb = h4_recv_skb(hu->hdev, &hu->alignment, &hu->padding,
+				 h4->rx_skb, data, count, h4_recv_pkts,
+				 ARRAY_SIZE(h4_recv_pkts));
 	if (IS_ERR(h4->rx_skb)) {
 		int err = PTR_ERR(h4->rx_skb);
 		bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
@@ -155,120 +157,7 @@ struct sk_buff *h4_recv_buf(struct hci_uart *hu, struct sk_buff *skb,
 			    const unsigned char *buffer, int count,
 			    const struct h4_recv_pkt *pkts, int pkts_count)
 {
-	u8 alignment = hu->alignment ? hu->alignment : 1;
-	struct hci_dev *hdev = hu->hdev;
-
-	/* Check for error from previous call */
-	if (IS_ERR(skb))
-		skb = NULL;
-
-	while (count) {
-		int i, len;
-
-		/* remove padding bytes from buffer */
-		for (; hu->padding && count > 0; hu->padding--) {
-			count--;
-			buffer++;
-		}
-		if (!count)
-			break;
-
-		if (!skb) {
-			for (i = 0; i < pkts_count; i++) {
-				if (buffer[0] != (&pkts[i])->type)
-					continue;
-
-				skb = bt_skb_alloc((&pkts[i])->maxlen,
-						   GFP_ATOMIC);
-				if (!skb)
-					return ERR_PTR(-ENOMEM);
-
-				hci_skb_pkt_type(skb) = (&pkts[i])->type;
-				hci_skb_expect(skb) = (&pkts[i])->hlen;
-				break;
-			}
-
-			/* Check for invalid packet type */
-			if (!skb)
-				return ERR_PTR(-EILSEQ);
-
-			count -= 1;
-			buffer += 1;
-		}
-
-		len = min_t(uint, hci_skb_expect(skb) - skb->len, count);
-		skb_put_data(skb, buffer, len);
-
-		count -= len;
-		buffer += len;
-
-		/* Check for partial packet */
-		if (skb->len < hci_skb_expect(skb))
-			continue;
-
-		for (i = 0; i < pkts_count; i++) {
-			if (hci_skb_pkt_type(skb) == (&pkts[i])->type)
-				break;
-		}
-
-		if (i >= pkts_count) {
-			kfree_skb(skb);
-			return ERR_PTR(-EILSEQ);
-		}
-
-		if (skb->len == (&pkts[i])->hlen) {
-			u16 dlen;
-
-			switch ((&pkts[i])->lsize) {
-			case 0:
-				/* No variable data length */
-				dlen = 0;
-				break;
-			case 1:
-				/* Single octet variable length */
-				dlen = skb->data[(&pkts[i])->loff];
-				hci_skb_expect(skb) += dlen;
-
-				if (skb_tailroom(skb) < dlen) {
-					kfree_skb(skb);
-					return ERR_PTR(-EMSGSIZE);
-				}
-				break;
-			case 2:
-				/* Double octet variable length */
-				dlen = get_unaligned_le16(skb->data +
-							  (&pkts[i])->loff);
-				hci_skb_expect(skb) += dlen;
-
-				if (skb_tailroom(skb) < dlen) {
-					kfree_skb(skb);
-					return ERR_PTR(-EMSGSIZE);
-				}
-				break;
-			default:
-				/* Unsupported variable length */
-				kfree_skb(skb);
-				return ERR_PTR(-EILSEQ);
-			}
-
-			if (!dlen) {
-				hu->padding = (skb->len + 1) % alignment;
-				hu->padding = (alignment - hu->padding) % alignment;
-
-				/* No more data, complete frame */
-				(&pkts[i])->recv(hdev, skb);
-				skb = NULL;
-			}
-		} else {
-			hu->padding = (skb->len + 1) % alignment;
-			hu->padding = (alignment - hu->padding) % alignment;
-
-			/* Complete frame */
-			(&pkts[i])->recv(hdev, skb);
-			skb = NULL;
-		}
-	}
-
-	return skb;
+	return h4_recv_skb(hu->hdev, &hu->alignment, &hu->padding, skb, buffer,
+			   count, pkts, pkts_count);
 }
 EXPORT_SYMBOL_GPL(h4_recv_buf);
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 48ac7ca9334e..7fbe8dffab98 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -8,6 +8,8 @@
  *  Copyright (C) 2004-2005  Marcel Holtmann <marcel@holtmann.org>
  */
 
+#include <net/bluetooth/hci_h4.h>
+
 #ifndef N_HCI
 #define N_HCI	15
 #endif
@@ -121,43 +123,6 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable);
 void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
 			 unsigned int oper_speed);
 
-struct h4_recv_pkt {
-	u8  type;	/* Packet type */
-	u8  hlen;	/* Header length */
-	u8  loff;	/* Data length offset in header */
-	u8  lsize;	/* Data length field size */
-	u16 maxlen;	/* Max overall packet length */
-	int (*recv)(struct hci_dev *hdev, struct sk_buff *skb);
-};
-
-#define H4_RECV_ACL \
-	.type = HCI_ACLDATA_PKT, \
-	.hlen = HCI_ACL_HDR_SIZE, \
-	.loff = 2, \
-	.lsize = 2, \
-	.maxlen = HCI_MAX_FRAME_SIZE \
-
-#define H4_RECV_SCO \
-	.type = HCI_SCODATA_PKT, \
-	.hlen = HCI_SCO_HDR_SIZE, \
-	.loff = 2, \
-	.lsize = 1, \
-	.maxlen = HCI_MAX_SCO_SIZE
-
-#define H4_RECV_EVENT \
-	.type = HCI_EVENT_PKT, \
-	.hlen = HCI_EVENT_HDR_SIZE, \
-	.loff = 1, \
-	.lsize = 1, \
-	.maxlen = HCI_MAX_EVENT_SIZE
-
-#define H4_RECV_ISO \
-	.type = HCI_ISODATA_PKT, \
-	.hlen = HCI_ISO_HDR_SIZE, \
-	.loff = 2, \
-	.lsize = 2, \
-	.maxlen = HCI_MAX_FRAME_SIZE \
-
 #ifdef CONFIG_BT_HCIUART_H4
 int h4_init(void);
 int h4_deinit(void);
diff --git a/include/net/bluetooth/hci_h4.h b/include/net/bluetooth/hci_h4.h
new file mode 100644
index 000000000000..a37e7df8c9ce
--- /dev/null
+++ b/include/net/bluetooth/hci_h4.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  Bluetooth HCI H:4 packet reassembly
+ *
+ *  Copyright (C) 2000-2001  Qualcomm Incorporated
+ *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
+ *  Copyright (C) 2004-2005  Marcel Holtmann <marcel@holtmann.org>
+ */
+
+#ifndef __HCI_H4_H
+#define __HCI_H4_H
+
+#include <linux/skbuff.h>
+#include <linux/types.h>
+
+struct hci_dev;
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
+#define H4_RECV_ISO \
+	.type = HCI_ISODATA_PKT, \
+	.hlen = HCI_ISO_HDR_SIZE, \
+	.loff = 2, \
+	.lsize = 2, \
+	.maxlen = HCI_MAX_FRAME_SIZE \
+
+struct sk_buff *h4_recv_skb(struct hci_dev *hdev, u8 *alignment, u8 *padding,
+			    struct sk_buff *skb, const unsigned char *buffer,
+			    int count, const struct h4_recv_pkt *pkts,
+			    int pkts_count);
+
+#endif /* __HCI_H4_H */
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index ff466ea97436..b78ad98864d4 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -14,7 +14,7 @@ bluetooth_6lowpan-y := 6lowpan.o
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o lib.o \
 	ecdh_helper.o mgmt_util.o mgmt_config.o hci_codec.o eir.o hci_sync.o \
-	hci_drv.o
+	hci_drv.o hci_h4.o
 
 bluetooth-$(CONFIG_DEV_COREDUMP) += coredump.o
 
diff --git a/net/bluetooth/hci_h4.c b/net/bluetooth/hci_h4.c
new file mode 100644
index 000000000000..86f809018062
--- /dev/null
+++ b/net/bluetooth/hci_h4.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Bluetooth HCI H:4 packet reassembly
+ *
+ *  Copyright (C) 2000-2001  Qualcomm Incorporated
+ *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
+ *  Copyright (C) 2004-2005  Marcel Holtmann <marcel@holtmann.org>
+ */
+
+#include <linux/export.h>
+#include <linux/skbuff.h>
+#include <linux/unaligned.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/hci_h4.h>
+
+/* h4_recv_skb - Reassemble H:4 framed packets
+ * @hdev: HCI device the packets are received on
+ * @alignment: optional packet alignment, NULL or 0 means no alignment
+ * @padding: optional padding state carried over between calls
+ * @skb: partially received packet from a previous call, may be NULL or an
+ *	 ERR_PTR returned by a previous call
+ * @buffer: buffer holding the received data
+ * @count: number of bytes in @buffer
+ * @pkts: table of supported packet types
+ * @pkts_count: number of entries in @pkts
+ *
+ * Returns the partially received packet to be passed to the next call, or an
+ * ERR_PTR on error. The returned value can be fed back into this function as
+ * is, but must be checked with IS_ERR() before being freed.
+ */
+struct sk_buff *h4_recv_skb(struct hci_dev *hdev, u8 *alignment, u8 *padding,
+			    struct sk_buff *skb, const unsigned char *buffer,
+			    int count, const struct h4_recv_pkt *pkts,
+			    int pkts_count)
+{
+	u8 align = alignment && *alignment ? *alignment : 1;
+
+	/* Check for error from previous call */
+	if (IS_ERR(skb))
+		skb = NULL;
+
+	while (count) {
+		int i, len;
+
+		/* remove padding bytes from buffer */
+		if (padding) {
+			for (; (*padding) && count > 0; (*padding)--) {
+				count--;
+				buffer++;
+			}
+		}
+
+		if (!count)
+			break;
+
+		if (!skb) {
+			for (i = 0; i < pkts_count; i++) {
+				if (buffer[0] != pkts[i].type)
+					continue;
+
+				skb = bt_skb_alloc(pkts[i].maxlen,
+						   GFP_ATOMIC);
+				if (!skb)
+					return ERR_PTR(-ENOMEM);
+
+				hci_skb_pkt_type(skb) = pkts[i].type;
+				hci_skb_expect(skb) = pkts[i].hlen;
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
+			if (hci_skb_pkt_type(skb) == pkts[i].type)
+				break;
+		}
+
+		if (i >= pkts_count) {
+			kfree_skb(skb);
+			return ERR_PTR(-EILSEQ);
+		}
+
+		if (skb->len == pkts[i].hlen) {
+			u16 dlen;
+
+			switch (pkts[i].lsize) {
+			case 0:
+				/* No variable data length */
+				dlen = 0;
+				break;
+			case 1:
+				/* Single octet variable length */
+				dlen = skb->data[pkts[i].loff];
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
+							  pkts[i].loff);
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
+				if (padding) {
+					*padding = (skb->len + 1) % align;
+					*padding = (align - *padding) % align;
+				}
+
+				/* No more data, complete frame */
+				pkts[i].recv(hdev, skb);
+				skb = NULL;
+			}
+		} else {
+			if (padding) {
+				*padding = (skb->len + 1) % align;
+				*padding = (align - *padding) % align;
+			}
+
+			/* Complete frame */
+			pkts[i].recv(hdev, skb);
+			skb = NULL;
+		}
+	}
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(h4_recv_skb);
-- 
2.54.0

