Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem with slow Speed of Socket CF Card
From: Marcel Holtmann <marcel@holtmann.org>
To: Wolfgang =?ISO-8859-1?Q?M=FCes?= <wolfgang@iksw-muees.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200405291047.20701.wolfgang@iksw-muees.de>
References: <200405291047.20701.wolfgang@iksw-muees.de>
Content-Type: text/plain
Message-Id: <1085821206.3932.11.camel@pegasus>
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
Date: Sat, 29 May 2004 11:00:06 +0200

Hi Wolfgang,

> I am using the Socket Communications CF Card Rev. G with the CSR chipset 
> and the bcsp protocol in my Zaurus C750 with Kernel 2.4.18.
> It is working fine (thank you, guys).
> 
> hicattach opens the card with a speed of 230 KBit/s. This is the speed 
> the CSR chipset is initialized after reset. I am using PAN, and I get a 
> file transfer rate of about 150 KBit/s. With other bluetooth devices 
> (USB dongle) I get about 550-600 KBit/s.
> 
> I have asked Socket Communications if the card is limited to slow 
> baudrates, and they have answered me that this card is able to perform 
> about 730 KBit/s under ideal conditions.
> 
> Obviously, this is not possible with a serial UART and 230 KBit/s.
> So there must be a speed change command, and I want to use it.
> 
> Can anybody give me some usefull advice how to proceed? 
> I am able to write/change kernel drivers, but I have no hint where to 
> start and how to get the speed change information in the bcsp protocol.

this is simple. Try "hciattach <dev> socket 460800".

Look at the manpage and the source code of hcitattch, because the kernel
hasn't really to do anything with it.

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
