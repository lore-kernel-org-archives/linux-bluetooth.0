Return-Path: <cijoml@volny.cz>
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] another hibernate warning
Date: Fri, 17 Sep 2004 12:40:29 +0200
Cc: Marcel Holtmann <marcel@holtmann.org>
References: <200409171209.47267.cijoml@volny.cz> <1095416145.3280.41.camel@pegasus>
In-Reply-To: <1095416145.3280.41.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200409171240.29603.cijoml@volny.cz>
List-ID: <bluez-users.lists.sourceforge.net>

Dne p=E1 17. z=E1=F8=ED 2004 12:15 Marcel Holtmann napsal(a):
> Hi Michal,
>
> > when hibernate compiled into kernel, this is written into dmesg:
> > hci_usb: Unknown symbol hci_free_dev
> > hci_usb: Unknown symbol hci_alloc_dev
> > hci_usb: Unknown symbol hci_unregister_dev
> > hci_usb: Unknown symbol hci_register_dev
> >
> > dongle works fine
>
> this is not hibernate specific. I have seen this many times, but the
> module still gets loaded at some point. Maybe this has something to do
> with the MODULE_VERSION macro we use, but I am not sure. If you load the
> bluetooth.ko from a boot script you won't see this anymore.
>
> Regards
>
> Marcel

I never seen it before I started to play with hibernate. After compiling in=
to=20
kernel hibernation mode, this started to be shown.

M.
