Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75DEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Mar 2022 20:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbiCRUQG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Mar 2022 16:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240632AbiCRUPn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Mar 2022 16:15:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54A125E328
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Mar 2022 13:14:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a8so19091211ejc.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Mar 2022 13:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z9hZkl5u6IAgI8NBoJCESzioyxhPp1rK+Vj3Me/jupw=;
        b=Z2gMrZdajuPzLve7x0HTrI2vpEC//el3CclQyjpDG8js0aDs/VbkxDcu/NEFA9cvZ5
         S2ORpNLgEjY9lC/NgH5RUSgnqpLrinbk/R58AGYXtKoiGALM4qVqQkDpprtKSKR3jjXL
         m+PzIIGJmsSocWptNhmiI8sKYKMexepJZvZh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z9hZkl5u6IAgI8NBoJCESzioyxhPp1rK+Vj3Me/jupw=;
        b=DFXs2Y9vZenyUK7YLtKzJ3TJ568nMOMu2leuBZaFG6jcJLf7N39qpBhh/YDmpE7qBm
         j8fUvp6qCz9EuPOFEm8r9qdJbqLM8QJuVj1Dkh2cveed0vlqzXrQZrEEO0rBNVdqogoT
         A2oeLUXGJX++D7u0BTbIfGikc0JsPB8Xx6yy0X1wpMDZAyIqvtlM6TMYz+4SXXnihL9D
         dciG/7aVlkw87lhwCor9cl+YS33XOYOfwJlAtynG2ttOixjO0yHw6r/IB+XIZZ/VxOgN
         v3NOQzOz+bRzLURM5qgIjwg7sJIwVok4cd/O49gQJyndW0/hQNU9AA0cLs/4ozgf6k3p
         I7/g==
X-Gm-Message-State: AOAM530t0LE31j4P+vKZ3Cx0MJ7LK9jGffOLnCXOe2D8UthWMiCUzALa
        Zx5PogbxrG3aEImJ74hbfaq/465jw2ToTg==
X-Google-Smtp-Source: ABdhPJy8gtkBq/Cq34laAV+FHHJeBxOxsirOQATwZ3azOcYrowgih3B/0EBwHRFTbWq9xyc08imURA==
X-Received: by 2002:a17:906:7947:b0:6da:892f:2503 with SMTP id l7-20020a170906794700b006da892f2503mr10296871ejo.710.1647634449044;
        Fri, 18 Mar 2022 13:14:09 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id hb11-20020a170907160b00b006df8951ed1bsm3030640ejc.32.2022.03.18.13.14.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 13:14:08 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id h13so11515927ede.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Mar 2022 13:14:08 -0700 (PDT)
X-Received: by 2002:a05:6402:847:b0:418:95d4:9126 with SMTP id
 b7-20020a056402084700b0041895d49126mr11365380edz.152.1647634447619; Fri, 18
 Mar 2022 13:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAPBVwTQrcYYauoCXBWdOsPa_vmN=cajYzVFcep_GLC-2OwOwYQ@mail.gmail.com>
 <3DAED89D-72AC-4D38-A092-D2A52AEEE5BB@holtmann.org> <CAO271mmX+jMbcuskH23FnWBZc2Or05wLuAc9n6B1Or4g145OTA@mail.gmail.com>
 <14A05E77-95D3-4313-B9F6-BC654CD96E01@holtmann.org>
In-Reply-To: <14A05E77-95D3-4313-B9F6-BC654CD96E01@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 18 Mar 2022 13:13:56 -0700
X-Gmail-Original-Message-ID: <CAO271m=8i0Pv+ODzvP+gW7YxmGuxAm9232SqBrQ3qhpZfmTYAQ@mail.gmail.com>
Message-ID: <CAO271m=8i0Pv+ODzvP+gW7YxmGuxAm9232SqBrQ3qhpZfmTYAQ@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Adding support for /etc/bluetooth/main.conf.d
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Katherine Lai <laikatherine@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for the clarification. We will not be moving forward with this
proposal but will implement overrides in our build system instead.

On Thu, Mar 10, 2022 at 12:04 PM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Sonny,
>
> >>> It was found that a change to the default settings for
> >>> MinConnectionInterval and MaxConnectionInterval in main.conf broke
> >>> some of ChromeOS=E2=80=99s keyboard HID tests for only certain Blueto=
oth
> >>> controllers. These keyboards aren=E2=80=99t able to connect to the de=
vice.
> >>> Since those connection parameters improve the connection interval for
> >>> most other chipsets, we want to leave the default values but have a
> >>> way to have an optional override to address problematic models.
> >>>
> >>>
> >>> Proposed Solution
> >>>
> >>> Adding support to bluetoothd for an additional config directory
> >>> /etc/bluetooth/main.conf.d containing multiple files which will
> >>> override common params. Override order will be lexically sorted
> >>> filename order. This pattern is already used by Linux distros, for
> >>> example there is /etc/sudoers.d which files will override common
> >>> params in /etc/sudoers.
> >>>
> >>> Users can add override config files to /etc/bluetooth/main.conf.d
> >>> rather than directly editing /etc/bluetooth/main.conf. This is more
> >>> friendly to package managers since BlueZ package updates won't cause
> >>> conflict to /etc/bluetooth/main.conf.
> >>>
> >>> In bluez=E2=80=99s main.c, merge the params for each *.conf file from
> >>> /etc/bluetooth/main.conf.d with the existing /etc/bluetooth/main.conf
> >>> in lexical filename order
> >>>
> >>> /etc/bluetooth/main.conf.d will be configurable at build time, e.g.
> >>> with ./configure --main-conf-dir
> >>
> >> actually I rather not do this. Let met try to explain this. In modern =
distribution layout, the /etc directory is purely for the admin of the syst=
em. They can do localized changes. Defaults are meant to be in /usr/lib/ ac=
tually. And override is also meant that an /etc file can fully replace an /=
usr/lib file.
> >>
> >> We already structured that /etc/bluetooth/main.conf is optional and th=
at package managers / distros should only install it if they really know wh=
at they are doing. If an upgrade of a package overwrites /etc/bluetooth/mai=
n.conf then it is doing something wrong (mind you we don=E2=80=99t install =
it by default).
> >>
> >> That said, some time ago I discussed with Alain, that fundamentally yo=
u first need an option to identify your controller, what firmware etc. and =
then can decide what to load. That thread ended and got no further discussi=
on. Based on that identification we wanted to allow tweaking certain set of=
 parameters to add known good parameters / workaround to broken hardware.
> >>
> >> If you say, that you already know all of this anyway upfront and your =
filesystem is specific for a given platform, then use tmpfs for /etc/blueto=
oth/main.conf or alternatively, we actually introduce support for CONFIGURA=
TION_DIRECTORY. We already have this in iwd and it would make sense to just=
 support it.
> >>
> >> The CONFIGURATION_DIRECTORY directory comes from systemd (https://www.=
freedesktop.org/software/systemd/man/systemd.exec.html), but since it is ju=
st an environment variable for the bluetoothd process, you can do with any =
shell by just setting it.
> >
> > If I interpret this correctly, the reason against this proposal isn't
> > really about the location of the conf (/usr vs /etc), but rather that
> > BlueZ intends to use the main.conf already as an override (so there is
> > no need for another override), is that right?
>
> that is one of them. The other is that these days overrides are done diff=
erently as mentioned above.
>
> Regards
>
> Marcel
>
