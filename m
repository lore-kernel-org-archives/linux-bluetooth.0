Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDA0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Mar 2022 17:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbiCIRMU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Mar 2022 12:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbiCIRMK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Mar 2022 12:12:10 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD8010E55A
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Mar 2022 09:05:47 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bg10so6544406ejb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Mar 2022 09:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JEU7ee569p+vgQ2rlGkuRI8+ynD1ujzhla+J+Wlp5ZY=;
        b=kQpJCpisR5yQeO5+PI3cN7evuO3FaDDVTMEAvDRAvv9RftWl55wnWv5FnZNNsWb+eA
         w3FJYm7cZIuPyz08ed6jFEdv1QQFOtdp+lwUEQ1LzaafedKyqvlo3vDgJ9NMUMFO/sxd
         vAnjKK27xTU7/8PEWEiRAsjzNys2qJlNFIcFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JEU7ee569p+vgQ2rlGkuRI8+ynD1ujzhla+J+Wlp5ZY=;
        b=64h4+hsWgZ1l/Q8SkRW0qFdlxLYMMSRL+vxWRaSO+d9nSqdMK4GfAHvV78dK1Vc2lQ
         XEl3E/z3/6ZqG0W3NnNdBfVwohCS2gU6grlsq1tfShyHMLtzo/fOQw87ERB+pM6slZrz
         +laQyLMouZNj1wSA+mlp7PwUromwDzfNueY4x6bUbJZIsLgVisjWEfftLQ2MYBTRZRlp
         9vuTQqhkClUDZ9XJRZIDFcoyBiWUl+w5ivW2Bye4vsx7UKt6Fr5rMSsjggVZtG3R0SFi
         E781MBdzByiryjIaNJeeif4jR3ST5OqRlicJYMaZPT+a/MLhTbQhW23q3ex3VoOO2V5i
         VQpA==
X-Gm-Message-State: AOAM532bMpFAGoRDgLAWiDZ2VN1P+7zLY/4WBRu0//8FPF2aO3FCV8zq
        F9oxKM8Lv3jQCnI0e5gjZ7W/PjRI9GvEpQ==
X-Google-Smtp-Source: ABdhPJxXZrFK47m6PR0GnqxvgUmD9syd98R2ADZDowpYop2nr3BEkikUBgOM4K4pzyjA44Q0LzM/YA==
X-Received: by 2002:a17:906:a148:b0:6cd:50c7:8d4d with SMTP id bu8-20020a170906a14800b006cd50c78d4dmr635097ejb.641.1646845545454;
        Wed, 09 Mar 2022 09:05:45 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a102-20020a509eef000000b0041614c8f79asm1090552edf.88.2022.03.09.09.05.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 09:05:44 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id h13so3723288ede.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Mar 2022 09:05:44 -0800 (PST)
X-Received: by 2002:a05:6402:718:b0:415:a0e5:48c with SMTP id
 w24-20020a056402071800b00415a0e5048cmr443138edx.156.1646845543873; Wed, 09
 Mar 2022 09:05:43 -0800 (PST)
MIME-Version: 1.0
References: <CAPBVwTQrcYYauoCXBWdOsPa_vmN=cajYzVFcep_GLC-2OwOwYQ@mail.gmail.com>
 <6f8f47ceebfbcfd7fa8b04a4df807ae822e2960c.camel@hadess.net>
 <CAO271m=hf0uB1t50t6tTXqDQREVxzX2S=R2rVCGK60xwVKgSYQ@mail.gmail.com> <f1ab40c531d81135918e0a05cc8b1721b951e958.camel@hadess.net>
In-Reply-To: <f1ab40c531d81135918e0a05cc8b1721b951e958.camel@hadess.net>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed, 9 Mar 2022 09:05:30 -0800
X-Gmail-Original-Message-ID: <CAO271m=GeJTiXZ94pMMWjXwNNtpDAAQ_p1Hh8V0kWqEa8wr9mw@mail.gmail.com>
Message-ID: <CAO271m=GeJTiXZ94pMMWjXwNNtpDAAQ_p1Hh8V0kWqEa8wr9mw@mail.gmail.com>
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

