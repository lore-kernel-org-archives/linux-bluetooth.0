Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?ISO-8859-2?Q?Szab=F3_Zolt=E1n?= <szz@freemail.hu>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] 3CRWB6096 PCMCIA card
Message-Id: <20050526075425.77237420.szz@freemail.hu>
In-Reply-To: <1117055231.12036.6.camel@pegasus>
References: <20050523165711.055d97c2.szz@freemail.hu>
	<1116857587.30044.84.camel@pegasus>
	<20050523195921.07267820.szz@freemail.hu>
	<1116871922.30044.126.camel@pegasus>
	<20050525231540.79e3034b.szz@freemail.hu>
	<1117055231.12036.6.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Date: Thu, 26 May 2005 07:54:25 +0200

Hi Marcel,

> insert the card and see what happens. Check dmesg for details.
NET: Unregistered protocol family 31
Bluetooth: Core ver 2.6
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized

And after a few seconds:
[ACPI Debug] String: [0x12] "=====QUERY_42====="
bt3c_open: Firmware request failed
bt3c_interrupt: Call of irq 3 for unknown device
---

Is it possible to test the hotplug system via some manual commands?

Regards,

Zol




-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
