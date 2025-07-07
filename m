Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E908121B9FE
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904340; cv=none; b=XgSEo9suz4Q8XUjMix+UG8wu9srr+Gf2O/2FSW2JWzhW1VhERb2lyQuL2KDZ50DRzufMuw6ceSMHy0HVvchD+7T9frcjfLKvZvpcHku6dCgO7iQWEj0Gaxj4pfB7Ia22U+jmUVUffXFx3whQmKYe8v+iR8S/41zTwcOTxBAkmP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904340; c=relaxed/simple;
	bh=xvXehOqnvFgfXYek8TjruVT/K3NXHxu5JN2YY2jJQBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmlXFekTEBxAAwdvdkJrKWOCEz8vb2uEuOKFVMxNNyzk9GI0i9eckeJlFVzxvxv5sjOlCIpDAfnH6KnIMw2vJahAk5Qw7nNde428ttf2ASr6Pru9dw0ZIUZIeuErYV24KVdOkXj3Bd9+5r0xn0kbHGfcJ9wpmSGLXkOvHhy5XgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8BfKCNW; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8BfKCNW"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553dceb342aso2942921e87.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 09:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751904336; x=1752509136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozBxo9+ey/7RTFGwktIz+nZ+yAQ7p8lGa8PnkxUbbfg=;
        b=U8BfKCNWrX2e34Z1F48Qkr8Xa/gk1fIl6+E29ipK12rSmYd0JnkmRPMISN6Nnvj3HH
         CBiIwoEpACnjatVZukzk4jPG3Pk7tdA0ZvoKzfDDCfmn8l4WCYqwh0mtA2PEj/Bj7AfG
         LaYxwmP6KXEkAr2WHaLMinkuAnG1qKyZpnvCz/GIue7LHiC1toPyNTjB8sUgfX8va101
         GL0DFSDJwAfAHVLFbab7wqdn+TY54TUVRJ9YnYp+1RyXElFVlshRf7rIntIJY4WnEzkM
         kBCOgqT/Z8r6lfZckLQIR2nDCGAjqfFKvD8YF2s4NQBvXCxavUuuK7C8xwJbmQui+b0g
         MQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751904336; x=1752509136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozBxo9+ey/7RTFGwktIz+nZ+yAQ7p8lGa8PnkxUbbfg=;
        b=GjKAAz4ug8omU0pJIBLVcum/57gJi3QPU2eGEfhvA47kJPUMYY6Bs1wOSBFBOCLUSz
         uisEyN/+pedD01+98nARBmYsN3Kgw9/z/BA6psxsj/K4/UAdruWzISsEyvAIA28LiW0w
         LsVq6m95nPmp/8kA6Te3CAwYZJwDgFyfiv6oQE1Flw/W1tpT4TdgZuVTrtkzRtY+wPAz
         MG24Ds/o4ir4S6+wMUsmuRTdsR9+O/F4p8V8Ju8n1uStXTo2zNctVxfSvSo/k49Alf8T
         GCuuoz/jgrjA/WamW1FCWf364fZmAsmr2C4rLHjD3STPEhL9d2rkIHZGy4TUCe1OjTAT
         XV8Q==
X-Forwarded-Encrypted: i=1; AJvYcCURgZM66FZM+PcqG95AaUOB4UDemGngTsk5X1FCxmTrsdqUqKcbGe9QJ03CCILhHtlfvpQeLwW6Dyw4+ilWG4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2odd6eulTxogsWoaEdFqrD/q1ymTgoLNkEOATga8F0zyD6Nrw
	ePBZ2slxsfjHtqqTQq8/OqFlcoFHrlr6patT0XwrgZJOdKCxXDJbodHJbxbl8BxFnU1DM9g/XZv
	2a1YxdVcYHO3aRmCG6+KH0cx8bgOqBmE=
X-Gm-Gg: ASbGncv5HN41kBqiOurYgKKuszXrvIB5N5xJ2kNZjtYZf+KwMjNIG01wi9D6n1TkiaY
	pui5o3Mj33txIGo+vKitZlu9GLmyEhBiDlEOouhBE6xXgCtNiwM52VJ1DUkYDh3TW9M+rW8RXcG
	d8W1LbanamdLDnc67VQrxKejcRXNHKJ39OauOKGKRsqA==
