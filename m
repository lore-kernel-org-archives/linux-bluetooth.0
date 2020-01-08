Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46D7C282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAB9206DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYTyqqwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgAHV5x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:57:53 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34161 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgAHV5x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 16:57:53 -0500
Received: by mail-oi1-f195.google.com with SMTP id l136so4108517oig.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 13:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6Oa26iDbw8VKzHgATpl1oMrCEN/jmJiXI2BcSQLno8=;
        b=QYTyqqwcoHHRrLx5SBqykYZYa5f1Tu/qBEe14lu4JqTqB6myFTaeFtxYikD6hxx7kb
         N9tmQXPQOV/gm8lcemBymG7kaLJR3+txyOZQp0IHpNHtvk9EjM6qOblRrABAOosX9LKv
         M46W2qbPia+GwWCvC5E7b/k8UqBHtuctVRPm0UdUyUGaSJuAQVJGAAFI58W9IXLRYahd
         3DCLW7j2p9I+bclXzV4TDjFnVt6sTi7wvzUURfRmAMXC+urHDk9fltBfTz0HpKJjUHsT
         SdhkPXsUgNEk7j5TrBIS2ll0DOWhqy3+7UouiJ2QVXp2qeKzAS7xQZJsfTHyM2cIEKlg
         z3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6Oa26iDbw8VKzHgATpl1oMrCEN/jmJiXI2BcSQLno8=;
        b=o1TdyvFcSjo4UB2eFsg1bgTfiZ13/xt8oHJ6o6+MMPevqmy7nLywAFMuq1H4vSyp/r
         dv50+OfNGjO3ZjOlbghjkKU9mAfWr3/QdS34P+qa2Olo8z+24oBfEMb2VQ57FpKY5cdy
         P3VBcp0a2wZO+4LsfMjw2/WBNBxF+SWvV4cq5YPkqmQ1cEHi4AKH54Fb89BtgkoaFJx+
         6JRyXoebfonYCYHDtsoJITS65gUjc76hmgeNQK3NH4TMZUDh9RoWRtG1h4c9eq3GoE/N
         YAZgPy17GD70/egKHaaW0/L780BDSOvz/nL8hWXb89KTko+tBfIHBCSYdLS5Q87d9qIf
         u8ng==
X-Gm-Message-State: APjAAAXEGOUnMvuQddJhH2+yMiZM6onK6ZfY34s9WKqAbbiEPnPQptsk
        mo+YtwtYZvDcs1nVlnNTV2lWq7T71JfTK65pTucHUGFF
X-Google-Smtp-Source: APXvYqxTsjgxzBVkn6XIctCRNrC7EZSmrc1Xsq3jyGpUEcgdjTGU0qSiaMXD7UtT8//RAlQ5wB6rFJl3buhxSyeiksI=
X-Received: by 2002:aca:af54:: with SMTP id y81mr631911oie.21.1578520672093;
 Wed, 08 Jan 2020 13:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20200107074056.25453-1-luiz.dentz@gmail.com> <20200107074056.25453-10-luiz.dentz@gmail.com>
 <EA23917D-86E4-4C03-A74B-007E0EC691A4@holtmann.org>
In-Reply-To: <EA23917D-86E4-4C03-A74B-007E0EC691A4@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 8 Jan 2020 13:57:39 -0800
Message-ID: <CABBYNZJFXsQb-i15d0LwWWfcwum4rTZqwqyr6yrzcAMdM_99DQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] Bluetooth: btusb: Add support for ISO packets
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Jan 8, 2020 at 1:22 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This enabled btusb driver to properly transmit ISO packets.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > drivers/bluetooth/btusb.c | 14 ++++++++++++++
> > 1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index f5924f3e8b8d..ded0ba83bcce 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -1463,6 +1463,13 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
> >
> >               hdev->stat.sco_tx++;
> >               return submit_tx_urb(hdev, urb);
> > +
> > +     case HCI_ISODATA_PKT:
> > +             urb = alloc_bulk_urb(hdev, skb);
> > +             if (IS_ERR(urb))
> > +                     return PTR_ERR(urb);
> > +
> > +             return submit_or_queue_tx_urb(hdev, urb);
> >       }
> >
> >       return -EILSEQ;
> > @@ -2123,6 +2130,13 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
> >
> >               hdev->stat.sco_tx++;
> >               return submit_tx_urb(hdev, urb);
> > +
> > +     case HCI_ISODATA_PKT:
> > +             urb = alloc_bulk_urb(hdev, skb);
> > +             if (IS_ERR(urb))
> > +                     return PTR_ERR(urb);
> > +
> > +             return submit_or_queue_tx_urb(hdev, urb);
> >       }
>
> I am failing to see where it says to use bulk endpoints.

It doesn't, in fact USB don't seem to have anything for ISO so this is
the assumption we made that bulk would cut it, though I would agree an
ISOC endpoint would actually be better but afaik we would need new
alternate settings if we intend to use with the new ISO packets, so it
doesn't look like there is any other option to USB transport to just
sent packet over the bulk endpoint, or perhaps you want to file an
issue against the spec to specify this properly?

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
