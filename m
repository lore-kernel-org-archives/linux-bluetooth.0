Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm: permission denied
From: Marcel Holtmann <marcel@holtmann.org>
To: "Zbigniew Diaczyszyn (gmx)" <z.dia@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <000c01c3f0f6$e9a19e10$154db850@ULLA>
References: <000101c3ee91$fa205f40$f84ab850@ULLA>
	 <1076321608.6869.78.camel@pegasus>  <000c01c3f0f6$e9a19e10$154db850@ULLA>
Content-Type: text/plain
Message-Id: <1076542073.3041.40.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 12 Feb 2004 00:27:54 +0100

Hi Zbigniew,

> ----- Original Message ----- 
> 
> > > linux:~ # rfcomm connect 0 00:10:60:29:AC:2C
> > > Can't connect RFCOMM socket: Permission denied
> > 
> > this can't work. If you bind the device you don't need an additional
> > connect. You only have to open /dev/rfcomm0 with pppd or any other TTY
> > related program.
> --------------------------------------------------------
> Well, having done this (suse 8.2, ppp1 is directed to /dev/rfcomm0) the kinternet protocol tells that there is <no route to host>:
> 
> SuSE Meta pppd (smpppd-ifcfg), Version 1.00 on linux.
> trying to connect to smpppd
> connect to smpppd
> We are disconnected.
> We are connecting.
> pppd: Plugin passwordfd.so loaded.
> pppd: Failed to open /dev/rfcomm0: No route to host
> We are disconnected.
> pppd died: Serial port open failed (exit code 7)
> 
> the proprietary mask tells: crw-rw----         root dialout         /dev/rfcomm0

create a dump file with "hcidump -w <file>".

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
