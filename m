Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237F2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Mar 2022 21:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbiCIVDj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Mar 2022 16:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiCIVDi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Mar 2022 16:03:38 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9645D2BF7
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Mar 2022 13:02:37 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2d6d0cb5da4so36975807b3.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Mar 2022 13:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UHgTxvf6VgZ5PFAt6y3/2XNugUNHdbsuR4TZCsqghd8=;
        b=Lv4lbVhpBDQ1mnYCz58PSjjnCkZSylWIokoDVdOX5OHH0oo44gdsFP00RggHwAtJtu
         GfPB2jOxK/OEXW2VyORlCU3gXAqI9f2CiLT/15uOJ7CSyOa/3WUPw6sHBwjfG5XLDlnm
         3b5O/Gufi/09NTzFXzERxiI4/CbdZwop9lPpA+qN2a6QRNc6qxg3PWhld9ZjBWZez0xB
         NvtrjhSdelDtJRrRCdNf6L6zCvfGVWBK+1SiWghv/Ym3fCCCO72V7ov17aZ6yyc6/G3J
         QHfVi39m/iC2968HOkePDX5PMy88jHmFO9Cucc/2IH6lTW2E2lSMELKo1LX3A4GihJbb
         ptug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UHgTxvf6VgZ5PFAt6y3/2XNugUNHdbsuR4TZCsqghd8=;
        b=o4b84fpwt8r0vwf2YL8Uis/2Wx6ZKFH7pSQXLwWhMuQkhHKxxfOga/X2JZKS7JpB1+
         cGaDkVqeD3qW89Agta82U4xIfh0jPsgUQjYbWUUVAWXM1XjwqHxIsudHCjUq+lYoN8yz
         kydDAaTVEMtFFA0mAg4+0U7v7y/RRx1z9a0Af45XTYm4Ev71CUC02o7bEggo6/FdM+0W
         Qz0cISGjseNzPc2nbNZGm6vnGRyExnTn2gFYlOolr6I251vpbUnSSX8S5VUuQxc6If6Q
         f2dKfGkA3Wojl0RN5ZR72it//ft0LeWVGY5nblGzVrYzFof2ZlSmjH9RHkVtFFXJoVro
         tiyQ==
X-Gm-Message-State: AOAM532ZuryC1y9Ci62wDTHajOlaJjXWd3HHROYwyUO/RIT+agohRZUb
        9MAh6317TesyGxmT0MwmqqQXIckEm3zZaFHnv1U=
X-Google-Smtp-Source: ABdhPJwNLYG8Rj8K6YdcT+VX2ZSLQvWGrhAIYzsFgZolzRE64Dit60uAbROh/OWVrj5GoBWGbDkhU5EGA+hWXxDyWos=
X-Received: by 2002:a81:9115:0:b0:2dc:2daf:4b8b with SMTP id
 i21-20020a819115000000b002dc2daf4b8bmr1552227ywg.376.1646859756701; Wed, 09
 Mar 2022 13:02:36 -0800 (PST)
MIME-Version: 1.0
References: <CAPBVwTQrcYYauoCXBWdOsPa_vmN=cajYzVFcep_GLC-2OwOwYQ@mail.gmail.com>
 <6f8f47ceebfbcfd7fa8b04a4df807ae822e2960c.camel@hadess.net>
 <CAO271m=hf0uB1t50t6tTXqDQREVxzX2S=R2rVCGK60xwVKgSYQ@mail.gmail.com>
 <f1ab40c531d81135918e0a05cc8b1721b951e958.camel@hadess.net> <CABBYNZK9kkA2JQCJ8z-a0asHobxqkSeATtEoPDWxAF=b2TWK5g@mail.gmail.com>
In-Reply-To: <CABBYNZK9kkA2JQCJ8z-a0asHobxqkSeATtEoPDWxAF=b2TWK5g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Mar 2022 13:02:25 -0800
Message-ID: <CABBYNZ+rg+=ZOAFdBFhyE=Ki7KL1C=Jq-w2cT3rMTMmoMTt6_w@mail.gmail.com>
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

