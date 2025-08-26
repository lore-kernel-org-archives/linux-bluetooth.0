Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E473D984
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 04:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756181479; cv=none; b=TX8mdSkxZDGa//Sngl05XctFST7NS04BRAiSlRTmwOmEA/ljOwymE8YlZmn9zT/+SistonmfE/82oeKaf2dEPVa5aGPiBC909Jmtko6NUStG0wAyzYmMXklsXthmRmZ3TcsrsJ48vxS1CDdjS0DkHnuIAJqOBcrsHFfzaSOCGb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756181479; c=relaxed/simple;
	bh=/ZYgw3f/YwhbhIGBUGnb907urtjghpCGYhGTcOo4i6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o8LIc4k4bLrqQ89ZByCqZpEEj8qaF9cRd3QCEisLOrIW2HJDue4rOJsoy2lHe95JltH1EjrZJbU5bj+v2nxU1vLiqMaowRb/gefJn6f2LF9odAK+GQWmSaBnn6ibHJ/gAw6e6oqZI1evmi7e7LEU2eXQuEmfxjJFJOFauF57ggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=ZJLbad5A; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="ZJLbad5A"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-771ed4a8124so1243875b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 21:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756181475; x=1756786275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SihI0LEZCbrlbxxp8mie2+EGuARolL/677aRNBJupM8=;
        b=ZJLbad5A5UIAlt/ZedUk5AWCac0c1j5DsPAjCeqBMSwzuUHZvgNRS/hgIwrTM9j0iE
         tKsSX5PJaAHk/lG4Wjtk6XWFrewXw2MPwyU3TMFp5c11m75+O9yXLtxhRclIRUeUWwh8
         rDm2c4S00XRWsi/IqvuAjLjgC9WVkeatJwEsNJ4kyF/3IBwJz0NuESoOgc8xTn3Kj2X4
         VoVa6Nrf/rWl34xdd5TkNqL3buT8MqQde8vGvytnVbvK4KHPInP1NHuKO4lwrro58sXb
         aFYqO20V+qQqGANK0ems/fxNAKRUyI/9J+gJFsLawjTcrVjCg+d9GeQuSa7Yf8XFoS2b
         ABow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756181475; x=1756786275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SihI0LEZCbrlbxxp8mie2+EGuARolL/677aRNBJupM8=;
        b=TADOPUOYDaDwTWEturZlND7UHMpONg4Id2bGgCMYh0ay2lubmWI8X9xhQgzP5ZowSO
         +0/NuuERgbrmVKKLnBbwA/i960NFRXGhWgb5L5Gs8VLN6jIhR9vOBz1+WADKDLo9CgZU
         G/8ffLPmsVIZ2W73un0zFmasvMoHXoKdBbzecebokjb5Ytc1DFr09sMTJmt7CVb165m9
         6FYPwlMuwpCytBRYDVNJfOXHCPfUyX38Zb9NbSEE4AVm4+y839rPrMfHz0+kvxRS36L9
         O0pri+NduxSCfaOxIFTHOhnIf49xDWIsV18LdNKB4wP5pba6DpfUyTaGIOYY6mcmfuPT
         DfjA==
X-Forwarded-Encrypted: i=1; AJvYcCUaED3bIV3hJW/xhamxZpxFJ1mAmzyxLdUXyafeEgqzDJp4I62zatO4GoBvaVnp4RjQdsE8GCbWT+w5W6ZJ8Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcY65BLS1J2/TkwFZbymVR2uIZTY55PjpyqWm4gQLsYGA7ZWIC
	VaazF1tuQTmwYT0UwhYYbhkHGWVMyRNbox1ZF9IE3LlfddrqAcCDhru9aDuJ9kja5UA=
X-Gm-Gg: ASbGncuh8Pyg2NDzaL4156TOtCr2++qEw+YPnfk4Wo8WAkpjO8KWtQPBtM5gwWevf5v
	0+l8nA9niUpcUwH42zCjOjMpDbLyxG5D3cZH4ty5LnlYzS0ra1bd1Ysf9EfUFAVQmB6QifBQyez
	cz4NOMJG2Ul7WvuFpHmLdBHeJmx5hD3sOPJHSempe6bODdPbxUq49KkG7Obd3rrJSRepqw3rkj+
	ZVucbWL0TLaIXml6N7KS9Bw16QpB+/+l9UjraCUT8qkRkpRNmclZUC9Egu9FwpWmU1tLP052DKA
	U78LtL5krCnVUP8zjjjA8m1Ui9CNSaq4NAQMUqMSy3CtZoB/BRxV+ib9kUbkUUj3u/afPVovXhk
	6k61j1iW/d8uFyl2vmJpfFwch