X-Google-Smtp-Source: AGHT+IF9tqM8DEoB5TSgG3vVwEc//W2mPRanSwUSa/wf4qWCZMs1IyAWIOMr+0+tROopne5KyutOArks/3DOJpZp/LI=
X-Received: by 2002:a05:6512:3f0e:b0:553:ce07:de8e with SMTP id
 2adb3069b0e04-556f1b653f6mr4186459e87.42.1751904334783; Mon, 07 Jul 2025
 09:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABtds-1fKyFYvU1jL9njmhfphU0XytO+F5mBhARAzQip+CK6cA@mail.gmail.com>
 <CABBYNZLgWF7m0Lwc+C848-0qgBZfV30F7SE0YcKJCPLV5KbG-Q@mail.gmail.com>
 <CABtds-3FMYA1s7n6tFivxNypubKp+D6fjG8aSf-nkRK4Rxh1-w@mail.gmail.com>
 <CABBYNZLPW9PE4qiLaszncFoi3euFba1qfsJB+tU8hszvjFoOoQ@mail.gmail.com>
 <CABtds-2mFsGWU5Qi6CrrhpMeQr4kJ0hZw1A2gw=drNLm_T5tTw@mail.gmail.com>
 <CABBYNZKDxVmcY6uBYvqr=a6Xu=iR76tsb5k4-+MpuVNxpD9jXQ@mail.gmail.com> <CABtds-1+zVcnm35VQvwqP0VCXOkuaJszvsqQ-D-etwhm8kMzZA@mail.gmail.com>
In-Reply-To: <CABtds-1+zVcnm35VQvwqP0VCXOkuaJszvsqQ-D-etwhm8kMzZA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 7 Jul 2025 12:05:21 -0400
X-Gm-Features: Ac12FXyPxItlZnokzDkzWvE5mFph7RSSf0Dn8D3NH-5HXBE-JNM7NmmLLFFjaJE
Message-ID: <CABBYNZ+Qnf7B5Koc3EvBrxiZsGaYy2ue=e4WHDb1zeEiRr9CgQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Revert vendor-specific ISO classification for
To: Sean Rhodes <sean@starlabs.systems>
Cc: Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org, 
	Matt DeVillier <matt@starlabs.systems>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Mon, Jun 30, 2025 at 4:08=E2=80=AFAM Sean Rhodes <sean@starlabs.systems>=
 wrote:
>
> Hi
>
> Btmon outputs attached, one with 6.8 which works fine connecting to an LG=
 monitor and Logitech Mouse. The other with 6.11, which fails to pair with =
the LG monitor, and can't see the Logtech Mouse.

I don't see a single ISO packet in these traces, if the reclassify is
being the problem we would see ACL packets as ISO instead, which is
not the case, or are you not using btmon to capture these traces?
Anyway, I don't see the pairing error, or anything really that would
indicate there is any errors with C4:30:18:62:E2:01 which seems to be
the LG monitor (A2DP/AVRCP/etc), or maybe it is the wrong trace?