On Wed, Mar 9, 2022 at 12:44 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Wed, Mar 9, 2022 at 4:10 AM Bastien Nocera <hadess@hadess.net> wrote:
> >
> > On Tue, 2022-03-08 at 14:50 -0800, Sonny Sasaka wrote:
> > > Hi Bastien,
> > >
> > >
> > > On Tue, Mar 8, 2022 at 2:14 AM Bastien Nocera <hadess@hadess.net>
> > > wrote:
> > > >
> > > > Hey Katherine,
> > > >
> > > > On Mon, 2022-03-07 at 10:57 -0800, Katherine Lai wrote:
> > > > > Background
> > > > >
> > > > > It was found that a change to the default settings for
> > > > > MinConnectionInterval and MaxConnectionInterval in main.conf
> > > > > broke
> > > > > some of ChromeOS=E2=80=99s keyboard HID tests for only certain Bl=
uetooth
> > > > > controllers. These keyboards aren=E2=80=99t able to connect to th=
e
> > > > > device.
> > > > > Since those connection parameters improve the connection interval
> > > > > for
> > > > > most other chipsets, we want to leave the default values but have
> > > > > a
> > > > > way to have an optional override to address problematic models.
> > > > >
> > > > >
> > > > > Proposed Solution
> > > > >
> > > > > Adding support to bluetoothd for an additional config directory
> > > > > /etc/bluetooth/main.conf.d containing multiple files which will
> > > > > override common params. Override order will be lexically sorted
> > > > > filename order. This pattern is already used by Linux distros,
> > > > > for
> > > > > example there is /etc/sudoers.d which files will override common
> > > > > params in /etc/sudoers.
> > > > >
> > > > > Users can add override config files to /etc/bluetooth/main.conf.d
> > > > > rather than directly editing /etc/bluetooth/main.conf. This is
> > > > > more
> > > > > friendly to package managers since BlueZ package updates won't
> > > > > cause
> > > > > conflict to /etc/bluetooth/main.conf.
> > > > >
> > > > > In bluez=E2=80=99s main.c, merge the params for each *.conf file =
from
> > > > > /etc/bluetooth/main.conf.d with the existing
> > > > > /etc/bluetooth/main.conf
> > > > > in lexical filename order
> > > > >
> > > > > /etc/bluetooth/main.conf.d will be configurable at build time,
> > > > > e.g.
> > > > > with ./configure --main-conf-dir
> > > >
> > > > This isn't quite how the pattern is usually used. With the existing
> > > > patterns, the OS-supplied stock configuration would be in
> > > > /usr/lib/bluetooth/main.conf.d (maybe with the default .conf in the
> > > > same directory as that subdir), with /etc/bluetooth/main.conf.d
> > > > only
> > > > used for the user/admin override the default configuration.
> > > We did a bit of research and found that /etc/X and /etc/X.d is more
> > > common, e.g. the one described in
> > > https://www.redhat.com/sysadmin/etc-configuration-directories.
> >
> > This is documentation for an enterprise distribution, not how the
> > pattern is now used upstream.
> >
> > $ ls -d1 /usr/lib/*.d/
> > /usr/lib/binfmt.d/
> > /usr/lib/environment.d/
> > /usr/lib/modprobe.d/
> > /usr/lib/modules-load.d/
> > /usr/lib/motd.d/
> > /usr/lib/pam.d/
> > /usr/lib/sysctl.d/
> > /usr/lib/sysusers.d/
> > /usr/lib/tmpfiles.d/
> > $ ls -d1 /usr/lib/*/*.d/
> > /usr/lib/dracut/dracut.conf.d/
> > /usr/lib/dracut/modules.d/
> > /usr/lib/fedora-third-party/conf.d/
> > /usr/lib/gconv/gconv-modules.d/
> > /usr/lib/kernel/install.d/
> > /usr/lib/NetworkManager/conf.d/
> > /usr/lib/NetworkManager/dispatcher.d/
> > /usr/lib/rpm/macros.d/
> > /usr/lib/systemd/ntp-units.d/
> > /usr/lib/udev/hwdb.d/
> > /usr/lib/udev/rules.d/
> >
> > > If some distribution wants to organize the conf files to
> > > /usr/lib/bluetooth (for stock by package managers) and
> > > /etc/bluetooth/main.conf.d (for admin/users), I guess this is where
> > > having a configurable path is useful.
> > > What do you think?
> >
> > I'm saying this isn't the current pattern, especially for OSes where
> > /usr is locked-down. I still think this isn't the right way to
> > implement this feature.
>
> Before we start doing this we should check if the devices with
> problems don't implement Peripheral Preferred Connection Parameters
> (PPCP) as some of peripherals are not capable of updating the
> connection parameters themselves they depend on the central reading
> the PPCP, some years back we got someone attempting to implement PPCP
> support but the problem was that one needs to load all the devices
> connection parameters with Peripheral Preferred Connection Parameters
> management command, anyway it would be great to have support for PPCP
> even if that means reloading everything or perhaps we introduce
> something at socket level where the user can set the parameters which
> then gets saved once the update connection parameters procedure is
> completed.

Here it is the RFC for the kernel side:

https://www.spinics.net/lists/linux-bluetooth/msg69520.html

It probably needs some improvements like checkinf if the conneciton is
really LE, etc.

> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
