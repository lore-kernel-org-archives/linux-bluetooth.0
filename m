Return-Path: <SRS0=Wjv6=RP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D5AC43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Mar 2019 13:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5BC214AE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Mar 2019 13:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgSMk8OA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfCLNMH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:12:07 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:45078 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfCLNMG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Mar 2019 09:12:06 -0400
Received: by mail-ot1-f41.google.com with SMTP id i12so2358358otp.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Mar 2019 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kjtha81FEcNqGj/PHO8IM6YiiBNmcFavqFbetE86A7Q=;
        b=CgSMk8OAIr8zsIUkBy1BvU+o5DZfFAuBtts9bfxDZdityGgWCS8BNJYXEHS/X05tqg
         OnLL5U86kCIBzQcRHRm9Unml+KIl2jDMmWkgiJnV5e90VR0/pdxmZUUOw/JYODAPNVu/
         vzwgDhU9STHOd0/R9J1bZdV/ZB30w05C5ESTyiENnR5qUpNrzKdyKyo4d7qFnEAPinLD
         vQln8FXBIUWToptJAJpetghqmnkPJnN3FcYd/6Pszos3wh0toDo5IzGqtYf+OEd90694
         Yq/0+fw4BiJA9/9FyjXYDbj68UBO8fObZNk153qva1YdMdrn9mpb4VD6Rmk1v1wUipzX
         N6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kjtha81FEcNqGj/PHO8IM6YiiBNmcFavqFbetE86A7Q=;
        b=ZM9at0TqPIDbnYBTSxqpbLJwKY8AnHnVXqZyx4/xxGtScsvXHGPuqsFf4gZkJ11tGr
         Lnsgk0VVxQ/4mD1mtplqtPKfw2/lEXVVusdxtNHp67hGOUlgzLc2zlHpRIfI9umxfIpE
         +KViUpvvGuXM/hdJuOYCIE43XlBZ4Z7hdn1AIiG6Y26DELkmLOYxDnXnF4XONsMPM7SU
         XHBG8Fg/2vyQk/WCDAgvPLYf4e7tXdPo8kjr98zYi1agKBe018SPlNGD7Hhy2G2J/deY
         /G3GlPy/8HwEUyU7xodnzOX4h1W35x7ojRCUQMsVg4ftHI2y7mrEuAtjDYJyWz+SQxT2
         IMVg==
X-Gm-Message-State: APjAAAWHZ1tyB+A8kn4jo+TCr0fg9DQwU2b7Bs+ABQuS42+VonEjnR+B
        FJyyN57Cyd7MkfGniR3by1C0H9S2AoQLZ3G02iw=
X-Google-Smtp-Source: APXvYqzo9moqmhC8I+CQk/qRB3pvbN7zBMrxIUG5X7w8GnaQ4D3QwoHcHDdcEbw4AifYEe/ggkwSTqs949eTPy6lVg0=
X-Received: by 2002:a9d:7003:: with SMTP id k3mr24190102otj.291.1552396325244;
 Tue, 12 Mar 2019 06:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAAu3APbx4njmmBgu4_U=9CEahhK-f8BnhMuAwp0=XgFRZhexvw@mail.gmail.com>
 <CAAu3APbP02yHgtJE6k4D4iQ4ukFRjQhF3rs0A=jPL-J_DZKZMw@mail.gmail.com>
In-Reply-To: <CAAu3APbP02yHgtJE6k4D4iQ4ukFRjQhF3rs0A=jPL-J_DZKZMw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 12 Mar 2019 15:11:52 +0200
Message-ID: <CABBYNZK5jauJ-9aumBsVgwhdYMpf-sJ5A8726+ms-eP7_PNFtA@mail.gmail.com>
Subject: Re: Peripheral notifications not showing up
To:     Barry Byford <31baz66@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Barry,

On Fri, Mar 8, 2019 at 11:20 PM Barry Byford <31baz66@gmail.com> wrote:
>
> I have tried the same experiment on a Raspberry Pi.
>
> $ uname -a
> Linux raspberrypi 4.14.79-v7+ #1159 SMP Sun Nov 4 17:50:20 GMT 2018
> armv7l GNU/Linux
>
> I ran the peripheral code I have and it worked fine on the Raspberry
> Pi. I then rebuilt BlueZ 5.43 and reinstalled it and I see the same
> issue with getting notificatins.
> That is, reading of the characteristic in the Nordic nRF app on my
> phone works. However, when I activate notifications I can see the
> status change on the peripheral and the notifications show up on the
> DBus. The notifications just don't show up in btmon or on my phone.

Perhaps is being blocked somehow, you got the StartNotification I
suppose? Please make sure the object path matches otherwise it won't
work, you may also check how bluetoothctl does handle notifications
since that has been working for a while.

> Does anyone have any suggestions of how I can debug this?

The usual btmon traces and bluetoothd debug logs are normally a good
idea to share since there could be some bug, though Ive been testing
this regularly with bluetoothctl and that has been stable for a while,
at least on master that is.

> Thanks,
> Barry
>
>
> On Wed, 6 Mar 2019 at 22:37, Barry Byford <31baz66@gmail.com> wrote:
> >
> > Hello,
> >
> > I have a system that comes with BlueZ 5.43 installed on a single board
> > computer (SBC). I have downloaded, built and installed various newer
> > versions of BlueZ but I am having problems getting them working
> > correctly.
> >
> > I have a peripheral (very similar to the gatt server example in the
> > test directory) with one characteristic. My example was working before
> > upgrading. However after upgrading, when I turn on notification for
> > the characteristic it is not showing on the phone.
> >
> > I do see the notification turn up in dbus-monitor but not in btmon.
> >
> > signal time=1551910979.743011 sender=:1.38 -> destination=(null
> > destination) serial=339 path=/ukBaz/bluezero/service0001/char0001;
> > interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
> >    string "org.bluez.GattCharacteristic1"
> >    array [
> >       dict entry(
> >          string "Value"
> >          variant             array of bytes [
> >                78 14
> >             ]
> >       )
> >    ]
> >    array [
> >    ]
> >
> > I have tried going back to version 5.43 again but now that is not
> > working either.
> >
> > The configure I ran was:
> > ./configure --prefix=/usr \
> >             --mandir=/usr/share/man \
> >             --sysconfdir=/etc \
> >             --localstatedir=/var \
> >             --enable-experimental \
> >             --enable-maintainer-mode
> >
> >
> > To get configure to work without error I needed to install the following:
> > sudo apt install glib2.
> > sudo apt install libdbus-1-dev libudev-dev libical-dev libreadline-dev
> >
> > I have tried various variations on this and done a lot of searching
> > but don't seem to find an answer.
> > Is anyone else seeing this issue?
> > Anyone have any suggestions as what I could try?
> >
> > Thanks in advance,
> > Barry



-- 
Luiz Augusto von Dentz
