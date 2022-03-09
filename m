Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0547CC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Mar 2022 20:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbiCIUqJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Mar 2022 15:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbiCIUqI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Mar 2022 15:46:08 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2204F4BB96
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Mar 2022 12:45:09 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id u10so6856969ybd.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Mar 2022 12:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=es3JyafYzC7vzfeDhYTd934vaAVSW2eJVfxgKVe4lbc=;
        b=VRpbZnV6sRZoYzFm7pBnu+1WE4IPaZxA/LZ9oIokh53/iJfhRZwaJHtQXgEKzWBB8n
         +QSGGcb1bj5yypB+VnPgShNMUe2iX8JbrltYCpYLrV+ZOZLeaehSw5DpVNC4nsPLc2Xg
         Hlv1bHLhbHmxN1dT/sxtuoHtzoQjJWk893HNYl82rPH9lJIXrQR8/KiLfByJLOsVC7wq
         2vHQ1S7btg2mB99DC3v4duwpGUFwfZzIEmjY0APzc2sYnn7CdhDyd3iMtaBz5F9k+ZdF
         56Z/7sThNV21WuvYViZWAYkJonL3hyTmpwjZjCiyaMZK4bZGdbsIb1QL3XlsDJvLaOtW
         9kyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=es3JyafYzC7vzfeDhYTd934vaAVSW2eJVfxgKVe4lbc=;
        b=pM7ah60iONFDgj1OmqTv+badoMM5mVStKs+GEMuYfxO+SVOGdWbNKuuFqKOdl13154
         IaMSGZcbVzdrl0/ZI90j9PWHVfRvsdx3n5QB8shbTi3AIAw9Kw5FGeAz5yIf5UM70Kov
         DYv341HLvkpwM5J3CtKRYOvkuLF8FC/51R4oYa6dh+uJyrqmXCiaFA+hV5XRi03vUFk6
         3WoDe7wZ0/1LNkcxM5sIMGTeSgHmrG7EQXxnSEOkTddqMe7IxhuWKgazeL0gEtAHpYBV
         UwkhRyrGQqPvp4PJDfrg6MgvZIVWtwLolCCGRon/6F3tZnq04waQLka57l1Gc8E+NolC
         p1cQ==
X-Gm-Message-State: AOAM533gJaFoloiVM5YTHJ9BBTxJEX2QQwRsa8r2Rib1HRLB7kXOTqKy
        APDrPFuakFiJoDQPL6saPiEWCnWC8cMD/dRaDow=
X-Google-Smtp-Source: ABdhPJxv7x/vLII3kQXuiF7SfVn0jNblZAWFb0mvHJYqxv4iD+P97oDlezQ2sOmJgwyM1lC1sWgfH6qmIuKHzRqD9qs=
X-Received: by 2002:a25:9742:0:b0:61d:9526:ebc3 with SMTP id
 h2-20020a259742000000b0061d9526ebc3mr1363814ybo.578.1646858708204; Wed, 09
 Mar 2022 12:45:08 -0800 (PST)
MIME-Version: 1.0
References: <CAPBVwTQrcYYauoCXBWdOsPa_vmN=cajYzVFcep_GLC-2OwOwYQ@mail.gmail.com>
 <6f8f47ceebfbcfd7fa8b04a4df807ae822e2960c.camel@hadess.net>
 <CAO271m=hf0uB1t50t6tTXqDQREVxzX2S=R2rVCGK60xwVKgSYQ@mail.gmail.com> <f1ab40c531d81135918e0a05cc8b1721b951e958.camel@hadess.net>
In-Reply-To: <f1ab40c531d81135918e0a05cc8b1721b951e958.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Mar 2022 12:44:57 -0800
Message-ID: <CABBYNZK9kkA2JQCJ8z-a0asHobxqkSeATtEoPDWxAF=b2TWK5g@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Adding support for /etc/bluetooth/main.conf.d
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Katherine Lai <laikatherine@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Mar 9, 2022 at 4:10 AM Bastien Nocera <hadess@hadess.net> wrote:
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

Before we start doing this we should check if the devices with
problems don't implement Peripheral Preferred Connection Parameters
(PPCP) as some of peripherals are not capable of updating the
connection parameters themselves they depend on the central reading
the PPCP, some years back we got someone attempting to implement PPCP
support but the problem was that one needs to load all the devices
connection parameters with Peripheral Preferred Connection Parameters
management command, anyway it would be great to have support for PPCP
even if that means reloading everything or perhaps we introduce
something at socket level where the user can set the parameters which
then gets saved once the update connection parameters procedure is
completed.

--=20
Luiz Augusto von Dentz
