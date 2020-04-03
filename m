Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F872C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 13:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE0A20721
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 13:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGPmz1Ev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390830AbgDCNyk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:54:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36031 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgDCNyk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 09:54:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id w145so5865359lff.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 06:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2qrPWP1HMlAQ7xVCzFV4sopJDFytmcca9BIYFHQJoT4=;
        b=vGPmz1Eva/1WxPZgnjugPd4PTtk7Y/Dz7l6SykF4Ch05s5oqtBhQmJ4X3iAEbwZBKx
         ZTiEBVOjbP3JKVV5SOqmKtXXAz2BxrUQfryKHyH8XYDJ2oEwlHxAfsEbRkzi0PP4Pkng
         vz3zOGEC/vNU9SEpct1gjQGioIPtiOOKR/KK+c7Ygho4/85Y1/KeL5wqwpR1NcgAGBOi
         EzgE9EwfQKpUCj1Yu7cHCNY6+V8a6FItZx3uASXKiCbsoIyvwSVQUCMWxhty5NRsGoQ1
         XFka1t8ciiRGBv2x/Ca9Ag/vXGE46nP2QyciuomcETBSMa002iN2hP01HpnD08+uANUv
         ANHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2qrPWP1HMlAQ7xVCzFV4sopJDFytmcca9BIYFHQJoT4=;
        b=WlX7/Ac4W4DZuPz2861ljMzX/qcDE/eShOV0bbm73N+eyZ8EISlz5A2p8ijMsNbkal
         HVskimfjpfay5JKVwl3Wk7F0UQ5KMmxf38lV25bpjnTVewXYINwFbK+130gHD+kcfT3u
         xLVQNR73ygCupAlABKDJ6eFkiZyCOTXZG+k5ffZxGdyX1oj2m7NRQRWV8K/PiUWQNbBc
         rAUW8w9TAELM3i3F1+lfxGry85UbfuvYhyaV09wkj6jwhxqo8Vt3Nj3InAYreU1gBQTL
         nZuIfX+WWJUyT/oV39xd218c/zFEdfo9GsoSXjdFCWl4vcaqKP2SrB+Qlh5zN/szMlSy
         AKDg==
X-Gm-Message-State: AGi0PuY1xysBgFXiAqZXBYVFYLjmQyMENZQWdUtBaBlX/YowIJacDv23
        EqteFmiGYjQoJ0dgkHI5ogu1Oz8coR/AKaU9Y9Kavw==
X-Google-Smtp-Source: APiQypI0PRQT4IX89/FdNItOkclVjeay2eezr9uSv69EjqbkajsSelrH6Cl4qO4MVjjcDqk1jU3WpFg5hY2oBGbe+m0=
X-Received: by 2002:a19:c1c5:: with SMTP id r188mr5470575lff.191.1585922076042;
 Fri, 03 Apr 2020 06:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200403133806.246918-1-alainm@chromium.org> <D3C05492-13B9-447C-982B-26B681C9EF8C@holtmann.org>
In-Reply-To: <D3C05492-13B9-447C-982B-26B681C9EF8C@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Fri, 3 Apr 2020 09:54:24 -0400
Message-ID: <CALWDO_Xy0m4PyAACDAHmf9wmPGwKoW6keYWHy8UKjNcsLF5SDQ@mail.gmail.com>
Subject: Re: [PATCH v1] bluetooth:Adding driver and quirk defs for multi-role LE
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Apr 3, 2020 at 9:49 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > This change adds the relevant driver and quirk to allow drivers to
> > report that concurrent roles are well supported by the controller.
> >
> > This has historically been disabled as controllers did not reliably
> > support this. In particular, this will be used to relax this condition
> > for controllers that have been well tested and reliable.
> >
> >       /* Most controller will fail if we try to create new connections
> >        * while we have an existing one in slave role.
> >        */
> >       if (hdev->conn_hash.le_num_slave > 0)
> >               return NULL;
> >
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> > drivers/bluetooth/btusb.c   | 2 ++
> > include/net/bluetooth/hci.h | 8 ++++++++
> > 2 files changed, 10 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 3bdec42c9612..22e61a502d40 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -58,6 +58,8 @@ static struct usb_driver btusb_driver;
> > #define BTUSB_CW6622          0x100000
> > #define BTUSB_MEDIATEK                0x200000
> > #define BTUSB_WIDEBAND_SPEECH 0x400000
> > +#define BTUSB_LE_CONCURRENT_ROLES_SUPPORTED \
> > +                             0x800000
> >
> > static const struct usb_device_id btusb_table[] =3D {
> >       /* Generic Bluetooth USB device */
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 5f60e135aeb6..b2c76cde7cd4 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -214,6 +214,14 @@ enum {
> >        * This quirk must be set before hci_register_dev is called.
> >        */
> >       HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
> > +
> > +     /* When this quirk is set, the controller has validated that
> > +      * concurrent LE roles are supported.  This mechanism is necessar=
y
> > +      * as many controllers have been seen has having trouble initiati=
ng
> > +      * a connectable advertisement after at least one connection in
> > +      * central had already been established.
> > +      */
> > +     HCI_QUIRK_LE_CONCURRENT_ROLES_SUPPORTED,
> > };
>
> lets do this the other way around. Lets remove the limitation we have in =
our HCI core code. And then we see which controllers report errors. Trying =
to enable each controller individually is cumbersome. I rather later on bla=
cklist the one or two historic controllers that don=E2=80=99t support it.
>

I agree it's cumbersome but given we don't have much data or existing
tests around this, we don't have too many options.  I strongly
disagree with the approach of simply enabling it and seeing what
breaks as scenarios using this functionality are expected to scale out
quickly, likely before we have time to fine all controller issues.

My team is building test infrastructure to help collect data with
this, we already know it's already problematic on a range of
controllers and we have a good idea on which controllers which will be
set.  We will contribute to the cumbersome part of this.

> Regards
>
> Marcel
>
