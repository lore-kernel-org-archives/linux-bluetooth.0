Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problems switching usb dongles...
From: Marcel Holtmann <marcel@holtmann.org>
To: Anthony Yulo <strikewing16th@hotmail.com>
Cc: bluez devel <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Law11-OE54SB2qgrZCT0000dbb9@hotmail.com>
References: <Law11-OE54SB2qgrZCT0000dbb9@hotmail.com>
Content-Type: text/plain
Message-Id: <1074452313.6070.7.camel@pegasus>
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
Date: Sun, 18 Jan 2004 19:58:33 +0100

Hi Anthony,

> Hi! I have a problems switching usb dongles...
> When i installed bluez the bluetooth dongle i used is the one made by
> TDK... now when i tried using a different dongle, a Billionton class
> B, it seems linux cannot startup the bluetooth system...
>  
> i.e.
> "hciconfig hci0 up"
>  
> linux outputs a messaging saying the device is not present or not
> connected.... when i switch back to the TDK dongle, then it was ok... 

maybe this is the same problems others saw already with some dongles on
an UHCI USB host controller. Unload and reload the [usb-]uhci.o driver.

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
