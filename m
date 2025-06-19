Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81FF246BC5
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750363993; cv=none; b=a4FujhgBoKRx0uvHPSID/shQS2LK7Bkq7VylADoFnyCgagIUZ380fOC8w4BNh0FIMTq7FWnHL1utA1iH49wnKnbTpeK6SZ8VfLzf4PSLkiFaZRw0c5x1HcQw/V2T/hWIkWZ0aJbkE5jgmB4MdZ4O4c0TTy4SGNo9tcC5s8mTavE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750363993; c=relaxed/simple;
	bh=kSdgWxPgv152+1EWzb8tdRstPss2zCu2kNijX8QWSSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bR1y6fLlXcJEh8uRkBcS7McaZW0sg5K9/PBif2X36wJ2X30mz5keM9ZH40FS012b12Vy/ZNCMnmAiDmjFbgyp6K8SyD83Zg/eOlVd0iK9BGEis6jDO1fFohDF8XBI7feN0fuqOeW9XZCmwrxSH+fK0/U9PJSy7Our05sSPupnz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtcrlBcp; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtcrlBcp"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b7cf56cacso10791701fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 13:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750363989; x=1750968789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvzEcIszNXLy6sMWKfShIUavg6InEqjQ4A1ukHcOIzw=;
        b=KtcrlBcpQoFK6Lj32rx+ab8kEzywkBxSNDNHZ1ns2bAV3n6LVB86WzMrYziKV9Ds1b
         /uqr4Q5fEFuk1B1USpua8kW+PjxLrt/S5wPaW3VxfWbivEVGlXcQUJhk0WptiDNwOHHs
         AjgUNUquJWfky4gn0J20QPqyeMSnZd5aLw7OSc6aez0f4U/ZG2aatsjIYSeUD9LEP8PQ
         LpfIIMeBCYrO+N2JkSUgJcaOut24n5XAd6v/MaMEqwaZZZe3jO51r24GQkXOwvsajybY
         9sBQBtmxM3eZvn6bbm/Hmsusfap/06/kzV+LDRMRfriOnALftUraaC/Q4BYr1wshPqeI
         9wEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750363989; x=1750968789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvzEcIszNXLy6sMWKfShIUavg6InEqjQ4A1ukHcOIzw=;
        b=AJNwU7zsTS+5AV/5tvoMr+csr36LMx1SrnKr0izFnYoqZ+8UdORBFQdh7YfXRIIzQa
         RJVXB8B9Ix12wNaOqmUhJtOKCQpem0kSPj04Wn+tA7vBXG/aYd0DI7yJVjIQeLR4vh0t
         q8yhfIq+gChGvzXKggudfjnIpWxf6GUKqESqA+IT7YKvjJaOgVoX3lihQaFQ2ZJBU4H8
         J8X8k57LHDGkEApNbMCa6XB1iiexeDMgojVbd+Y6ywIEzzBVvT7B+VFErKSbRxqSSOYM
         xBvpRK7OKeF8N1E0rBYTvWcV6O70f2ERtzS4UVuk/Ln9/g0XLwGmQCcviFehIDkzkbS1
         V/9g==
X-Gm-Message-State: AOJu0YwHztiW1fkfQXbWCyostMWOIWEHIQ49dDdlrr1hHdDdu01tI+1I
	vgZ07pWrr90Dy1VgcjvZuD37bU4ai6wcUPVYAH7/Th6X/h4qsUSn7KOmTuuXd2d70CAUg6zqf48
	fYpNyH0h/tOqTbIm5yaDxSy8OO7BB6dQ=
X-Gm-Gg: ASbGncsklqQWHNCVqPnUczj2O3ubleooPKatZcSPvf4R+39MiW6O4YdhXIg2QJ8grI0
	ZwHp/8bsLmXQyS5SQSLpQcrZb6P6rBMIndEcw2VVvpaoLAoWbpQeoy0T0AoQPxey2rWxNm9Pt0x
	dQawQCreV0VaGZnjsWzVyteoKgw7vQa9Z/rAOTUsn/wYSJj7f1iuLB
