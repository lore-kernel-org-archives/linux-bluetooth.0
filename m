Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] i-Tec Bluetooth USB dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: Rudolf Matousek <matousek@utia.cas.cz>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4028818C.1070109@utia.cas.cz>
References: <4028818C.1070109@utia.cas.cz>
Content-Type: text/plain
Message-Id: <1076401303.32750.6.camel@pegasus>
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
Date: Tue, 10 Feb 2004 09:21:43 +0100

Hi Rudolf,

> I've recently purchased i-Tec USB dongle. Before the purchase, I checked 
> that the dongle is supported by linux Bluez.
> 
> Unfortunatelly, the dongle I purchased has different chipset from the 
> dongle announced as functional. The chipset is Broadcom with Vendor Id: 
> 0a5c and Product Id: 200a.

this is not a Broadcom dongle in firmware mode, because it must have id
0a5c:2033. After the firmware was loaded the id is 0a5c:2001.

What is the content of /proc/bus/usb/devices ?

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
