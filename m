Return-Path: <cijoml@volny.cz>
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] another hibernate warning
Date: Fri, 17 Sep 2004 12:41:22 +0200
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200409171209.47267.cijoml@volny.cz> <200409171223.18547.cijoml@volny.cz> <1095417162.3280.46.camel@pegasus>
In-Reply-To: <1095417162.3280.46.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200409171241.22645.cijoml@volny.cz>
List-ID: <bluez-users.lists.sourceforge.net>

Dne p=E1 17. z=E1=F8=ED 2004 12:32 Marcel Holtmann napsal(a):
> Hi Michal,
>
> > > > when hibernate compiled into kernel, this is written into dmesg:
> > > > hci_usb: Unknown symbol hci_free_dev
> > > > hci_usb: Unknown symbol hci_alloc_dev
> > > > hci_usb: Unknown symbol hci_unregister_dev
> > > > hci_usb: Unknown symbol hci_register_dev
> > > >
> > > > dongle works fine
> > >
> > > this is not hibernate specific. I have seen this many times, but the
> > > module still gets loaded at some point. Maybe this has something to do
> > > with the MODULE_VERSION macro we use, but I am not sure. If you load
> > > the bluetooth.ko from a boot script you won't see this anymore.
> >
> > hotplug loads it for me when booting and still see this...
>
> this must be timing problem of the kernel module loader or something
> like that. The reason why this works is because hci_usb will be loaded
> two or three times by hotplug. Once for every interface. Do you wanna
> track this problem down? I am happy if someone do.
>
> Regards
>
> Marcel

So help me how to step boot scripts. Something like F8 when old MS-DOS boot=
ed=20
and scripts were started...

M.
