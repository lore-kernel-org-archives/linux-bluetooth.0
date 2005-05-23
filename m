Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] DBUS service support - Initial library
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0505201404d05e818@mail.gmail.com>
References: <1115901694.18499.32.camel@pegasus>
	 <Pine.LNX.4.33.0505121821020.3523-100000@redbean.intranet.gw-instruments.de>
	 <e1effdeb0505201404d05e818@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1116844053.30044.59.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 23 May 2005 12:27:33 +0200

Hi Claudio,

> I am sending a initial skeleton of pand DBUS support. I was not able to
> access BlueZ CVS due firewall permissions.
> 
> The path is based on bluez-utils-2.17.

no problem the 2.17 is quite up-to-date.

> Suggestions and comments are welcome!

please use only the file dbus.c and put needed function prototypes into
pand.h. The dbus_services.h is not needed. Put the declarations into
dbus.c.

Don't provide and "hcid" service within pand. If you wanna provide HCI
task then hide them inside the pand D-Bus. Use org.bluez.pand as base
name for all stuff.

Never use dev_id. You can use the source Bluetooth address instead and
then convert it to dev_id internally. Don't use bdaddr_t at all. Simply
use the string representation of the Bluetooth device address.

Don't use char to represent an one byte value. Use uint8_t.

Once if we agree on the changes to Makefile.am, pand.h and main.c, then
I can commit a simple framework with an empty dbus.c and you only need
to send me changes to dbus.c from then on.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
