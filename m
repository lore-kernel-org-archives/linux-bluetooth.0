Return-Path: <cijoml@volny.cz>
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] another hibernate warning
Date: Fri, 17 Sep 2004 12:23:18 +0200
References: <200409171209.47267.cijoml@volny.cz> <1095416145.3280.41.camel@pegasus>
In-Reply-To: <1095416145.3280.41.camel@pegasus>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200409171223.18547.cijoml@volny.cz>
List-ID: <bluez-users.lists.sourceforge.net>

Dne p=E1 17. z=E1=F8=ED 2004 12:15 jste napsal(a):
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

hotplug loads it for me when booting and still see this...

M.
