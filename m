Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5C286323
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904582; cv=none; b=V2HCuWbMgZUeLKbo2uQl65J35cAJa65uPUzXCp07rC1zTfIrwto8TK3KifOpFTEHrLBD85M1whXPhbNvRDnEDMWnwSvdv3h35Z+cL2Q3BWINBHJ5jf0mxE7D9XPCMdgeI3MSvl1/UOSmQLOPIW5ql4XmJpoT1V3MCtsU7u9pfNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904582; c=relaxed/simple;
	bh=ynHL39R56eskxwZwlpRXTsh4WcMeWbtLnznP/AYaZdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XI/QhiOHeZg5orsqMVYH23kO0E5hWd68VerLq0kWWqV5IcX6zdufk10WVLxbwDths6/M0QTaNsIoC6UMXvWcj2SprxYcYygPD7JtQzdzTqYGoXBMiWpmm9hHZ2r+H10/KN6w+JxLmdnEiZn3R6/3mNDtKDUm3jZeCc7vKYMY7Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=e4Gz/xr3; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="e4Gz/xr3"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so6067326a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 09:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1751904574; x=1752509374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsCZfVSq0WjbHc017V9J5HtNdsLJgtJlHK1u2GkKqN0=;
        b=e4Gz/xr3WY8NqPGffRougqNkOz95R86p3UF8Caop+0BrdORnxGt3hi+tmKmgof4jYZ
         xP+M06BfOtQaVS0ft6syYcdJ+XVVvYE8Vp778uoQlo0Xwko3fk+WNuw+VbP8Xzv2eCoC
         oIMJtLqqqvsTxLsaaslcxdVJKz0qL+/ysfEtxKCYQ69b5UnIB5t7spQ6bTaLdIk0vtTl
         BGaSYMuHVzQ94Vg1Ak/J1YLuQhaLKGfU2ICAm+4bCwKSU++atgslYxZbUqOjVDu9Z1UW
         JxpYt1pWT9r1XQf6iM1MPpqkGbpEUghdypRydLZJhe7WpfpKViwPUyhdd+sGgcHhoWMa
         4r3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751904574; x=1752509374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsCZfVSq0WjbHc017V9J5HtNdsLJgtJlHK1u2GkKqN0=;
        b=cPM9k45znvZt2yj00XhqgYFJLyO3qg0kkbJYbWL2vLmMfGvzoRjctUqQ7PnupvIzHy
         F1T7fPxp9RyFEraMJ+fcsH/cFPiuoJhSAENux5n6k/CnPbcOG+9cUNyaIoTLTmHH3QSR
         sTQINK7QF6B1Ks8R267z6CUDQhLtJPksopohZy+gaxLlFcAtMOa35xKAMtcuEbInOsXj
         LwJzIxNVuy4FjvmjF/WclKglS5FQ5zj134uKRO5fApsX9Vqrp5ava1C8a/PwAaEXdBPL
         h+EC1Kpn7R2cV9iY0goE+vxydz2Scs2jvXbm69bwwEjrfSWicPTEZAG2Uh2M6Xs/XG/j
         yOwA==
X-Forwarded-Encrypted: i=1; AJvYcCV8C9v12cC7lOcJNQF15VuOFax43SU6Y9XYzre8R43gc9Wsu21cIc7PzThfxukPEChP/rf7PjdMesEIxkZPlGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnkASfw3iDFaNupFZ06cUlMG9fkbnSgTqcvi23qs/kAjN04ZHk
	aNSm/CJlUG0qcNdJwlEwS6QasLaFJxzbk39YyfCUQBNg6IjSaS2zzYHG0wQ2uyP0HE3YR6sV41h
	uI4CsmXAq8bFiOkznpUU8c/55dCcWHmbyhMXm3wj406u2yhDK1LhDV0B7
X-Gm-Gg: ASbGncsL3h9lQsUSkcbgxTelFVHiZNdmWg5nKuHg09Am/PFyhZwNXJs2FgVnkdK78XC
	ztrV2f6zSoogCW5vxCzpM0DfKaq+UWlp2JSzZqgexBFTaJv7cqmKbu7FmFSi1f/Jpm7EHmQkHG+
	wDYaZREr/a6FS/izhyscXRsKYqRbCA3Xt3qUwUe0GBa7n/
