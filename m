Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-user@schaettgen.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] passive inquiry
References: <20041217141809.62713.qmail@web40605.mail.yahoo.com>
In-Reply-To: <20041217141809.62713.qmail@web40605.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412171534.03946.bluez-user@schaettgen.de>
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
Date: Fri, 17 Dec 2004 15:34:03 +0100

On Friday 17 December 2004 15:18, Paolino paperino wrote:
> Hi,
> i want to know if it is possible to make a "passive
> inquiry", i explain better, a device A do an inquiry
> no find their neighbours, it is possible for a device
> B (in the reachability field) to know that was
> inquiried by device A? The applican can receive an
> event each time the device is inquiried?

No, that is not possible in general. 
The bluetooth chip responds to the inquiry without generating any HCI events. 
You can see SDP requests, since those are handled by the Bluetooth stack, but 
that won't help you much I guess. Maybe there are vendor-specific commands to 
make that possible, but I don't know about any.

Fred

-- 
Fred Schaettgen
bluez-devel@schaettgen.de


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
