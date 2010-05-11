Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <p2q793f89501005052222u4393c8dfhb55bea4454c454b9@mail.gmail.com>
References: <p2q793f89501005052222u4393c8dfhb55bea4454c454b9@mail.gmail.com>
Date: Tue, 11 May 2010 16:06:31 +0300
Message-ID: <AANLkTinOD1ODHqYSWTLv5ho2ZYU-bfiJ1xYkWNlbgaZQ@mail.gmail.com>
Subject: Re: [bugreport]
From: Serhiy Kachaniuk <serzholino@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2010/5/6 Serhiy Kachaniuk <serzholino@gmail.com>:
> Hi!
>
> My USB bluetooth adapter stopped working with new versions of bluez.
> Latest version which works is 4.32.
> I initially reported bug for ubuntu package in launchpad here
> https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/453885 , but then
> i tried also opensuse livecd and problem remained there too, so looks
> like it's not ubuntu specific.
> jhe at #bluez-devel suggested to me to collect hcidump output on
> bluetoothd startup, and then write to this mailinglist. I attached
> suggested hcidumps for bluez versions 4.64 and 4.32, and looks like
> 4.64 stops initialization process after it cannot read parameter
> 'Default Link Policy Settings' from device.
>
> Can you please take a look at this bug?
> Thanks in advance.
>

Can someone turn this e-mail thread into bluez bugreport? If i
understand correctly, only developers can create bluez bugreports in
trac? Also, if you need any more debugging info, i would be glad to
provide you with any.
