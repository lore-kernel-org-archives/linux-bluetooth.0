Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED82E610E
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435208; cv=none; b=bdP/YTcS4MO0x16QGUZgb19d5Jti7kL4mdFRiEnSvkc5sGAG5xVu5CO4IpTEj5JXWkGssbxIz7il9Z529GO1+AeKYsUE3tDmS1NEGi05WAofim7ZZjMattrs+ymCkIYTrwpQF4tn7k5vSUVohWsiNep+j7Xl2Et5cnyN5xOX4IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435208; c=relaxed/simple;
	bh=d3XtcXn4IB59GWbgZrl7n0Gal8ry+RUpWZYegPBhEm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lnbro73O9tHifB5w79wrPiz+yhE0AWxFIVPEJtCHZcTyRKEHc0Q4eVWtnLdl0pZSvSztvl2K/oA5hm972GMZDzLReizFYp9CgSQ6ARBZz/tAhT9jSEX4p6qZD1IeWIE1HetRT61iz2RgtgyTEicGJcESm2/V3HYchFeCT5ycTHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRe8RHE7; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRe8RHE7"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b3a3a8201so16131321fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 09:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750435205; x=1751040005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcUhhMivag40NWj24e3EdKY6USvVLRFXPBYDM8aA/mk=;
        b=WRe8RHE75GQdlbqp8cjgWNxByXl8NysMAC3L7Cf4jPlHdZyuML4Y6j3zHNo7P4EmvG
         w6lfTuq1Z29GgTTTs8U+gYMlOSw5u7TVM+VMBXW8AAxCnQvRZNUMbW8YHYPJJXmNiBFo
         ZY19Qxz76YRnS3OrqUF7vVlT2K0U8+HCr8HjWrjcLBkfOcBgzvhmZjg2usg6HOrKzi11
         Md7DkVoymaz5p3oVs6Y3gzCtvqxEYWxbzSwDClTS12UQVJjdyZ/K0pRSvT5QMjo1mjQ9
         /+0os04qy9dzJixTIW7LS8bb5gObCIom4DobtH5d0eBqJK/hMQxt/yyE8jQE18QngsJN
         CGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750435205; x=1751040005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcUhhMivag40NWj24e3EdKY6USvVLRFXPBYDM8aA/mk=;
        b=bTXsnIFyCUtSSOTvvu5r3+7b1m1AG+Ay8DDpUKk17ZYeKo8nXCjG/t4Fj+e9ozPHf6
         umqx4M0hm7/qMPp4ruinAzgmjigcWn4RpU26XpxH8jkLXbbhDK/02ZVUTdMwauDkingj
         8KxTVMwOvnnbFs0jhPFGSFvUH1CmGUP3N98opGgAWqs7dzEhAEFdrdE0QFLcXlQgfHPO
         dvxfnO20bymv3UwKs6RgUoYWnn/M4d3+3MEMynlLy+2gMZ2mhlw/mS+HVhkfqt6qlcYt
         vgNETmQhLKIY/PXkMqJTac59tTJqe5twyJtGFcAXHUGmKXTVzwI3u7sCfVIS12N8qIpj
         9kqw==
X-Gm-Message-State: AOJu0YxMzBXGxNQWGQayR+OAQH2UtDudNM1QykOvtUl3I3kbE7Z6xbm+
	WxQlVXb5ts8TpclnkMxZcR6qlRWQDRWK3mkmXhno0FE4UStmxXcC8oORK0h4QIPtRhuZWr6JU9g
	edl9TQLIWHbNa9j7m7bR1J1+2yXv6qPY=
X-Gm-Gg: ASbGncsc/g+8SXFWv0WgKgCrpEZodyLK43Kedyuh7AVlKF00vFaFQ8uRWOa6WPyz7um
	x8IFovnypeJdWCbVr5PHqv4K+5lZEcHH/7goAgcV92iLwG7fFgnlVhw9A5xy7RM292gNq6RyePF
	0NmTYNLQySD2mlfP5eNZAnyWfM1WDP2er2tJbhBAHX7w==
X-Google-Smtp-Source: AGHT+IGdyemtX3qU9lqE/Wg++mQ9zRx/c+B+8NsuXpyJ0ZcGxT0eTN3vZq9m9kHZHgTG27GGjSHkp2avgaj5/zKPGW8=
X-Received: by 2002:a2e:ba81:0:b0:32a:8916:55af with SMTP id
 38308e7fff4ca-32b98e38561mr9290961fa.2.1750435204499; Fri, 20 Jun 2025
 09:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABtds-1fKyFYvU1jL9njmhfphU0XytO+F5mBhARAzQip+CK6cA@mail.gmail.com>
 <CABBYNZLgWF7m0Lwc+C848-0qgBZfV30F7SE0YcKJCPLV5KbG-Q@mail.gmail.com>
 <CABtds-3FMYA1s7n6tFivxNypubKp+D6fjG8aSf-nkRK4Rxh1-w@mail.gmail.com>
 <CABBYNZLPW9PE4qiLaszncFoi3euFba1qfsJB+tU8hszvjFoOoQ@mail.gmail.com> <CABtds-2mFsGWU5Qi6CrrhpMeQr4kJ0hZw1A2gw=drNLm_T5tTw@mail.gmail.com>
