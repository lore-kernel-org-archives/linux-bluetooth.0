Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] usb to serial verification
From: Marcel Holtmann <marcel@holtmann.org>
To: Torez Smith <torez@us.ibm.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <OFFB852EAA.3DE1580F-ON87256E36.00730EA0-86256E36.00738AB6@us.ibm.com>
References: 
	 <OFFB852EAA.3DE1580F-ON87256E36.00730EA0-86256E36.00738AB6@us.ibm.com>
Content-Type: text/plain
Message-Id: <1076452078.2777.24.camel@pegasus>
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
Date: Tue, 10 Feb 2004 23:27:58 +0100

Hi Torez,

> is there a way to determine if your usb to serial profile is working?

there is no USB to serial profile.

> I have a usb bluetooth dongle on one machine and a serial dongle
> connected to comm1 on another machine. I am able to pair the two
> dongles and have connected the usb dongle to /dev/rfcomm0.

What kind of serial dongle is this? Normal serial dongles must be
attached with hciattach.

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