> Thanks
>
> Sean
>
> On Fri, 20 Jun 2025 at 17:00, Luiz Augusto von Dentz <luiz.dentz@gmail.co=
m> wrote:
>>
>> Hi Kiran,
>>
>> On Thu, Jun 19, 2025 at 4:33=E2=80=AFPM Sean Rhodes <sean@starlabs.syste=
ms> wrote:
>> >
>> > Multiple users confirmed the revert fixed the issue (https://github.co=
m/StarLabsLtd/firmware/issues/180#issuecomment-2784770614) and that 6.9 wor=
ks as it doesn't have this patch and we've got a DKMS module with that patc=
h reverted that makes things works.
>> >
>> > I'll grab a trace on Monday
>> >
>> > On Thu, 19 Jun 2025 at 21:13, Luiz Augusto von Dentz <luiz.dentz@gmail=
.com> wrote:
>> >>
>> >> Hi Sean,
>> >>
>> >> On Thu, Jun 19, 2025 at 4:03=E2=80=AFPM Sean Rhodes <sean@starlabs.sy=
stems> wrote:
>> >> >
>> >> > Hi Luiz
>> >> >
>> >> > It breaks pairing - some details can be found here - https://bugzil=
la.kernel.org/show_bug.cgi?id=3D219553
>> >>
>> >> Yeah, and Ive commented:
>> >>
>> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D219553#c4
>> >>
>> >> There seems to be a mixup of issues, something with pairing, which ha=
s
>> >> absolutely nothing to do with reclassifying packets, it is very likel=
y
>> >> the following bug:
>> >>
>> >> https://github.com/bluez/bluez/issues/1138
>> >>
>> >> If you have evidence that there is something that these changes
>> >> actually cause a problem I'd like to see the HCI trace of that (use
>> >> btmon to collect it).
>> >>
>> >> > Thanks
>> >> >
>> >> >
>> >> > On Thu, 19 Jun 2025 at 21:00, Luiz Augusto von Dentz <luiz.dentz@gm=
ail.com> wrote:
>> >> >>
>> >> >> Hi Sean,
>> >> >>
>> >> >> On Thu, Jun 19, 2025 at 3:12=E2=80=AFPM Sean Rhodes <sean@starlabs=
.systems> wrote:
>> >> >> >
>> >> >> > From 3b5497d0154a58d948ee95900e4c62704399de0a Mon Sep 17 00:00:0=
0 2001
>> >> >> > From: Sean Rhodes <sean@starlabs.systems>
>> >> >> > Date: Wed, 2 Apr 2025 09:05:17 +0100
>> >> >> > Subject: [PATCH] Bluetooth: Revert vendor-specific ISO classific=
ation for
>> >> >> >  non-offload cards
>> >> >> >
>> >> >> > This reverts commit f25b7fd36cc3a850e006aed686f5bbecd200de1b.
>> >> >> >
>> >> >> > The commit introduces vendor-specific classification of ISO data=
,
>> >> >> > but breaks Bluetooth functionality on certain Intel cards that d=
o
>> >> >> > not support audio offload, such as the 9462. Affected devices ar=
e
>> >> >> > unable to discover new Bluetooth peripherals, and previously pai=
red
>> >> >> > devices fail to reconnect.
>> >> >>
>> >> >> How it breaks? It doesn't seem there is anything regarding the
>> >> >> reclassification of the packets that could affect something that
>> >> >> doesn't support ISO packets, well except if it happens that older
>> >> >> controllers use the handle range of ISO but btintel_classify_pkt_t=
ype
>> >> >> shouldn't be set for them.
>> >> >>
>> >> >> > This issue does not affect newer cards (e.g., AX201+) that suppo=
rt
>> >> >> > audio offload. A conditional check using AOLD() could be used in
>> >> >> > the future to reintroduce this behavior only on supported hardwa=
re.
>> >> >> >
>> >> >> > Cc: Marcel Holtmann <marcel@holtmann.org>
>> >> >> > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>> >> >> > Cc: Ying Hsu <yinghsu@chromium.org>
>> >> >> > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> >> >> > Cc: Marcel Holtmann <marcel@holtmann.org>
>> >> >> > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>> >> >> > Cc: Johan Hedberg <johan.hedberg@gmail.com>
>> >> >> > Cc: linux-bluetooth@vger.kernel.org
>> >> >> > Signed-off-by: Sean Rhodes <sean@starlabs.systems>
>> >> >> > ---
>> >> >> >  drivers/bluetooth/btintel.c      |  7 ++-----
>> >> >> >  include/net/bluetooth/hci_core.h |  1 -
>> >> >> >  net/bluetooth/hci_core.c         | 16 ----------------
>> >> >> >  3 files changed, 2 insertions(+), 22 deletions(-)
>> >> >> >
>> >> >> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/bti=
ntel.c
>> >> >> > index 55cc1652bfe4..1a5108cf6517 100644
>> >> >> > --- a/drivers/bluetooth/btintel.c
>> >> >> > +++ b/drivers/bluetooth/btintel.c
>> >> >> > @@ -3582,15 +3582,12 @@ static int btintel_setup_combined(struct=
 hci_dev *hdev)