In-Reply-To: <CABtds-2mFsGWU5Qi6CrrhpMeQr4kJ0hZw1A2gw=drNLm_T5tTw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Jun 2025 11:59:52 -0400
X-Gm-Features: AX0GCFtIlRXVzLmrPTyobp-H4Qk_JINHoYH_X9qTe18Pz9zO-A-5RB7nvFe5BQw
Message-ID: <CABBYNZKDxVmcY6uBYvqr=a6Xu=iR76tsb5k4-+MpuVNxpD9jXQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Revert vendor-specific ISO classification for
To: Sean Rhodes <sean@starlabs.systems>, Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, Matt DeVillier <matt@starlabs.systems>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Thu, Jun 19, 2025 at 4:33=E2=80=AFPM Sean Rhodes <sean@starlabs.systems>=
 wrote:
>
> Multiple users confirmed the revert fixed the issue (https://github.com/S=
tarLabsLtd/firmware/issues/180#issuecomment-2784770614) and that 6.9 works =
as it doesn't have this patch and we've got a DKMS module with that patch r=
everted that makes things works.
>
> I'll grab a trace on Monday
>
> On Thu, 19 Jun 2025 at 21:13, Luiz Augusto von Dentz <luiz.dentz@gmail.co=
m> wrote:
>>
>> Hi Sean,
>>
>> On Thu, Jun 19, 2025 at 4:03=E2=80=AFPM Sean Rhodes <sean@starlabs.syste=
ms> wrote:
>> >
>> > Hi Luiz
>> >
>> > It breaks pairing - some details can be found here - https://bugzilla.=
kernel.org/show_bug.cgi?id=3D219553
>>
>> Yeah, and Ive commented:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D219553#c4
>>
>> There seems to be a mixup of issues, something with pairing, which has
>> absolutely nothing to do with reclassifying packets, it is very likely
>> the following bug:
>>
>> https://github.com/bluez/bluez/issues/1138
>>
>> If you have evidence that there is something that these changes
>> actually cause a problem I'd like to see the HCI trace of that (use
>> btmon to collect it).
>>
>> > Thanks
>> >
>> >
>> > On Thu, 19 Jun 2025 at 21:00, Luiz Augusto von Dentz <luiz.dentz@gmail=
.com> wrote:
>> >>
>> >> Hi Sean,
>> >>
>> >> On Thu, Jun 19, 2025 at 3:12=E2=80=AFPM Sean Rhodes <sean@starlabs.sy=
stems> wrote:
>> >> >
>> >> > From 3b5497d0154a58d948ee95900e4c62704399de0a Mon Sep 17 00:00:00 2=
001
>> >> > From: Sean Rhodes <sean@starlabs.systems>
>> >> > Date: Wed, 2 Apr 2025 09:05:17 +0100
>> >> > Subject: [PATCH] Bluetooth: Revert vendor-specific ISO classificati=
on for
>> >> >  non-offload cards
>> >> >
>> >> > This reverts commit f25b7fd36cc3a850e006aed686f5bbecd200de1b.
>> >> >
>> >> > The commit introduces vendor-specific classification of ISO data,
>> >> > but breaks Bluetooth functionality on certain Intel cards that do
>> >> > not support audio offload, such as the 9462. Affected devices are
>> >> > unable to discover new Bluetooth peripherals, and previously paired
>> >> > devices fail to reconnect.
>> >>
>> >> How it breaks? It doesn't seem there is anything regarding the
>> >> reclassification of the packets that could affect something that
>> >> doesn't support ISO packets, well except if it happens that older
>> >> controllers use the handle range of ISO but btintel_classify_pkt_type
>> >> shouldn't be set for them.
>> >>
>> >> > This issue does not affect newer cards (e.g., AX201+) that support
>> >> > audio offload. A conditional check using AOLD() could be used in
>> >> > the future to reintroduce this behavior only on supported hardware.
>> >> >
>> >> > Cc: Marcel Holtmann <marcel@holtmann.org>
>> >> > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>> >> > Cc: Ying Hsu <yinghsu@chromium.org>
>> >> > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> >> > Cc: Marcel Holtmann <marcel@holtmann.org>
>> >> > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>> >> > Cc: Johan Hedberg <johan.hedberg@gmail.com>
>> >> > Cc: linux-bluetooth@vger.kernel.org
>> >> > Signed-off-by: Sean Rhodes <sean@starlabs.systems>
>> >> > ---
>> >> >  drivers/bluetooth/btintel.c      |  7 ++-----
>> >> >  include/net/bluetooth/hci_core.h |  1 -
>> >> >  net/bluetooth/hci_core.c         | 16 ----------------
>> >> >  3 files changed, 2 insertions(+), 22 deletions(-)
>> >> >
>> >> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btinte=
l.c
>> >> > index 55cc1652bfe4..1a5108cf6517 100644
>> >> > --- a/drivers/bluetooth/btintel.c
>> >> > +++ b/drivers/bluetooth/btintel.c
>> >> > @@ -3582,15 +3582,12 @@ static int btintel_setup_combined(struct hc=
i_dev *hdev)
>> >> >                 err =3D btintel_bootloader_setup(hdev, &ver);
>> >> >                 btintel_register_devcoredump_support(hdev);
>> >> >                 break;
>> >> > -       case 0x18: /* GfP2 */
>> >> > -       case 0x1c: /* GaP */
>> >> > -               /* Re-classify packet type for controllers with LE =
audio */
>> >> > -               hdev->classify_pkt_type =3D btintel_classify_pkt_ty=
pe;
>> >> > -               fallthrough;
>> >>
>> >> 9462 seem to be JfP (0x11), so the above code shouldn't even be used =
for it.

