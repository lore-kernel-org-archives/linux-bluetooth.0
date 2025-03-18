Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D54D1C84B7
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742326281; cv=none; b=qaEB0kWKLxRwv5cXvXd8/GDVDdyggJwu53Pc0K9iU/yZtydG4klLsXCZDjhOENdlJ4VspdE592NnMmJZjY3YDbAStM9bCCdyO0Thj7Hl8FKAEiaoPqTF8uGRfeFP8Mvz3291dCI7ExKxXssP12zNiNAtMxXDG67OnbT85QK1Gos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742326281; c=relaxed/simple;
	bh=8R6ZQnF5TaGduHp9FkjQSdRTu3vXK+o2LlA8IQPT0EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CZ3AH9wI31HnZgzpSuGtyeeluobq06miNXEJsoxRw+FUzC8r72d8Vt7uVqjMmri6p6aZeZ06s9X7YRy9c4YAwHk9qvDtuO6+bHWjqtL7dKznMaxASsNzvSyWB3MczvCqmuQgqvchXQq9/88KhTNNKbVXuZDTBk2a8l5c/RlQ8mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=cqAATSHo; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="cqAATSHo"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3012a0c8496so4689380a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 12:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1742326279; x=1742931079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=19z1Kk5mXf9SmqNPxTrWbr2dcMvFexRCx2f5g7HF46k=;
        b=cqAATSHo2mupXdxRugyRdtSNgr8lQTJSMzgWMIIc/G66+FYwQjRstz82ZJV5S6kXLS
         FFBwq+tPFCdJfJAmHHqydTPArvlftSGiKvodQFBSaDpjq8dAQeLnxw0UnutvtgCxMob8
         fOQ4ihPcDQN0kvfXIFmNmf5moPFjRQ0oaGjY5mx1LV7MB21XOxW9GH1oGLxCgPfsv9/d
         OzeCJ+eeLEdp4eoYVtgwY92tzecX67B+xCXd+OHeDtlYQ89AI0Hagdul80pj4Qz7BO0L
         aVBhlWIwWwsHL8PkzCR9UusYx/T/7td0rCA2yWfH9wIJk2u/u/NAgLpCfVaoh731kT9Z
         +WgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742326279; x=1742931079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19z1Kk5mXf9SmqNPxTrWbr2dcMvFexRCx2f5g7HF46k=;
        b=HJa2QD5Q4HHcgVvE/OzsLJy3EtkmrpuwYaHlpbSpKZl9P7YeXjhNLc0sdPLdSpJ3oH
         sHszWJtWPg6ueSqpN7np6p5d0VMLWYAhtD72viiCJ0cJvDGC5XQzaIL3pnL7NTdWaXhK
         78rDHAF3CT6hqhmQ99se0N5lgSgzEZPu8ncloq01/8cycsOn3G6LuY4lztinsQMTk+1M
         MvKI2yUFCr0k+BhS1TsBnMHI020j1331rSrUq/34sntrYcUeYa2UtwKSobCQnu8AcaQW
         w26+L4DlSUdMweBRz/Sx1BUT4ZgdIT5LU+TunsV8KrKklFhJ1bW8yCnrZmr/prYYlZUF
         vSng==
X-Forwarded-Encrypted: i=1; AJvYcCXD1ho+11FnyEPhwXZNjr7edrApoQYg4AiWyK69yWcKmL4Yydhxnb6NywPKdCwctimYriVOOSeO3tmaPwC7dyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBEpyOuipjVwooPfJIEN1o7wCfV6IUSvS1CMbdV00k+s8IKyiQ
	IS/rq/kpeKfFB/YmqmT0t3E+8wOMj0UAACdUt4OIpWeJ8fXUeCuRo9bwFzF5afY=
