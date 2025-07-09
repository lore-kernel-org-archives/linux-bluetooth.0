Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34922E92B2
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074013; cv=none; b=OtC6glMMbJ5U7ieIzZKXedUU/z8ZaqVsB95eoKNEvRRjxx730Mo7FXH9ljgZQ00OHdINVhv7C2ezmuR+hIqR29zEtO7jpYVSSd8Jiv2Xi9O4rQjxrzLSwd5lCppm1jFSth+4VfFOLRgfO7I1nBrbNEwYXjnxMNKKoTdhgF01p70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074013; c=relaxed/simple;
	bh=rG+IBVo7tmxg7bbcmwp7YP9RejYEUMzcrmhnHYOqazk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JemSolIIreAYWD16CNtAjLDGP8NCVnicSiCuyNFLueEXWVeBVHVLi/dpUYS0yV3znVE8tiwuxeYhdSKiMF6RAuxNAYr22t8TkPnV62ThomWQTGrZUT9jJdODFGbc/Rgco1w5U8ugGL32RLAo0C9A2no8xxXNeI6PdnSVaIlgadg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCqeu5iy; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCqeu5iy"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3137c20213cso64532a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752074011; x=1752678811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afrV9PLnEVSvqgBaKZjXSvsBFPq2GzJNU1LUPVNSTSY=;
        b=DCqeu5iyKtPv/V6XxmbF7vVUiMkUS98mnHq/ysIl/nRhvqbKnJJL5EtObQMJZ8MCBU
         Wjq5CW8Nr6cjGZUaKh4p6+NHeiy5CQRQ9zxSkhW7d9jPRh7O97ATYjgeO3GqWtmEZNEf
         Dm9BkmVhmWOQRUcvG0OPXmvl96L/bcVzZSE2q+Q0JeAyAhxiYJ3qx2VR5/2tIsjEe3BD
         c3GSDV5k7DewxBcztfThR9r3RC2VX9feWS71AHBPHvsFbAuIEE10l6zCSv7Ks46GEzNB
         L5fMC7QeEtyiy9hej/mUiPsBTDL/vbuXndB1AeCg+/FtG1oI781Cj0zlKxrTJ90dk4cw
         GHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752074011; x=1752678811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afrV9PLnEVSvqgBaKZjXSvsBFPq2GzJNU1LUPVNSTSY=;
        b=sF/OVJTDqe1GJsJxXsyIYlEp9XwjmQCp0ybgVB3tF2A24dIrOIF42OUDK7G6zny1h1
         IK9wtskoje2kvuvV1O2RASWQzb4V61wGLJwXn9rS+dlL+SQFQHE9ve74B20jvg7yHlF3
         pNrSPI/PpLKibp5PWNYSJe9q8WhYeaXYYjbi1V2WW6gx3iIzagEhjtajTcVw6LPC1ona
         5pBdBJU4qtEhRzfhOVzdor6ld0xJrksCU2hEWu1zHLkejrsSC/OCDc9gNID4dxi60E4A
         mNZvQV+diEfZ2k8ApFtaNobtsGWYcli+WjiiaajHt4/o+T0CniawKFztyZeI90qAe3iL
         HSog==
X-Forwarded-Encrypted: i=1; AJvYcCVrstoCBzBRx041VsSjWn1iryMuI4UjP8I4kSZiYQeKjoX3Wsvxl34r8S0ZxMyWl04Txv7ZFHxrsq4HtD1Vz2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWd7B12V8eSRIVi3Ls1aTkPKnlDirrpxxYPMh+R0Bqms7LbTD7
	6AuR4SiaJQ8dh23xa5NqSFZnKQ0w3uWLK1Yd9Z7Un2WzOeA004wTUl3nQcQDy+cs1H6ZoOWaC0T
	0gjBEZ5rL1cumKGqCj2F1epegGMRFlR9LQiPmhW0fOg==
X-Gm-Gg: ASbGncsQWHHnRkKCqQj/n2brKnGMO1maDnABajvY5iN+JvCtN1G3XFrThd2H81/Xc3t
	HMQIkqVCH0ped6eB1aYSnbcs4VHOvr//D/0jeJYJkLGjIe7m2zPlRgSruLpoAUBqidztWWhN4jK
	Zxzjw43FA5Asf4fTsLkyEySQVXz4biAHZjondt2IKLMA==
