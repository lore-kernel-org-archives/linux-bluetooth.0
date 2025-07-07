Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C591F8AC8
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751905986; cv=none; b=dw5DTb1y4KWrpG3XTEPfbaRpDP9yysmn7iMkjg7q0swlW1fAHt4raZN9KsrVbnWNmFvGBhiYAashnZ9KeRNsQRJldJuwk8lb24xib917jzzwTbanTw6/TDLuS8K36TqEMW8adrn56PKPGb9F6yG5xcWOj6N8RyPC4Dp84979vtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751905986; c=relaxed/simple;
	bh=jFsqesQXn4GfZsl8DNDYins9vLgfpqbP9FdIJtVYiOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTrK9W5pTnvVTHnWWtyQyZ+QVZHUmWJioL54SNRHME2/zy6sn7higzg8ZJdZbo2NSfQpfN5XB4UXGrfZE+TF8wzhZ8sQyPrQ0f2tr2fmJAHO+rrSIR+OGBma2fcP8M9nmhnWcd0hkJOWIXlD/yUbMoHZgmcKTadU2aJAj29XKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRhSfeWF; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRhSfeWF"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32b43c5c04fso42081841fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751905982; x=1752510782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jcn4aTXFFqzdzxCNcAZIEJUdwhzskC0Xjrv3SXa1nwM=;
        b=JRhSfeWF844qqXRyeatrdMCC4yLvtJ2xLei9SZs1YkMWnCJpXbKUDBHgmGwF20KD9X
         mlMYyaxhVAKU7Yt9j6dg2O/nHlRp3GAd2+KU5e/z/z8otfxjOV3yPaVdVIT3EvXcGd3m
         gHvCIIHH5nBC1rHlKeAdwHWuID0mhn53P9ASPbli+GBOgTCkrUc9dEDqy69OGUPEnCGi
         j8yeKCxU/pLTjPulTqipFNcv7C+SacCJd5Ps0y6UXhsT5yxiRNipb10msUAJP93nZTax
         emEf1t7CizFDE0fmA2Q5CvFKufz28AWUvQ9R/+9jSaZtzVbabFHa6oMBbUgao2TCVe+f
         BGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751905982; x=1752510782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jcn4aTXFFqzdzxCNcAZIEJUdwhzskC0Xjrv3SXa1nwM=;
        b=hmi5hk2gvjkVc6lGxEnSQOxb253StZEFb7/tlxAer5QP8b4JcouUGSV4hxXVbKiB/6
         SuRp5v80SYWt9Q3MzMvrH0p9JGaek8Vs7ArrvzxMU/o57hCSrjbql9RYU3Z13bDL4Nxf
         bUMNldxkph8i7BGPZ1X9USUzzBI4IFwa3KR/I7InhUYiM5zALfz646pvGE9gk5dmDaxr
         6777kQIALuEJ3FDvB7FqN53t+j4QI9Nhn/BVoBYcdvl76JAYo48qRxvUr1zFyn8kRaOU
         79biDIjWVqiMF7B+HV1CmtDyRKMykhnYwmGMXDcpjJbZvLp8Jfkdq1uHw8g2OWvhgEB9
         Di4A==
X-Forwarded-Encrypted: i=1; AJvYcCVkV5VL+AtbROS9Nk8IByEUZE81YuLu2ko+peqhYnnn6IzHRJqfNW/XiSvaCC+UnPxV9jhdFkgcRQqZ6U0zLtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHRMtd1g2ZSllCIkWPRt9EIbQCGLW2HLObBgiveV6vm3SrZLAC
	jHzqoUVAG+rYwCmzx8jcc2591skZ1aU9VJ814wqysV1WgYLvSWf82V6RS1XkNVZH1f0ZzhNkxk+
	oXLhp3mixd/nxB74LxfZ9cjHfy8fUN04=
X-Gm-Gg: ASbGnct2lj8T5qvUOR/dv6tgChGgn5c5hP/WF0sYLoItIEaWqHi0hi0+xqFdvcj/XdJ
	WePfZazTLVudIsRZAgW11j7xu+snr+pvJV15ijjreToxrzn7LyiX5FP8neMBCgz84/C+AZY5WTm
	wON70TL8Lkv/anQOWOpLh6+Utgp4nGe1hpO2RBC2wZkQ==
