Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB37C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Apr 2022 08:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiDEIF3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Apr 2022 04:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbiDEICI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Apr 2022 04:02:08 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A594B438
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Apr 2022 01:00:09 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id b17so14072174lfv.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Apr 2022 01:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/qsag3sAyioO3+ak2r/PvC834IWCFPW787+/S1QtlE=;
        b=qJqor+2BC1l2zeAzKb+KYeRKC3MXQSQ/q1DzsJe6brmoCm0mnK22oKHn2c8+eanm0r
         1i1B39mqMOs3+SctN/Wm+L93y1Xb9HSCK8sHEGGd5zCLwF9H6AJfxgo4Js6QpKEnh/t9
         KPIFZ3C7OuPflphEPoBajEdvbVpj58AUqEDMuN6KJOcKcegsxhMBfqDQRsPwdTjEUfKQ
         hWRtaT6tToKyJVVhIzNLKBrmPhUOcnbKsrWmy0JYUQYGUq6rpClaAgzp/nzPZsBBWE/X
         ZpNd4UR77ozbp/5nYkWP1M0K98Eo7UtFjgkxVAaAwwxvbkrj58vsLfps3oDuQucQDH5b
         HwMw==
X-Gm-Message-State: AOAM530rJSTRzuHgA732kk1CgrZgV0eHI50G/4i4P309vx8lOwj2HvKW
        YlAeRMKg0HPrwUU5F2KVquhsOfyq13aqquyHSzg=
X-Google-Smtp-Source: ABdhPJwMZCTPRsky1mcRcLhUIumZqhwT4GJzfrvqWbAYak7djAIFH+PaHf9yj8evfvANSXwno1R8KOAgJD++PAGqG9w=
X-Received: by 2002:a05:6512:690:b0:44a:30d6:fb1c with SMTP id
 t16-20020a056512069000b0044a30d6fb1cmr1766791lfe.430.1649145608043; Tue, 05
 Apr 2022 01:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220404201750.1082470-1-luiz.dentz@gmail.com> <CABBYNZK9PSUTMeKEdPFp16cGBtGyNC3V1LAYD5x0AVmpRYT_wA@mail.gmail.com>
In-Reply-To: <CABBYNZK9PSUTMeKEdPFp16cGBtGyNC3V1LAYD5x0AVmpRYT_wA@mail.gmail.com>
From:   Adam Pigg <adam@piggz.co.uk>
Date:   Tue, 5 Apr 2022 08:59:56 +0100
Message-ID: <CANFkB1zEu82CBzu-jZ_RZSi4yyb2f-DFMpahPtKwJ_EOtq-=mg@mail.gmail.com>
Subject: Re: [RFC BlueZ] gap: Don't attempt to read the appearance if already set
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz

On Mon, 4 Apr 2022 at 23:19, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Adam,
>
> On Mon, Apr 4, 2022 at 1:17 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > Devices are unlikely to change appearance over time which is the reason
> > why we cache then on the storage so this skips reading it on every
> > reconnection.
> > ---
> >  profiles/gap/gas.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
> > index ea3249be9..400818d67 100644
> > --- a/profiles/gap/gas.c
> > +++ b/profiles/gap/gas.c
> > @@ -142,6 +142,11 @@ static void read_appearance_cb(bool success, uint8_t att_ecode,
> >
> >  static void handle_appearance(struct gas *gas, uint16_t value_handle)
> >  {
> > +       uint16_t value;
> > +
> > +       if (!device_get_appearance(gas->device, &value))
> > +               return;
> > +
> >         if (!bt_gatt_client_read_value(gas->client, value_handle,
> >                                                 read_appearance_cb, gas, NULL))
> >                 DBG("Failed to send request to read appearance");
> > --
> > 2.35.1
>
> Check if the above works for you.
>

Yes, this will work for me.

Reading the appearance still fails, but at least I can manually set it
in the info file, and I can instruct users to do the same,

The other way I was thinking about making it work would be to add some
kind of quirk to skip reading the appearance altogether, which would
probably also require editing a config file anyway, and this way, the
appearance value gets set (im using 0x0192)

Thanks



> --
> Luiz Augusto von Dentz
