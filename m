Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] ISSC USB Dongle does not work with current bluez?
From: Marcel Holtmann <marcel@holtmann.org>
To: Andreas Krause <Andreas.Krause@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200407231251.27478.Andreas.Krause@web.de>
References: <200407222124.44032.Andreas.Krause@web.de>
	 <200407231230.50970.Andreas.Krause@web.de>
	 <1090579307.4791.12.camel@pegasus>
	 <200407231251.27478.Andreas.Krause@web.de>
Content-Type: text/plain
Message-Id: <1090579838.4791.20.camel@pegasus>
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
Date: Fri, 23 Jul 2004 12:50:38 +0200

Hi Andreas,

> > > And here's the dump for "hcitool inq":
> > > < HCI Command: Inquiry (0x01|0x0001) plen 5
> > >   33 8B 9E 08 64
> > > > HCI Event: Command Status (0x0f) plen 4
> > >   00 01 01 04
> > 
> > I miss the inquiry complete event.
> 
> There's no other output. 'hcitool scan' terminates with "Inquiry failed: 
> Connection timed out". No other events shown by hcidump. Sorry.

very nice :(

Another buggy Bluetooth chip with a stupid link manager. Is it really so
hard to get a correct HCI implementation before manufacturing end-user
products?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
