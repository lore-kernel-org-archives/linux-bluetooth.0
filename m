Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] itec CF dongle and PCMCIA reduction
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200401252215.59732.cijoml@volny.cz>
References: <200401252215.59732.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1075072311.18967.8.camel@pegasus>
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
Date: Mon, 26 Jan 2004 00:11:51 +0100

Hi Michal,

> in one shop in Czech Republic, there they have very cheap BT CF card from 
> iTec.
> This card has CF<->PCMCIA reduction.
> 
> Will this work with BlueZ?

in general all of these cards are serial PCMCIA cards with a specific
UART and Bluetooth chip inside. First goal is to make these cards work
with the serial_cs driver and then you must find the correct settings
for the hciattach command. Baudrate, H4 or BCSP etc.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
