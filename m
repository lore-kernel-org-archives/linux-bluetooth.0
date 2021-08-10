Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD90C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Aug 2021 18:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62C960E76
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Aug 2021 18:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhHJSiK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhHJSiJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Aug 2021 14:38:09 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027F8C06179A
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Aug 2021 11:37:43 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id p4so6414355yba.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Aug 2021 11:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W9rtX+LgqXfUU0w5chHnxksqh1Ez/W21ZabD/Fwos/o=;
        b=o2W9AswlhgEk4zJdF8GItCARO0aoapqQSoucoeqLQZn7LHolDsZAvBnQ0e55pJJ+FW
         lfdlYEZ0Y3GPaTFFl7bQMW/tztdsjUIRIywd6EWNnldyYrBllPmuJ5mD0jGvyhxxhH3Y
         GILv4jW11Rn+SnlTDx27b3fRN6CcMyeN5ldRGHJKin7YeiNdREPuef++TQ9++o4v8Fzs
         6xIyHgEQGzh0H0/ZQKCj9ak3W4ZVWfd6aRoC1++FFIqf82sgUwvF69EFyB7LbNSY1YQL
         0qC3THUMfLRpYpXjPVj4dvvXB7eX7bQr0akKBnxs8QUo20mxU/gkXb/dxWYd+ot0BE1c
         tD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W9rtX+LgqXfUU0w5chHnxksqh1Ez/W21ZabD/Fwos/o=;
        b=F8S5WWuppYrtv6CVdILEUuavvCf7GzaEnCtb1fe9bavSfITiVu+Gu4TFbDlTEahOhI
         avIv9kB2dpPUU0Sg5lKPtCkhtYCtvzDXfpeQfgdDog+WPhjNglYqaD4Nzuo/41/5C69/
         HxyhF81tk26v11sZ+1s5BKpsamUSKyfRF5jbNtZQ2oy1+qwNr2Dn3/IiAMUETqUS3gXs
         FiN0tm7VSGFRhnoZshydyXu//n37AZooEuLqv/lAqb1m8Yw7IhLduj80sY5bpc77zGyc
         Y1OFvKudKTDJSOD9xosK51c1i9NUzn35IRIoK4CM+FH2tIpLbQniZlOtXBryZJud+qGI
         orBA==
X-Gm-Message-State: AOAM531qfg425223itJNnj8dYHcbidwkqVBd+eqsN4wJns/O/63zcWZO
        DgD9iW6HxlnlbQWfyuCBvMshnpUmdyqO16ff3vM=
X-Google-Smtp-Source: ABdhPJz1IPEioFLmaticp2BUxrSAiFQ3E7iQZ80EH6Ua7SvwF+a61vJ52SKvwSRhW8Ijmiioie07Tw9QMoxtMCo/AoM=
X-Received: by 2002:a25:bb13:: with SMTP id z19mr41868941ybg.347.1628620662166;
 Tue, 10 Aug 2021 11:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <d43dffdc43a40782ec6d5d6c24b1638005992a8f.camel@iki.fi>
 <b86543908684cc6cd9afaf4de10fac7af1a49665.camel@iki.fi> <872F0B33-594E-4BD7-8B75-EA96DE8DBA8F@holtmann.org>
 <20210810164820.GA12064@reaktio.net>
In-Reply-To: <20210810164820.GA12064@reaktio.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 10 Aug 2021 11:37:31 -0700
Message-ID: <CABBYNZLpx1NL6nprUmsA_OTeUJ-nOS8i-cokvJpVDzKjSNayyg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: check conditions before enabling USB
 ALT 3 for WBS
To:     =?UTF-8?B?UGFzaSBLw6Rya2vDpGluZW4=?= <pasik@iki.fi>
Cc:     Marcel Holtmann <marcel@holtmann.org>, Pauli Virtanen <pav@iki.fi>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Joseph Hwang <josephsih@google.com>,
        Hilda Wu <hildawu@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pasi, Pauli,

