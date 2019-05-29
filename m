Return-Path: <SRS0=mLwb=T5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E03C28CC0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 May 2019 12:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC072081C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 May 2019 12:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JslR3G5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfE2MWM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 May 2019 08:22:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35328 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2MWM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 May 2019 08:22:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id n14so1805436otk.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 May 2019 05:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+J9y5fLJIR/bX20zyu/g84WntM7xlBTMJSTTEOuMS6Y=;
        b=JslR3G5q+Sy2OKQyyDHIA/gpxPUMkQq8oetGHpYVhQeQj9ZOdjrxNordPpStyLlAZu
         Thh6odvwIAFGJhDbPD/3yldz1ZXdpos1TRMFqbIZmCPVq66jgcYYOPDxWpBzHVIc26/D
         I3n8NJc+yf9LFbpawH/aIk6fxVLCkwfpE3va0Nfgfi+PQbEIvabanUtVPwQf1qPWREX5
         lZ4srfX0mvMf473XF4zzMBTUPYdwwOIq+SB7X7/tJErzBSqvSMo6NVcN/WEjtX5uM5+H
         yIqYhmeZxe/Zvw4bAH6neRw4MDRGVk0c9QchtqSIaNaWw2aO4hWTLP7zGupA1ZsuSV05
         Vmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+J9y5fLJIR/bX20zyu/g84WntM7xlBTMJSTTEOuMS6Y=;
        b=ZA6BFacHouzZ9ERo02VP9TbR/RpTWTOfczqcrQOglbF65Xs5DN6sRmkpoAc6sNAc1X
         JbrjpISfDKiVMUG0nrucvsuGOSYcpNWKvTRdtKsvXKavu/0673ZwthFqZyCYrYS/2TR3
         Y2r0Pi4PWMGXoDBL8hsDFvhzeuHmV7w+1FO4qNkz2LsCnAsOJRouAqXhU3kzcAEE8OCm
         DsNGhUj7SP4lTsJt10y2AKbnYebazOpQzQixxLXxNftLBvSYsJ+i1QLqRQlX6d4KyFF9
         3mM6W616Xmd2p2wdJP+Th9ZMBrniLcCNaFaSRcQvHzBHsgoHKjj8vSFEkicApfvyqfEZ
         237Q==
X-Gm-Message-State: APjAAAUbuWbZ8X+5KjxRDeQz++HtsmRsiiRgOGEDZXEHHgD9L3AVY9+U
        U3gBdhIGKVzoqvVw/mjX5SIwwgxkYgLNe4ovFk4=
X-Google-Smtp-Source: APXvYqyTnA0agDZEVHH3FlvIdhssdbTo5POqMcxfnhTsraWVJaMWtJag/o5MqVE3rAB536JcRBiSksLF0IFnwjdbAe4=
X-Received: by 2002:a05:6830:104b:: with SMTP id b11mr1787736otp.146.1559132531488;
 Wed, 29 May 2019 05:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <f61b05a1-3e87-d09e-6892-ac1999dc6abd@gmail.com>
 <CABBYNZL8JopSfd4AYyYHLAHLzaSNuGPmHbMSOF9wbeNo_QwOLg@mail.gmail.com> <1a6318a2-1aef-a322-fe7e-d40848424f19@gmail.com>
In-Reply-To: <1a6318a2-1aef-a322-fe7e-d40848424f19@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 29 May 2019 15:22:00 +0300
Message-ID: <CABBYNZ+WGZuOV1_m8ShopNrh24x_EpkbjCjEMjGKrfr3fw0WPA@mail.gmail.com>
Subject: Re: Problems with bluez
To:     Matteo Formigli <matteo.formigli@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Matteo,

On Tue, May 28, 2019 at 11:10 PM Matteo Formigli
<matteo.formigli@gmail.com> wrote:
>
> Hi Luiz!
>
> First, thanks for your answer! For now I can't upgrade my ubuntu, but I
> already tried to upgrade bluez launching classic shell commands such as
> apt-get update, upgrade and dist-upgrade. But bluez remains at version
> 5.37. I have to tell you that I tried to uninstall bluez and than
> reinstall it. It was a gamble and maybe it went wrong, but I'm not sure.
>
> About the logs and the HCI traces I don't have knowledge to provide you
> what you want on my own. Can you tell me what commands i have to put in
> the terminal?

5.37 is quite old so there is a high risk there something new, like
LE/GATT connection, that happens to be unstable at that point. You can
use btmon to collect the the HCI traces:

> sudo btmon -t

You can also check the daemon logs with:

> sudo journalctl --unit=bluetooth.service

> Thanks in advance for your help!
>
> Matteo
>
> Il 28/05/19 20:54, Luiz Augusto von Dentz ha scritto:
> > Hi Matteo,
> >
> > On Tue, May 28, 2019 at 9:38 PM Matteo Formigli
> > <matteo.formigli@gmail.com> wrote:
> >> Hi all!
> >>
> >>
> >> I am using Ubuntu 16.04 and there is no way to make the bluetooth work.
> >> Every time I try to pair to my bluetooth headset bluez crashes. I really
> >> don't know where to start solving this problem and I really hope that
> >> someone on this list can help me.
> > Maybe it would help if you update your version of BlueZ, or better yet
> > update your ubuntu, if that still doesn't work then we may have a look
> > at some logs and HCI traces.
> >
> >> Thanks in advance for your help!
> >>
> >> Matteo
> >>
> >> P.s. The following is the output of the dpkg --status of the bluez packgage
> >>
> >> :~$ dpkg --status bluez
> >> Package: bluez
> >> Status: install ok installed
> >> Priority: optional
> >> Section: admin
> >> Installed-Size: 4119
> >> Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
> >> Architecture: amd64
> >> Multi-Arch: foreign
> >> Version: 5.37-0ubuntu5.1
> >> Replaces: bluez-alsa, bluez-audio (<= 3.36-3), bluez-input,
> >> bluez-network, bluez-serial, bluez-utils (<= 3.36-3), udev (<< 170-1)
> >> Depends: libc6 (>= 2.15), libdbus-1-3 (>= 1.9.14), libglib2.0-0 (>=
> >> 2.31.8), libreadline6 (>= 6.0), libudev1 (>= 196), init-system-helpers
> >> (>= 1.18~), lsb-base (>= 4.1+Debian11ubuntu7), kmod, udev (>= 170-1), dbus
> >> Breaks: udev (<< 170-1)
> >> Conflicts: bluez-alsa, bluez-audio (<= 3.36-3), bluez-utils (<= 3.36-3)
> >> Conffiles:
> >>    /etc/bluetooth/input.conf
> >>    /etc/bluetooth/main.conf
> >>    /etc/bluetooth/network.conf
> >>    /etc/bluetooth/proximity.conf
> >>    /etc/dbus-1/system.d/bluetooth.conf
> >>    /etc/init.d/bluetooth
> >>    /etc/init/bluetooth.conf
> >> Description: Bluetooth tools and daemons
> >>    This package contains tools and system daemons for using Bluetooth
> >> devices.
> >>    .
> >>    BlueZ is the official Linux Bluetooth protocol stack. It is an Open
> >> Source
> >>    project distributed under GNU General Public License (GPL).
> >> Homepage: http://www.bluez.org
> >> Original-Maintainer: Debian Bluetooth Maintainers
> >> <pkg-bluetooth-maintainers@lists.alioth.deb
> >>
> >



-- 
Luiz Augusto von Dentz