I'm starting to suspect that JfP may not be responding with the expect
id here, which means we will need to use another field to confirm what
is the real model.

>> >>
>> >> >         case 0x17:
>> >> > +       case 0x18:
>> >> >         case 0x19:
>> >> >         case 0x1b:
>> >> >         case 0x1d:
>> >> > +       case 0x1c:
>> >> >         case 0x1e:
>> >> >         case 0x1f:
>> >> >                 /* Display version information of TLV type */
>> >> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetoo=
th/hci_core.h
>> >> > index 2b261e74e2c4..648ee7e2403f 100644
>> >> > --- a/include/net/bluetooth/hci_core.h
>> >> > +++ b/include/net/bluetooth/hci_core.h
>> >> > @@ -649,7 +649,6 @@ struct hci_dev {
>> >> >         int (*get_codec_config_data)(struct hci_dev *hdev, __u8 typ=
e,
>> >> >                                      struct bt_codec *codec, __u8 *=
vnd_len,
>> >> >                                      __u8 **vnd_data);
>> >> > -       u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buf=
f *skb);
>> >> >  };
>> >> >
>> >> >  #define HCI_PHY_HANDLE(handle) (handle & 0xff)
>> >> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> >> > index 3b49828160b7..64ab7702be81 100644
>> >> > --- a/net/bluetooth/hci_core.c
>> >> > +++ b/net/bluetooth/hci_core.c
>> >> > @@ -2868,31 +2868,15 @@ int hci_reset_dev(struct hci_dev *hdev)
>> >> >  }
>> >> >  EXPORT_SYMBOL(hci_reset_dev);
>> >> >
>> >> > -static u8 hci_dev_classify_pkt_type(struct hci_dev *hdev, struct s=
k_buff *skb)
>> >> > -{
>> >> > -       if (hdev->classify_pkt_type)
>> >> > -               return hdev->classify_pkt_type(hdev, skb);
>> >> > -
>> >> > -       return hci_skb_pkt_type(skb);
>> >> > -}
>> >> > -
>> >> >  /* Receive frame from HCI drivers */
>> >> >  int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
>> >> >  {
>> >> > -       u8 dev_pkt_type;
>> >> > -
>> >> >         if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
>> >> >                       && !test_bit(HCI_INIT, &hdev->flags))) {
>> >> >                 kfree_skb(skb);
>> >> >                 return -ENXIO;
>> >> >         }
>> >> >
>> >> > -       /* Check if the driver agree with packet type classificatio=
n */
>> >> > -       dev_pkt_type =3D hci_dev_classify_pkt_type(hdev, skb);
>> >> > -       if (hci_skb_pkt_type(skb) !=3D dev_pkt_type) {
>> >> > -               hci_skb_pkt_type(skb) =3D dev_pkt_type;
>> >> > -       }
>> >>
>> >> This will affect all cards, not just the one you are claiming.
>> >>
>> >>
>> >> >         switch (hci_skb_pkt_type(skb)) {
>> >> >         case HCI_EVENT_PKT:
>> >> >                 break;
>> >> > --
>> >> > 2.48.1
>> >> >
>> >>
>> >>
>> >> --
>> >> Luiz Augusto von Dentz
>>
>>
>>
>> --
>> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