>> >> >> >                 err =3D btintel_bootloader_setup(hdev, &ver);
>> >> >> >                 btintel_register_devcoredump_support(hdev);
>> >> >> >                 break;
>> >> >> > -       case 0x18: /* GfP2 */
>> >> >> > -       case 0x1c: /* GaP */
>> >> >> > -               /* Re-classify packet type for controllers with =
LE audio */
>> >> >> > -               hdev->classify_pkt_type =3D btintel_classify_pkt=
_type;
>> >> >> > -               fallthrough;
>> >> >>
>> >> >> 9462 seem to be JfP (0x11), so the above code shouldn't even be us=
ed for it.
>>
>> I'm starting to suspect that JfP may not be responding with the expect
>> id here, which means we will need to use another field to confirm what
>> is the real model.
>>
>> >> >>
>> >> >> >         case 0x17:
>> >> >> > +       case 0x18:
>> >> >> >         case 0x19:
>> >> >> >         case 0x1b:
>> >> >> >         case 0x1d:
>> >> >> > +       case 0x1c:
>> >> >> >         case 0x1e:
>> >> >> >         case 0x1f:
>> >> >> >                 /* Display version information of TLV type */
>> >> >> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/blue=
tooth/hci_core.h
>> >> >> > index 2b261e74e2c4..648ee7e2403f 100644
>> >> >> > --- a/include/net/bluetooth/hci_core.h
>> >> >> > +++ b/include/net/bluetooth/hci_core.h
>> >> >> > @@ -649,7 +649,6 @@ struct hci_dev {
>> >> >> >         int (*get_codec_config_data)(struct hci_dev *hdev, __u8 =
type,
>> >> >> >                                      struct bt_codec *codec, __u=
8 *vnd_len,
>> >> >> >                                      __u8 **vnd_data);
>> >> >> > -       u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_=
buff *skb);
>> >> >> >  };
>> >> >> >
>> >> >> >  #define HCI_PHY_HANDLE(handle) (handle & 0xff)
>> >> >> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> >> >> > index 3b49828160b7..64ab7702be81 100644
>> >> >> > --- a/net/bluetooth/hci_core.c
>> >> >> > +++ b/net/bluetooth/hci_core.c
>> >> >> > @@ -2868,31 +2868,15 @@ int hci_reset_dev(struct hci_dev *hdev)
>> >> >> >  }
>> >> >> >  EXPORT_SYMBOL(hci_reset_dev);
>> >> >> >
>> >> >> > -static u8 hci_dev_classify_pkt_type(struct hci_dev *hdev, struc=
t sk_buff *skb)
>> >> >> > -{
>> >> >> > -       if (hdev->classify_pkt_type)
>> >> >> > -               return hdev->classify_pkt_type(hdev, skb);
>> >> >> > -
>> >> >> > -       return hci_skb_pkt_type(skb);
>> >> >> > -}
>> >> >> > -
>> >> >> >  /* Receive frame from HCI drivers */
>> >> >> >  int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
>> >> >> >  {
>> >> >> > -       u8 dev_pkt_type;
>> >> >> > -
>> >> >> >         if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
>> >> >> >                       && !test_bit(HCI_INIT, &hdev->flags))) {
>> >> >> >                 kfree_skb(skb);
>> >> >> >                 return -ENXIO;
>> >> >> >         }
>> >> >> >
>> >> >> > -       /* Check if the driver agree with packet type classifica=
tion */
>> >> >> > -       dev_pkt_type =3D hci_dev_classify_pkt_type(hdev, skb);
>> >> >> > -       if (hci_skb_pkt_type(skb) !=3D dev_pkt_type) {
>> >> >> > -               hci_skb_pkt_type(skb) =3D dev_pkt_type;
>> >> >> > -       }
>> >> >>
>> >> >> This will affect all cards, not just the one you are claiming.
>> >> >>
>> >> >>
>> >> >> >         switch (hci_skb_pkt_type(skb)) {
>> >> >> >         case HCI_EVENT_PKT:
>> >> >> >                 break;
>> >> >> > --
>> >> >> > 2.48.1
>> >> >> >
>> >> >>
>> >> >>
>> >> >> --
>> >> >> Luiz Augusto von Dentz
>> >>
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
