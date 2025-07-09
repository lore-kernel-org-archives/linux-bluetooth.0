Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A0B2E888C
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075024; cv=none; b=q5IxjZEUSclb4KiDStonJRxvL5Bkxhw0R7KfqIF6PXuztynRw7gnGbfQO+F7J337ZPEyCxZ9GHIX7owmJVD8bfURvhQ+5FwGgdAXfq/MMhF1aGf9ub6aVaky42wk+2ziOrO0eYzehRvUvaM5eWuBeeBLbz9XfEkAeqrrPquzsOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075024; c=relaxed/simple;
	bh=v3ArjuoGP2lVXWofqyuWOQfypQ0k3tVwQl4bAjm8Cow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlgLIM8VvCq26LA3G9nYcNC6dSMOsW16OK1hKjYDFUl10FuSAYbuGKbbU8CxF1PixvR4Qfy07+/ZUTN/9YFtxBPiTy6qiObxxZJUOizArncb6qui34dfH/5W6AaL1nYFj4OCf2kx2GV+8HFE8RaUUH9lp2y+d0FLaHEAP8kZwVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp/2ocY9; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp/2ocY9"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b170c99aa49so89574a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 08:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752075021; x=1752679821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gZxZWGWNhhXV+hwetBc9DM1yq981eE8tPFD4Qn3PyY=;
        b=Xp/2ocY98tMo1U0XfOVqgaEe9JIAMaQRNAQyKTZIxVKyqa0Ma+78U9wnDQPu/VKHJ2
         5COSZY9/2eRgFuSTeovM4Pp3vssEz4qZHAlG2ax2INxTXisrrAOWLb1mUUfFMTIoXdwa
         x3jvYLOqYJdTClXeFIz27el0GiwFTLfHZGAZpvYMtS3/W9JRmep5ApX4QGdZmanEjbG+
         tj5Np1/rjfWKjaS4euj9amogR73+0rSgs81K+fBUqU7VKFp1eiAk+tFgOwN0tIFRoOHa
         NHEkq3ClxNSexBHukpe8kmtaLjNtnrlJMUjJMC+nhSu87BtVat2i/OiBsHuZk/Ql6EIS
         R5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752075021; x=1752679821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gZxZWGWNhhXV+hwetBc9DM1yq981eE8tPFD4Qn3PyY=;
        b=AM3kYe8uSk6kwBTPrJmF8UTfpmw7OBQAgnTe9ALvEWyzBd10J4nBtnlDg/l+Go0n8e
         72QADKM9aYeXUzjxxPTUw7MGM2KpZPYOJz8cuhM96N48CgZ2s9ztqYPVtN+EX1fCPMBc
         AyXy+sMil6PAexH0RFRdEhf5Vt+JJ1H4URgsooEzhjgbZHDtdcQNcYYHOOMGx/A/N/ZK
         DUOd5slEDXfP70xG1XfqRn3k/mtt6m7E/AMShRI6Q5CkyiA+ysLKqwlD3jiiieZODoPy
         XYXqLY3oN3IKgMZEw+V2OPFPdTR7qVJZIlQsO2uF1NBX0cpzspRxOvTtYooRxWp6A3GE
         nRyA==
X-Forwarded-Encrypted: i=1; AJvYcCV2+3rP2kexM8Oq35lwt5Ixfgo6t7KlNOcdeWUGqD2u/CCsaDWm5QY17WxTZH00JmDu6dkOjrSPaRsLSq9dFPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUEwUWiYIzvbdVt3UcMFFqJUl7sOpBMWXRifAKCBeVO5uex8+5
	tdbsOUonWJaUXjAGU4YZYxEFW8XzeCJEOo8etXNdw2tDiocr1KzKu8T88gaZgJfW53KKNIPGM1A
	03Lf+DOBBztR06NvhJ52mNOW3RzXXAcA=