X-Google-Smtp-Source: AGHT+IESPCdKReFrbnNm6pB1UWC44V+yrANNyoN+k1gJTbeP038frPr17DfGc6/2CLbew99rCMguO4RvdBVA4QiC6mQ=
X-Received: by 2002:a17:90b:224c:b0:31a:9004:899d with SMTP id
 98e67ed59e1d1-31c3c2e3491mr463647a91.18.1752074010673; Wed, 09 Jul 2025
 08:13:30 -0700 (PDT)
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
 <CABtds-2tDcar+UOkVH4u5erOS+7A3kK=kJkVwQi_Ai1-OfEYdQ@mail.gmail.com>
 <CABBYNZKdcP3NxXfaWSFJVN5enTb6V7UYM0o8dr1NWa=XoWB3Kg@mail.gmail.com> <CABtds-2v=bgQ_5jtFAmaUpTrp-zVPBqS5q=caNhLMaUr-Tsvng@mail.gmail.com>
In-Reply-To: <CABtds-2v=bgQ_5jtFAmaUpTrp-zVPBqS5q=caNhLMaUr-Tsvng@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 9 Jul 2025 11:13:15 -0400
X-Gm-Features: Ac12FXwiBVP8wr_1Y4c7uJcsVCL0NuTO1NDVuLtkp0dqhTbcA1-283j50xzVMj4
Message-ID: <CABBYNZ+0u-khSXP4rOnGrj8e_o_P+bobPtRqqZKL_bxJ+qBbqA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Revert vendor-specific ISO classification for
To: Sean Rhodes <sean@starlabs.systems>
Cc: Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org, 
	Matt DeVillier <matt@starlabs.systems>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Tue, Jul 8, 2025 at 4:29=E2=80=AFAM Sean Rhodes <sean@starlabs.systems> =
wrote:
>
> > -r is for reading, -w is for writing a trace, anyway the traces are in
>
> Thanks, attached is captured with `btmon -w log.txt` with 6.14, trying
> to connect to a Logitech Mouse.
>
> >  have you guys tried upgrading the BlueZ version?
>
> Yes - literally, only thing we've found to work is to not have the
> aforementioned patch in the equation.

Yep, this does look like it is reclassifying packets as ISO:

> ISO Data RX: Handle 3585 flags 0x02 dlen 11                              =
                                                #35 [hci0] 2.949967
> ISO Data RX: Handle 3585 flags 0x02 dlen 7                               =
                                                #36 [hci0] 2.995012
> HCI Event: Disconnect Complete (0x05) plen 4                             =
                                               #37 [hci0] 32.423595
        Status: Success (0x00)
        Handle: 3585 Address: EF:36:6F:77:29:0D (Static)
        Reason: Remote User Terminated Connection (0x13)

