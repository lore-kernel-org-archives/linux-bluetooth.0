Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: systemparadox@gmail.com, BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <453E7A4E.9080600@gmail.com>
References: <453E7A4E.9080600@gmail.com>
Date: Wed, 25 Oct 2006 17:23:46 +0200
Message-Id: <1161789826.10866.168.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bt3c firmware
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

> I'm running Arch Linux if that makes any difference.
> 
> I recently bought a 3Com 3CRWB6096 "Bluetooth Wireless PC Card" 
> (PCMCIA/Cardbus). I've seen many people report that this card works in 
> Linux using the bt3c driver. However, I've also seen a lot of people 
> with the same problem as me. It seems that the documentation on this is 
> somewhat lacking. My only searches for this error return people trying 
> to resolve it (with no answers) and the bt3c source code for the error.
> 
> When I plug the card in, dmesg gives me:
> 
> pccard: PCMCIA card inserted into slot 0
> pcmcia: registering new device pcmcia0.0
> bt3c_interrupt: Call of irq 4 for unknown device
> bt3c_open: Firmware request failed
> bt3c_interrupt: Call of irq 4 for unknown device
> bt3c_open: Firmware request failed
> bt3c_interrupt: Call of irq 4 for unknown device
> 
> And nothing appears in hciconfig.
> As per the little amount of info I found on google, I have obtained the 
> firmware for this card from 3Com- BT3CPCC.bin.
> 
> I have tried putting this file in the following locations:
> /etc/bluetooth/firmware
> /usr/lib/hotplug/firmware (though I'm using UDEV, as everyone does these 
> days)
> /lib/firmware
> 
> But that makes no difference whatsoever.
> I have also tried installing the bluez-firmware package, but that only 
> seems to include BCM2033 and STLC2500 firmware.
> It is also worth noting that this package put those files in 
> /lib/firmware. Before that, none of the above firmware dirs existed.
> I have installed every relevant bluetooth package I can get my hands on.
> 
> Interestingly this card does not show up in lspci (which I think means 
> that it is PCMCIA and not CardBus). lspcmcia gives:
> Socket 0 Bridge:        [yenta_cardbus]         (bus ID: 0000:02:00.0)
> Socket 0 Device 0:      [serial_cs]             (bus ID: 0.0)
> 
> A serial device? Maybe that makes sense for bluetooth, but does this 
> mean that I have to use hciattach? Thought surely the firmware issue 
> needs resolving first.

you might have the 3.0 version of the card which presents itself as
serial device. It doesn't need any special firmware. Use hciattach to
make it available.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
