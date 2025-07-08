Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8073298261
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963378; cv=none; b=ccqaVtg0OPj9xWSC5h1XtJz+G3SykwhMl1+Y1hS8eJwJ8NaMVXx9zb872rbohC4YPrhwkwuKzAWedtHn1p4+NEYLYVbDNtQj7vX970fHocJrIZvlUIfkH0cbIs6reSzMu57nGHjBEgmzmI4N7TQpwAAHUzRcEK2dTdjBkOwbvY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963378; c=relaxed/simple;
	bh=geZpiIeTdWrGV4DumDoA9+qISwqeQCUEUWkC0nynQYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjyqLtNZy+9A5+/HyQu9h776aPPBHbB5OMHi8xkQF6Xll0j7lXYe4FCSgpPTq/bxfCdm8cTH/Cero2Yp92cjs+Z1NcvbgIY+1blxDuPoWARCivwH0MicxqhwhIlxMm8C32OM6vCTS3X9wk98tDQ6uAvl8wgU7KxwrUWlIBtrDdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=Coxw/BdX; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="Coxw/BdX"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so6646560a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 01:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1751963373; x=1752568173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g/4eImo8hsllQD921+UXI+3gSKTfdHSFFQSl85xe7RA=;
        b=Coxw/BdXWxdtfBEcJWtdeXy7+fSjpaguwCsIAM95WYGNWy8dh8ZJxOvuv2+51z18nA
         7KSzgLndYDuszVGKRJhwWwBH37V/lpivXKFpVr/JLlqhDoK39Jskw/3/XXhYDNM6AaB4
         3hla0ZNeW0Oaj3xnx/gaEyRonpQJNDFCmtPaYY6IP6mklHy6CRVsLIazDTYyfLaNG4qS
         y1IwdYVZ8UfymgOYUccw/Z0bDbfaP94YSblQ4FldoBsuuMqUCV1EfF694OIM1HkblGKK
         dZGNZIwNk0GsJB7Il14obfejZhu8kgUr0JFliHBktpWas2Tt9yKZgGh7Zl4eEpntIYGV
         8qcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751963373; x=1752568173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/4eImo8hsllQD921+UXI+3gSKTfdHSFFQSl85xe7RA=;
        b=eZFJBiY4ZDuQ6zux3i5fcKTPLyTuVrS+jHRhRoVSM3EUFhTyqygXsMgXpZbAGUhbM9
         6+GQWdrxPCpNObiRwewDZMBPxqIoAnZlBD+sWSbhO5W6SgswTfK+vxVltqMheLXJOS3b
         jkjlfnE3dJcgM0AYtEi9+YW1C/7f/aXYE9MOXLRA4hDAXlXMGlZ99LS7mw54UCRHnhba
         c0WzPqhbZgBTqt+In2ZlUSj/O4tKmTDU7l/EiT2KWknokAK3kIwsAoOq1nBFwxT2OQ3z
         CTDljo2wO12fGFxdrbH9A0AfVTuLA2wfXqPMAQuDoPNWAwIWoOfzLnVuaZYqufhbFmgI
         i74w==
X-Forwarded-Encrypted: i=1; AJvYcCUIDbRHWe/8f4mJ+yD7js+pu70MoCV6K7RzQJHDnBhe0W62UpwGbUHsPuxbYlRChgpg/ML6HzqQycK4OTryBzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0JnDFK/F9J3BYseHJwCJb2PZKSVOIH92QqIIlZRxBwkohlTuC
	LOJ2F1Y+PMbZNihSUqhdxu4lvEwv0PFSwD7ypRVkcZuL2hphsMBdZ8IPHwiGS23M6D+VE8nYF9+
	nVumhM+/wxAoPuDt5KjIB5JlBeJmhA8b28NbB1zkc
X-Gm-Gg: ASbGncvT21ufI18ddklARsS/KhTJ3imjeQXAV0oOgocqhDy94GAw4fX1hvxrA9LsxTZ
	5NQt1s/tX0gmTxL8oGwiDS8j67+EULwE047OBFvW3fu1sVFRlOdjwLlt83svFE01rE/jf/1PiuH
	REaRboPNq43d/6tXohVBy4q/e82AJLmUXmUweqQqC5pJFlTQIZ+jEzT1o=
