Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1074196213.2559.255.camel@localhost>
References: <1074193649.2629.23.camel@pegasus>
	 <1074196213.2559.255.camel@localhost>
Content-Type: text/plain
Message-Id: <1074197813.2629.52.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: BCM2033 firmware loader
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
Date: Thu, 15 Jan 2004 21:16:53 +0100

Hi Max,

> What's wrong with BlueFW ? Why did you implement BCM FW loader in the
> kernel ?
> I looked in the archive and the only thing I could find was that you
> don't want to keep it without an explanation why.

actually I never got bluefw working stable with 2.6. The usbfs interface
causes troubles which I can't explain. Maybe the problems are caused by
my hardware, but I don't know. I also want to avoid using bulk transfer
over ISOC endpoint to make OHCI happy and it seems that inside the
kernel there exists no more problems for the OHCI chips. So after I made
my experiences with the request_firmware() interface and the bfusb
driver I decided to give it a try and the bcm203x driver was born.

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
