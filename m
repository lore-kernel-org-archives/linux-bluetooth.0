Return-Path: <z.dia@gmx.de>
Message-ID: <000c01c3f0f6$e9a19e10$154db850@ULLA>
From: "Zbigniew Diaczyszyn \(gmx\)" <z.dia@gmx.de>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: <bluez-users@lists.sourceforge.net>
References: <000101c3ee91$fa205f40$f84ab850@ULLA> <1076321608.6869.78.camel@pegasus>
Subject: Re: [Bluez-users] rfcomm: permission denied
Date: Thu, 12 Feb 2004 00:29:32 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-ID: <bluez-users.lists.sourceforge.net>

Hallo Marcel,

----- Original Message -----=20

> > linux:~ # rfcomm connect 0 00:10:60:29:AC:2C
> > Can't connect RFCOMM socket: Permission denied
>=20
> this can't work. If you bind the device you don't need an additional
> connect. You only have to open /dev/rfcomm0 with pppd or any other TTY
> related program.
--------------------------------------------------------
Well, having done this (suse 8.2, ppp1 is directed to /dev/rfcomm0) the =
kinternet protocol tells that there is <no route to host>:

SuSE Meta pppd (smpppd-ifcfg), Version 1.00 on linux.
trying to connect to smpppd
connect to smpppd
We are disconnected.
We are connecting.
pppd: Plugin passwordfd.so loaded.
pppd: Failed to open /dev/rfcomm0: No route to host
We are disconnected.
pppd died: Serial port open failed (exit code 7)

the proprietary mask tells: crw-rw----         root dialout         =
/dev/rfcomm0