X-Google-Smtp-Source: AGHT+IFVNXVtzqSKlA9nforjsOPMIyVenKz+MkiHgh2PXZPjqjt9NSJXhL02YJ6VJ7Ae5GYun3NUHWWSoiMjt8tP1+M=
X-Received: by 2002:a05:6402:3904:b0:607:ea4e:251c with SMTP id
 4fb4d7f45d1cf-61047f8b4b8mr77885a12.8.1751904574139; Mon, 07 Jul 2025
 09:09:34 -0700 (PDT)
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
 <CABBYNZKDxVmcY6uBYvqr=a6Xu=iR76tsb5k4-+MpuVNxpD9jXQ@mail.gmail.com>
 <CABtds-1+zVcnm35VQvwqP0VCXOkuaJszvsqQ-D-etwhm8kMzZA@mail.gmail.com> <CABBYNZ+Qnf7B5Koc3EvBrxiZsGaYy2ue=e4WHDb1zeEiRr9CgQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+Qnf7B5Koc3EvBrxiZsGaYy2ue=e4WHDb1zeEiRr9CgQ@mail.gmail.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Mon, 7 Jul 2025 17:09:23 +0100
X-Gm-Features: Ac12FXxxjx27qFuG_rN38i9K9LZ2wEom_crhNfOl8gEJVdoXk43NSCdBz3CP1MU
Message-ID: <CABtds-2tDcar+UOkVH4u5erOS+7A3kK=kJkVwQi_Ai1-OfEYdQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Revert vendor-specific ISO classification for
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org, 
	Matt DeVillier <matt@starlabs.systems>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz

>  are you not using btmon to capture these traces?

I used `btmon -r` - is that sufficient?

> maybe it is the wrong trace?

It's the right trace. Happy to run again if you still have doubts?

Thanks

On Mon, 7 Jul 2025 at 17:05, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sean,
>
> On Mon, Jun 30, 2025 at 4:08=E2=80=AFAM Sean Rhodes <sean@starlabs.system=
s> wrote:
> >
> > Hi
> >
> > Btmon outputs attached, one with 6.8 which works fine connecting to an =
LG monitor and Logitech Mouse. The other with 6.11, which fails to pair wit=
h the LG monitor, and can't see the Logtech Mouse.
>
> I don't see a single ISO packet in these traces, if the reclassify is
> being the problem we would see ACL packets as ISO instead, which is
> not the case, or are you not using btmon to capture these traces?
> Anyway, I don't see the pairing error, or anything really that would
> indicate there is any errors with C4:30:18:62:E2:01 which seems to be
> the LG monitor (A2DP/AVRCP/etc), or maybe it is the wrong trace?
>
> > Thanks
> >
> > Sean
> >
> > On Fri, 20 Jun 2025 at 17:00, Luiz Augusto von Dentz <luiz.dentz@gmail.=
com> wrote:
> >>
> >> Hi Kiran,
> >>
> >> On Thu, Jun 19, 2025 at 4:33=E2=80=AFPM Sean Rhodes <sean@starlabs.sys=
tems> wrote:
> >> >
> >> > Multiple users confirmed the revert fixed the issue (https://github.=
com/StarLabsLtd/firmware/issues/180#issuecomment-2784770614) and that 6.9 w=
orks as it doesn't have this patch and we've got a DKMS module with that pa=
tch reverted that makes things works.
> >> >
> >> > I'll grab a trace on Monday
> >> >
> >> > On Thu, 19 Jun 2025 at 21:13, Luiz Augusto von Dentz <luiz.dentz@gma=
il.com> wrote:
> >> >>
> >> >> Hi Sean,
> >> >>
> >> >> On Thu, Jun 19, 2025 at 4:03=E2=80=AFPM Sean Rhodes <sean@starlabs.=
systems> wrote:
> >> >> >
> >> >> > Hi Luiz
> >> >> >
> >> >> > It breaks pairing - some details can be found here - https://bugz=
illa.kernel.org/show_bug.cgi?id=3D219553
> >> >>
> >> >> Yeah, and Ive commented:
> >> >>
> >> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D219553#c4
> >> >>
> >> >> There seems to be a mixup of issues, something with pairing, which =
has
> >> >> absolutely nothing to do with reclassifying packets, it is very lik=
ely
> >> >> the following bug:
> >> >>
> >> >> https://github.com/bluez/bluez/issues/1138
> >> >>
> >> >> If you have evidence that there is something that these changes
> >> >> actually cause a problem I'd like to see the HCI trace of that (use
> >> >> btmon to collect it).
> >> >>
> >> >> > Thanks
> >> >> >
> >> >> >
> >> >> > On Thu, 19 Jun 2025 at 21:00, Luiz Augusto von Dentz <luiz.dentz@=
gmail.com> wrote:
> >> >> >>
> >> >> >> Hi Sean,
> >> >> >>
> >> >> >> On Thu, Jun 19, 2025 at 3:12=E2=80=AFPM Sean Rhodes <sean@starla=
bs.systems> wrote:
> >> >> >> >
> >> >> >> > From 3b5497d0154a58d948ee95900e4c62704399de0a Mon Sep 17 00:00=
:00 2001
> >> >> >> > From: Sean Rhodes <sean@starlabs.systems>
> >> >> >> > Date: Wed, 2 Apr 2025 09:05:17 +0100
> >> >> >> > Subject: [PATCH] Bluetooth: Revert vendor-specific ISO classif=
ication for
> >> >> >> >  non-offload cards
> >> >> >> >
> >> >> >> > This reverts commit f25b7fd36cc3a850e006aed686f5bbecd200de1b.
> >> >> >> >
> >> >> >> > The commit introduces vendor-specific classification of ISO da=
ta,
> >> >> >> > but breaks Bluetooth functionality on certain Intel cards that=
 do