On Tue, Aug 10, 2021 at 9:50 AM Pasi K=C3=A4rkk=C3=A4inen <pasik@iki.fi> wr=
ote:
>
> Hello Marcel,
>
> On Fri, Jul 23, 2021 at 02:19:09PM +0200, Marcel Holtmann wrote:
> > Hi Pauli,
> >
> > > Some USB BT adapters don't satisfy the MTU requirement mentioned in
> > > commit e848dbd364ac ("Bluetooth: btusb: Add support USB ALT 3 for WBS=
")
> > > and have ALT 3 setting that produces no/garbled audio. Some adapters
> > > with larger MTU were also reported to have problems with ALT 3.
> > >
> > > Add a flag and check it and MTU before selecting ALT 3, falling back =
to
> > > ALT 1. Enable the flag for Realtek, restoring the previous behavior f=
or
> > > non-Realtek devices.
> > >
> > > Tested with USB adapters (mtu<72, no/garbled sound with ALT3, ALT1
> > > works) BCM20702A1 0b05:17cb, CSR8510A10 0a12:0001, and (mtu>=3D72, AL=
T3
> > > works) RTL8761BU 0bda:8771, Intel AX200 8087:0029 (after disabling
> > > ALT6). Also got reports for (mtu>=3D72, ALT 3 reported to produce bad
> > > audio) Intel 8087:0a2b.
> > >
> > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > Fixes: e848dbd364ac ("Bluetooth: btusb: Add support USB ALT 3 for WBS=
")
> >
> > before I will apply this, I need Tested-by or Ack-by people that confir=
m that this fixes their issues now.
> >
>
> Is v3 ok/enough? It has one Tested-by.
> It would probably be good to send v4 anyway with CC stable@kernel.org ..
>
>
> Thanks,
>
> -- Pasi
>
> >
> > > ---
> > >
> > > Changes in v2:
> > > - Explain magic number 72 in a comment; didn't add the table for them=
,
> > >  because it's not used elsewhere and we need just one number from it.
> > > - Add flag for ALT3 support, restoring the behavior
> > >  for non-Realtek devices the same as before e848dbd364ac, due to
> > >  the problems reported on an Intel adapter. Don't have the device
> > >  myself.
> > >
> > > drivers/bluetooth/btusb.c | 22 ++++++++++++++--------
> > > 1 file changed, 14 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > index 6d23308119d1..5cec719f6cba 100644
> > > --- a/drivers/bluetooth/btusb.c
> > > +++ b/drivers/bluetooth/btusb.c
> > > @@ -516,6 +516,7 @@ static const struct dmi_system_id btusb_needs_res=
et_resume_table[] =3D {
> > > #define BTUSB_HW_RESET_ACTIVE       12
> > > #define BTUSB_TX_WAIT_VND_EVT       13
> > > #define BTUSB_WAKEUP_DISABLE        14
> > > +#define BTUSB_ALT3_OK_FOR_WBS      15
> >
> > Rename this to BTUSB_USE_ALT3_FOR_WBS.
> >
> > >
> > > struct btusb_data {
> > >     struct hci_dev       *hdev;
> > > @@ -1748,16 +1749,20 @@ static void btusb_work(struct work_struct *wo=
rk)
> > >                     /* Bluetooth USB spec recommends alt 6 (63 bytes)=
, but
> > >                      * many adapters do not support it.  Alt 1 appear=
s to
> > >                      * work for all adapters that do not have alt 6, =
and
> > > -                    * which work with WBS at all.
> > > +                    * which work with WBS at all.  Some devices pref=
er
> > > +                    * alt 3 (HCI payload >=3D 60 Bytes let air packe=
t
> > > +                    * data satisfy 60 bytes), requiring
> > > +                    * MTU >=3D 3 (packets) * 25 (size) - 3 (headers)=
 =3D 72
> > > +                    * see also Core spec 5, vol 4, B 2.1.1 & Table 2=
.1.
> > >                      */
> > > -                   new_alts =3D btusb_find_altsetting(data, 6) ? 6 :=
 1;
> > > -                   /* Because mSBC frames do not need to be aligned =
to the
> > > -                    * SCO packet boundary. If support the Alt 3, use=
 the
> > > -                    * Alt 3 for HCI payload >=3D 60 Bytes let air pa=
cket
> > > -                    * data satisfy 60 bytes.
> > > -                    */
> > > -                   if (new_alts =3D=3D 1 && btusb_find_altsetting(da=
ta, 3))
> > > +                   if (btusb_find_altsetting(data, 6))
> > > +                           new_alts =3D 6;
> > > +                   else if (test_bit(BTUSB_ALT3_OK_FOR_WBS, &data->f=
lags) &&
> > > +                            hdev->sco_mtu >=3D 72 &&
> > > +                            btusb_find_altsetting(data, 3))
> >
> > This is whitespace damaged.

Ive fixed this and made it fit in 80 columns by reordering the checks.

> >
> > >                             new_alts =3D 3;
> > > +                   else
> > > +                           new_alts =3D 1;
> > >             }
> > >
> > >             if (btusb_switch_alt_setting(hdev, new_alts) < 0)
> > > @@ -4733,6 +4738,7 @@ static int btusb_probe(struct usb_interface *in=
tf,
> > >              * (DEVICE_REMOTE_WAKEUP)
> > >              */
> > >             set_bit(BTUSB_WAKEUP_DISABLE, &data->flags);
> > > +           set_bit(BTUSB_ALT3_OK_FOR_WBS, &data->flags);
> > >     }
> >
> > Regards
> >
> > Marcel

Applied, thanks.


--=20
Luiz Augusto von Dentz
