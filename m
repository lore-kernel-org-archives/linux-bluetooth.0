Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BlueZ error in cc,cc,dc sequence
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200404162339.01392.cijoml@volny.cz>
References: <200404162339.01392.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1082159344.4489.1.camel@pegasus>
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
Date: Sat, 17 Apr 2004 01:49:04 +0200

Hi Michal,

> notas:/etc/hotplug# hcitool cc 00:0A:D9:FC:EC:51
> notas:/etc/hotplug# hcitool cc 00:0A:D9:FC:EC:51
> Can't create connection: Input/output error

you can't have to ACL links to the same remote device.

> notas:/etc/hotplug# hcitool cc 00:0A:D9:FC:EC:51
> Can't create connection: Input/output error
> notas:/etc/hotplug# hcitool cc 00:0A:D9:FC:EC:51
> Can't create connection: Input/output error
> notas:/etc/hotplug# hcitool dc 00:0A:D9:FC:EC:51
> Not connected.
> notas:/etc/hotplug# hcitool dc 00:0A:D9:FC:EC:51
> Not connected.
> notas:/etc/hotplug# hcitool cc 00:0A:D9:FC:EC:51
> Can't create connection: Input/output error
> notas:/etc/hotplug# hcitool dc 00:0A:D9:FC:EC:51
> Not connected.
> 
> But device is connected

Check with "hcitool con" every time, because this is what the kernel
sees and "hcitool dc" only sends the raw HCI_Disconnect command.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