X-Google-Smtp-Source: AGHT+IE6PpW/HOdNS5oZX4PeHU+PjR/DEI/AATl9npioGYOmUwe8aFkAarlXPhw3BZVTIZPHP8fcZw==
X-Received: by 2002:a05:6a20:918a:b0:243:15b9:7790 with SMTP id adf61e73a8af0-24340eb9569mr22274208637.52.1756181475437;
        Mon, 25 Aug 2025 21:11:15 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb891a00sm8039888a12.2.2025.08.25.21.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 21:11:14 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	johan.hedberg@intel.com
Subject: [PATCH] Bluetooth: remove duplicate h4_recv_buf() in header
Date: Mon, 25 Aug 2025 21:11:08 -0700
Message-ID: <be8edf7f8ba8dea6c61272b02fb20a4ac7e1c5a5.1756179634.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "h4_recv.h" header contains a duplicate h4_recv_buf() that is nearly
but not quite identical to the h4_recv_buf() in hci_h4.c.

This duplicated header was added in commit 07eb96a5a7b0 ("Bluetooth:
bpa10x: Use separate h4_recv_buf helper"). I wasn't able to find any
explanation for duplicating the code in the discussion:

    https://lore.kernel.org/all/20180320181855.37297-1-marcel@holtmann.org/
    https://lore.kernel.org/all/20180324091954.73229-2-marcel@holtmann.org/

Unfortunately, in the years since, several other drivers have come to
also rely on this duplicated function, probably by accident. This is, at
the very least, *extremely* confusing. It's also caused real issues when
it's become out-of-sync, see the following:

    ef564119ba83 ("Bluetooth: hci_h4: Add support for ISO packets")
    61b27cdf025b ("Bluetooth: hci_h4: Add support for ISO packets in h4_recv.h")

This is the full diff between the two implementations today:

    --- orig.c
    +++ copy.c
    @@ -1,117 +1,100 @@
     {
    -	struct hci_uart *hu = hci_get_drvdata(hdev);
    -	u8 alignment = hu->alignment ? hu->alignment : 1;
    -
     	/* Check for error from previous call */
     	if (IS_ERR(skb))
     		skb = NULL;

     	while (count) {
     		int i, len;

    -		/* remove padding bytes from buffer */
    -		for (; hu->padding && count > 0; hu->padding--) {
    -			count--;
    -			buffer++;
    -		}
    -		if (!count)
    -			break;
    -
     		if (!skb) {
     			for (i = 0; i < pkts_count; i++) {
     				if (buffer[0] != (&pkts[i])->type)
     					continue;

     				skb = bt_skb_alloc((&pkts[i])->maxlen,
     						   GFP_ATOMIC);
     				if (!skb)
     					return ERR_PTR(-ENOMEM);

     				hci_skb_pkt_type(skb) = (&pkts[i])->type;
     				hci_skb_expect(skb) = (&pkts[i])->hlen;
     				break;
     			}

     			/* Check for invalid packet type */
     			if (!skb)
     				return ERR_PTR(-EILSEQ);

     			count -= 1;
     			buffer += 1;
     		}

     		len = min_t(uint, hci_skb_expect(skb) - skb->len, count);
     		skb_put_data(skb, buffer, len);

     		count -= len;
     		buffer += len;

     		/* Check for partial packet */
     		if (skb->len < hci_skb_expect(skb))
     			continue;

     		for (i = 0; i < pkts_count; i++) {
     			if (hci_skb_pkt_type(skb) == (&pkts[i])->type)
     				break;
     		}

     		if (i >= pkts_count) {
     			kfree_skb(skb);
     			return ERR_PTR(-EILSEQ);
     		}

     		if (skb->len == (&pkts[i])->hlen) {
     			u16 dlen;

     			switch ((&pkts[i])->lsize) {
     			case 0:
     				/* No variable data length */
     				dlen = 0;
     				break;
     			case 1:
     				/* Single octet variable length */
     				dlen = skb->data[(&pkts[i])->loff];
     				hci_skb_expect(skb) += dlen;

     				if (skb_tailroom(skb) < dlen) {
     					kfree_skb(skb);
     					return ERR_PTR(-EMSGSIZE);
     				}
     				break;
     			case 2:
     				/* Double octet variable length */
     				dlen = get_unaligned_le16(skb->data +
     							  (&pkts[i])->loff);
     				hci_skb_expect(skb) += dlen;

     				if (skb_tailroom(skb) < dlen) {
     					kfree_skb(skb);
     					return ERR_PTR(-EMSGSIZE);
     				}
     				break;
     			default:
     				/* Unsupported variable length */
     				kfree_skb(skb);
     				return ERR_PTR(-EILSEQ);
     			}

     			if (!dlen) {
    -				hu->padding = (skb->len + 1) % alignment;
    -				hu->padding = (alignment - hu->padding) % alignment;
    -
     				/* No more data, complete frame */
     				(&pkts[i])->recv(hdev, skb);
     				skb = NULL;
     			}
     		} else {
    -			hu->padding = (skb->len + 1) % alignment;
    -			hu->padding = (alignment - hu->padding) % alignment;
    -
     			/* Complete frame */
     			(&pkts[i])->recv(hdev, skb);
     			skb = NULL;
     		}
     	}

     	return skb;
     }
    -EXPORT_SYMBOL_GPL(h4_recv_buf)

As I read this: If alignment is one, and padding is zero, padding
remains zero throughout the loop. So it seems to me that the two
functions behave strictly identically in that case. All the duplicated
defines are also identical, as is the duplicated h4_recv_pkt structure
declaration.

All four drivers which use the duplicated function use the default
alignment of one, and the default padding of zero. I therefore conclude
the duplicate function may be safely replaced with the core one.

I raised this in an RFC a few months ago, and didn't get much interest:

    https://lore.kernel.org/all/CABBYNZ+ONkYtq2fR-8PtL3X-vetvJ0BdP4MTw9cNpjLDzG3HUQ@mail.gmail.com/

...but I'm still wary I've missed something, and I'd really appreciate
more eyeballs on it.

I tested this successfully on btnxpuart a few months ago, but
unfortunately I no longer have access to that hardware.

Cc: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/bluetooth/bpa10x.c    |   2 +-
 drivers/bluetooth/btmtksdio.c |   2 +-
 drivers/bluetooth/btmtkuart.c |   2 +-
 drivers/bluetooth/btnxpuart.c |   2 +-
 drivers/bluetooth/h4_recv.h   | 153 ----------------------------------
 5 files changed, 4 insertions(+), 157 deletions(-)
 delete mode 100644 drivers/bluetooth/h4_recv.h

diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 8b43dfc755de..b7ba667a3d09 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -20,7 +20,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#include "h4_recv.h"
+#include "hci_uart.h"
 
 #define VERSION "0.11"
 
diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 4fc673640bfc..50abefba6d04 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -29,7 +29,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#include "h4_recv.h"
+#include "hci_uart.h"
 #include "btmtk.h"
 
 #define VERSION "0.1"
diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index 76995cfcd534..d9b90ea2ad38 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -27,7 +27,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#include "h4_recv.h"
+#include "hci_uart.h"
 #include "btmtk.h"
 
 #define VERSION "0.2"
diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 76e7f857fb7d..d5153fed0518 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -24,7 +24,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#include "h4_recv.h"
+#include "hci_uart.h"
 
 #define MANUFACTURER_NXP		37
 
diff --git a/drivers/bluetooth/h4_recv.h b/drivers/bluetooth/h4_recv.h
deleted file mode 100644
index 28cf2d8c2d48..000000000000
--- a/drivers/bluetooth/h4_recv.h
+++ /dev/null
@@ -1,153 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *
- *  Generic Bluetooth HCI UART driver
- *
- *  Copyright (C) 2015-2018  Intel Corporation
- */
-
-#include <linux/unaligned.h>
-
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
-	.maxlen = HCI_MAX_FRAME_SIZE
-
-static inline struct sk_buff *h4_recv_buf(struct hci_dev *hdev,
-					  struct sk_buff *skb,
-					  const unsigned char *buffer,
-					  int count,
-					  const struct h4_recv_pkt *pkts,
-					  int pkts_count)
-{
-	/* Check for error from previous call */
-	if (IS_ERR(skb))
-		skb = NULL;
-
-	while (count) {
-		int i, len;
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
-				/* No more data, complete frame */
-				(&pkts[i])->recv(hdev, skb);
-				skb = NULL;
-			}
-		} else {
-			/* Complete frame */
-			(&pkts[i])->recv(hdev, skb);
-			skb = NULL;
-		}
-	}
-
-	return skb;
-}
-- 
2.49.1