X-Google-Smtp-Source: AGHT+IEcie81C5ttSCPkT/537vRRf2ivwq3G5jvmxoI2nI3vHl+RzE9ohmhDoERoTBildWY+IfZUNUn2Ej8kmMm0aFM=
X-Received: by 2002:a05:6402:40c5:b0:60c:44d6:281f with SMTP id
 4fb4d7f45d1cf-60fd650a617mr15900575a12.7.1751963372429; Tue, 08 Jul 2025
 01:29:32 -0700 (PDT)
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
 <CABBYNZ+Qnf7B5Koc3EvBrxiZsGaYy2ue=e4WHDb1zeEiRr9CgQ@mail.gmail.com>
 <CABtds-2tDcar+UOkVH4u5erOS+7A3kK=kJkVwQi_Ai1-OfEYdQ@mail.gmail.com> <CABBYNZKdcP3NxXfaWSFJVN5enTb6V7UYM0o8dr1NWa=XoWB3Kg@mail.gmail.com>
In-Reply-To: <CABBYNZKdcP3NxXfaWSFJVN5enTb6V7UYM0o8dr1NWa=XoWB3Kg@mail.gmail.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Tue, 8 Jul 2025 09:29:20 +0100
X-Gm-Features: Ac12FXwSHj-o85T9CJWriaDEy4wNBb_pacXsRuMu504PEqnD1PDpe_lj33HMa3Y
Message-ID: <CABtds-2v=bgQ_5jtFAmaUpTrp-zVPBqS5q=caNhLMaUr-Tsvng@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Revert vendor-specific ISO classification for
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org, 
	Matt DeVillier <matt@starlabs.systems>
Content-Type: multipart/mixed; boundary="000000000000797054063966c2e0"

--000000000000797054063966c2e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> -r is for reading, -w is for writing a trace, anyway the traces are in

Thanks, attached is captured with `btmon -w log.txt` with 6.14, trying
to connect to a Logitech Mouse.

>  have you guys tried upgrading the BlueZ version?

Yes - literally, only thing we've found to work is to not have the
aforementioned patch in the equation.

