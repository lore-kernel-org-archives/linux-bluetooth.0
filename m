Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] i-Tec Bluetooth USB dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: Rudolf Matousek <matousek@utia.cas.cz>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40289CAA.8050204@utia.cas.cz>
References: <4028818C.1070109@utia.cas.cz>
	 <1076401303.32750.6.camel@pegasus>  <402895E4.4040500@utia.cas.cz>
	 <1076402023.32750.17.camel@pegasus>  <40289CAA.8050204@utia.cas.cz>
Content-Type: text/plain
Message-Id: <1076405681.32750.26.camel@pegasus>
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
Date: Tue, 10 Feb 2004 10:34:41 +0100

Hi Rudolf,

> I don't see any of these devices when dongle is unplugged. All these 
> devices are definitely integrated in the dongle.
> 
> I guess that the chip may be Broadcom 2035 (see serial no.).
> 
> This is the output of the hciconfig:
> 
> hci0:   Type: USB
>          BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>          DOWN
>          RX bytes:0 acl:0 sco:0 events:0 errors:0
>          TX bytes:3 acl:0 sco:0 commands:1 errors:0
> 
> # hciconfig hci0 up
> Can't init device hci0. Connection timed out(110)
> 
> # dmesg after dongle insertion
> hub.c: new USB device 00:07.2-2.4, assigned address 15
> hub.c: USB hub found
> hub.c: 3 ports detected
> hub.c: new USB device 00:07.2-2.4.1, assigned address 16
> hub.c: new USB device 00:07.2-2.4.2, assigned address 17
> input: USB HID v1.11 Keyboard [0a5c:0099] on usb1:17.0
> hub.c: new USB device 00:07.2-2.4.3, assigned address 18
> input: USB HID v1.11 Mouse [0a5c:0097] on usb1:18.0
> 
> # /var/log/daemon.log removal and insertion
> 
> Feb 10 09:54:22 Cipisek hcid[739]: HCI dev 0 unregistered
> Feb 10 09:54:36 Cipisek hcid[739]: HCI dev 0 registered
> Feb 10 09:54:46 Cipisek hcid[10193]: Can't init device hci0. Connection 
> timed out(110)
> 
> If you wish, I can create an account on my machine and you can try to 
> dig in by yourself. Maybe you will be much more sucessful.

thanks for the offer, but I can't do anything without proper information
about these dongle. You must log the USB traffic on a Windows machine
with USB SnoopyPro (http://sourceforge.net/projects/usbsnoop/). There
must be some kind of firmware loading or switching stuff to make these
dongle working.

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
