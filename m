Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Connection dropped or cannot connect
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean-Pierre Lord <jeanplord@videotron.ca>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <000801c41e98$9e75d080$0100a8c0@terre>
References: <000801c41e98$9e75d080$0100a8c0@terre>
Content-Type: text/plain
Message-Id: <1081592935.3028.3.camel@pegasus>
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
Date: Sat, 10 Apr 2004 12:28:55 +0200

Hi Jean-Pierre,

> My Linux box has a Anycom usb-220 bluetooth adapter connected to it
> which is used to serve my iPAQ1940.  Works "superbly great" except
> those times it won't work at all ;-).  Either a long connection (like
> a download) will be cut or i will not be able to open a new
> connection.  When it happens, i have 2 choices: unplung the bluetooth
> adapter for a few seconds (which requires no other intervention on the
> software side) and replug it or reset the device using hciconfig. 
> Except that doing this reset will sometimes crash the hole Linux box. 
> I then get a stack dump and once i got a message that looked like
> this: "...killing interrupt handler...".  Sorry i wasn't fast enough
> to write down the message.

this message is important and you should try to get it over a serial
console. Please try a 2.4.25-mh3 or a 2.4.26-rc2. Maybe there is already
a fix for it.
 
> I'm running "Kernel 2.4.24-mh2 on an i586" with bluez-libs-2.5,
> bluez-sdp-1.5, bluez-utils-2.5.  I normally run hcid, sdpd, "dund
> --listen --msdun call dun".  It seems to me that enabling
> authentification and encryption has made the whole thing less
> reliable.

Setting auth and encrypt switches to security mode 3 which is not what
your really want.

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