X-Gm-Gg: ASbGncvEhxQzUpZdRi+yEL5P5pxtG1rBYxEV2adHP9dMGFx8WXAZMnU5cu86f7625Wx
	IhXSQNgHvXI5sKvsFFGFyeA8sWrWMGRcjgIc9M0s8OJfIrm1yamClal+vrPhMFYAZbhbpwfJ+dF
	5nly3tuOtoeJEjsT4Va6Nj2y5SM6RK+YvlB2zU4vLCyc6o2Z1yAil0+BJFMerWDg0MHntEITHUS
	mNacVPX5tmfrDiAKdWW1eiCiVUkYjNdZYzPRMfBPV0zKtyD4v4J/65ylhIVb98an8onsEJk+h9p
	7AL2PKtmK5ou2GlrlQJvoLMefmUL1oCbJ3CL/5WhTn2Ic1o=
X-Google-Smtp-Source: AGHT+IGtg/Gus/fPA/C0wTqoGIQvSoUpP0NE5t1Cbk1OIUeB6Lmwk6dhW0m3CZ42u0xM6Wx6yXDp7A==
X-Received: by 2002:a17:90b:4c45:b0:2ee:d63f:d73 with SMTP id 98e67ed59e1d1-301b9fcbbc1mr589133a91.11.1742326278694;
        Tue, 18 Mar 2025 12:31:18 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:4680:a100:1c4a:720d:c0fa:efac])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3015363217dsm8638407a91.32.2025.03.18.12.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 12:31:18 -0700 (PDT)
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
	linux-mediatek@lists.infradead.org
Subject: [PATCH][QUESTION] bluetooth: Remove duplicated h4_recv_buf() in header
Date: Tue, 18 Mar 2025 12:31:12 -0700
Message-ID: <2b612e2c1f4fa697b47b5dd9b72f1949d7c206f5.1742324401.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

In the course of other debugging, I've discovered that h4_recv_buf() is
almost completely duplicated in an inline header definiton, and I don't
understand why.

I'd like to clean this up: see the patch below for an explanation.

Does anybody who was around at the time remember any more details about
this? Or failing that, perhaps somebody with access to the bpa10x
hardware can test it with the core function?

Thanks,
Calvin

---8<---
From: Calvin Owens <calvin@wbinvd.org>
Subject: [PATCH] bluetooth: Remove duplicated h4_recv_buf() in header

The "h4_recv.h" header contains a duplicate h4_recv_buf() that is nearly
but not quite identical to the h4_recv_buf() in hci_h4.c.

This duplicated header was added in commit 07eb96a5a7b0 ("Bluetooth:
bpa10x: Use separate h4_recv_buf helper"). Unfortunately, there was no
discussion about it on the list at the time:

    https://lore.kernel.org/all/20180320181855.37297-1-marcel@holtmann.org/
    https://lore.kernel.org/all/20180324091954.73229-2-marcel@holtmann.org/

This is the diff between the two implementations as they exist today:

    --- /home/calvinow/orig.c	2025-03-10 14:43:18.383882623 -0700
    +++ /home/calvinow/copy.c	2025-03-10 14:42:57.109953576 -0700
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

It seems fairly obvious from the above that, if alignment is one,
hu->padding is always zero, and in that case the two functions behave
strictly identically.

Since that is the case for every driver except hci_nokia, clean this up
and let them use the core function. I've done some light testing on
btnxpuart, so far everything seems to work.

I would love to eliminate the duplicate function entirely, but I don't
have access to hardware for bpa10x. Since bpa10x breaking was the
original justification for the change, I've left it there for now. I'm
hoping somebody else can shed more light on this.

Cc: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/bluetooth/btmtksdio.c | 2 +-
 drivers/bluetooth/btmtkuart.c | 2 +-
 drivers/bluetooth/btnxpuart.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index bd5464bde174..47d1073fb4a4 100644
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
index c97e260fcb0c..aeb111a0f242 100644
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
index aa5ec1d444a9..e6db563088cb 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -21,7 +21,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#include "h4_recv.h"
+#include "hci_uart.h"
 
 #define MANUFACTURER_NXP		37
 
-- 
2.47.2

