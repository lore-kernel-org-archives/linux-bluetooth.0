Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 24 Jan 2011 20:35:51 -0600
Message-ID: <AANLkTi=CufNvvAr0w2JfsG8b3ddgAsHh31pRANoW+z1r@mail.gmail.com>
Subject: Refusing SCO from non-connected headset
From: Mike <puffy.taco@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I get the following error when I try to dial a phone number from my
cell phone and am connected using HFP:

bluetoothd[14651]: audio/main.c:sco_server_cb() Refusing SCO from
non-connected headset

Here are my versions:

2.6.35-24-generic
bluez 4.86
ofono 0.39
dbus 1.4.0

Is this something that is supposed to work?  Known to almost work?  Do
I need a newer kernel?  Something that doesn't work that I can fix
given a pointer of what to look at?

Let me know if there is any more helpful debug information I can provide.

Thanks,

Mike