> >> >> >> > not support audio offload, such as the 9462. Affected devices =
are
> >> >> >> > unable to discover new Bluetooth peripherals, and previously p=
aired
> >> >> >> > devices fail to reconnect.
> >> >> >>
> >> >> >> How it breaks? It doesn't seem there is anything regarding the
> >> >> >> reclassification of the packets that could affect something that
> >> >> >> doesn't support ISO packets, well except if it happens that olde=
r
> >> >> >> controllers use the handle range of ISO but btintel_classify_pkt=
_type
> >> >> >> shouldn't be set for them.
> >> >> >>
> >> >> >> > This issue does not affect newer cards (e.g., AX201+) that sup=
port
> >> >> >> > audio offload. A conditional check using AOLD() could be used =
in
> >> >> >> > the future to reintroduce this behavior only on supported hard=
ware.
> >> >> >> >
> >> >> >> > Cc: Marcel Holtmann <marcel@holtmann.org>
> >> >> >> > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> >> >> >> > Cc: Ying Hsu <yinghsu@chromium.org>
> >> >> >> > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >> >> >> > Cc: Marcel Holtmann <marcel@holtmann.org>
> >> >> >> > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> >> >> >> > Cc: Johan Hedberg <johan.hedberg@gmail.com>
> >> >> >> > Cc: linux-bluetooth@vger.kernel.org
> >> >> >> > Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> >> >> >> > ---
> >> >> >> >  drivers/bluetooth/btintel.c      |  7 ++-----
> >> >> >> >  include/net/bluetooth/hci_core.h |  1 -
> >> >> >> >  net/bluetooth/hci_core.c         | 16 ----------------
> >> >> >> >  3 files changed, 2 insertions(+), 22 deletions(-)
> >> >> >> >
> >> >> >> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/b=
tintel.c
> >> >> >> > index 55cc1652bfe4..1a5108cf6517 100644
> >> >> >> > --- a/drivers/bluetooth/btintel.c
> >> >> >> > +++ b/drivers/bluetooth/btintel.c
> >> >> >> > @@ -3582,15 +3582,12 @@ static int btintel_setup_combined(stru=
ct hci_dev *hdev)
> >> >> >> >                 err =3D btintel_bootloader_setup(hdev, &ver);
> >> >> >> >                 btintel_register_devcoredump_support(hdev);
> >> >> >> >                 break;
> >> >> >> > -       case 0x18: /* GfP2 */
> >> >> >> > -       case 0x1c: /* GaP */
> >> >> >> > -               /* Re-classify packet type for controllers wit=
h LE audio */
> >> >> >> > -               hdev->classify_pkt_type =3D btintel_classify_p=
kt_type;
> >> >> >> > -               fallthrough;
> >> >> >>
> >> >> >> 9462 seem to be JfP (0x11), so the above code shouldn't even be =
used for it.
> >>
> >> I'm starting to suspect that JfP may not be responding with the expect
> >> id here, which means we will need to use another field to confirm what
> >> is the real model.
> >>
> >> >> >>
> >> >> >> >         case 0x17:
> >> >> >> > +       case 0x18:
> >> >> >> >         case 0x19:
> >> >> >> >         case 0x1b:
> >> >> >> >         case 0x1d:
> >> >> >> > +       case 0x1c:
> >> >> >> >         case 0x1e:
> >> >> >> >         case 0x1f:
> >> >> >> >                 /* Display version information of TLV type */
> >> >> >> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bl=
uetooth/hci_core.h
> >> >> >> > index 2b261e74e2c4..648ee7e2403f 100644
> >> >> >> > --- a/include/net/bluetooth/hci_core.h
> >> >> >> > +++ b/include/net/bluetooth/hci_core.h
> >> >> >> > @@ -649,7 +649,6 @@ struct hci_dev {
> >> >> >> >         int (*get_codec_config_data)(struct hci_dev *hdev, __u=
8 type,
> >> >> >> >                                      struct bt_codec *codec, _=
_u8 *vnd_len,
> >> >> >> >                                      __u8 **vnd_data);
> >> >> >> > -       u8 (*classify_pkt_type)(struct hci_dev *hdev, struct s=
k_buff *skb);
> >> >> >> >  };
> >> >> >> >
> >> >> >> >  #define HCI_PHY_HANDLE(handle) (handle & 0xff)
> >> >> >> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core=
.c
> >> >> >> > index 3b49828160b7..64ab7702be81 100644
> >> >> >> > --- a/net/bluetooth/hci_core.c
> >> >> >> > +++ b/net/bluetooth/hci_core.c
> >> >> >> > @@ -2868,31 +2868,15 @@ int hci_reset_dev(struct hci_dev *hdev=
)
> >> >> >> >  }
> >> >> >> >  EXPORT_SYMBOL(hci_reset_dev);
> >> >> >> >
> >> >> >> > -static u8 hci_dev_classify_pkt_type(struct hci_dev *hdev, str=
uct sk_buff *skb)
> >> >> >> > -{
> >> >> >> > -       if (hdev->classify_pkt_type)
> >> >> >> > -               return hdev->classify_pkt_type(hdev, skb);
> >> >> >> > -
> >> >> >> > -       return hci_skb_pkt_type(skb);
> >> >> >> > -}
> >> >> >> > -
> >> >> >> >  /* Receive frame from HCI drivers */
> >> >> >> >  int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
> >> >> >> >  {
> >> >> >> > -       u8 dev_pkt_type;
> >> >> >> > -
> >> >> >> >         if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
> >> >> >> >                       && !test_bit(HCI_INIT, &hdev->flags))) {
> >> >> >> >                 kfree_skb(skb);
> >> >> >> >                 return -ENXIO;
> >> >> >> >         }
> >> >> >> >
> >> >> >> > -       /* Check if the driver agree with packet type classifi=
cation */
> >> >> >> > -       dev_pkt_type =3D hci_dev_classify_pkt_type(hdev, skb);
> >> >> >> > -       if (hci_skb_pkt_type(skb) !=3D dev_pkt_type) {
> >> >> >> > -               hci_skb_pkt_type(skb) =3D dev_pkt_type;
> >> >> >> > -       }
> >> >> >>
> >> >> >> This will affect all cards, not just the one you are claiming.
> >> >> >>
> >> >> >>
> >> >> >> >         switch (hci_skb_pkt_type(skb)) {
> >> >> >> >         case HCI_EVENT_PKT:
> >> >> >> >                 break;
> >> >> >> > --
> >> >> >> > 2.48.1
> >> >> >> >
> >> >> >>
> >> >> >>
> >> >> >> --
> >> >> >> Luiz Augusto von Dentz
> >> >>
> >> >>
> >> >>
> >> >> --
> >> >> Luiz Augusto von Dentz
> >>
> >>
> >>
> >> --
> >> Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