On Wed, Mar 9, 2022 at 1:17 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Tue, 2022-03-08 at 14:50 -0800, Sonny Sasaka wrote:
> > Hi Bastien,
> >
> >
> > On Tue, Mar 8, 2022 at 2:14 AM Bastien Nocera <hadess@hadess.net>
> > wrote:
> > >
> > > Hey Katherine,
> > >
> > > On Mon, 2022-03-07 at 10:57 -0800, Katherine Lai wrote:
> > > > Background
> > > >
> > > > It was found that a change to the default settings for
> > > > MinConnectionInterval and MaxConnectionInterval in main.conf
> > > > broke
> > > > some of ChromeOS=E2=80=99s keyboard HID tests for only certain Blue=
tooth
> > > > controllers. These keyboards aren=E2=80=99t able to connect to the
> > > > device.
> > > > Since those connection parameters improve the connection interval
> > > > for
> > > > most other chipsets, we want to leave the default values but have
> > > > a
> > > > way to have an optional override to address problematic models.
> > > >
> > > >
> > > > Proposed Solution
> > > >
> > > > Adding support to bluetoothd for an additional config directory
> > > > /etc/bluetooth/main.conf.d containing multiple files which will
> > > > override common params. Override order will be lexically sorted
> > > > filename order. This pattern is already used by Linux distros,
> > > > for
> > > > example there is /etc/sudoers.d which files will override common
> > > > params in /etc/sudoers.
> > > >
> > > > Users can add override config files to /etc/bluetooth/main.conf.d
> > > > rather than directly editing /etc/bluetooth/main.conf. This is
> > > > more
> > > > friendly to package managers since BlueZ package updates won't
> > > > cause
> > > > conflict to /etc/bluetooth/main.conf.
> > > >
> > > > In bluez=E2=80=99s main.c, merge the params for each *.conf file fr=
om
> > > > /etc/bluetooth/main.conf.d with the existing
> > > > /etc/bluetooth/main.conf
> > > > in lexical filename order
> > > >
> > > > /etc/bluetooth/main.conf.d will be configurable at build time,
> > > > e.g.
> > > > with ./configure --main-conf-dir
> > >
> > > This isn't quite how the pattern is usually used. With the existing
> > > patterns, the OS-supplied stock configuration would be in
> > > /usr/lib/bluetooth/main.conf.d (maybe with the default .conf in the
> > > same directory as that subdir), with /etc/bluetooth/main.conf.d
> > > only
> > > used for the user/admin override the default configuration.
> > We did a bit of research and found that /etc/X and /etc/X.d is more
> > common, e.g. the one described in
> > https://www.redhat.com/sysadmin/etc-configuration-directories.
>
> This is documentation for an enterprise distribution, not how the
> pattern is now used upstream.
>
> $ ls -d1 /usr/lib/*.d/
> /usr/lib/binfmt.d/
> /usr/lib/environment.d/
> /usr/lib/modprobe.d/
> /usr/lib/modules-load.d/
> /usr/lib/motd.d/
> /usr/lib/pam.d/
> /usr/lib/sysctl.d/
> /usr/lib/sysusers.d/
> /usr/lib/tmpfiles.d/
> $ ls -d1 /usr/lib/*/*.d/
> /usr/lib/dracut/dracut.conf.d/
> /usr/lib/dracut/modules.d/
> /usr/lib/fedora-third-party/conf.d/
> /usr/lib/gconv/gconv-modules.d/
> /usr/lib/kernel/install.d/
> /usr/lib/NetworkManager/conf.d/
> /usr/lib/NetworkManager/dispatcher.d/
> /usr/lib/rpm/macros.d/
> /usr/lib/systemd/ntp-units.d/
> /usr/lib/udev/hwdb.d/
> /usr/lib/udev/rules.d/
The proposal doesn't actually define the location of the .d directory,
the proposal only states that bluetoothd will have the capability to
have a .d directory defined at compile time and used at runtime.
As I mentioned earlier, this is where configurability at build time
will be useful.
For example, for the enterprise distribution that you just mentioned,
BlueZ can be configured to have the stock conf at
/usr/lib/bluetooth/main.conf (locked down), and user/admin overrides
at /etc/bluetooth/main.conf.d.
If I understand your concern correctly, this should solve the problem
with this different configuration file layout. If I misunderstand
something let me know.
>
> > If some distribution wants to organize the conf files to
> > /usr/lib/bluetooth (for stock by package managers) and
> > /etc/bluetooth/main.conf.d (for admin/users), I guess this is where
> > having a configurable path is useful.
> > What do you think?
>
> I'm saying this isn't the current pattern, especially for OSes where
> /usr is locked-down. I still think this isn't the right way to
> implement this feature.
Could you elaborate why providing a .d overrides directory isn't
right? I can mention an example use case: BlueZ ships at a distro with
certain values of MinConnectionInterval and MaxConnectionInterval in
the stock configuration. The user realizes that these values don't
work well with the Bluetooth controller hardware, maybe LE keyboards
don't reconnect well. They then want to configure this values, but
don't want to edit the stock conf because maybe it's locked or they
don't want to mess with files provided with the package manager. The
user can then use the override directory to customize the values for
MinConnectionInterval and MaxConnectionInterval to make the keyboard
work.

I think that the proposal solves the use case above. If you think this
is not the right approach, could you elaborate why and suggest an
alternative we can consider?
