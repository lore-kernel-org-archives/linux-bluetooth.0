Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Can you spoof/forge Bluetooth Devices/Address?
From: Marcel Holtmann <marcel@holtmann.org>
To: Xavier Garreau <x.garreau@prim-time.fr>
Cc: David Mackie <d.mackie@ru.ac.za>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <015f01c44c68$0a24a520$b67ba8c0@zaz1>
References: <20040606162154.GA94074@rucus.ru.ac.za>
	 <015f01c44c68$0a24a520$b67ba8c0@zaz1>
Content-Type: text/plain
Message-Id: <1086596922.12811.39.camel@pegasus>
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
Date: Mon, 07 Jun 2004 10:28:42 +0200

Hi Xavier,

> > Does anyone know if you are able to spoof or forge a Bluetooth Device
> > Address? I am wanting to pick up Bluetooth comms at one point and
> > forward it on to another device but I am wanting the repeating
> > devices to act like the original sending devices. Eg. If I have a
> > phone that wants to communicate with my PC, I can have 2 repeaters,
> > one spoofed as the PC and one as the phone.
> >
> > phone <-BT-> Repeater(spoof PC) <-Not BT-> Repeater(spoof phone)
> > <-BT-> PC
> 
> As far as i know you can change the BD Address of a CSR BT chip by using CSR
> vendor specific commands. At least, you can use an application they've made
> to achieve this.

you can change the BD_ADDR of almost every Bluetooth dongle, but as
Michael correctly pointed out, you must reset the dongle after it. So
changing the address on the fly is not possible.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
