Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem with connection between two pc using
	bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: Dirk Vornheder <DVornheder@t-online.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402131919.56303.dvornheder@t-online.de>
References: <1ArCh7-0SGjjc0@cmpmail09.bbul.t-online.de>
	 <1076585404.2671.2.camel@pegasus>
	 <200402131919.56303.dvornheder@t-online.de>
Content-Type: text/plain
Message-Id: <1076697866.2671.210.camel@pegasus>
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
Date: Fri, 13 Feb 2004 19:44:26 +0100

Hi Dirk,

> After using
> 
> pand --connect 00:04:0E:85:35:15
> 
> instead of 
> 
> pand --search
> 
> on both pc's everything works fine.

looks like a role switch or scatternet problem. If you are using
connect, there is no inquiry and no SDP request. Is the firmware on the
AP-ISDN the latest?

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