X-Google-Smtp-Source: AGHT+IGXpesYqNAzmygHg57lUqe+rUjFACfMjpUy/yLEjFX2TH1SZr5IQYUtI2ZDhEC17P76WpYKB0IydWMBlw2GzDo=
X-Received: by 2002:a2e:b88c:0:b0:32a:e7b9:1dc9 with SMTP id
 38308e7fff4ca-32f37e3803dmr606921fa.3.1751905981336; Mon, 07 Jul 2025
 09:33:01 -0700 (PDT)
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
 <CABtds-1+zVcnm35VQvwqP0VCXOkuaJszvsqQ-D-etwhm8kMzZA@mail.gmail.com>
 <CABBYNZ+Qnf7B5Koc3EvBrxiZsGaYy2ue=e4WHDb1zeEiRr9CgQ@mail.gmail.com> <CABtds-2tDcar+UOkVH4u5erOS+7A3kK=kJkVwQi_Ai1-OfEYdQ@mail.gmail.com>
In-Reply-To: <CABtds-2tDcar+UOkVH4u5erOS+7A3kK=kJkVwQi_Ai1-OfEYdQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 7 Jul 2025 12:32:47 -0400
X-Gm-Features: Ac12FXynaeLXcIgIjbd0bZ5byZMMu4UQ60GrHl1MxVKFWxcYMvDOja6JppyHIA0
Message-ID: <CABBYNZKdcP3NxXfaWSFJVN5enTb6V7UYM0o8dr1NWa=XoWB3Kg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Revert vendor-specific ISO classification for
To: Sean Rhodes <sean@starlabs.systems>
Cc: Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org, 
	Matt DeVillier <matt@starlabs.systems>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Mon, Jul 7, 2025 at 12:09=E2=80=AFPM Sean Rhodes <sean@starlabs.systems>=
 wrote:
>
> Hi Luiz
>
> >  are you not using btmon to capture these traces?
>
> I used `btmon -r` - is that sufficient?

-r is for reading, -w is for writing a trace, anyway the traces are in
text format so for sure this was not captured with -w.

> > maybe it is the wrong trace?
>
> It's the right trace. Happy to run again if you still have doubts?

