Return-Path: <SRS0=9Smc=RV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB04C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 22:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D91B2171F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 22:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMvmNYQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfCRWRa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:17:30 -0400
Received: from mail-yw1-f42.google.com ([209.85.161.42]:40509 "EHLO
        mail-yw1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfCRWRa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Mar 2019 18:17:30 -0400
Received: by mail-yw1-f42.google.com with SMTP id p64so10972542ywg.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2019 15:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=IrUzAh37ZYp34y3zguSKDwMSiB6crDVsGvoePFOq830=;
        b=SMvmNYQFp0eeoKxgYk8MB+Bb3LQ2CLMzHaVXPigHoVHSbA6KQr4SD7UiUwvUTe5qnh
         EkeGq1NYyrJVQ1fyt1rnybkftVTsJEWuZRqBJAQbX9fok5xVVDVgb25Z74j4evn6ZtEO
         FWk0omfjsJRT3ELBsF5+YYAWd9jJvx02GYi6fsu8u2G2I7m2TmvCscVO4n8WZzwxsMmm
         dDN8I7NhZcdkMCJey6ybJHG2AFYtxBSizTVcFWzWGz5YUItINj4nNUrrOOXC7wUb14E/
         DBxKA+hhuzV+nFIxqOEy6RLcHUpL7hbwDfP3JYN9wLFoGNTIq50fNvSjB9lvRNPNM9SB
         ziFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IrUzAh37ZYp34y3zguSKDwMSiB6crDVsGvoePFOq830=;
        b=FkJx3fTKB312z0trdmXWiC1V4CP3CVEexwN2Fe6yU0O1U8tsC6yBIW2/PFWmzQ3cU/
         AuJU4IiKl3hZbAJHcLRDeZsTM35heQTAuEUNUsJ6kW1qDiLQ7YvV8WGhmJ0MEoN7GYkc
         QGZ2IgfsHfr5WytlEndWXeiMXZgUNOAWG5RG2gOk1jOGLcbhc8YmftNF+NeRRjSq3uWe
         yLkLnzMo5bKbnICaKhW4hVdPb6T+wrXBGfbeiHQ4Tc0wFNSh4+QWDQqh7cUtiCJX1Xik
         KDxrlOUCjMEC7WGIE2cH0IUbIfkXc2FieaY6uVYCzT1bjF9EMF1vrGf/bbxv1eIX+FSR
         hh/w==
X-Gm-Message-State: APjAAAWweLqz+c/ImUdULp2bZsLbRBZEfM8ti/kQXBHG5NOcNbsAbHsJ
        CcIod+sfIP7SoOVfK4Il8suoKP/Vk6c6ybxKr2o8NA==
X-Google-Smtp-Source: APXvYqx0ynNDjXH1lP/dg03/TxKgRiXvnC81p+Ip6sIOQ40Unqm1it15tvk3LxHYZzzrag9rhYBF7PdWrS77rojQLzY=
X-Received: by 2002:a81:6705:: with SMTP id b5mr9675149ywc.31.1552947448728;
 Mon, 18 Mar 2019 15:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAAu3APbx4njmmBgu4_U=9CEahhK-f8BnhMuAwp0=XgFRZhexvw@mail.gmail.com>
 <CAAu3APbP02yHgtJE6k4D4iQ4ukFRjQhF3rs0A=jPL-J_DZKZMw@mail.gmail.com>
 <CABBYNZK5jauJ-9aumBsVgwhdYMpf-sJ5A8726+ms-eP7_PNFtA@mail.gmail.com> <CAAu3APamGb5enNZrKC0HvBMt6Erba2z0YU10BsdkGFZGYzVA_Q@mail.gmail.com>
In-Reply-To: <CAAu3APamGb5enNZrKC0HvBMt6Erba2z0YU10BsdkGFZGYzVA_Q@mail.gmail.com>
From:   Barry Byford <31baz66@gmail.com>
Date:   Mon, 18 Mar 2019 22:17:17 +0000
Message-ID: <CAAu3APacBJzqF3GS-u2FB2m7mtH7PaDeHyTxnwOBjgpSQdicmg@mail.gmail.com>
Subject: Re: Peripheral notifications not showing up
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This seems to be a permissions issue. If I run my script with sudo
then it works.

Not quite sure why the build and install is changing the permissions required.

Any thoughts?

On Sun, 17 Mar 2019 at 22:02, Barry Byford <31baz66@gmail.com> wrote:
>
> Hi Luiz,
>
> Thanks for taking a look at this.
>
> On Tue, 12 Mar 2019 at 13:12, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Barry,
> >
> > On Fri, Mar 8, 2019 at 11:20 PM Barry Byford <31baz66@gmail.com> wrote:
> > >
> > > I have tried the same experiment on a Raspberry Pi.
> > >
> > > $ uname -a
> > > Linux raspberrypi 4.14.79-v7+ #1159 SMP Sun Nov 4 17:50:20 GMT 2018
> > > armv7l GNU/Linux
> > >
> > > I ran the peripheral code I have and it worked fine on the Raspberry
> > > Pi. I then rebuilt BlueZ 5.43 and reinstalled it and I see the same
> > > issue with getting notificatins.
> > > That is, reading of the characteristic in the Nordic nRF app on my
> > > phone works. However, when I activate notifications I can see the
> > > status change on the peripheral and the notifications show up on the
> > > DBus. The notifications just don't show up in btmon or on my phone.
> >
> > Perhaps is being blocked somehow, you got the StartNotification I
> > suppose? Please make sure the object path matches otherwise it won't
> > work, you may also check how bluetoothctl does handle notifications
> > since that has been working for a while.
>
> My code is working with the default installation of BlueZ that is on
> the board. The issue is when I build a version of BlueZ on the board
> myself.
> This leads me to believe it is not the code I'm running.
>
>
>
> >
> > > Does anyone have any suggestions of how I can debug this?
> >
> > The usual btmon traces and bluetoothd debug logs are normally a good
> > idea to share since there could be some bug, though Ive been testing
> > this regularly with bluetoothctl and that has been stable for a while,
> > at least on master that is.
> >
>
> Here are the logs.
> https://gist.github.com/ukBaz/b8317f2d76acc6dbf844c2713555974e
> To my untrained eye it looks like the notification is started but it
> never shows up. In the dbus-monitor output below, the notifications
> are on the dbus. I can't tell where they are going missing between the
> dbus and bluetoothd.
>
>
> > > Thanks,
> > > Barry
> > >
> > >
> > > On Wed, 6 Mar 2019 at 22:37, Barry Byford <31baz66@gmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > I have a system that comes with BlueZ 5.43 installed on a single board
> > > > computer (SBC). I have downloaded, built and installed various newer
> > > > versions of BlueZ but I am having problems getting them working
> > > > correctly.
> > > >
> > > > I have a peripheral (very similar to the gatt server example in the
> > > > test directory) with one characteristic. My example was working before
> > > > upgrading. However after upgrading, when I turn on notification for
> > > > the characteristic it is not showing on the phone.
> > > >
> > > > I do see the notification turn up in dbus-monitor but not in btmon.
> > > >
> > > > signal time=1551910979.743011 sender=:1.38 -> destination=(null
> > > > destination) serial=339 path=/ukBaz/bluezero/service0001/char0001;
> > > > interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
> > > >    string "org.bluez.GattCharacteristic1"
> > > >    array [
> > > >       dict entry(
> > > >          string "Value"
> > > >          variant             array of bytes [
> > > >                78 14
> > > >             ]
> > > >       )
> > > >    ]
> > > >    array [
> > > >    ]
> > > >
> > > > I have tried going back to version 5.43 again but now that is not
> > > > working either.
> > > >
> > > > The configure I ran was:
> > > > ./configure --prefix=/usr \
> > > >             --mandir=/usr/share/man \
> > > >             --sysconfdir=/etc \
> > > >             --localstatedir=/var \
> > > >             --enable-experimental \
> > > >             --enable-maintainer-mode
> > > >
> > > >
> > > > To get configure to work without error I needed to install the following:
> > > > sudo apt install glib2.
> > > > sudo apt install libdbus-1-dev libudev-dev libical-dev libreadline-dev
> > > >
> > > > I have tried various variations on this and done a lot of searching
> > > > but don't seem to find an answer.
> > > > Is anyone else seeing this issue?
> > > > Anyone have any suggestions as what I could try?
> > > >
> > > > Thanks in advance,
> > > > Barry
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