> On Mon, 7 Jul 2025 at 17:33, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sean,
> >
> > On Mon, Jul 7, 2025 at 12:09=E2=80=AFPM Sean Rhodes <sean@starlabs.syst=
ems> wrote:
> > >
> > > Hi Luiz
> > >
> > > >  are you not using btmon to capture these traces?
> > >
> > > I used `btmon -r` - is that sufficient?
> >
> > -r is for reading, -w is for writing a trace, anyway the traces are in
> > text format so for sure this was not captured with -w.
> >
> > > > maybe it is the wrong trace?
> > >
> > > It's the right trace. Happy to run again if you still have doubts?
> >
> > Well if it is the right trace, then the issue has nothing to do with
> > reclassification of packets, perhaps something does quite work as
> > expected with the combination of BlueZ 5.72 and Kernel 6.11, have you
> > guys tried upgrading the BlueZ version? The only thing that I find a
> > little out of place is there seems to be a missing link-key at first
> > (frame #81):
> >
> > < HCI Command: Link Key Request Negative... (0x01|0x000c) plen 6  #81 2=
0.350588
> >         Address: C4:30:18:62:E2:01 (MCS Logic Inc.)
> > > HCI Event: Command Complete (0x0e) plen 10                      #82 2=
0.351065
> >       Link Key Request Negative Reply (0x01|0x000c) ncmd 1
> >         Status: Success (0x00)
> >         Address: C4:30:18:62:E2:01 (MCS Logic Inc.)
> >
> > But then it proceed to pair normally (frame #94):
> >
> > > HCI Event: Auth Complete (0x06) plen 3                          #94 2=
0.787869
> >         Status: Success (0x00)
> >         Handle: 256 Address: C4:30:18:62:E2:01 (MCS Logic Inc.)
> >
> > > Thanks
> > >
> > > On Mon, 7 Jul 2025 at 17:05, Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Sean,
> > > >
> > > > On Mon, Jun 30, 2025 at 4:08=E2=80=AFAM Sean Rhodes <sean@starlabs.=
systems> wrote:
> > > > >
> > > > > Hi
> > > > >
> > > > > Btmon outputs attached, one with 6.8 which works fine connecting =
to an LG monitor and Logitech Mouse. The other with 6.11, which fails to pa=
ir with the LG monitor, and can't see the Logtech Mouse.
> > > >
> > > > I don't see a single ISO packet in these traces, if the reclassify =
is
> > > > being the problem we would see ACL packets as ISO instead, which is
> > > > not the case, or are you not using btmon to capture these traces?
> > > > Anyway, I don't see the pairing error, or anything really that woul=
d
> > > > indicate there is any errors with C4:30:18:62:E2:01 which seems to =
be
> > > > the LG monitor (A2DP/AVRCP/etc), or maybe it is the wrong trace?
> > > >
> > > > > Thanks
> > > > >
> > > > > Sean
> > > > >
> > > > > On Fri, 20 Jun 2025 at 17:00, Luiz Augusto von Dentz <luiz.dentz@=
gmail.com> wrote:
> > > > >>
> > > > >> Hi Kiran,
> > > > >>
> > > > >> On Thu, Jun 19, 2025 at 4:33=E2=80=AFPM Sean Rhodes <sean@starla=
bs.systems> wrote:
> > > > >> >
> > > > >> > Multiple users confirmed the revert fixed the issue (https://g=
ithub.com/StarLabsLtd/firmware/issues/180#issuecomment-2784770614) and that=
 6.9 works as it doesn't have this patch and we've got a DKMS module with t=
hat patch reverted that makes things works.
> > > > >> >
> > > > >> > I'll grab a trace on Monday
> > > > >> >
> > > > >> > On Thu, 19 Jun 2025 at 21:13, Luiz Augusto von Dentz <luiz.den=
tz@gmail.com> wrote:
> > > > >> >>
> > > > >> >> Hi Sean,
> > > > >> >>
> > > > >> >> On Thu, Jun 19, 2025 at 4:03=E2=80=AFPM Sean Rhodes <sean@sta=
rlabs.systems> wrote:
> > > > >> >> >
> > > > >> >> > Hi Luiz
> > > > >> >> >
> > > > >> >> > It breaks pairing - some details can be found here - https:=
//bugzilla.kernel.org/show_bug.cgi?id=3D219553
> > > > >> >>
> > > > >> >> Yeah, and Ive commented:
> > > > >> >>
> > > > >> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D219553#c4
> > > > >> >>
> > > > >> >> There seems to be a mixup of issues, something with pairing, =
which has
> > > > >> >> absolutely nothing to do with reclassifying packets, it is ve=
ry likely
> > > > >> >> the following bug:
> > > > >> >>
> > > > >> >> https://github.com/bluez/bluez/issues/1138
> > > > >> >>
> > > > >> >> If you have evidence that there is something that these chang=
es
> > > > >> >> actually cause a problem I'd like to see the HCI trace of tha=
t (use
> > > > >> >> btmon to collect it).
> > > > >> >>
> > > > >> >> > Thanks
> > > > >> >> >
> > > > >> >> >
> > > > >> >> > On Thu, 19 Jun 2025 at 21:00, Luiz Augusto von Dentz <luiz.=
dentz@gmail.com> wrote:
> > > > >> >> >>
> > > > >> >> >> Hi Sean,
> > > > >> >> >>
> > > > >> >> >> On Thu, Jun 19, 2025 at 3:12=E2=80=AFPM Sean Rhodes <sean@=
starlabs.systems> wrote:
> > > > >> >> >> >
> > > > >> >> >> > From 3b5497d0154a58d948ee95900e4c62704399de0a Mon Sep 17=
 00:00:00 2001
> > > > >> >> >> > From: Sean Rhodes <sean@starlabs.systems>
> > > > >> >> >> > Date: Wed, 2 Apr 2025 09:05:17 +0100
> > > > >> >> >> > Subject: [PATCH] Bluetooth: Revert vendor-specific ISO c=
lassification for
> > > > >> >> >> >  non-offload cards
> > > > >> >> >> >
> > > > >> >> >> > This reverts commit f25b7fd36cc3a850e006aed686f5bbecd200=
de1b.
> > > > >> >> >> >
> > > > >> >> >> > The commit introduces vendor-specific classification of =
ISO data,
> > > > >> >> >> > but breaks Bluetooth functionality on certain Intel card=
s that do
> > > > >> >> >> > not support audio offload, such as the 9462. Affected de=
vices are
> > > > >> >> >> > unable to discover new Bluetooth peripherals, and previo=
usly paired
> > > > >> >> >> > devices fail to reconnect.
> > > > >> >> >>
> > > > >> >> >> How it breaks? It doesn't seem there is anything regarding=
 the
> > > > >> >> >> reclassification of the packets that could affect somethin=
g that
> > > > >> >> >> doesn't support ISO packets, well except if it happens tha=
t older
> > > > >> >> >> controllers use the handle range of ISO but btintel_classi=
fy_pkt_type
> > > > >> >> >> shouldn't be set for them.
> > > > >> >> >>
> > > > >> >> >> > This issue does not affect newer cards (e.g., AX201+) th=
at support
> > > > >> >> >> > audio offload. A conditional check using AOLD() could be=
 used in
> > > > >> >> >> > the future to reintroduce this behavior only on supporte=
d hardware.
> > > > >> >> >> >
> > > > >> >> >> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > > > >> >> >> > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > > > >> >> >> > Cc: Ying Hsu <yinghsu@chromium.org>
> > > > >> >> >> > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > >> >> >> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > > > >> >> >> > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > > > >> >> >> > Cc: Johan Hedberg <johan.hedberg@gmail.com>
> > > > >> >> >> > Cc: linux-bluetooth@vger.kernel.org
> > > > >> >> >> > Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> > > > >> >> >> > ---
> > > > >> >> >> >  drivers/bluetooth/btintel.c      |  7 ++-----
> > > > >> >> >> >  include/net/bluetooth/hci_core.h |  1 -
> > > > >> >> >> >  net/bluetooth/hci_core.c         | 16 ----------------
> > > > >> >> >> >  3 files changed, 2 insertions(+), 22 deletions(-)
> > > > >> >> >> >
> > > > >> >> >> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluet=
ooth/btintel.c
> > > > >> >> >> > index 55cc1652bfe4..1a5108cf6517 100644
> > > > >> >> >> > --- a/drivers/bluetooth/btintel.c
> > > > >> >> >> > +++ b/drivers/bluetooth/btintel.c
> > > > >> >> >> > @@ -3582,15 +3582,12 @@ static int btintel_setup_combine=
d(struct hci_dev *hdev)
> > > > >> >> >> >                 err =3D btintel_bootloader_setup(hdev, &=
ver);
> > > > >> >> >> >                 btintel_register_devcoredump_support(hde=
v);
> > > > >> >> >> >                 break;
> > > > >> >> >> > -       case 0x18: /* GfP2 */
> > > > >> >> >> > -       case 0x1c: /* GaP */
> > > > >> >> >> > -               /* Re-classify packet type for controlle=
rs with LE audio */
> > > > >> >> >> > -               hdev->classify_pkt_type =3D btintel_clas=
sify_pkt_type;
> > > > >> >> >> > -               fallthrough;
> > > > >> >> >>
> > > > >> >> >> 9462 seem to be JfP (0x11), so the above code shouldn't ev=
en be used for it.
> > > > >>
> > > > >> I'm starting to suspect that JfP may not be responding with the =
expect
> > > > >> id here, which means we will need to use another field to confir=
m what
> > > > >> is the real model.
> > > > >>
> > > > >> >> >>
> > > > >> >> >> >         case 0x17:
> > > > >> >> >> > +       case 0x18:
> > > > >> >> >> >         case 0x19:
> > > > >> >> >> >         case 0x1b:
> > > > >> >> >> >         case 0x1d:
> > > > >> >> >> > +       case 0x1c:
> > > > >> >> >> >         case 0x1e:
> > > > >> >> >> >         case 0x1f:
> > > > >> >> >> >                 /* Display version information of TLV ty=
pe */
> > > > >> >> >> > diff --git a/include/net/bluetooth/hci_core.h b/include/=
net/bluetooth/hci_core.h
> > > > >> >> >> > index 2b261e74e2c4..648ee7e2403f 100644
> > > > >> >> >> > --- a/include/net/bluetooth/hci_core.h
> > > > >> >> >> > +++ b/include/net/bluetooth/hci_core.h
> > > > >> >> >> > @@ -649,7 +649,6 @@ struct hci_dev {
> > > > >> >> >> >         int (*get_codec_config_data)(struct hci_dev *hde=
v, __u8 type,
> > > > >> >> >> >                                      struct bt_codec *co=
dec, __u8 *vnd_len,
> > > > >> >> >> >                                      __u8 **vnd_data);
> > > > >> >> >> > -       u8 (*classify_pkt_type)(struct hci_dev *hdev, st=
ruct sk_buff *skb);
> > > > >> >> >> >  };
> > > > >> >> >> >
> > > > >> >> >> >  #define HCI_PHY_HANDLE(handle) (handle & 0xff)
> > > > >> >> >> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hc=
i_core.c
> > > > >> >> >> > index 3b49828160b7..64ab7702be81 100644
> > > > >> >> >> > --- a/net/bluetooth/hci_core.c
> > > > >> >> >> > +++ b/net/bluetooth/hci_core.c
> > > > >> >> >> > @@ -2868,31 +2868,15 @@ int hci_reset_dev(struct hci_dev=
 *hdev)
> > > > >> >> >> >  }
> > > > >> >> >> >  EXPORT_SYMBOL(hci_reset_dev);
> > > > >> >> >> >
> > > > >> >> >> > -static u8 hci_dev_classify_pkt_type(struct hci_dev *hde=
v, struct sk_buff *skb)
> > > > >> >> >> > -{
> > > > >> >> >> > -       if (hdev->classify_pkt_type)
> > > > >> >> >> > -               return hdev->classify_pkt_type(hdev, skb=
);
> > > > >> >> >> > -
> > > > >> >> >> > -       return hci_skb_pkt_type(skb);
> > > > >> >> >> > -}
> > > > >> >> >> > -
> > > > >> >> >> >  /* Receive frame from HCI drivers */
> > > > >> >> >> >  int hci_recv_frame(struct hci_dev *hdev, struct sk_buff=
 *skb)
> > > > >> >> >> >  {
> > > > >> >> >> > -       u8 dev_pkt_type;
> > > > >> >> >> > -
> > > > >> >> >> >         if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
> > > > >> >> >> >                       && !test_bit(HCI_INIT, &hdev->flag=
s))) {
> > > > >> >> >> >                 kfree_skb(skb);
> > > > >> >> >> >                 return -ENXIO;
> > > > >> >> >> >         }
> > > > >> >> >> >
> > > > >> >> >> > -       /* Check if the driver agree with packet type cl=
assification */
> > > > >> >> >> > -       dev_pkt_type =3D hci_dev_classify_pkt_type(hdev,=
 skb);
> > > > >> >> >> > -       if (hci_skb_pkt_type(skb) !=3D dev_pkt_type) {
> > > > >> >> >> > -               hci_skb_pkt_type(skb) =3D dev_pkt_type;
> > > > >> >> >> > -       }
> > > > >> >> >>
> > > > >> >> >> This will affect all cards, not just the one you are claim=
ing.
> > > > >> >> >>
> > > > >> >> >>
> > > > >> >> >> >         switch (hci_skb_pkt_type(skb)) {
> > > > >> >> >> >         case HCI_EVENT_PKT:
> > > > >> >> >> >                 break;
> > > > >> >> >> > --
> > > > >> >> >> > 2.48.1
> > > > >> >> >> >
> > > > >> >> >>
> > > > >> >> >>
> > > > >> >> >> --
> > > > >> >> >> Luiz Augusto von Dentz
> > > > >> >>
> > > > >> >>
> > > > >> >>
> > > > >> >> --
> > > > >> >> Luiz Augusto von Dentz
> > > > >>
> > > > >>
> > > > >>
> > > > >> --
> > > > >> Luiz Augusto von Dentz
> > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
