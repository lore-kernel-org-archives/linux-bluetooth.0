Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59EDC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Mar 2022 23:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiCIXf6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Mar 2022 18:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbiCIXf5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Mar 2022 18:35:57 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64844FABFB
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Mar 2022 15:34:57 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w4so4828499edc.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Mar 2022 15:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sBaLhq4NRHuRuLzZ8mRj/EriK/+EfMlvthU5xTLb07c=;
        b=a0onYQ08XIu7lKFXtQdsWiO7qiA4HBj2Vo8iMci596rRm5QTzCVyJ2PLAnEEfHUJIZ
         zQ81K03Jpj/SG//W4UhQ7thG80Vo/WN0dUOViCUT6/stEYQQxF/mLM0jE29v6RjiooAj
         fAG+4YcEOBmH/oPiIO2h0JxM1GP0WAStCtk3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sBaLhq4NRHuRuLzZ8mRj/EriK/+EfMlvthU5xTLb07c=;
        b=Qzsa0HfljRVG9T56GMVDIGzhmUKw7T0Lv4XBc4joonzTpGMkDc3orRm/z0l9OqsmSC
         utVtf8mLEd30diQSoDv8/WIGzEfw2/642YFMFmb2O2x+jCJK+NZtFICbSpdQaznNIoYk
         MGl22brvnjQrOx9Ic5FhBQ9qv71cC3d9HUmR2s0mVUs8Bj14z00mf+MxgChY3Tfncq3u
         mw1+ZnCx0qPaGH4I7mk9Z99tbuk5eqnS72kLgakk86vZt6Q52bwmAe//ajes/UFwUd2T
         CAjOuwD6Jnp5Noq28o+IImmi/Mdz+8HaH0RMeO4YZJf5cOLM2vCfe7Y/L4YXPJCLn0jF
         GPHw==
X-Gm-Message-State: AOAM533/oqgywcYvJBmGqxY6AWzE8UU6fQNcPN8EE3f+xW/VKczmDGMK
        IP5jvmnoa5iimbDJo30EvWYJb+mfVZB2lbUM
X-Google-Smtp-Source: ABdhPJxKujqk4nNH50fs78W7a1/iGSTU1r1otFj3XyGt84L8l02l6RQ/OE0Kpaihq5PEuOsCd95TDw==
X-Received: by 2002:a05:6402:440d:b0:412:9e8a:5e51 with SMTP id y13-20020a056402440d00b004129e8a5e51mr1816648eda.362.1646868895613;
        Wed, 09 Mar 2022 15:34:55 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id d1-20020a17090694c100b006da91d57e93sm1262422ejy.207.2022.03.09.15.34.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 15:34:55 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a8so8457443ejc.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Mar 2022 15:34:55 -0800 (PST)
X-Received: by 2002:a17:906:2b97:b0:6cd:6d67:ab5d with SMTP id
 m23-20020a1709062b9700b006cd6d67ab5dmr1916965ejg.723.1646868894429; Wed, 09
 Mar 2022 15:34:54 -0800 (PST)
MIME-Version: 1.0
References: <CAPBVwTQrcYYauoCXBWdOsPa_vmN=cajYzVFcep_GLC-2OwOwYQ@mail.gmail.com>
 <6f8f47ceebfbcfd7fa8b04a4df807ae822e2960c.camel@hadess.net>
 <CAO271m=hf0uB1t50t6tTXqDQREVxzX2S=R2rVCGK60xwVKgSYQ@mail.gmail.com>
 <f1ab40c531d81135918e0a05cc8b1721b951e958.camel@hadess.net>
 <CABBYNZK9kkA2JQCJ8z-a0asHobxqkSeATtEoPDWxAF=b2TWK5g@mail.gmail.com> <CABBYNZ+rg+=ZOAFdBFhyE=Ki7KL1C=Jq-w2cT3rMTMmoMTt6_w@mail.gmail.com>
