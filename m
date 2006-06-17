Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0606131336450.23668@redbean.intranet.gw-instruments.de>
References: <Pine.LNX.4.63.0606131336450.23668@redbean.intranet.gw-instruments.de>
Date: Sat, 17 Jun 2006 12:30:02 +0200
Message-Id: <1150540202.17539.24.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] RFCOMM TTY behaviour
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Peter,

> we just had some discussion on the behaviour of the RFCOMM TTY driver with 
> some BlueZ users. The problem is that it is not realy possible to have 
> RFCOMM server ports when using the TTY driver (/dev/rfcommX). 
> 
> The suggested behaviour would be that a /dev/rfcommX device always exists 
> (like any normal tty device), no matter if a bluetooth connection to the 
> DLC exists or not. This would than much more act like a normal TTY. If 
> there is a Bluetooth connection the cable is plugged, if there is no 
> Bluetooth connection the cable is unplugged. 
> 
> After looking at the source of the RFC tty driver it should be possible to 
> make it work like this by a few changes: 
> Add a flag to the driver struct to make it a "server" port. 
> Change the tty open behaviour.
> Modify the tty write / ioctl functions to honour the actual connection 
> status (just do nothing / throw write data away if not connected). 
> 
> Question: is there anything I missed which would provide from doing a 
> described ?? 
> Is there any good other reason why the tty driver should act like it 
> currently does ?? 

the main API of RFCOMM is the socket. So I don't actually bother that
much with the TTY stuff. However patches are always welcome. Feel free
to provide actual code for the change you described.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
