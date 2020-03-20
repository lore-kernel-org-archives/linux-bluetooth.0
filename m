Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A856CC4332B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5D920777
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gcT/fSxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgCTU4h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:56:37 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41810 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbgCTU4g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Mar 2020 16:56:36 -0400
Received: by mail-vs1-f65.google.com with SMTP id a63so4904896vsa.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2020 13:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYdG2hZZXDgzoLuLkSsYKB717kSEQmaZ6NuxIAkbkRI=;
        b=gcT/fSxvwm997aNwLBz/zCmRcQu7nWKXDJpT0PIDSQR8ASPqr6q7+iYrqwNI9OOzx5
         HHoQ5CvwCFDFgIo3RDlaOMxpWDiYkob13WZ1XDH5c0lg54kPSz9RBhPZ9UN6Qh7jhU5U
         MUILZ0Echiv7Ns1i1d7cKl6S/BY1KfmH59RFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYdG2hZZXDgzoLuLkSsYKB717kSEQmaZ6NuxIAkbkRI=;
        b=J2tCiMfvIgzsYJEtzxwGbPis+GrnfHGgBJGJm+5oO/vDM8seuYqjLnZYu1WUaBqJ94
         KD4rw09YzsBwYU2G02ah5ztdZDWOJTMYSxRZyp1/erJArgj3Vswi9F1HX5RgOroeqZf0
         CYNsFj35m/ThMGiarexoAqjuRk0E5HtVJlKgXEepSpztqbkIenOd4/s/AO7pZGv9+gwx
         IZ4QgtM0+KELjkBzLa/A+58EYqUxdl1ZCg10DK1yJe61oeLq74jlWvQvgrUhH4Hj6+uu
         AB+51TA/RNsEKB6A584/Kle5fsseOIjEqLbbb6x3D3DyexVTVZB9mFxQZJmYVD+4VEq6
         aR9g==
X-Gm-Message-State: ANhLgQ1JJYdK8VdzCKxGGULsWzvFByYk4Pzh9Ofrv/txddpTPPBdpV/i
        Ta/Mr8+YDquGFwTckOUJuZcrhHCnjxVBu6dGo4EZvA==
X-Google-Smtp-Source: ADFU+vtcGXL3fhlGGMllbHl+g02q56snlZV+onuaMun/wEuC1hbpQwMm+tjNvRXzZoBInnt9/mzSWyrRn3dNAiDI9JE=
X-Received: by 2002:a67:ec81:: with SMTP id h1mr6782268vsp.96.1584737794701;
 Fri, 20 Mar 2020 13:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200320020153.98280-1-abhishekpandit@chromium.org>
 <20200319190144.1.I40cc9b3d5de04f0631c931d94757fb0f462b24bd@changeid> <CAD=FV=XT=NTyPag9wNCotATBzT4v9pg=OOa8X6=xWkMH2AFiLQ@mail.gmail.com>
In-Reply-To: <CAD=FV=XT=NTyPag9wNCotATBzT4v9pg=OOa8X6=xWkMH2AFiLQ@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Fri, 20 Mar 2020 13:56:23 -0700
Message-ID: <CANFp7mUKRRQT0m9jRB4aeE3GeSW8UM6d-NVJ3CZmHibhSny3+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: btmrvl: Detect hangs and force a reset of
 the SDIO card
To:     Doug Anderson <dianders@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for the heads up Doug. I'll resend the patch once I handle the
case where the reset is immediate and not a full unplug/replug.

In the meantime, please do not merge this patch.

Thanks
Abhishek

On Fri, Mar 20, 2020 at 1:00 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Mar 19, 2020 at 7:02 PM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
> >
> > From: Matthias Kaehlcke <mka@chromium.org>
> >
> > When scanning for BLE devices for a longer period (e.g. because a
> > BLE device is paired, but not connected) the Marvell 8997 often
> > ends up in a borked state, which manifests through failures on
> > certain SDIO transactions.
> >
> > When such a SDIO failure is detected force a reset of the SDIO
> > card to initialize it from scratch. Since the SDIO bus is shared
> > with the WiFi part of the chip this also involves a reset of WiFi.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> >  drivers/bluetooth/btmrvl_sdio.c | 24 ++++++++++++++++++++++++
> >  drivers/bluetooth/btmrvl_sdio.h |  1 +
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
> > index 0f3a020703ab..69a8b6b3c11c 100644
> > --- a/drivers/bluetooth/btmrvl_sdio.c
> > +++ b/drivers/bluetooth/btmrvl_sdio.c
> > @@ -22,6 +22,8 @@
> >  #include <linux/slab.h>
> >  #include <linux/suspend.h>
> >
> > +#include <linux/mmc/core.h>
> > +#include <linux/mmc/card.h>
> >  #include <linux/mmc/sdio_ids.h>
> >  #include <linux/mmc/sdio_func.h>
> >  #include <linux/module.h>
> > @@ -59,6 +61,23 @@ static const struct of_device_id btmrvl_sdio_of_match_table[] = {
> >         { }
> >  };
> >
> > +static void btmrvl_sdio_card_reset_work(struct work_struct *work)
> > +{
> > +       struct btmrvl_sdio_card *card =
> > +               container_of(work, struct btmrvl_sdio_card, reset_work);
> > +       struct sdio_func *func = card->func;
> > +
> > +       sdio_claim_host(func);
> > +       mmc_hw_reset(func->card->host);
>
> The fact that you don't check the return value here seems like a
> problem.  See specifically how commit cdb2256f795e ("mwifiex: Re-work
> support for SDIO HW reset") handles it.
>
> This is a distinct difference between the solution that we landed in
> Chrome OS 4.19 and what landed upstream.  In Chrome OS 4.19 we went
> the simple approach and said that there was only one way to reset the
> card: treat it as a full unplug / replug of the card.  ...but upstream
> adopted a different solution.  For upstream if there is only a single
> function on the SD card it will not trigger a full unplug/replug and
> it's up to the function driver to re-init itself.  This wasn't such a
> big deal for the WiFi driver since it already had a way to re-init
> itself (mwifiex_reinit_sw).  I don't know how hard it will be for
> Bluetooth, but that needs to be part of this patch I think?
>
> -Doug
