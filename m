Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Version 3 libs/utils
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Stephen Crane <steve.crane@rococosoft.com>, Philip Blundell <pb@nexus.co.uk>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030721172830.094837d0@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030717170310.0703eec8@unixmail.qualcomm.com>
	<1057107686.15797.101.camel@pegasus>
	<5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
	<1057107686.15797.101.camel@pegasus>
	<5.1.0.14.2.20030717170310.0703eec8@unixmail.qualcomm.com>
	<5.1.0.14.2.20030721172830.094837d0@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1058868378.24408.31.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 22 Jul 2003 12:06:11 +0200

Hi Max,

> >> >I quite like this idea, except the SDP server functionality won't be
> >> >needed for some devices (e.g., handhelds).
> >> Agreed.
> >
> >not agreed.
> >
> >Try to connect with a Windows machine to a Linux based handheld to
> >transfer files over OBEX. You need a SDP server on your Linux handheld.
> >Only the real client only devices need no SDP server and these are
> >special cases or applications.
> 
> I don't use OBEX and my laptop doesn't provide any other Bluetooth service.

but some laptops will provide Bluetooth services to others ;)

Anyway, if I remember correctly, the status channel of HCRP will
connected from the server to client. And the server ask the client for
the PSM of status channel by SDP.

And don't forget the stupid mRouter callback mechanism of the Symbian
Bluetooth phones.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
