Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] l2ping Can't connect.: Permission denied
From: Marcel Holtmann <marcel@holtmann.org>
To: Ullrich Martini <mailbox@ullrich.martini.name>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403232243.25854.mailbox@ullrich.martini.name>
References: <200403232153.26004.mailbox@ullrich.martini.name>
	 <1080076647.2515.47.camel@pegasus>
	 <200403232243.25854.mailbox@ullrich.martini.name>
Content-Type: text/plain
Message-Id: <1080080941.2515.50.camel@pegasus>
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
Date: Tue, 23 Mar 2004 23:29:01 +0100

Hi Ullrich,

> # l2ping  00:04:0E:84:15:F5
> > HCI Event: Command Status(0x0f) plen 4
>   00 01 05 04
> > HCI Event: Connect Complete(0x03) plen 11
>   05 0C 00 F5 15 84 0E 04 00 01 00

this is an authentication error. Disable auth and encrypt in hcid.conf
and let the AP trigger the authentication.

What firmware version is on your AP?

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