In-Reply-To: <CABBYNZ+rg+=ZOAFdBFhyE=Ki7KL1C=Jq-w2cT3rMTMmoMTt6_w@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed, 9 Mar 2022 15:34:43 -0800
X-Gmail-Original-Message-ID: <CAO271mnSPVV0BdmdMLGxREy=4TwHB2ryuxcgpnhiDQJPoEELSA@mail.gmail.com>
Message-ID: <CAO271mnSPVV0BdmdMLGxREy=4TwHB2ryuxcgpnhiDQJPoEELSA@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Adding support for /etc/bluetooth/main.conf.d
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Katherine Lai <laikatherine@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Wed, Mar 9, 2022 at 1:02 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Wed, Mar 9, 2022 at 12:44 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi,
> >
> > On Wed, Mar 9, 2022 at 4:10 AM Bastien Nocera <hadess@hadess.net> wrote=
:
> > >
> > > On Tue, 2022-03-08 at 14:50 -0800, Sonny Sasaka wrote:
> > > > Hi Bastien,
> > > >
> > > >
> > > > On Tue, Mar 8, 2022 at 2:14 AM Bastien Nocera <hadess@hadess.net>
> > > > wrote:
> > > > >
> > > > > Hey Katherine,
> > > > >
> > > > > On Mon, 2022-03-07 at 10:57 -0800, Katherine Lai wrote:
> > > > > > Background
> > > > > >
> > > > > > It was found that a change to the default settings for
> > > > > > MinConnectionInterval and MaxConnectionInterval in main.conf
> > > > > > broke
> > > > > > some of ChromeOS=E2=80=99s keyboard HID tests for only certain =
Bluetooth
> > > > > > controllers. These keyboards aren=E2=80=99t able to connect to =
the
> > > > > > device.
> > > > > > Since those connection parameters improve the connection interv=
al
> > > > > > for
> > > > > > most other chipsets, we want to leave the default values but ha=
ve
> > > > > > a
> > > > > > way to have an optional override to address problematic models.
> > > > > >
> > > > > >
> > > > > > Proposed Solution
> > > > > >
> > > > > > Adding support to bluetoothd for an additional config directory
> > > > > > /etc/bluetooth/main.conf.d containing multiple files which will
> > > > > > override common params. Override order will be lexically sorted
> > > > > > filename order. This pattern is already used by Linux distros,
> > > > > > for
> > > > > > example there is /etc/sudoers.d which files will override commo=
n
> > > > > > params in /etc/sudoers.
> > > > > >
> > > > > > Users can add override config files to /etc/bluetooth/main.conf=
.d
> > > > > > rather than directly editing /etc/bluetooth/main.conf. This is
> > > > > > more
> > > > > > friendly to package managers since BlueZ package updates won't
> > > > > > cause
> > > > > > conflict to /etc/bluetooth/main.conf.
> > > > > >
> > > > > > In bluez=E2=80=99s main.c, merge the params for each *.conf fil=
e from
> > > > > > /etc/bluetooth/main.conf.d with the existing
> > > > > > /etc/bluetooth/main.conf
> > > > > > in lexical filename order
> > > > > >
> > > > > > /etc/bluetooth/main.conf.d will be configurable at build time,
> > > > > > e.g.
> > > > > > with ./configure --main-conf-dir
> > > > >
> > > > > This isn't quite how the pattern is usually used. With the existi=
ng
> > > > > patterns, the OS-supplied stock configuration would be in
> > > > > /usr/lib/bluetooth/main.conf.d (maybe with the default .conf in t=
he
> > > > > same directory as that subdir), with /etc/bluetooth/main.conf.d
> > > > > only
> > > > > used for the user/admin override the default configuration.
> > > > We did a bit of research and found that /etc/X and /etc/X.d is more
> > > > common, e.g. the one described in
> > > > https://www.redhat.com/sysadmin/etc-configuration-directories.
> > >
> > > This is documentation for an enterprise distribution, not how the
> > > pattern is now used upstream.
> > >
> > > $ ls -d1 /usr/lib/*.d/
> > > /usr/lib/binfmt.d/
> > > /usr/lib/environment.d/
> > > /usr/lib/modprobe.d/
> > > /usr/lib/modules-load.d/
> > > /usr/lib/motd.d/
> > > /usr/lib/pam.d/
> > > /usr/lib/sysctl.d/
> > > /usr/lib/sysusers.d/
> > > /usr/lib/tmpfiles.d/
> > > $ ls -d1 /usr/lib/*/*.d/
> > > /usr/lib/dracut/dracut.conf.d/
> > > /usr/lib/dracut/modules.d/
> > > /usr/lib/fedora-third-party/conf.d/
> > > /usr/lib/gconv/gconv-modules.d/
> > > /usr/lib/kernel/install.d/
> > > /usr/lib/NetworkManager/conf.d/
> > > /usr/lib/NetworkManager/dispatcher.d/
> > > /usr/lib/rpm/macros.d/
> > > /usr/lib/systemd/ntp-units.d/
> > > /usr/lib/udev/hwdb.d/
> > > /usr/lib/udev/rules.d/
> > >
> > > > If some distribution wants to organize the conf files to
> > > > /usr/lib/bluetooth (for stock by package managers) and
> > > > /etc/bluetooth/main.conf.d (for admin/users), I guess this is where
> > > > having a configurable path is useful.
> > > > What do you think?
> > >
> > > I'm saying this isn't the current pattern, especially for OSes where
> > > /usr is locked-down. I still think this isn't the right way to
> > > implement this feature.
> >
> > Before we start doing this we should check if the devices with
> > problems don't implement Peripheral Preferred Connection Parameters
> > (PPCP) as some of peripherals are not capable of updating the
> > connection parameters themselves they depend on the central reading
> > the PPCP, some years back we got someone attempting to implement PPCP
> > support but the problem was that one needs to load all the devices
> > connection parameters with Peripheral Preferred Connection Parameters
> > management command, anyway it would be great to have support for PPCP
> > even if that means reloading everything or perhaps we introduce
> > something at socket level where the user can set the parameters which
> > then gets saved once the update connection parameters procedure is
> > completed.
In our case, the problem is not with the peripherals but with a
specific Bluetooth controller of the central. We can't assume that all
Bluetooth controllers behave well with a certain configuration,
therefore I think that trying to get a one-size-fits-all configuration
will likely run into a problem eventually.

Also, although it's motivated by a specific issue, the solution that
we are proposing is actually a generally helpful feature since there
are other parameters that users may override without modifying the
original configuration that comes from package manager especially when
it is locked down. As a generic override mechanism, what do you think
about this proposal?
>
> Here it is the RFC for the kernel side:
>
> https://www.spinics.net/lists/linux-bluetooth/msg69520.html
>
> It probably needs some improvements like checkinf if the conneciton is
> really LE, etc.
>
> > --
> > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
