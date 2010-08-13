Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oneukum@suse.de>
To: Ville Tervo <ville.tervo@iki.fi>
Subject: Re: resending patch to retry reset in case it failed
Date: Fri, 13 Aug 2010 15:56:22 +0200
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth" <linux-bluetooth@vger.kernel.org>,
	"linux-usb" <linux-usb@vger.kernel.org>
References: <201008120944.49044.oneukum@suse.de> <201008121416.31808.oneukum@suse.de> <AANLkTi=odMckPT4pAOiQJm+1NWbk0diL=-9=yKBfj66W@mail.gmail.com>
In-Reply-To: <AANLkTi=odMckPT4pAOiQJm+1NWbk0diL=-9=yKBfj66W@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201008131556.22623.oneukum@suse.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Freitag, 13. August 2010, 15:20:08 schrieb Ville Tervo:
> On Thu, Aug 12, 2010 at 8:16 AM, Oliver Neukum <oneukum@suse.de> wrote:
> > Am Donnerstag, 12. August 2010, 13:25:23 schrieb Marcel Holtmann:
> >> Hi Oliver,
> >>
> >> > may I ask what happened to this patch?
> >> > Do you take it, want modifications or reject it?
> >> >
> >> >     Regards
> >> >             Oliver
> >> >
> >> > From af61f0663f095599003290b13ad6fadee1d4fb25 Mon Sep 17 00:00:00 2001
> >> > From: Oliver Neukum <oliver@neukum.org>
> >> > Date: Tue, 6 Jul 2010 08:08:42 +0200
> >> > Subject: [PATCH] bluetooth: retry reset for devices that fail
> >> >
> >> > Some devices fail to reset properly at the first attempt to reset
> >> > them under unknown circumstances. Failures can be identified by
> >> > an invalid btaddr. Retry in those cases.
> >>
> >> I was pondering about it and haven't really made up my mind with this
> >> stuff. To be honest, I don't like the patch a little bit. I can see your
> >> point why you want it, but the patch is a bit too ugly for my taste.
> >
> > I am very open to alternatives. But without that it is needed to make the
> > hardware work.
> >
> >> Tell me which device is causing this and I might be able to reproduce
> >> this and find small less ugly fix.
> >
> >
> > I happens with this hardware from Broadcom. There may be others I don't
> > know about. It is an internal dongle. I don't know whether it can be found in
> > external hardware.
> >
> 
> Could you share also "hciconfig hci0 revision" and "hciconfig hci0
> version" info. And laptop model you have the chip build in.

The device reported:

localhost:/tmp # hciconfig hci0 version
hci0:	Type: USB
	BD Address: 00:27:13:98:49:7E ACL MTU: 1021:8 SCO MTU: 64:1
	HCI Ver: 3.0 (0x5) HCI Rev: 0x1e1 LMP Ver: 3.0 (0x5) LMP Subver: 0x4203
	Manufacturer: Broadcom Corporation (15)
localhost:/tmp # hciconfig hci0 revision
hci0:	Type: USB
	BD Address: 00:27:13:98:49:7E ACL MTU: 1021:8 SCO MTU: 64:1
	Firmware 225.66 / 3

The laptop is a prototype. All laptops it was installed in showed the same
problem.

	Regards
		Oliver
