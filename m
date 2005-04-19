Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] connecting linux laptop to a three-wire RS232
	device via bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <86mzrv7f6a.fsf@coulee.tdb.com>
References: <86mzrv7f6a.fsf@coulee.tdb.com>
Content-Type: text/plain
Message-Id: <1113872979.16233.156.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 19 Apr 2005 03:09:39 +0200

Hi Russell,

> I am looking for hardware recommendations for both ends of a bluetooth
> link between a Linux (kernel v2.6.11) laptop and a serial DCE device
> (9600 baud no-flow-control three-wire RS232).  I am assuming a USB
> part (the laptop has a USB 1.x port) for the laptop and some kind of
> serial-bluetooth converter for the device end.  We'll need to provide
> battery power (it is a mobile application and won't have line power)
> to the serial-bluetooth converter.
> 
> I'd like recommendations on both parts.  I think we'll need Class 1
> devices for the range.
> 
> For the serial-bluetooth converter, we have looked at the: Brainboxes
> BL-512; the Free2Move F2M01C1; the BRADATECH BlueSerial Adapter; and
> the Digi Wavespeed/S (we found less information on this one).
> 
> The only lead I have on the USB side is that we probably want a CSR
> chipset (??).  Can someone point me at some of those?

I didn't tested any Bluetooth-Serial converters, but for the laptop
equipment you should really get a CSR based USB dongle. You may simply
go with the D-Link DBT-120, because this is known to be upgradable to
the Bluetooth 1.2 standard.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
