Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6412D3A9D;
	Tue, 26 Aug 2025 05:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756187109; cv=none; b=ZN/NMPMk9CI+Ahl2yoS80VhDaAZDOlIc/eVX4P5lk0rjEasEjtKKuuRKSyA+q1RDknVZ/ksQCzMarLMfnplwp91Q8ptO4J1KUr1tDINhhDqsqAQ0voZf9uuRGV6fc1+L8D1dDwrUDNqMPfuf2gHEEZDIal3obsFjBPP6/gOjO1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756187109; c=relaxed/simple;
	bh=Xl6VfjCpmBKIbOhvtTRt/qN6bTkAvmzaG29/nSYcRtw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nw98XP1edZUcJ6JoZN1SWS9p5+t5S34D4PsSRN2BiKoBpe8BjXDw/zSvgJ10NZJcH9pDzWb0exVxIniJ3RmpOmH5xgv0uYLlsisKrfMm5oNku84pbIsHGbr2mPASJh7gzSMANUEYWpZOK+9u2g/VPt2bpLkovk0ItS+a7hY+9ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7cb.dynamic.kabel-deutschland.de [95.90.247.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id F403A6028826D;
	Tue, 26 Aug 2025 07:44:37 +0200 (CEST)
Message-ID: <bdd4c3f0-4ba4-4c86-b1b7-afe3c9834ae0@molgen.mpg.de>
Date: Tue, 26 Aug 2025 07:44:37 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: remove duplicate h4_recv_buf() in header
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Amitkumar Karwar <amitkumar.karwar@nxp.com>,
 Neeraj Kale <neeraj.sanjaykale@nxp.com>, linux-bluetooth@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <be8edf7f8ba8dea6c61272b02fb20a4ac7e1c5a5.1756179634.git.calvin@wbinvd.org>
 <e9bbe0bb-b70d-445b-a7ff-b0ab2eef6c6f@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <e9bbe0bb-b70d-445b-a7ff-b0ab2eef6c6f@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: Remove Johan’s bouncing address]