On Mon, 7 Jul 2025 at 17:33, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sean,
>
> On Mon, Jul 7, 2025 at 12:09=E2=80=AFPM Sean Rhodes <sean@starlabs.system=
s> wrote:
> >
> > Hi Luiz
> >
> > >  are you not using btmon to capture these traces?
> >
> > I used `btmon -r` - is that sufficient?
>
> -r is for reading, -w is for writing a trace, anyway the traces are in
> text format so for sure this was not captured with -w.
>
> > > maybe it is the wrong trace?
> >
> > It's the right trace. Happy to run again if you still have doubts?
>
> Well if it is the right trace, then the issue has nothing to do with
> reclassification of packets, perhaps something does quite work as
> expected with the combination of BlueZ 5.72 and Kernel 6.11, have you
> guys tried upgrading the BlueZ version? The only thing that I find a
> little out of place is there seems to be a missing link-key at first
> (frame #81):
>
> < HCI Command: Link Key Request Negative... (0x01|0x000c) plen 6  #81 20.=
350588
>         Address: C4:30:18:62:E2:01 (MCS Logic Inc.)
> > HCI Event: Command Complete (0x0e) plen 10                      #82 20.=
351065
>       Link Key Request Negative Reply (0x01|0x000c) ncmd 1
>         Status: Success (0x00)
>         Address: C4:30:18:62:E2:01 (MCS Logic Inc.)
>
> But then it proceed to pair normally (frame #94):
>
> > HCI Event: Auth Complete (0x06) plen 3                          #94 20.=
787869
>         Status: Success (0x00)
>         Handle: 256 Address: C4:30:18:62:E2:01 (MCS Logic Inc.)
>
> > Thanks
> >
> > On Mon, 7 Jul 2025 at 17:05, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Sean,
> > >
> > > On Mon, Jun 30, 2025 at 4:08=E2=80=AFAM Sean Rhodes <sean@starlabs.sy=
stems> wrote:
> > > >
> > > > Hi
> > > >
> > > > Btmon outputs attached, one with 6.8 which works fine connecting to=
 an LG monitor and Logitech Mouse. The other with 6.11, which fails to pair=
 with the LG monitor, and can't see the Logtech Mouse.
> > >
> > > I don't see a single ISO packet in these traces, if the reclassify is
> > > being the problem we would see ACL packets as ISO instead, which is
> > > not the case, or are you not using btmon to capture these traces?
> > > Anyway, I don't see the pairing error, or anything really that would
> > > indicate there is any errors with C4:30:18:62:E2:01 which seems to be
> > > the LG monitor (A2DP/AVRCP/etc), or maybe it is the wrong trace?
> > >
> > > > Thanks
> > > >
> > > > Sean
> > > >
> > > > On Fri, 20 Jun 2025 at 17:00, Luiz Augusto von Dentz <luiz.dentz@gm=
ail.com> wrote:
> > > >>
> > > >> Hi Kiran,
> > > >>
> > > >> On Thu, Jun 19, 2025 at 4:33=E2=80=AFPM Sean Rhodes <sean@starlabs=
.systems> wrote:
> > > >> >
> > > >> > Multiple users confirmed the revert fixed the issue (https://git=
hub.com/StarLabsLtd/firmware/issues/180#issuecomment-2784770614) and that 6=
.9 works as it doesn't have this patch and we've got a DKMS module with tha=
t patch reverted that makes things works.
> > > >> >
> > > >> > I'll grab a trace on Monday
> > > >> >
> > > >> > On Thu, 19 Jun 2025 at 21:13, Luiz Augusto von Dentz <luiz.dentz=
@gmail.com> wrote:
> > > >> >>
> > > >> >> Hi Sean,
> > > >> >>
> > > >> >> On Thu, Jun 19, 2025 at 4:03=E2=80=AFPM Sean Rhodes <sean@starl=
abs.systems> wrote:
> > > >> >> >
> > > >> >> > Hi Luiz
> > > >> >> >
> > > >> >> > It breaks pairing - some details can be found here - https://=
bugzilla.kernel.org/show_bug.cgi?id=3D219553
> > > >> >>
> > > >> >> Yeah, and Ive commented:
> > > >> >>
> > > >> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D219553#c4
> > > >> >>
> > > >> >> There seems to be a mixup of issues, something with pairing, wh=
ich has
> > > >> >> absolutely nothing to do with reclassifying packets, it is very=
 likely
> > > >> >> the following bug:
> > > >> >>
> > > >> >> https://github.com/bluez/bluez/issues/1138
> > > >> >>
> > > >> >> If you have evidence that there is something that these changes
> > > >> >> actually cause a problem I'd like to see the HCI trace of that =
(use
> > > >> >> btmon to collect it).
> > > >> >>
> > > >> >> > Thanks
> > > >> >> >
> > > >> >> >
> > > >> >> > On Thu, 19 Jun 2025 at 21:00, Luiz Augusto von Dentz <luiz.de=
ntz@gmail.com> wrote:
> > > >> >> >>
> > > >> >> >> Hi Sean,
> > > >> >> >>
> > > >> >> >> On Thu, Jun 19, 2025 at 3:12=E2=80=AFPM Sean Rhodes <sean@st=
arlabs.systems> wrote:
> > > >> >> >> >
> > > >> >> >> > From 3b5497d0154a58d948ee95900e4c62704399de0a Mon Sep 17 0=
0:00:00 2001
> > > >> >> >> > From: Sean Rhodes <sean@starlabs.systems>
> > > >> >> >> > Date: Wed, 2 Apr 2025 09:05:17 +0100
> > > >> >> >> > Subject: [PATCH] Bluetooth: Revert vendor-specific ISO cla=
ssification for
> > > >> >> >> >  non-offload cards
> > > >> >> >> >
> > > >> >> >> > This reverts commit f25b7fd36cc3a850e006aed686f5bbecd200de=
1b.
> > > >> >> >> >
> > > >> >> >> > The commit introduces vendor-specific classification of IS=
O data,
> > > >> >> >> > but breaks Bluetooth functionality on certain Intel cards =
that do
> > > >> >> >> > not support audio offload, such as the 9462. Affected devi=
ces are
> > > >> >> >> > unable to discover new Bluetooth peripherals, and previous=
ly paired
> > > >> >> >> > devices fail to reconnect.
> > > >> >> >>
> > > >> >> >> How it breaks? It doesn't seem there is anything regarding t=
he
> > > >> >> >> reclassification of the packets that could affect something =
that
> > > >> >> >> doesn't support ISO packets, well except if it happens that =
older
> > > >> >> >> controllers use the handle range of ISO but btintel_classify=
_pkt_type
> > > >> >> >> shouldn't be set for them.
> > > >> >> >>
> > > >> >> >> > This issue does not affect newer cards (e.g., AX201+) that=
 support
> > > >> >> >> > audio offload. A conditional check using AOLD() could be u=
sed in
> > > >> >> >> > the future to reintroduce this behavior only on supported =
hardware.
> > > >> >> >> >
> > > >> >> >> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > > >> >> >> > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > > >> >> >> > Cc: Ying Hsu <yinghsu@chromium.org>
> > > >> >> >> > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > >> >> >> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > > >> >> >> > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > > >> >> >> > Cc: Johan Hedberg <johan.hedberg@gmail.com>
> > > >> >> >> > Cc: linux-bluetooth@vger.kernel.org
> > > >> >> >> > Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> > > >> >> >> > ---
> > > >> >> >> >  drivers/bluetooth/btintel.c      |  7 ++-----
> > > >> >> >> >  include/net/bluetooth/hci_core.h |  1 -
> > > >> >> >> >  net/bluetooth/hci_core.c         | 16 ----------------
> > > >> >> >> >  3 files changed, 2 insertions(+), 22 deletions(-)
> > > >> >> >> >
> > > >> >> >> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetoo=
th/btintel.c
> > > >> >> >> > index 55cc1652bfe4..1a5108cf6517 100644
> > > >> >> >> > --- a/drivers/bluetooth/btintel.c
> > > >> >> >> > +++ b/drivers/bluetooth/btintel.c
> > > >> >> >> > @@ -3582,15 +3582,12 @@ static int btintel_setup_combined(=
struct hci_dev *hdev)
> > > >> >> >> >                 err =3D btintel_bootloader_setup(hdev, &ve=
r);
> > > >> >> >> >                 btintel_register_devcoredump_support(hdev)=
;
> > > >> >> >> >                 break;
> > > >> >> >> > -       case 0x18: /* GfP2 */
> > > >> >> >> > -       case 0x1c: /* GaP */
> > > >> >> >> > -               /* Re-classify packet type for controllers=
 with LE audio */
> > > >> >> >> > -               hdev->classify_pkt_type =3D btintel_classi=
fy_pkt_type;
> > > >> >> >> > -               fallthrough;
> > > >> >> >>
> > > >> >> >> 9462 seem to be JfP (0x11), so the above code shouldn't even=
 be used for it.
> > > >>
> > > >> I'm starting to suspect that JfP may not be responding with the ex=
pect
> > > >> id here, which means we will need to use another field to confirm =
what
> > > >> is the real model.
> > > >>
> > > >> >> >>
> > > >> >> >> >         case 0x17:
> > > >> >> >> > +       case 0x18:
> > > >> >> >> >         case 0x19:
> > > >> >> >> >         case 0x1b:
> > > >> >> >> >         case 0x1d:
> > > >> >> >> > +       case 0x1c:
> > > >> >> >> >         case 0x1e:
> > > >> >> >> >         case 0x1f:
> > > >> >> >> >                 /* Display version information of TLV type=
 */
> > > >> >> >> > diff --git a/include/net/bluetooth/hci_core.h b/include/ne=
t/bluetooth/hci_core.h
> > > >> >> >> > index 2b261e74e2c4..648ee7e2403f 100644
> > > >> >> >> > --- a/include/net/bluetooth/hci_core.h
> > > >> >> >> > +++ b/include/net/bluetooth/hci_core.h
> > > >> >> >> > @@ -649,7 +649,6 @@ struct hci_dev {
> > > >> >> >> >         int (*get_codec_config_data)(struct hci_dev *hdev,=
 __u8 type,
> > > >> >> >> >                                      struct bt_codec *code=
c, __u8 *vnd_len,
> > > >> >> >> >                                      __u8 **vnd_data);
> > > >> >> >> > -       u8 (*classify_pkt_type)(struct hci_dev *hdev, stru=
ct sk_buff *skb);
> > > >> >> >> >  };
> > > >> >> >> >
> > > >> >> >> >  #define HCI_PHY_HANDLE(handle) (handle & 0xff)
> > > >> >> >> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_=
core.c
> > > >> >> >> > index 3b49828160b7..64ab7702be81 100644
> > > >> >> >> > --- a/net/bluetooth/hci_core.c
> > > >> >> >> > +++ b/net/bluetooth/hci_core.c
> > > >> >> >> > @@ -2868,31 +2868,15 @@ int hci_reset_dev(struct hci_dev *=
hdev)
> > > >> >> >> >  }
> > > >> >> >> >  EXPORT_SYMBOL(hci_reset_dev);
> > > >> >> >> >
> > > >> >> >> > -static u8 hci_dev_classify_pkt_type(struct hci_dev *hdev,=
 struct sk_buff *skb)
> > > >> >> >> > -{
> > > >> >> >> > -       if (hdev->classify_pkt_type)
> > > >> >> >> > -               return hdev->classify_pkt_type(hdev, skb);
> > > >> >> >> > -
> > > >> >> >> > -       return hci_skb_pkt_type(skb);
> > > >> >> >> > -}
> > > >> >> >> > -
> > > >> >> >> >  /* Receive frame from HCI drivers */
> > > >> >> >> >  int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *=
skb)
> > > >> >> >> >  {
> > > >> >> >> > -       u8 dev_pkt_type;
> > > >> >> >> > -
> > > >> >> >> >         if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
> > > >> >> >> >                       && !test_bit(HCI_INIT, &hdev->flags)=
)) {
> > > >> >> >> >                 kfree_skb(skb);
> > > >> >> >> >                 return -ENXIO;
> > > >> >> >> >         }
> > > >> >> >> >
> > > >> >> >> > -       /* Check if the driver agree with packet type clas=
sification */
> > > >> >> >> > -       dev_pkt_type =3D hci_dev_classify_pkt_type(hdev, s=
kb);
> > > >> >> >> > -       if (hci_skb_pkt_type(skb) !=3D dev_pkt_type) {
> > > >> >> >> > -               hci_skb_pkt_type(skb) =3D dev_pkt_type;
> > > >> >> >> > -       }
> > > >> >> >>
> > > >> >> >> This will affect all cards, not just the one you are claimin=
g.
> > > >> >> >>
> > > >> >> >>
> > > >> >> >> >         switch (hci_skb_pkt_type(skb)) {
> > > >> >> >> >         case HCI_EVENT_PKT:
> > > >> >> >> >                 break;
> > > >> >> >> > --
> > > >> >> >> > 2.48.1
> > > >> >> >> >
> > > >> >> >>
> > > >> >> >>
> > > >> >> >> --
> > > >> >> >> Luiz Augusto von Dentz
> > > >> >>
> > > >> >>
> > > >> >>
> > > >> >> --
> > > >> >> Luiz Augusto von Dentz
> > > >>
> > > >>
> > > >>
> > > >> --
> > > >> Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz

--000000000000797054063966c2e0
Content-Type: text/plain; charset="ISO-8859-1"; name="log.txt"
Content-Disposition: attachment; filename="log.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mcu9n79n0>
X-Attachment-Id: f_mcu9n79n0

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
--000000000000797054063966c2e0--
