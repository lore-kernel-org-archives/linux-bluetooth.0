Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Bluez-users] bt3c_cs time out - no firmware loaded?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: Krisztian Mark Szentes <office@produktivIT.com>, BlueZ Mailing List <bluez-users@lists.sourceforge.net>, Edd Dumbill <ejad@debian.org>
In-Reply-To: <1053092394.26552.132.camel@pegasus>
References: 
	<53B03DA73719D5119E6A0008C71E1D78030EA9A3@svr-mail1.corp.home.nl>
	<200305131047.39294.office@produktivIT.com>
	<1053083095.26552.49.camel@pegasus>
	<200305161438.08919.office@produktivIT.com>
	<1053091452.2561.86.camel@gaston>  <1053091839.26550.125.camel@pegasus>
	<1053091938.2978.88.camel@gaston>  <1053092394.26552.132.camel@pegasus>
Content-Type: text/plain
Message-Id: <1053092826.2561.90.camel@gaston>
Mime-Version: 1.0
Date: 16 May 2003 15:47:06 +0200
Sender: Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <bluez-users.lists.sourceforge.net>


> an ioctl is not possible at that time, because we need the firmware
> loaded before we can initialise the Bluetooth HCI device. And I don't
> want to use the /proc for this kind of stuff. We hopefully will have a
> unified interface for this in 2.5 with request_firmware() call and the
> sysfs. See current discussion on LKML.

Then a /proc entry or a temporary /dev entry will be the only sane
solution for 2.4 I'm afraid...

Ben.
