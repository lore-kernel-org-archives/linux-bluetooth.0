Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem with slow Speed of Socket CF Card
From: Marcel Holtmann <marcel@holtmann.org>
To: Wolfgang =?ISO-8859-1?Q?M=FCes?= <wolfgang@iksw-muees.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200405291139.54618.wolfgang@iksw-muees.de>
References: <200405291047.20701.wolfgang@iksw-muees.de>
	 <1085821206.3932.11.camel@pegasus>
	 <200405291139.54618.wolfgang@iksw-muees.de>
Content-Type: text/plain
Message-Id: <1085824617.3932.34.camel@pegasus>
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
Date: Sat, 29 May 2004 11:56:58 +0200

Hi Wolfgang,

> > this is simple. Try "hciattach <dev> socket 460800".
> 
> Been there - done that.
> 
> "BCSP initalisation timed out"
> 
> 230400 Baud is the only baud rate which is working. Do I need a special
> version of the hciattach utility?

check the mailing list archives for a thread about BCSP and changing the
baud rate. This is not very easy and the CSR guys explained it in very
details.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
