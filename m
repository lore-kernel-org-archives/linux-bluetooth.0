Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] How to initiate a Pin-Exchange?
From: Marcel Holtmann <marcel@holtmann.org>
To: "Nicholas A. Preyss" <nalp@gmx.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040417140311.GA2532@gmx.net>
References: <200404142203.21126.panizzon@woody.ch>
	 <200404142211.55534.cijoml@volny.cz> <200404151149.35989.panizzon@woody.ch>
	 <200404151729.32798.cijoml@volny.cz> <20040415202106.GA17934@gmx.net>
	 <1082160503.4489.25.camel@pegasus>  <20040417140311.GA2532@gmx.net>
Content-Type: text/plain
Message-Id: <1082280336.4403.12.camel@pegasus>
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
Date: Sun, 18 Apr 2004 11:25:36 +0200

Hi Nicholas,

> What is security mode 3? AUTH and ENCRYPT ?
> What is wrong about it?

look at the Bluetooth specification or read my Bluetooth security paper.
What you really wan't is security mode 1/2 and setting auth and encrypt
is security mode 3.

> > You can use the D-Bus enabled hcid and bluez-pin package.
> 
> Anyone written some doc about this combination? I dont get it running..

Set "dbus_pin_helper" option in hcid.conf and run "bluez-pin --dbus" as
normal user.

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
