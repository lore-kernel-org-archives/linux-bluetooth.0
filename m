Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1074287664.2559.422.camel@localhost>
References: <1074193649.2629.23.camel@pegasus>
	 <1074196213.2559.255.camel@localhost>  <1074197813.2629.52.camel@pegasus>
	 <1074287664.2559.422.camel@localhost>
Content-Type: text/plain
Message-Id: <1074302399.2629.137.camel@pegasus>
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
Date: Sat, 17 Jan 2004 02:19:59 +0100

Hi Max,

> > actually I never got bluefw working stable with 2.6. The usbfs interface
> > causes troubles which I can't explain. Maybe the problems are caused by
> > my hardware, but I don't know. I also want to avoid using bulk transfer
> > over ISOC endpoint to make OHCI happy and it seems that inside the
> > kernel there exists no more problems for the OHCI chips. 
> You mean Bulk over Interrupt. BlueFW doesn't send Bulk over Isoc.

of course. I mixed it, maybe because I talked about ISOC transfer and
the HCI USB driver problem on the Linux USB mailing list ;)

> > So after I made
> > my experiences with the request_firmware() interface and the bfusb
> > driver I decided to give it a try and the bcm203x driver was born.
> 
> I see. I have no problem with implementation in fact it's very clean and
> nice. My only concern is that if it can be done from user space it
> should be done in user-space thing :). I mean nobody is going to unload
> this bcm203x module after fw download is complete. Yeah it's small but
> it's still a waste. I'd rather fix usbfs if it's broken. Greg and
> Johannes will happily accept patches ;-). 

I simply agree with you on all points. If I found enough time to look at
my usbfs problems I will try to fix them.

On the other hand it is also possible to make the firmware loading
routine of the bcm203x driver a compile time option of the hci_usb
driver. Of course this is also a waste inside the kernel, but you don't
have an extra module to load. Do you think this is a better approach?

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