Well if it is the right trace, then the issue has nothing to do with
reclassification of packets, perhaps something does quite work as
expected with the combination of BlueZ 5.72 and Kernel 6.11, have you
guys tried upgrading the BlueZ version? The only thing that I find a
little out of place is there seems to be a missing link-key at first
(frame #81):

< HCI Command: Link Key Request Negative... (0x01|0x000c) plen 6  #81 20.35=
0588
        Address: C4:30:18:62:E2:01 (MCS Logic Inc.)
> HCI Event: Command Complete (0x0e) plen 10                      #82 20.35=
1065
      Link Key Request Negative Reply (0x01|0x000c) ncmd 1
        Status: Success (0x00)
        Address: C4:30:18:62:E2:01 (MCS Logic Inc.)

But then it proceed to pair normally (frame #94):

> HCI Event: Auth Complete (0x06) plen 3                          #94 20.78=
7869
        Status: Success (0x00)
        Handle: 256 Address: C4:30:18:62:E2:01 (MCS Logic Inc.)

> Thanks
>
> On Mon, 7 Jul 2025 at 17:05, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sean,
> >
> > On Mon, Jun 30, 2025 at 4:08=E2=80=AFAM Sean Rhodes <sean@starlabs.syst=
ems> wrote:
> > >
> > > Hi
> > >
> > > Btmon outputs attached, one with 6.8 which works fine connecting to a=
n LG monitor and Logitech Mouse. The other with 6.11, which fails to pair w=
ith the LG monitor, and can't see the Logtech Mouse.
> >
> > I don't see a single ISO packet in these traces, if the reclassify is
> > being the problem we would see ACL packets as ISO instead, which is
> > not the case, or are you not using btmon to capture these traces?
> > Anyway, I don't see the pairing error, or anything really that would
> > indicate there is any errors with C4:30:18:62:E2:01 which seems to be
> > the LG monitor (A2DP/AVRCP/etc), or maybe it is the wrong trace?
> >
> > > Thanks
> > >
> > > Sean
> > >
> > > On Fri, 20 Jun 2025 at 17:00, Luiz Augusto von Dentz <luiz.dentz@gmai=
l.com> wrote:
> > >>
> > >> Hi Kiran,
> > >>
> > >> On Thu, Jun 19, 2025 at 4:33=E2=80=AFPM Sean Rhodes <sean@starlabs.s=
ystems> wrote:
> > >> >
> > >> > Multiple users confirmed the revert fixed the issue (https://githu=
b.com/StarLabsLtd/firmware/issues/180#issuecomment-2784770614) and that 6.9=
 works as it doesn't have this patch and we've got a DKMS module with that =
patch reverted that makes things works.
> > >> >
> > >> > I'll grab a trace on Monday
> > >> >
> > >> > On Thu, 19 Jun 2025 at 21:13, Luiz Augusto von Dentz <luiz.dentz@g=
mail.com> wrote:
> > >> >>
> > >> >> Hi Sean,
> > >> >>
> > >> >> On Thu, Jun 19, 2025 at 4:03=E2=80=AFPM Sean Rhodes <sean@starlab=
s.systems> wrote:
> > >> >> >
> > >> >> > Hi Luiz
> > >> >> >
> > >> >> > It breaks pairing - some details can be found here - https://bu=
gzilla.kernel.org/show_bug.cgi?id=3D219553
> > >> >>
> > >> >> Yeah, and Ive commented:
> > >> >>
> > >> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D219553#c4
> > >> >>
> > >> >> There seems to be a mixup of issues, something with pairing, whic=
h has
> > >> >> absolutely nothing to do with reclassifying packets, it is very l=
ikely
> > >> >> the following bug:
> > >> >>
> > >> >> https://github.com/bluez/bluez/issues/1138
> > >> >>
> > >> >> If you have evidence that there is something that these changes
> > >> >> actually cause a problem I'd like to see the HCI trace of that (u=
se
> > >> >> btmon to collect it).
> > >> >>
> > >> >> > Thanks
> > >> >> >
> > >> >> >
> > >> >> > On Thu, 19 Jun 2025 at 21:00, Luiz Augusto von Dentz <luiz.dent=
z@gmail.com> wrote:
> > >> >> >>
> > >> >> >> Hi Sean,
> > >> >> >>
> > >> >> >> On Thu, Jun 19, 2025 at 3:12=E2=80=AFPM Sean Rhodes <sean@star=
labs.systems> wrote:
> > >> >> >> >
> > >> >> >> > From 3b5497d0154a58d948ee95900e4c62704399de0a Mon Sep 17 00:=
00:00 2001
> > >> >> >> > From: Sean Rhodes <sean@starlabs.systems>
> > >> >> >> > Date: Wed, 2 Apr 2025 09:05:17 +0100
> > >> >> >> > Subject: [PATCH] Bluetooth: Revert vendor-specific ISO class=
ification for
> > >> >> >> >  non-offload cards
> > >> >> >> >
> > >> >> >> > This reverts commit f25b7fd36cc3a850e006aed686f5bbecd200de1b=
.
> > >> >> >> >
> > >> >> >> > The commit introduces vendor-specific classification of ISO =
data,
> > >> >> >> > but breaks Bluetooth functionality on certain Intel cards th=
at do
> > >> >> >> > not support audio offload, such as the 9462. Affected device=
s are
> > >> >> >> > unable to discover new Bluetooth peripherals, and previously=
 paired
> > >> >> >> > devices fail to reconnect.
> > >> >> >>
> > >> >> >> How it breaks? It doesn't seem there is anything regarding the
> > >> >> >> reclassification of the packets that could affect something th=
at
> > >> >> >> doesn't support ISO packets, well except if it happens that ol=
der
> > >> >> >> controllers use the handle range of ISO but btintel_classify_p=
kt_type
> > >> >> >> shouldn't be set for them.
> > >> >> >>
> > >> >> >> > This issue does not affect newer cards (e.g., AX201+) that s=
upport
> > >> >> >> > audio offload. A conditional check using AOLD() could be use=
d in
> > >> >> >> > the future to reintroduce this behavior only on supported ha=
rdware.
> > >> >> >> >
> > >> >> >> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > >> >> >> > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > >> >> >> > Cc: Ying Hsu <yinghsu@chromium.org>
> > >> >> >> > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >> >> >> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > >> >> >> > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > >> >> >> > Cc: Johan Hedberg <johan.hedberg@gmail.com>
> > >> >> >> > Cc: linux-bluetooth@vger.kernel.org
> > >> >> >> > Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> > >> >> >> > ---
> > >> >> >> >  drivers/bluetooth/btintel.c      |  7 ++-----
> > >> >> >> >  include/net/bluetooth/hci_core.h |  1 -
> > >> >> >> >  net/bluetooth/hci_core.c         | 16 ----------------
> > >> >> >> >  3 files changed, 2 insertions(+), 22 deletions(-)
> > >> >> >> >
> > >> >> >> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth=
/btintel.c
> > >> >> >> > index 55cc1652bfe4..1a5108cf6517 100644
> > >> >> >> > --- a/drivers/bluetooth/btintel.c
> > >> >> >> > +++ b/drivers/bluetooth/btintel.c
> > >> >> >> > @@ -3582,15 +3582,12 @@ static int btintel_setup_combined(st=
ruct hci_dev *hdev)
> > >> >> >> >                 err =3D btintel_bootloader_setup(hdev, &ver)=
;
> > >> >> >> >                 btintel_register_devcoredump_support(hdev);
> > >> >> >> >                 break;
> > >> >> >> > -       case 0x18: /* GfP2 */
> > >> >> >> > -       case 0x1c: /* GaP */
> > >> >> >> > -               /* Re-classify packet type for controllers w=
ith LE audio */
> > >> >> >> > -               hdev->classify_pkt_type =3D btintel_classify=
_pkt_type;
> > >> >> >> > -               fallthrough;
> > >> >> >>
> > >> >> >> 9462 seem to be JfP (0x11), so the above code shouldn't even b=
e used for it.
> > >>
> > >> I'm starting to suspect that JfP may not be responding with the expe=
ct
> > >> id here, which means we will need to use another field to confirm wh=
at
> > >> is the real model.
> > >>
> > >> >> >>
> > >> >> >> >         case 0x17:
> > >> >> >> > +       case 0x18:
> > >> >> >> >         case 0x19:
> > >> >> >> >         case 0x1b:
> > >> >> >> >         case 0x1d:
> > >> >> >> > +       case 0x1c:
> > >> >> >> >         case 0x1e:
> > >> >> >> >         case 0x1f:
> > >> >> >> >                 /* Display version information of TLV type *=
/
> > >> >> >> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/=
bluetooth/hci_core.h
> > >> >> >> > index 2b261e74e2c4..648ee7e2403f 100644
> > >> >> >> > --- a/include/net/bluetooth/hci_core.h
> > >> >> >> > +++ b/include/net/bluetooth/hci_core.h
> > >> >> >> > @@ -649,7 +649,6 @@ struct hci_dev {
> > >> >> >> >         int (*get_codec_config_data)(struct hci_dev *hdev, _=
_u8 type,
> > >> >> >> >                                      struct bt_codec *codec,=
 __u8 *vnd_len,
> > >> >> >> >                                      __u8 **vnd_data);
> > >> >> >> > -       u8 (*classify_pkt_type)(struct hci_dev *hdev, struct=
 sk_buff *skb);
> > >> >> >> >  };
> > >> >> >> >
> > >> >> >> >  #define HCI_PHY_HANDLE(handle) (handle & 0xff)
> > >> >> >> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_co=
re.c
> > >> >> >> > index 3b49828160b7..64ab7702be81 100644
> > >> >> >> > --- a/net/bluetooth/hci_core.c
> > >> >> >> > +++ b/net/bluetooth/hci_core.c
> > >> >> >> > @@ -2868,31 +2868,15 @@ int hci_reset_dev(struct hci_dev *hd=
ev)
> > >> >> >> >  }
> > >> >> >> >  EXPORT_SYMBOL(hci_reset_dev);
> > >> >> >> >
> > >> >> >> > -static u8 hci_dev_classify_pkt_type(struct hci_dev *hdev, s=
truct sk_buff *skb)
> > >> >> >> > -{
> > >> >> >> > -       if (hdev->classify_pkt_type)
> > >> >> >> > -               return hdev->classify_pkt_type(hdev, skb);
> > >> >> >> > -
> > >> >> >> > -       return hci_skb_pkt_type(skb);
> > >> >> >> > -}
> > >> >> >> > -
> > >> >> >> >  /* Receive frame from HCI drivers */
> > >> >> >> >  int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *sk=
b)
> > >> >> >> >  {
> > >> >> >> > -       u8 dev_pkt_type;
> > >> >> >> > -
> > >> >> >> >         if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
> > >> >> >> >                       && !test_bit(HCI_INIT, &hdev->flags)))=
 {
> > >> >> >> >                 kfree_skb(skb);
> > >> >> >> >                 return -ENXIO;
> > >> >> >> >         }
> > >> >> >> >
> > >> >> >> > -       /* Check if the driver agree with packet type classi=
fication */
> > >> >> >> > -       dev_pkt_type =3D hci_dev_classify_pkt_type(hdev, skb=
);
> > >> >> >> > -       if (hci_skb_pkt_type(skb) !=3D dev_pkt_type) {
> > >> >> >> > -               hci_skb_pkt_type(skb) =3D dev_pkt_type;
> > >> >> >> > -       }
> > >> >> >>
> > >> >> >> This will affect all cards, not just the one you are claiming.
> > >> >> >>
> > >> >> >>
> > >> >> >> >         switch (hci_skb_pkt_type(skb)) {
> > >> >> >> >         case HCI_EVENT_PKT:
> > >> >> >> >                 break;
> > >> >> >> > --
> > >> >> >> > 2.48.1
> > >> >> >> >
> > >> >> >>
> > >> >> >>
> > >> >> >> --
> > >> >> >> Luiz Augusto von Dentz
> > >> >>
> > >> >>
> > >> >>
> > >> >> --
> > >> >> Luiz Augusto von Dentz
> > >>
> > >>
> > >>
> > >> --
> > >> Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
