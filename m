Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Help, Xscale-based Linux machin cannot use
	Bluetooth USB  dongle ^^;;;
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Cc: heejune@snut.ac.kr
In-Reply-To: <1106071c70101.heejune@snut.ac.kr>
References: <1106071c70101.heejune@snut.ac.kr>
Content-Type: text/plain
Message-Id: <1103980267.8758.23.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 25 Dec 2004 14:11:07 +0100

Hi,

> I have problem using Bluetooth USB Dongle in a Xscale-based Linux
> machine.
> The bluez official site announces that it suuport arm-based machine
> (including xscale).
> I am wondering what I have to do solve this problem.. please help me.
> 
> 
> First of all, I tested and succeeded in using the dongle with Redhat
> 9.x (2.4.20-8) with bluez 1.12 applications.
> l2ping, hciconfig, ... and finally pand, where I get a ftp file
> trasfer speed of 500 kbp!
> 
> Now I tried to the same thing on the xsale-machine. I got a patch for
> 2.4.19 from the bluez site and applied it to my machine kernel.
> and cross-compiled the bluez lib and utility.
> Then, I plug in the dongle, I typed "hciconfig" and got a nice results
> 
> >hciconfig
>  hci0 
>  DN brabra.....
> 
> It is time to do the hci0 up:
> 
> >hciconfig hci0 up
> IRQ occurred while service SOF: irq = 0x1
> IRQ occurred while service SOF: irq = 0x1
> Cannot init device: time-out (101)
> 
> I checked the /proc/bus/usb/drivers and devices. It looks ok, it has
> the hci_usb devices and drivers also.
> So, I cheked the source and internet: it seems that the SL811 USB HOST
> controller driver of Arm-based linux kernel
> has some problem. I even tried to patch the usb low leve driver, but
> still not ok ^^;;;;;
> 
> Is there any solution and hint or some suggestion for this??????

this don't look like a BlueZ problem. This really looks like a problem
with the USB host controller.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
