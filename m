Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Device specific pins
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Henriksen <dhenriksen@optibrand.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075153448.2906.2.camel@linux.local>
References: <1075153448.2906.2.camel@linux.local>
Content-Type: text/plain
Message-Id: <1075151423.25442.135.camel@pegasus>
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
Date: Mon, 26 Jan 2004 22:10:23 +0100

Hi Dave,

> Just wondering if there is any way to have pins that vary depending upon
> what device you are connecting to.   Currently, I just use
> /etb/bluetooth/givepin to supply a pin, but this pin must be the same
> for every device that my Linux laptop connects to.

this is a planned future for the new security manager which also
includes one-time PIN codes.

For the current version you must do it by yourself in a pin-helper
script. The BD_ADDR of the remote device is one of the parameters.

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
