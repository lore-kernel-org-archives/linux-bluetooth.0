Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09491C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Mar 2022 22:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350829AbiCHWwI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbiCHWwH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Mar 2022 17:52:07 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C454EF4A
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Mar 2022 14:51:09 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x5so598030edd.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Mar 2022 14:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GNyxxtXcnyfmNNBli9SgJPfg/+KszGAsz9fS3NorGIg=;
        b=PnxAQB5mg7PZ8UGtkbZ1UIXLxmuEZkxURrHl7X35BCyIjZbw/9FMzwIGmuxidUWqBV
         1XhVUkSVmREfytJ4rUEGANtRJViTBNnNCeZSwLNtV9CzVyCnQidRghFDVelxbbB6j1d7
         XkcjEhAf7/6UiGCiOPy1mluFiAEfv1T3D9qG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GNyxxtXcnyfmNNBli9SgJPfg/+KszGAsz9fS3NorGIg=;
        b=OxwBZg2hzPUcAg4tDNDpFkNnfGhYLCcGMTiNpdG9jxWGSXP+dWaEHF3+asC1E2umad
         z19fIN3VGXgnRRrT1wxAyp0QZrfzLE2go7S7QAd37NRYMk2NHIkn8syiTFptzNpefYpA
         0+YYOlCuSqsScV47yXgZgcsae6KIMNU8LT87fRJ7EnT5KSgRuPkrp2AdPJBPT8v4s9d3
         wkB+dXIYcvh4G3A37Dvl0MrNcyfQn9/iGZ8hBSB2NBGBudiWQJEEBz0ZyW+wMmKc3qd7
         Ju2pukMrr8HgQh5hRBI70LoLeOaLZ6L6yUTIZaiB9ujNCbpT/zrUfl2ECe8/EKdI8VTC
         H8JQ==
X-Gm-Message-State: AOAM533kTiOV5Hg/7S5enugkQFU43DMjvz+fn/RA9YFHR9IRsMFFy8dX
        RbLNRlk7D93Kjwp+YN+izNKBGtxwER58YA==
X-Google-Smtp-Source: ABdhPJzXVfKtrKFcX/hjO2FpxQwn4Dp1GWALBKXm+X81UcKYic+4Z5i90reN8sK0I+AGPONhcivF3A==
X-Received: by 2002:a05:6402:51cb:b0:409:e99f:bc1c with SMTP id r11-20020a05640251cb00b00409e99fbc1cmr18641834edd.68.1646779868343;
        Tue, 08 Mar 2022 14:51:08 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b00415a1f9a4dasm54352edv.91.2022.03.08.14.51.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 14:51:07 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id yy13so1140848ejb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Mar 2022 14:51:07 -0800 (PST)
X-Received: by 2002:a17:906:2b97:b0:6cd:6d67:ab5d with SMTP id
 m23-20020a1709062b9700b006cd6d67ab5dmr15541284ejg.723.1646779866998; Tue, 08
 Mar 2022 14:51:06 -0800 (PST)
MIME-Version: 1.0
References: <CAPBVwTQrcYYauoCXBWdOsPa_vmN=cajYzVFcep_GLC-2OwOwYQ@mail.gmail.com>
 <6f8f47ceebfbcfd7fa8b04a4df807ae822e2960c.camel@hadess.net>
In-Reply-To: <6f8f47ceebfbcfd7fa8b04a4df807ae822e2960c.camel@hadess.net>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 8 Mar 2022 14:50:55 -0800
X-Gmail-Original-Message-ID: <CAO271m=hf0uB1t50t6tTXqDQREVxzX2S=R2rVCGK60xwVKgSYQ@mail.gmail.com>
Message-ID: <CAO271m=hf0uB1t50t6tTXqDQREVxzX2S=R2rVCGK60xwVKgSYQ@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Adding support for /etc/bluetooth/main.conf.d
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Katherine Lai <laikatherine@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,


On Tue, Mar 8, 2022 at 2:14 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> Hey Katherine,
>
> On Mon, 2022-03-07 at 10:57 -0800, Katherine Lai wrote:
> > Background
> >
> > It was found that a change to the default settings for
> > MinConnectionInterval and MaxConnectionInterval in main.conf broke
> > some of ChromeOS=E2=80=99s keyboard HID tests for only certain Bluetoot=
h
> > controllers. These keyboards aren=E2=80=99t able to connect to the devi=
ce.
> > Since those connection parameters improve the connection interval for
> > most other chipsets, we want to leave the default values but have a
> > way to have an optional override to address problematic models.
> >
> >
> > Proposed Solution
> >
> > Adding support to bluetoothd for an additional config directory
> > /etc/bluetooth/main.conf.d containing multiple files which will
> > override common params. Override order will be lexically sorted
> > filename order. This pattern is already used by Linux distros, for
> > example there is /etc/sudoers.d which files will override common
> > params in /etc/sudoers.
> >
> > Users can add override config files to /etc/bluetooth/main.conf.d
> > rather than directly editing /etc/bluetooth/main.conf. This is more
> > friendly to package managers since BlueZ package updates won't cause
> > conflict to /etc/bluetooth/main.conf.
> >
> > In bluez=E2=80=99s main.c, merge the params for each *.conf file from
> > /etc/bluetooth/main.conf.d with the existing /etc/bluetooth/main.conf
> > in lexical filename order
> >
> > /etc/bluetooth/main.conf.d will be configurable at build time, e.g.
> > with ./configure --main-conf-dir
>
> This isn't quite how the pattern is usually used. With the existing
> patterns, the OS-supplied stock configuration would be in
> /usr/lib/bluetooth/main.conf.d (maybe with the default .conf in the
> same directory as that subdir), with /etc/bluetooth/main.conf.d only
> used for the user/admin override the default configuration.
We did a bit of research and found that /etc/X and /etc/X.d is more
common, e.g. the one described in
https://www.redhat.com/sysadmin/etc-configuration-directories.
If some distribution wants to organize the conf files to
/usr/lib/bluetooth (for stock by package managers) and
/etc/bluetooth/main.conf.d (for admin/users), I guess this is where
having a configurable path is useful.
What do you think?
>
> I don't think that making it optional, or have the path changeable is
> needed, but the rest seems good.
>
> Cheers
