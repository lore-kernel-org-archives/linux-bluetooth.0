Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] RFCOMM Question
From: Marcel Holtmann <marcel@holtmann.org>
To: Kasimir =?ISO-8859-1?Q?M=FCller?= <Kasimir.Mueller@t-online.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <403B7FA5.4050607@gmx.de>
References: <403B7FA5.4050607@gmx.de>
Content-Type: text/plain
Message-Id: <1077642423.2919.18.camel@pegasus>
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
Date: Tue, 24 Feb 2004 18:07:03 +0100

Hi Kasimir,

> 1.) How many RFCOMM-Connections can be made to a single usb-Stick on Linux

you can have up to 30 connections per direction per ACL link.

> 2.) Is there a timeout which closes the connection, if there ist no 
> traffic for a certain time.

No.

> We plan to connect 10 devices via serial connections to a single server
> to transmit periodically data.

This is different from the number of RFCOMM connections, because you can
only connect up to 7 seven active slaves at the same time. But with each
slave you can have 30 RFCOMM connection in each direction.

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
