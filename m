Return-Path: <SRS0=QJP1=RU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A8BC43381
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Mar 2019 22:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33C02087C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Mar 2019 22:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAFkCxNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfCQWDE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Mar 2019 18:03:04 -0400
Received: from mail-yw1-f54.google.com ([209.85.161.54]:46255 "EHLO
        mail-yw1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfCQWDD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Mar 2019 18:03:03 -0400
Received: by mail-yw1-f54.google.com with SMTP id v127so11161686ywe.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Mar 2019 15:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zRu6S8IpB6lGJZWJ/EtFth6S6/BRofXPEPqFOJBVEBo=;
        b=CAFkCxNRo4nrPRZ+Ym78SFWgTZ8hoqN2Y3VyYfARcjgFrQrBN0pgvZv0qBVXvv/YoY
         i57KYy/8ftPml1QjiCAknueaIGBOO7/kx0z/5ivvBQ3fUiGnCbwv2QvJms60e6EIESOz
         c2VSBnmj6OOD6ED9li/p85eLzKARH5BfAC8OzEd2CslWfx3ovK4iKG67veYk8QkL10xC
         8get4x9KxgUy8pXgCEqtEo1y8fVfy9GpjSDD4SdfJYqO5g/+R/M9triYcaYi1L4FncSX
         K8FK/Wt6kjS2ddB5Cf0zQzGL+8AdTSmYqP/xLVsRLbfjNfwSOOQHLXIX44gSkkDzdUb+
         PhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRu6S8IpB6lGJZWJ/EtFth6S6/BRofXPEPqFOJBVEBo=;
        b=R86mfkRyiDKfYVChQqQdez55e93kKkPdxhZehKy/rPklrEY0tzUThiosNYXO8AmVnB
         nHUFt21lrZpJ9E65mEbEvyHb1xVxdPm76ib2wjU+x6NYSmUUCu4aGqaysbYTWQTlomtp
         bGNrM09CbNU/uUm0BqaWkD2AHia1tjYDKN2MITGrAYWc7aymhn5h5eBpzzIEKF/WoOP/
         JY56t6hoewr32pjWhMtwasGJtbZDediMNi4P+T2y8dPsptMwxSnkAiiVrtgBYLgMjdXw
         5KO0Tr/h99BCF6ZKi9FuAH/rweuWPaivpq/jHtYwAEh8GtugcMU19Nehdqa+z7QZCI92
         SpIg==
X-Gm-Message-State: APjAAAWAOi5s+UdM89km1kQ+WO2ypaMAD0q5mnF8Wu1gB6tpR2RchoVF
        +Gy3MklbkVXSKSuXhys+ui14pw2OhtU3df69hib/8xcV
X-Google-Smtp-Source: APXvYqw+2vAr4NFjV41u7wPMSOrsQZ64u6p6mBbGujDdA2PGmB2x2ymiZ6itwYuqPxe/qzUjo09OikZo1DyedHO7B4U=
X-Received: by 2002:a81:6705:: with SMTP id b5mr5617023ywc.31.1552860182828;
 Sun, 17 Mar 2019 15:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAAu3APbx4njmmBgu4_U=9CEahhK-f8BnhMuAwp0=XgFRZhexvw@mail.gmail.com>
 <CAAu3APbP02yHgtJE6k4D4iQ4ukFRjQhF3rs0A=jPL-J_DZKZMw@mail.gmail.com> <CABBYNZK5jauJ-9aumBsVgwhdYMpf-sJ5A8726+ms-eP7_PNFtA@mail.gmail.com>
In-Reply-To: <CABBYNZK5jauJ-9aumBsVgwhdYMpf-sJ5A8726+ms-eP7_PNFtA@mail.gmail.com>
From:   Barry Byford <31baz66@gmail.com>
Date:   Sun, 17 Mar 2019 22:02:51 +0000
Message-ID: <CAAu3APamGb5enNZrKC0HvBMt6Erba2z0YU10BsdkGFZGYzVA_Q@mail.gmail.com>
Subject: Re: Peripheral notifications not showing up
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks for taking a look at this.

On Tue, 12 Mar 2019 at 13:12, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Barry,
>
> On Fri, Mar 8, 2019 at 11:20 PM Barry Byford <31baz66@gmail.com> wrote:
> >
> > I have tried the same experiment on a Raspberry Pi.
> >
> > $ uname -a
> > Linux raspberrypi 4.14.79-v7+ #1159 SMP Sun Nov 4 17:50:20 GMT 2018
> > armv7l GNU/Linux
> >
> > I ran the peripheral code I have and it worked fine on the Raspberry
> > Pi. I then rebuilt BlueZ 5.43 and reinstalled it and I see the same
> > issue with getting notificatins.
> > That is, reading of the characteristic in the Nordic nRF app on my
> > phone works. However, when I activate notifications I can see the
> > status change on the peripheral and the notifications show up on the
> > DBus. The notifications just don't show up in btmon or on my phone.
>
> Perhaps is being blocked somehow, you got the StartNotification I
> suppose? Please make sure the object path matches otherwise it won't
> work, you may also check how bluetoothctl does handle notifications
> since that has been working for a while.

My code is working with the default installation of BlueZ that is on
the board. The issue is when I build a version of BlueZ on the board
myself.
This leads me to believe it is not the code I'm running.



>
> > Does anyone have any suggestions of how I can debug this?
>
> The usual btmon traces and bluetoothd debug logs are normally a good
> idea to share since there could be some bug, though Ive been testing
> this regularly with bluetoothctl and that has been stable for a while,
> at least on master that is.
>

Here are the logs.
https://gist.github.com/ukBaz/b8317f2d76acc6dbf844c2713555974e
To my untrained eye it looks like the notification is started but it
never shows up. In the dbus-monitor output below, the notifications
are on the dbus. I can't tell where they are going missing between the
dbus and bluetoothd.


> > Thanks,
> > Barry
> >
> >
> > On Wed, 6 Mar 2019 at 22:37, Barry Byford <31baz66@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > > I have a system that comes with BlueZ 5.43 installed on a single board
> > > computer (SBC). I have downloaded, built and installed various newer
> > > versions of BlueZ but I am having problems getting them working
> > > correctly.
> > >
> > > I have a peripheral (very similar to the gatt server example in the
> > > test directory) with one characteristic. My example was working before
> > > upgrading. However after upgrading, when I turn on notification for
> > > the characteristic it is not showing on the phone.
> > >
> > > I do see the notification turn up in dbus-monitor but not in btmon.
> > >
> > > signal time=1551910979.743011 sender=:1.38 -> destination=(null
> > > destination) serial=339 path=/ukBaz/bluezero/service0001/char0001;
> > > interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
> > >    string "org.bluez.GattCharacteristic1"
> > >    array [
> > >       dict entry(
> > >          string "Value"
> > >          variant             array of bytes [
> > >                78 14
> > >             ]
> > >       )
> > >    ]
> > >    array [
> > >    ]
> > >
> > > I have tried going back to version 5.43 again but now that is not
> > > working either.
> > >
> > > The configure I ran was:
> > > ./configure --prefix=/usr \
> > >             --mandir=/usr/share/man \
> > >             --sysconfdir=/etc \
> > >             --localstatedir=/var \
> > >             --enable-experimental \
> > >             --enable-maintainer-mode
> > >
> > >
> > > To get configure to work without error I needed to install the following:
> > > sudo apt install glib2.
> > > sudo apt install libdbus-1-dev libudev-dev libical-dev libreadline-dev
> > >
> > > I have tried various variations on this and done a lot of searching
> > > but don't seem to find an answer.
> > > Is anyone else seeing this issue?
> > > Anyone have any suggestions as what I could try?
> > >
> > > Thanks in advance,
> > > Barry
>
>
>
> --
> Luiz Augusto von Dentz