X-Google-Smtp-Source: AGHT+IHBWDNQl404pnu4LEed7C0s07HFYq/5tWP4y/ZVqYgN6UvuYThosEpbuAk8GsNtg9ZUHeFGi1/bBf+zrXWr7MU=
X-Received: by 2002:a05:651c:381:b0:32b:72c8:9a5d with SMTP id
 38308e7fff4ca-32b98f38ba9mr393811fa.0.1750363988743; Thu, 19 Jun 2025
 13:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABtds-1fKyFYvU1jL9njmhfphU0XytO+F5mBhARAzQip+CK6cA@mail.gmail.com>
 <CABBYNZLgWF7m0Lwc+C848-0qgBZfV30F7SE0YcKJCPLV5KbG-Q@mail.gmail.com> <CABtds-3FMYA1s7n6tFivxNypubKp+D6fjG8aSf-nkRK4Rxh1-w@mail.gmail.com>
In-Reply-To: <CABtds-3FMYA1s7n6tFivxNypubKp+D6fjG8aSf-nkRK4Rxh1-w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Jun 2025 16:12:56 -0400
X-Gm-Features: AX0GCFs3ryq4BUjX0R3HwguO7HDh3uIhx2hVUqnd7dJQ7b7GPkLCPiaMR2ZhLB8
Message-ID: <CABBYNZLPW9PE4qiLaszncFoi3euFba1qfsJB+tU8hszvjFoOoQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Revert vendor-specific ISO classification for
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Thu, Jun 19, 2025 at 4:03=E2=80=AFPM Sean Rhodes <sean@starlabs.systems>=
 wrote:
>
> Hi Luiz
>
> It breaks pairing - some details can be found here - https://bugzilla.ker=
nel.org/show_bug.cgi?id=3D219553

Yeah, and Ive commented:

https://bugzilla.kernel.org/show_bug.cgi?id=3D219553#c4

There seems to be a mixup of issues, something with pairing, which has
absolutely nothing to do with reclassifying packets, it is very likely
the following bug:

https://github.com/bluez/bluez/issues/1138

If you have evidence that there is something that these changes
actually cause a problem I'd like to see the HCI trace of that (use
btmon to collect it).

> Thanks
>
>
> On Thu, 19 Jun 2025 at 21:00, Luiz Augusto von Dentz <luiz.dentz@gmail.co=
m> wrote:
>>
>> Hi Sean,
>>
>> On Thu, Jun 19, 2025 at 3:12=E2=80=AFPM Sean Rhodes <sean@starlabs.syste=
ms> wrote:
>> >
>> > From 3b5497d0154a58d948ee95900e4c62704399de0a Mon Sep 17 00:00:00 2001
>> > From: Sean Rhodes <sean@starlabs.systems>
>> > Date: Wed, 2 Apr 2025 09:05:17 +0100
>> > Subject: [PATCH] Bluetooth: Revert vendor-specific ISO classification =
for
>> >  non-offload cards
>> >
>> > This reverts commit f25b7fd36cc3a850e006aed686f5bbecd200de1b.
>> >
>> > The commit introduces vendor-specific classification of ISO data,
>> > but breaks Bluetooth functionality on certain Intel cards that do
>> > not support audio offload, such as the 9462. Affected devices are
>> > unable to discover new Bluetooth peripherals, and previously paired
>> > devices fail to reconnect.
>>
>> How it breaks? It doesn't seem there is anything regarding the
>> reclassification of the packets that could affect something that
>> doesn't support ISO packets, well except if it happens that older
>> controllers use the handle range of ISO but btintel_classify_pkt_type
>> shouldn't be set for them.
>>
>> > This issue does not affect newer cards (e.g., AX201+) that support
>> > audio offload. A conditional check using AOLD() could be used in
>> > the future to reintroduce this behavior only on supported hardware.
>> >
>> > Cc: Marcel Holtmann <marcel@holtmann.org>
>> > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>> > Cc: Ying Hsu <yinghsu@chromium.org>
>> > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> > Cc: Marcel Holtmann <marcel@holtmann.org>
>> > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>> > Cc: Johan Hedberg <johan.hedberg@gmail.com>
>> > Cc: linux-bluetooth@vger.kernel.org
>> > Signed-off-by: Sean Rhodes <sean@starlabs.systems>
>> > ---
>> >  drivers/bluetooth/btintel.c      |  7 ++-----
>> >  include/net/bluetooth/hci_core.h |  1 -
>> >  net/bluetooth/hci_core.c         | 16 ----------------
>> >  3 files changed, 2 insertions(+), 22 deletions(-)
>> >
>> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
>> > index 55cc1652bfe4..1a5108cf6517 100644
>> > --- a/drivers/bluetooth/btintel.c
>> > +++ b/drivers/bluetooth/btintel.c
>> > @@ -3582,15 +3582,12 @@ static int btintel_setup_combined(struct hci_d=
ev *hdev)
>> >                 err =3D btintel_bootloader_setup(hdev, &ver);
>> >                 btintel_register_devcoredump_support(hdev);
>> >                 break;
>> > -       case 0x18: /* GfP2 */
>> > -       case 0x1c: /* GaP */
>> > -               /* Re-classify packet type for controllers with LE aud=
io */
>> > -               hdev->classify_pkt_type =3D btintel_classify_pkt_type;
>> > -               fallthrough;
>>
>> 9462 seem to be JfP (0x11), so the above code shouldn't even be used for=
 it.
