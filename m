Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89299C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 13:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D5120721
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 13:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWC5Cv7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390461AbgE1NdN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 09:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390303AbgE1NdK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 09:33:10 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8D8C05BD1E
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 06:33:10 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id o9so1705547ljj.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 06:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6wsWybGt83kgJRa1JNd7Drzt8ZH31Hjc0dnB9fL3tC8=;
        b=YWC5Cv7rrEQyD5gC9mbZT3ucItEkmbRF4MeQQuZX/C34MSZmF7nMHhabF3Uu/rLyvU
         0MjevZjgossqPCFLOHiCItFJLVe2GiesKDV28VD2a/ZShcLb6mX1D+61R88WOm9btkQO
         3Gc1k1cw1yycjJ23OdLuuHaKYWevAI8CSXIe1RmmoEt7KHNRDAKqLS0FcMOtSe2LS6XC
         RZmPRpDt/uKZZl+/tV/54g+BR6qbo+GQRBUZWfpalqIfl9N1bfLBOBY6LmWY31gZdh7R
         bBYOy7qWRfODoEJWfBGXLJPKacjnrbRu7BGhMWEhvyAiliNOlDddQBVOwMUEIUYRNErr
         voYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6wsWybGt83kgJRa1JNd7Drzt8ZH31Hjc0dnB9fL3tC8=;
        b=qSmp3CZinSzdBlZcVBoQFCoEL1Dj2dIy9p3dSC0BbVmekGe7JKccZoKamQQUy2nzLN
         KnkrzjcCj6vb7uOJzZ8OBMj+SiVzOfRIjHYtAYPceFzA8Z29B7eUdhqjK0re9K7n5Lyr
         lzm2ojAQ/PXJg1RCH7E14btSn+gIZRGcWFvkfeJTAySq3lXh27upolPZGbt4boGDELm/
         Rpmrms5yRVrfkIpuN0qdqU03gtJJzdIG9eJcNs5Z4JZT5OOQmKSS7eHD8ocmA4NFlRLC
         skdYpmPovBY3v4wL7+ZKVOVWI9AD5WFCWEZzUy30A9z9z8MGPRSWzb2IGeGBscNQ1/lg
         ZQZQ==
X-Gm-Message-State: AOAM532L9eBZ9qkx8OuipKFfFqlu0CPt3g37UX+G6X//S0k6CBab5hDn
        oPoHSHbN2cbdhs6tOEZBIFMR6hcU3jZHRX6/4dJfLA==
X-Google-Smtp-Source: ABdhPJybT/ohxFxGoairyni9Bh2Mdmijm1W/+bg2vpGYV8UY/5yn41yIeufT/Y92ZsTygwVR2i9p5YmHr4SvlLdH0bc=
X-Received: by 2002:a2e:9c45:: with SMTP id t5mr1689000ljj.344.1590672788372;
 Thu, 28 May 2020 06:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200528012421.136864-1-alainm@chromium.org> <6239D349-F91F-4C95-9001-A4410AA3BF3C@holtmann.org>
In-Reply-To: <6239D349-F91F-4C95-9001-A4410AA3BF3C@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 28 May 2020 09:32:56 -0400
Message-ID: <CALWDO_Ub8QTLRURmxX2vrj86BfiEUmgdoJ2GX+GoQ0twMtRpWQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v5] doc:adding definitions for load default params
 mgmt op
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

This makes sense.  I'll send a new set of patches shortly.

Thanks,
Alain


On Thu, May 28, 2020 at 4:13 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Alain,
>
> > This change adds the definition for the load default parameter command.
> > In particular, this command is used to load default parameters for
> > various operations in the kernel. This mechanism is also expandable to
> > future values that may be necessary.
> >
> > This will allow bluetoothd to load parameters from a conf file that may
> > be customized for the specific requirements of each platforms.
> >
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> > doc/mgmt-api.txt | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 59 insertions(+)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 6ee01fed8..14e3179b5 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -3223,6 +3223,65 @@ Set Experimental Feature Command
> >                               Invalid Index
> >
> >
> > +Load Default Controller Parameter Command
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > +
> > +     Command Code:           0x004b
> > +     Controller Index:       <controller id>
> > +     Command Parameters:     Parameter1 {
> > +                                     Parameter_Type (2 Octet)
> > +                                     Value_Length (1 Octet)
> > +                                     Value (0-255 Octets)
> > +                             }
> > +                             Parameter2 { }
> > +                             ...
> > +     Return Parameters:
> > +
> > +     This command is used to feed the kernel a list of default control=
ler
> > +     parameters.
> > +
> > +     Currently defined Parameter_Type values are:
> > +
> > +             0x0000  BR/EDR Page Scan Type
> > +             0x0001  BR/EDR Page Scan Interval
> > +             0x0002  BR/EDR Page Scan Window
> > +             0x0003  BR/EDR Inquiry Scan Type
> > +             0x0004  BR/EDR Inquiry Scan Interval
> > +             0x0005  BR/EDR Inquiry Scan Window
> > +             0x0006  BR/EDR Link Supervision Timeout
> > +             0x0007  BR/EDR Page Timeout
> > +             0x0008  BR/EDR Min Sniff Interval
> > +             0x0009  BR/EDR Max Sniff Interval
> > +             0x000a  LE Advertisement Min Interval
> > +             0x000b  LE Advertisement Max Interval
> > +             0x000c  LE Multi Advertisement Rotation Interval
> > +             0x000d  LE Scanning Interval for auto connect
> > +             0x000e  LE Scanning Window for auto connect
> > +             0x000f  LE Scanning Interval for wake scenarios
> > +             0x0010  LE Scanning Window for wake scenarios
> > +             0x0011  LE Scanning Interval for discovery
> > +             0x0012  LE Scanning Window for discovery
> > +             0x0013  LE Scanning Interval for adv monitoring
> > +             0x0014  LE Scanning Window for adv monitoring
> > +             0x0015  LE Scanning Interval for connect
> > +             0x0016  LE Scanning Window for connect
> > +             0x0017  LE Min Connection Interval
> > +             0x0018  LE Max Connection Interval
> > +             0x0019  LE Connection Latency
> > +             0x001a  LE Connection Supervision Timeout
> > +
> > +     This command can be used when the controller is not powered and
> > +     all settings will be programmed once powered.  Note that these on=
ly
> > +     control the default parameters.  Higher level Apis may influence =
the
> > +     effective value used.
> > +
> > +     This command generates a Command Complete event on success or
> > +     a Command Status event on failure.
> > +
> > +     Possible errors:        Invalid Parameters
> > +                             Invalid Index
> > +
> > +
>
> you asked me about naming and I was thinking this:
>
> +Read Default System Configuration Command
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +
> +Set Default System Configuration Command
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +
> +Read Default Runtime Parameters Command
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +
> +Load Default Runtime Parameters Command
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The Default System is the actual configuration that you load before you p=
ower on the controller. These are really the default values for a lot of th=
ings. And I used =E2=80=9CRead=E2=80=9D to get the current settings and als=
o with that the list of supported values. So you know what changes would ac=
tually be possible.
>
> I called the other one =E2=80=9CSet=E2=80=9D since it can set/overwrite a=
 few of these values or actually all. I don=E2=80=99t wanted to use =E2=80=
=9CLoad=E2=80=9D since it is not replacing all of the values like what we h=
ave with the other load commands.
>
> The Default Runtime would be then all values that can be tweaked while th=
e controller is up and running.
>
> Regards
>
> Marcel
>
