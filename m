Return-Path: <mark@thummb.com>
From: "Mark Coetser" <mark@thummb.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Using my linux box as an internet gateway for myi-mate/xda
Date: Sun, 24 Oct 2004 13:54:07 +0200
Message-ID: <000401c4b9c0$2b053f00$f500000a@citadel>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <1098618444.6465.1.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel

This is my core firewall and policy is that we use stable, except for
certain packages which are backported for functionality, surely this
should work on debian woody anyway ? 

Mark Adrian Coetser
http://www.thummb.com
Cel: 0833046633

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org] 
Sent: 24 October 2004 01:47 PM
To: Mark Coetser
Cc: BlueZ Mailing List
Subject: Re: [Bluez-users] Using my linux box as an internet gateway for
myi-mate/xda


Hi Mark,

> System info
> 
> Debian woody
> 
> Uname -a
> Linux fw1.mid 2.6.7 #1 SMP Sat Oct 23 12:41:48 SAST 2004 i686 unknown
> 
> dpkg -l | grep bluez
> ii  bluez-hcidump  1.5-2          Analyses Bluetooth HCI packets
> ii  bluez-pan      1.1rel-1       Personal area networking for
Bluetooth
> devic
> ii  bluez-sdp      1.1-1          BlueZ Bluetooth SDP daemon and tool
> ii  bluez-utils    2.3-1.woody.1  Utilities for controlling Bluetooth
> devices

maybe this will work with Debian Woody, but these versions of the BlueZ
userspace utilities are outdated. I think you should better switch to
Debian Sarge.

Regards

Marcel
