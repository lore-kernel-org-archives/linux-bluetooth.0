Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] 3CRWB6096 PCMCIA card
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050526075425.77237420.szz@freemail.hu>
References: <20050523165711.055d97c2.szz@freemail.hu>
	 <1116857587.30044.84.camel@pegasus>
	 <20050523195921.07267820.szz@freemail.hu>
	 <1116871922.30044.126.camel@pegasus>
	 <20050525231540.79e3034b.szz@freemail.hu>
	 <1117055231.12036.6.camel@pegasus>
	 <20050526075425.77237420.szz@freemail.hu>
Content-Type: text/plain
Message-Id: <1117094500.12036.8.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 26 May 2005 10:01:40 +0200

Hi Zol,

> > insert the card and see what happens. Check dmesg for details.
> NET: Unregistered protocol family 31
> Bluetooth: Core ver 2.6
> NET: Registered protocol family 31
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> 
> And after a few seconds:
> [ACPI Debug] String: [0x12] "=====QUERY_42====="
> bt3c_open: Firmware request failed
> bt3c_interrupt: Call of irq 3 for unknown device
> ---
> 
> Is it possible to test the hotplug system via some manual commands?

not really. Check your firmware.agent script that it really looks
in /lib/firmware for the 3Com firmware and that this firmware has not
the filesize 0.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
