Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] problems with nc6 with bluez support
From: Marcel Holtmann <marcel@holtmann.org>
To: Mauro Tortonesi <mtortonesi@ing.unife.it>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200401221127.57516.mtortonesi@ing.unife.it>
References: <200401221042.53134.mtortonesi@ing.unife.it>
	 <200401221127.57516.mtortonesi@ing.unife.it>
Content-Type: text/plain
Message-Id: <1074770040.19046.1.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 22 Jan 2004 12:14:00 +0100

Hi Mauro,

> sorry, i sent the email before it was finished :-( i was saying that when i 
> try to perform data tranfers over sco the bluez/usb subsystem on the 
> receiving host hangs: my dlink dbt120 usb dongle is shut down (the 2 leds 
> switch off) and the system does not recognize it anymore even if i unplug it 
> and plug it in again. and if i then replace the dlink dbt120 with an anycom 
> 220 usb dongle nothing changes: the green led of the anycom dongle lits but 
> the usb subsystem does not even recognize the peripheral.
> 
> the system keeps refusing to recognize usb dongles even if i unload and reload 
> the hci_usb, bluez, sco and l2cap modules and the hcid and sdpd daemons. 
> 
> how can i solve these problesm? do you have any clues?

as already told, SCO is not for data transfer. But show us the output of
"hciconfig hci0 version" and "hciconfig hci0 revision" (as root).

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