>>
>> >         case 0x17:
>> > +       case 0x18:
>> >         case 0x19:
>> >         case 0x1b:
>> >         case 0x1d:
>> > +       case 0x1c:
>> >         case 0x1e:
>> >         case 0x1f:
>> >                 /* Display version information of TLV type */
>> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/=
hci_core.h
>> > index 2b261e74e2c4..648ee7e2403f 100644
>> > --- a/include/net/bluetooth/hci_core.h
>> > +++ b/include/net/bluetooth/hci_core.h
>> > @@ -649,7 +649,6 @@ struct hci_dev {
>> >         int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
>> >                                      struct bt_codec *codec, __u8 *vnd=
_len,
>> >                                      __u8 **vnd_data);
>> > -       u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buff *=
skb);
>> >  };
>> >
>> >  #define HCI_PHY_HANDLE(handle) (handle & 0xff)
>> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> > index 3b49828160b7..64ab7702be81 100644
>> > --- a/net/bluetooth/hci_core.c
>> > +++ b/net/bluetooth/hci_core.c
>> > @@ -2868,31 +2868,15 @@ int hci_reset_dev(struct hci_dev *hdev)
>> >  }
>> >  EXPORT_SYMBOL(hci_reset_dev);
>> >
>> > -static u8 hci_dev_classify_pkt_type(struct hci_dev *hdev, struct sk_b=
uff *skb)
>> > -{
>> > -       if (hdev->classify_pkt_type)
>> > -               return hdev->classify_pkt_type(hdev, skb);
>> > -
>> > -       return hci_skb_pkt_type(skb);
>> > -}
>> > -
>> >  /* Receive frame from HCI drivers */
>> >  int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
>> >  {
>> > -       u8 dev_pkt_type;
>> > -
>> >         if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
>> >                       && !test_bit(HCI_INIT, &hdev->flags))) {
>> >                 kfree_skb(skb);
>> >                 return -ENXIO;
>> >         }
>> >
>> > -       /* Check if the driver agree with packet type classification *=
/
>> > -       dev_pkt_type =3D hci_dev_classify_pkt_type(hdev, skb);
>> > -       if (hci_skb_pkt_type(skb) !=3D dev_pkt_type) {
>> > -               hci_skb_pkt_type(skb) =3D dev_pkt_type;
>> > -       }
>>
>> This will affect all cards, not just the one you are claiming.
>>
>>
>> >         switch (hci_skb_pkt_type(skb)) {
>> >         case HCI_EVENT_PKT:
>> >                 break;
>> > --
>> > 2.48.1
>> >
>>
>>
>> --
>> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