X-Gm-Gg: ASbGncvdMtApMXAL1ZietUOIgQa+EaXKeq6jqi8cKKwrIEoUC/awiuisCLaPyZtITPD
	FAULliyqXsC/Cph6Uve4FnW+qhy1jp0InpD2x1N8oDx81XN3m0XSib7JooBArtV9tObHOPY42W5
	oYYFEs6afxq21b6MC7vJB8IRr3zl4iwA656b8ksuxVTw==
X-Google-Smtp-Source: AGHT+IHVTPbSP3vq/P1ATqYRfOwrPcHn2Bs7ocWVo4zJ58u70D+RjfGz8fOREqIjcbnErMcJkJfnJ7Gjdke3OWt+Fic=
X-Received: by 2002:a17:90b:1b08:b0:315:aa28:9501 with SMTP id
 98e67ed59e1d1-31c2fddc381mr5235440a91.24.1752075021168; Wed, 09 Jul 2025
 08:30:21 -0700 (PDT)
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
 <CABBYNZKdcP3NxXfaWSFJVN5enTb6V7UYM0o8dr1NWa=XoWB3Kg@mail.gmail.com>
 <CABtds-2v=bgQ_5jtFAmaUpTrp-zVPBqS5q=caNhLMaUr-Tsvng@mail.gmail.com> <CABBYNZ+0u-khSXP4rOnGrj8e_o_P+bobPtRqqZKL_bxJ+qBbqA@mail.gmail.com>
In-Reply-To: <CABBYNZ+0u-khSXP4rOnGrj8e_o_P+bobPtRqqZKL_bxJ+qBbqA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 9 Jul 2025 11:29:55 -0400
X-Gm-Features: Ac12FXz3J_yae3ZQVRPlW4jg-8TY8lsj_Af0em-BbXozhtmBrGwFSYXSDap5PI0
Message-ID: <CABBYNZLgoJo04Za5k=raKh_bxda3bYCUOqE1PfURgb-b1N4cHg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Revert vendor-specific ISO classification for
To: Sean Rhodes <sean@starlabs.systems>
Cc: Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org, 
	Matt DeVillier <matt@starlabs.systems>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi @Ying Hsu

On Wed, Jul 9, 2025 at 11:13=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sean,
>
> On Tue, Jul 8, 2025 at 4:29=E2=80=AFAM Sean Rhodes <sean@starlabs.systems=
> wrote:
> >
> > > -r is for reading, -w is for writing a trace, anyway the traces are i=
n
> >
> > Thanks, attached is captured with `btmon -w log.txt` with 6.14, trying
> > to connect to a Logitech Mouse.
> >
> > >  have you guys tried upgrading the BlueZ version?
> >
> > Yes - literally, only thing we've found to work is to not have the
> > aforementioned patch in the equation.
>
> Yep, this does look like it is reclassifying packets as ISO:
>
> > ISO Data RX: Handle 3585 flags 0x02 dlen 11                            =
                                                  #35 [hci0] 2.949967
> > ISO Data RX: Handle 3585 flags 0x02 dlen 7                             =
                                                  #36 [hci0] 2.995012
> > HCI Event: Disconnect Complete (0x05) plen 4                           =
                                                 #37 [hci0] 32.423595
>         Status: Success (0x00)
>         Handle: 3585 Address: EF:36:6F:77:29:0D (Static)
>         Reason: Remote User Terminated Connection (0x13)

Looks like we either are going to need to revert f25b7fd36cc3
("Bluetooth: Add vendor-specific packet classification for ISO data")
or do something like:

 diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 42f597cb0941..5c608cd15864 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2948,6 +2948,16 @@ int hci_recv_frame(struct hci_dev *hdev, struct
sk_buff *skb)
        case HCI_SCODATA_PKT:
                break;
        case HCI_ISODATA_PKT:
+               /* Detect if ACL packet has been wrongly reclassified as IS=
O */
+               if (!hci_conn_num(hdev, CIS_LINK) &&
+                   !hci_conn_num(hdev, BIS_LINK)) {
+                       __u16 handle =3D __le16_to_cpu(hci_acl_hdr(skb)->ha=
ndle);
+                       __u8 type;
+
+                       type =3D hci_conn_lookup_type(hdev, hci_handle(hand=
le));
+                       if (type =3D=3D LE_LINK || type =3D=3D ACL_LINK)
+                               hci_skb_pkt_type(skb) =3D HCI_ACLDATA_PKT;
+               }
                break;
        case HCI_DRV_PKT:
                break;

The problem is that for the systems using HCI_CHANNEL_USER the above
don't work since hci_conn_lookup_type won't be able to locate any
connection, so I'm leaning more towards reverting which mean
HCI_CHANNEL_USER will need to do packet reclassification on its own
(e.g. by doing handle lookup).

> > On Mon, 7 Jul 2025 at 17:33, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Sean,
> > >
> > > On Mon, Jul 7, 2025 at 12:09=E2=80=AFPM Sean Rhodes <sean@starlabs.sy=
stems> wrote:
> > > >
> > > > Hi Luiz
> > > >
> > > > >  are you not using btmon to capture these traces?
> > > >
> > > > I used `btmon -r` - is that sufficient?
> > >
> > > -r is for reading, -w is for writing a trace, anyway the traces are i=
n
> > > text format so for sure this was not captured with -w.
> > >
> > > > > maybe it is the wrong trace?
> > > >
> > > > It's the right trace. Happy to run again if you still have doubts?
> > >
> > > Well if it is the right trace, then the issue has nothing to do with
> > > reclassification of packets, perhaps something does quite work as
> > > expected with the combination of BlueZ 5.72 and Kernel 6.11, have you
> > > guys tried upgrading the BlueZ version? The only thing that I find a
> > > little out of place is there seems to be a missing link-key at first
> > > (frame #81):
> > >
> > > < HCI Command: Link Key Request Negative... (0x01|0x000c) plen 6  #81=
 20.350588
> > >         Address: C4:30:18:62:E2:01 (MCS Logic Inc.)
> > > > HCI Event: Command Complete (0x0e) plen 10                      #82=
 20.351065
> > >       Link Key Request Negative Reply (0x01|0x000c) ncmd 1
> > >         Status: Success (0x00)
> > >         Address: C4:30:18:62:E2:01 (MCS Logic Inc.)
> > >
> > > But then it proceed to pair normally (frame #94):
> > >
> > > > HCI Event: Auth Complete (0x06) plen 3                          #94=
 20.787869
> > >         Status: Success (0x00)
> > >         Handle: 256 Address: C4:30:18:62:E2:01 (MCS Logic Inc.)
> > >
> > > > Thanks
> > > >
> > > > On Mon, 7 Jul 2025 at 17:05, Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Sean,
> > > > >
> > > > > On Mon, Jun 30, 2025 at 4:08=E2=80=AFAM Sean Rhodes <sean@starlab=
s.systems> wrote:
> > > > > >
> > > > > > Hi
> > > > > >
> > > > > > Btmon outputs attached, one with 6.8 which works fine connectin=
g to an LG monitor and Logitech Mouse. The other with 6.11, which fails to =
pair with the LG monitor, and can't see the Logtech Mouse.
> > > > >
> > > > > I don't see a single ISO packet in these traces, if the reclassif=
y is
> > > > > being the problem we would see ACL packets as ISO instead, which =
is
> > > > > not the case, or are you not using btmon to capture these traces?
> > > > > Anyway, I don't see the pairing error, or anything really that wo=
uld
> > > > > indicate there is any errors with C4:30:18:62:E2:01 which seems t=
o be
> > > > > the LG monitor (A2DP/AVRCP/etc), or maybe it is the wrong trace?
> > > > >
> > > > > > Thanks
> > > > > >
> > > > > > Sean
> > > > > >
> > > > > > On Fri, 20 Jun 2025 at 17:00, Luiz Augusto von Dentz <luiz.dent=
z@gmail.com> wrote:
> > > > > >>
> > > > > >> Hi Kiran,
> > > > > >>
> > > > > >> On Thu, Jun 19, 2025 at 4:33=E2=80=AFPM Sean Rhodes <sean@star=
labs.systems> wrote:
> > > > > >> >
> > > > > >> > Multiple users confirmed the revert fixed the issue (https:/=
/github.com/StarLabsLtd/firmware/issues/180#issuecomment-2784770614) and th=
at 6.9 works as it doesn't have this patch and we've got a DKMS module with=
 that patch reverted that makes things works.
> > > > > >> >
> > > > > >> > I'll grab a trace on Monday
> > > > > >> >
> > > > > >> > On Thu, 19 Jun 2025 at 21:13, Luiz Augusto von Dentz <luiz.d=
entz@gmail.com> wrote:
> > > > > >> >>
> > > > > >> >> Hi Sean,
> > > > > >> >>
> > > > > >> >> On Thu, Jun 19, 2025 at 4:03=E2=80=AFPM Sean Rhodes <sean@s=
tarlabs.systems> wrote:
> > > > > >> >> >
> > > > > >> >> > Hi Luiz
> > > > > >> >> >
> > > > > >> >> > It breaks pairing - some details can be found here - http=
s://bugzilla.kernel.org/show_bug.cgi?id=3D219553
> > > > > >> >>
> > > > > >> >> Yeah, and Ive commented:
> > > > > >> >>
> > > > > >> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D219553#c4
> > > > > >> >>
> > > > > >> >> There seems to be a mixup of issues, something with pairing=
, which has
> > > > > >> >> absolutely nothing to do with reclassifying packets, it is =
very likely
> > > > > >> >> the following bug:
> > > > > >> >>
> > > > > >> >> https://github.com/bluez/bluez/issues/1138
> > > > > >> >>
> > > > > >> >> If you have evidence that there is something that these cha=
nges
> > > > > >> >> actually cause a problem I'd like to see the HCI trace of t=
hat (use
> > > > > >> >> btmon to collect it).
> > > > > >> >>
> > > > > >> >> > Thanks
> > > > > >> >> >
> > > > > >> >> >
> > > > > >> >> > On Thu, 19 Jun 2025 at 21:00, Luiz Augusto von Dentz <lui=
z.dentz@gmail.com> wrote:
> > > > > >> >> >>
> > > > > >> >> >> Hi Sean,
> > > > > >> >> >>
> > > > > >> >> >> On Thu, Jun 19, 2025 at 3:12=E2=80=AFPM Sean Rhodes <sea=
n@starlabs.systems> wrote:
> > > > > >> >> >> >
> > > > > >> >> >> > From 3b5497d0154a58d948ee95900e4c62704399de0a Mon Sep =
17 00:00:00 2001
> > > > > >> >> >> > From: Sean Rhodes <sean@starlabs.systems>
> > > > > >> >> >> > Date: Wed, 2 Apr 2025 09:05:17 +0100
> > > > > >> >> >> > Subject: [PATCH] Bluetooth: Revert vendor-specific ISO=
 classification for
> > > > > >> >> >> >  non-offload cards
> > > > > >> >> >> >
> > > > > >> >> >> > This reverts commit f25b7fd36cc3a850e006aed686f5bbecd2=
00de1b.
> > > > > >> >> >> >
> > > > > >> >> >> > The commit introduces vendor-specific classification o=
f ISO data,
> > > > > >> >> >> > but breaks Bluetooth functionality on certain Intel ca=
rds that do
> > > > > >> >> >> > not support audio offload, such as the 9462. Affected =
devices are
> > > > > >> >> >> > unable to discover new Bluetooth peripherals, and prev=
iously paired
> > > > > >> >> >> > devices fail to reconnect.
> > > > > >> >> >>
> > > > > >> >> >> How it breaks? It doesn't seem there is anything regardi=
ng the
> > > > > >> >> >> reclassification of the packets that could affect someth=
ing that
> > > > > >> >> >> doesn't support ISO packets, well except if it happens t=
hat older
> > > > > >> >> >> controllers use the handle range of ISO but btintel_clas=
sify_pkt_type
> > > > > >> >> >> shouldn't be set for them.
> > > > > >> >> >>
> > > > > >> >> >> > This issue does not affect newer cards (e.g., AX201+) =
that support
> > > > > >> >> >> > audio offload. A conditional check using AOLD() could =
be used in
> > > > > >> >> >> > the future to reintroduce this behavior only on suppor=
ted hardware.
> > > > > >> >> >> >
> > > > > >> >> >> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > > > > >> >> >> > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > > > > >> >> >> > Cc: Ying Hsu <yinghsu@chromium.org>
> > > > > >> >> >> > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > >> >> >> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > > > > >> >> >> > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > > > > >> >> >> > Cc: Johan Hedberg <johan.hedberg@gmail.com>
> > > > > >> >> >> > Cc: linux-bluetooth@vger.kernel.org
> > > > > >> >> >> > Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> > > > > >> >> >> > ---
> > > > > >> >> >> >  drivers/bluetooth/btintel.c      |  7 ++-----
> > > > > >> >> >> >  include/net/bluetooth/hci_core.h |  1 -
> > > > > >> >> >> >  net/bluetooth/hci_core.c         | 16 ---------------=
-
> > > > > >> >> >> >  3 files changed, 2 insertions(+), 22 deletions(-)
> > > > > >> >> >> >
> > > > > >> >> >> > diff --git a/drivers/bluetooth/btintel.c b/drivers/blu=
etooth/btintel.c
> > > > > >> >> >> > index 55cc1652bfe4..1a5108cf6517 100644
> > > > > >> >> >> > --- a/drivers/bluetooth/btintel.c
> > > > > >> >> >> > +++ b/drivers/bluetooth/btintel.c
> > > > > >> >> >> > @@ -3582,15 +3582,12 @@ static int btintel_setup_combi=
ned(struct hci_dev *hdev)
> > > > > >> >> >> >                 err =3D btintel_bootloader_setup(hdev,=
 &ver);
> > > > > >> >> >> >                 btintel_register_devcoredump_support(h=
dev);
> > > > > >> >> >> >                 break;
> > > > > >> >> >> > -       case 0x18: /* GfP2 */
> > > > > >> >> >> > -       case 0x1c: /* GaP */
> > > > > >> >> >> > -               /* Re-classify packet type for control=
lers with LE audio */
> > > > > >> >> >> > -               hdev->classify_pkt_type =3D btintel_cl=
assify_pkt_type;
> > > > > >> >> >> > -               fallthrough;
> > > > > >> >> >>
> > > > > >> >> >> 9462 seem to be JfP (0x11), so the above code shouldn't =
even be used for it.
> > > > > >>
> > > > > >> I'm starting to suspect that JfP may not be responding with th=
e expect
> > > > > >> id here, which means we will need to use another field to conf=
irm what
> > > > > >> is the real model.
> > > > > >>
> > > > > >> >> >>
> > > > > >> >> >> >         case 0x17:
> > > > > >> >> >> > +       case 0x18:
> > > > > >> >> >> >         case 0x19:
> > > > > >> >> >> >         case 0x1b:
> > > > > >> >> >> >         case 0x1d:
> > > > > >> >> >> > +       case 0x1c:
> > > > > >> >> >> >         case 0x1e:
> > > > > >> >> >> >         case 0x1f:
> > > > > >> >> >> >                 /* Display version information of TLV =
type */
> > > > > >> >> >> > diff --git a/include/net/bluetooth/hci_core.h b/includ=
e/net/bluetooth/hci_core.h
> > > > > >> >> >> > index 2b261e74e2c4..648ee7e2403f 100644
> > > > > >> >> >> > --- a/include/net/bluetooth/hci_core.h
> > > > > >> >> >> > +++ b/include/net/bluetooth/hci_core.h
> > > > > >> >> >> > @@ -649,7 +649,6 @@ struct hci_dev {
> > > > > >> >> >> >         int (*get_codec_config_data)(struct hci_dev *h=
dev, __u8 type,
> > > > > >> >> >> >                                      struct bt_codec *=
codec, __u8 *vnd_len,
> > > > > >> >> >> >                                      __u8 **vnd_data);
> > > > > >> >> >> > -       u8 (*classify_pkt_type)(struct hci_dev *hdev, =
struct sk_buff *skb);
> > > > > >> >> >> >  };
> > > > > >> >> >> >
> > > > > >> >> >> >  #define HCI_PHY_HANDLE(handle) (handle & 0xff)
> > > > > >> >> >> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/=
hci_core.c
> > > > > >> >> >> > index 3b49828160b7..64ab7702be81 100644
> > > > > >> >> >> > --- a/net/bluetooth/hci_core.c
> > > > > >> >> >> > +++ b/net/bluetooth/hci_core.c
> > > > > >> >> >> > @@ -2868,31 +2868,15 @@ int hci_reset_dev(struct hci_d=
ev *hdev)
> > > > > >> >> >> >  }
> > > > > >> >> >> >  EXPORT_SYMBOL(hci_reset_dev);
> > > > > >> >> >> >
> > > > > >> >> >> > -static u8 hci_dev_classify_pkt_type(struct hci_dev *h=
dev, struct sk_buff *skb)
> > > > > >> >> >> > -{
> > > > > >> >> >> > -       if (hdev->classify_pkt_type)
> > > > > >> >> >> > -               return hdev->classify_pkt_type(hdev, s=
kb);
> > > > > >> >> >> > -
> > > > > >> >> >> > -       return hci_skb_pkt_type(skb);
> > > > > >> >> >> > -}
> > > > > >> >> >> > -
> > > > > >> >> >> >  /* Receive frame from HCI drivers */
> > > > > >> >> >> >  int hci_recv_frame(struct hci_dev *hdev, struct sk_bu=
ff *skb)
> > > > > >> >> >> >  {
> > > > > >> >> >> > -       u8 dev_pkt_type;
> > > > > >> >> >> > -
> > > > > >> >> >> >         if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
> > > > > >> >> >> >                       && !test_bit(HCI_INIT, &hdev->fl=
ags))) {
> > > > > >> >> >> >                 kfree_skb(skb);
> > > > > >> >> >> >                 return -ENXIO;
> > > > > >> >> >> >         }
> > > > > >> >> >> >
> > > > > >> >> >> > -       /* Check if the driver agree with packet type =
classification */
> > > > > >> >> >> > -       dev_pkt_type =3D hci_dev_classify_pkt_type(hde=
v, skb);
> > > > > >> >> >> > -       if (hci_skb_pkt_type(skb) !=3D dev_pkt_type) {
> > > > > >> >> >> > -               hci_skb_pkt_type(skb) =3D dev_pkt_type=
;
> > > > > >> >> >> > -       }
> > > > > >> >> >>
> > > > > >> >> >> This will affect all cards, not just the one you are cla=
iming.
> > > > > >> >> >>
> > > > > >> >> >>
> > > > > >> >> >> >         switch (hci_skb_pkt_type(skb)) {
> > > > > >> >> >> >         case HCI_EVENT_PKT:
> > > > > >> >> >> >                 break;
> > > > > >> >> >> > --
> > > > > >> >> >> > 2.48.1
> > > > > >> >> >> >
> > > > > >> >> >>
> > > > > >> >> >>
> > > > > >> >> >> --
> > > > > >> >> >> Luiz Augusto von Dentz
> > > > > >> >>
> > > > > >> >>
> > > > > >> >>
> > > > > >> >> --
> > > > > >> >> Luiz Augusto von Dentz
> > > > > >>
> > > > > >>
> > > > > >>
> > > > > >> --
> > > > > >> Luiz Augusto von Dentz
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Luiz Augusto von Dentz
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



--=20
Luiz Augusto von Dentz