Am 26.08.25 um 07:40 schrieb Paul Menzel:
> Dear Calvin,
> 
> 
> Thank you for your patch.
> 
> Am 26.08.25 um 06:11 schrieb Calvin Owens:
>> The "h4_recv.h" header contains a duplicate h4_recv_buf() that is nearly
>> but not quite identical to the h4_recv_buf() in hci_h4.c.
>>
>> This duplicated header was added in commit 07eb96a5a7b0 ("Bluetooth:
>> bpa10x: Use separate h4_recv_buf helper"). I wasn't able to find any
>> explanation for duplicating the code in the discussion:
>>
>>      https://lore.kernel.org/all/20180320181855.37297-1-marcel@holtmann.org/
>>      https://lore.kernel.org/all/20180324091954.73229-2-marcel@holtmann.org/
>>
>> Unfortunately, in the years since, several other drivers have come to
>> also rely on this duplicated function, probably by accident. This is, at
>> the very least, *extremely* confusing. It's also caused real issues when
>> it's become out-of-sync, see the following:
>>
>>      ef564119ba83 ("Bluetooth: hci_h4: Add support for ISO packets")
>>      61b27cdf025b ("Bluetooth: hci_h4: Add support for ISO packets in h4_recv.h")
>>
>> This is the full diff between the two implementations today:
>>
>>      --- orig.c
>>      +++ copy.c
>>      @@ -1,117 +1,100 @@
>>       {
>>      -    struct hci_uart *hu = hci_get_drvdata(hdev);
>>      -    u8 alignment = hu->alignment ? hu->alignment : 1;
>>      -
>>           /* Check for error from previous call */
>>           if (IS_ERR(skb))
>>               skb = NULL;
>>
>>           while (count) {
>>               int i, len;
>>
>>      -        /* remove padding bytes from buffer */
>>      -        for (; hu->padding && count > 0; hu->padding--) {
>>      -            count--;
>>      -            buffer++;
>>      -        }
>>      -        if (!count)
>>      -            break;
>>      -
>>               if (!skb) {
>>                   for (i = 0; i < pkts_count; i++) {
>>                       if (buffer[0] != (&pkts[i])->type)
>>                           continue;
>>
>>                       skb = bt_skb_alloc((&pkts[i])->maxlen,
>>                                  GFP_ATOMIC);
>>                       if (!skb)
>>                           return ERR_PTR(-ENOMEM);
>>
>>                       hci_skb_pkt_type(skb) = (&pkts[i])->type;
>>                       hci_skb_expect(skb) = (&pkts[i])->hlen;
>>                       break;
>>                   }
>>
>>                   /* Check for invalid packet type */
>>                   if (!skb)
>>                       return ERR_PTR(-EILSEQ);
>>
>>                   count -= 1;
>>                   buffer += 1;
>>               }
>>
>>               len = min_t(uint, hci_skb_expect(skb) - skb->len, count);
>>               skb_put_data(skb, buffer, len);
>>
>>               count -= len;
>>               buffer += len;
>>
>>               /* Check for partial packet */
>>               if (skb->len < hci_skb_expect(skb))
>>                   continue;
>>
>>               for (i = 0; i < pkts_count; i++) {
>>                   if (hci_skb_pkt_type(skb) == (&pkts[i])->type)
>>                       break;
>>               }
>>
>>               if (i >= pkts_count) {
>>                   kfree_skb(skb);
>>                   return ERR_PTR(-EILSEQ);
>>               }
>>
>>               if (skb->len == (&pkts[i])->hlen) {
>>                   u16 dlen;
>>
>>                   switch ((&pkts[i])->lsize) {
>>                   case 0:
>>                       /* No variable data length */
>>                       dlen = 0;
>>                       break;
>>                   case 1:
>>                       /* Single octet variable length */
>>                       dlen = skb->data[(&pkts[i])->loff];
>>                       hci_skb_expect(skb) += dlen;
>>
>>                       if (skb_tailroom(skb) < dlen) {
>>                           kfree_skb(skb);
>>                           return ERR_PTR(-EMSGSIZE);
>>                       }
>>                       break;
>>                   case 2:
>>                       /* Double octet variable length */
>>                       dlen = get_unaligned_le16(skb->data +
>>                                     (&pkts[i])->loff);
>>                       hci_skb_expect(skb) += dlen;
>>
>>                       if (skb_tailroom(skb) < dlen) {
>>                           kfree_skb(skb);
>>                           return ERR_PTR(-EMSGSIZE);
>>                       }
>>                       break;
>>                   default:
>>                       /* Unsupported variable length */
>>                       kfree_skb(skb);
>>                       return ERR_PTR(-EILSEQ);
>>                   }
>>
>>                   if (!dlen) {
>>      -                hu->padding = (skb->len + 1) % alignment;
>>      -                hu->padding = (alignment - hu->padding) % alignment;
>>      -
>>                       /* No more data, complete frame */
>>                       (&pkts[i])->recv(hdev, skb);
>>                       skb = NULL;
>>                   }
>>               } else {
>>      -            hu->padding = (skb->len + 1) % alignment;
>>      -            hu->padding = (alignment - hu->padding) % alignment;
>>      -
>>                   /* Complete frame */
>>                   (&pkts[i])->recv(hdev, skb);
>>                   skb = NULL;
>>               }
>>           }
>>
>>           return skb;
>>       }
>>      -EXPORT_SYMBOL_GPL(h4_recv_buf)
>>
>> As I read this: If alignment is one, and padding is zero, padding
>> remains zero throughout the loop. So it seems to me that the two
>> functions behave strictly identically in that case. All the duplicated
>> defines are also identical, as is the duplicated h4_recv_pkt structure
>> declaration.
>>
>> All four drivers which use the duplicated function use the default
>> alignment of one, and the default padding of zero. I therefore conclude
>> the duplicate function may be safely replaced with the core one.
>>
>> I raised this in an RFC a few months ago, and didn't get much interest:
>>
>>      https://lore.kernel.org/all/CABBYNZ+ONkYtq2fR-8PtL3X-vetvJ0BdP4MTw9cNpjLDzG3HUQ@mail.gmail.com/
>>
>> ...but I'm still wary I've missed something, and I'd really appreciate
>> more eyeballs on it.
>>
>> I tested this successfully on btnxpuart a few months ago, but
>> unfortunately I no longer have access to that hardware.
> 
> Great analysis. Thank you for your time writing this up.
> 
>> Cc: Marcel Holtmann <marcel@holtmann.org>
>> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
>> ---
>>   drivers/bluetooth/bpa10x.c    |   2 +-
>>   drivers/bluetooth/btmtksdio.c |   2 +-
>>   drivers/bluetooth/btmtkuart.c |   2 +-
>>   drivers/bluetooth/btnxpuart.c |   2 +-
>>   drivers/bluetooth/h4_recv.h   | 153 ----------------------------------
>>   5 files changed, 4 insertions(+), 157 deletions(-)
>>   delete mode 100644 drivers/bluetooth/h4_recv.h
>>
>> diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
>> index 8b43dfc755de..b7ba667a3d09 100644
>> --- a/drivers/bluetooth/bpa10x.c
>> +++ b/drivers/bluetooth/bpa10x.c
>> @@ -20,7 +20,7 @@
>>   #include <net/bluetooth/bluetooth.h>
>>   #include <net/bluetooth/hci_core.h>
>> -#include "h4_recv.h"
>> +#include "hci_uart.h"
>>   #define VERSION "0.11"
>> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
>> index 4fc673640bfc..50abefba6d04 100644
>> --- a/drivers/bluetooth/btmtksdio.c
>> +++ b/drivers/bluetooth/btmtksdio.c
>> @@ -29,7 +29,7 @@
>>   #include <net/bluetooth/bluetooth.h>
>>   #include <net/bluetooth/hci_core.h>
>> -#include "h4_recv.h"
>> +#include "hci_uart.h"
>>   #include "btmtk.h"
>>   #define VERSION "0.1"
>> diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
>> index 76995cfcd534..d9b90ea2ad38 100644
>> --- a/drivers/bluetooth/btmtkuart.c
>> +++ b/drivers/bluetooth/btmtkuart.c
>> @@ -27,7 +27,7 @@
>>   #include <net/bluetooth/bluetooth.h>
>>   #include <net/bluetooth/hci_core.h>
>> -#include "h4_recv.h"
>> +#include "hci_uart.h"
>>   #include "btmtk.h"
>>   #define VERSION "0.2"
>> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
>> index 76e7f857fb7d..d5153fed0518 100644
>> --- a/drivers/bluetooth/btnxpuart.c
>> +++ b/drivers/bluetooth/btnxpuart.c
>> @@ -24,7 +24,7 @@
>>   #include <net/bluetooth/bluetooth.h>
>>   #include <net/bluetooth/hci_core.h>
>> -#include "h4_recv.h"
>> +#include "hci_uart.h"
>>   #define MANUFACTURER_NXP        37
>> diff --git a/drivers/bluetooth/h4_recv.h b/drivers/bluetooth/h4_recv.h
>> deleted file mode 100644
>> index 28cf2d8c2d48..000000000000
>> --- a/drivers/bluetooth/h4_recv.h
>> +++ /dev/null
>> @@ -1,153 +0,0 @@
>> -/* SPDX-License-Identifier: GPL-2.0-or-later */
>> -/*
>> - *
>> - *  Generic Bluetooth HCI UART driver
>> - *
>> - *  Copyright (C) 2015-2018  Intel Corporation
>> - */
>> -
>> -#include <linux/unaligned.h>
>> -
>> -struct h4_recv_pkt {
>> -    u8  type;    /* Packet type */
>> -    u8  hlen;    /* Header length */
>> -    u8  loff;    /* Data length offset in header */
>> -    u8  lsize;    /* Data length field size */
>> -    u16 maxlen;    /* Max overall packet length */
>> -    int (*recv)(struct hci_dev *hdev, struct sk_buff *skb);
>> -};
>> -
>> -#define H4_RECV_ACL \
>> -    .type = HCI_ACLDATA_PKT, \
>> -    .hlen = HCI_ACL_HDR_SIZE, \
>> -    .loff = 2, \
>> -    .lsize = 2, \
>> -    .maxlen = HCI_MAX_FRAME_SIZE \
>> -
>> -#define H4_RECV_SCO \
>> -    .type = HCI_SCODATA_PKT, \
>> -    .hlen = HCI_SCO_HDR_SIZE, \
>> -    .loff = 2, \
>> -    .lsize = 1, \
>> -    .maxlen = HCI_MAX_SCO_SIZE
>> -
>> -#define H4_RECV_EVENT \
>> -    .type = HCI_EVENT_PKT, \
>> -    .hlen = HCI_EVENT_HDR_SIZE, \
>> -    .loff = 1, \
>> -    .lsize = 1, \
>> -    .maxlen = HCI_MAX_EVENT_SIZE
>> -
>> -#define H4_RECV_ISO \
>> -    .type = HCI_ISODATA_PKT, \
>> -    .hlen = HCI_ISO_HDR_SIZE, \
>> -    .loff = 2, \
>> -    .lsize = 2, \
>> -    .maxlen = HCI_MAX_FRAME_SIZE
>> -
>> -static inline struct sk_buff *h4_recv_buf(struct hci_dev *hdev,
>> -                      struct sk_buff *skb,
>> -                      const unsigned char *buffer,
>> -                      int count,
>> -                      const struct h4_recv_pkt *pkts,
>> -                      int pkts_count)
>> -{
>> -    /* Check for error from previous call */
>> -    if (IS_ERR(skb))
>> -        skb = NULL;
>> -
>> -    while (count) {
>> -        int i, len;
>> -
>> -        if (!skb) {
>> -            for (i = 0; i < pkts_count; i++) {
>> -                if (buffer[0] != (&pkts[i])->type)
>> -                    continue;
>> -
>> -                skb = bt_skb_alloc((&pkts[i])->maxlen,
>> -                           GFP_ATOMIC);
>> -                if (!skb)
>> -                    return ERR_PTR(-ENOMEM);
>> -
>> -                hci_skb_pkt_type(skb) = (&pkts[i])->type;
>> -                hci_skb_expect(skb) = (&pkts[i])->hlen;
>> -                break;
>> -            }
>> -
>> -            /* Check for invalid packet type */
>> -            if (!skb)
>> -                return ERR_PTR(-EILSEQ);
>> -
>> -            count -= 1;
>> -            buffer += 1;
>> -        }
>> -
>> -        len = min_t(uint, hci_skb_expect(skb) - skb->len, count);
>> -        skb_put_data(skb, buffer, len);
>> -
>> -        count -= len;
>> -        buffer += len;
>> -
>> -        /* Check for partial packet */
>> -        if (skb->len < hci_skb_expect(skb))
>> -            continue;
>> -
>> -        for (i = 0; i < pkts_count; i++) {
>> -            if (hci_skb_pkt_type(skb) == (&pkts[i])->type)
>> -                break;
>> -        }
>> -
>> -        if (i >= pkts_count) {
>> -            kfree_skb(skb);
>> -            return ERR_PTR(-EILSEQ);
>> -        }
>> -
>> -        if (skb->len == (&pkts[i])->hlen) {
>> -            u16 dlen;
>> -
>> -            switch ((&pkts[i])->lsize) {
>> -            case 0:
>> -                /* No variable data length */
>> -                dlen = 0;
>> -                break;
>> -            case 1:
>> -                /* Single octet variable length */
>> -                dlen = skb->data[(&pkts[i])->loff];
>> -                hci_skb_expect(skb) += dlen;
>> -
>> -                if (skb_tailroom(skb) < dlen) {
>> -                    kfree_skb(skb);
>> -                    return ERR_PTR(-EMSGSIZE);
>> -                }
>> -                break;
>> -            case 2:
>> -                /* Double octet variable length */
>> -                dlen = get_unaligned_le16(skb->data +
>> -                              (&pkts[i])->loff);
>> -                hci_skb_expect(skb) += dlen;
>> -
>> -                if (skb_tailroom(skb) < dlen) {
>> -                    kfree_skb(skb);
>> -                    return ERR_PTR(-EMSGSIZE);
>> -                }
>> -                break;
>> -            default:
>> -                /* Unsupported variable length */
>> -                kfree_skb(skb);
>> -                return ERR_PTR(-EILSEQ);
>> -            }
>> -
>> -            if (!dlen) {
>> -                /* No more data, complete frame */
>> -                (&pkts[i])->recv(hdev, skb);
>> -                skb = NULL;
>> -            }
>> -        } else {
>> -            /* Complete frame */
>> -            (&pkts[i])->recv(hdev, skb);
>> -            skb = NULL;
>> -        }
>> -    }
>> -
>> -    return skb;
>> -}
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul
