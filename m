Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] usb to serial verification
From: Marcel Holtmann <marcel@holtmann.org>
To: Torez Smith <torez@us.ibm.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <OF5A385DC1.2BE48959-ON87256E36.007C6942-86256E36.007CBA73@us.ibm.com>
References: 
	 <OF5A385DC1.2BE48959-ON87256E36.007C6942-86256E36.007CBA73@us.ibm.com>
Content-Type: text/plain
Message-Id: <1076456996.2777.55.camel@pegasus>
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
Date: Wed, 11 Feb 2004 00:49:56 +0100

Hi Torez,

> The serial dongle is a BT125S dongle. It's connected to a com port on
> a
> linux box. Theoretically, I should be able to cat /dev/ttyS0 on that
> linux box
> to read the data coming across from the usb dongle. 

this was not my question. Maybe I should be more specific. Is this
serial dongle a simply host adapter or a full "cable replacement"
product?

> Do I still need to hciattach the serial dongle on the linux box? 

If it is a host adapter then you have to attach to your Bluetooth stack
and you must use RFCOMM on both sides.

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
