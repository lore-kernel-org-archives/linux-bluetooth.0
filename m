Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Can you spoof/forge Bluetooth Devices/Address?
From: Marcel Holtmann <marcel@holtmann.org>
To: David Mackie <d.mackie@ru.ac.za>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040606162154.GA94074@rucus.ru.ac.za>
References: <20040606162154.GA94074@rucus.ru.ac.za>
Content-Type: text/plain
Message-Id: <1086556258.4765.163.camel@pegasus>
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
Date: Sun, 06 Jun 2004 23:10:58 +0200

Hi David,

> Does anyone know if you are able to spoof or forge a Bluetooth Device
> Address? I am wanting to pick up Bluetooth comms at one point and forward it
> on to another device but I am wanting the repeating devices to act like the
> original sending devices. Eg. If I have a phone that wants to communicate
> with my PC, I can have 2 repeaters, one spoofed as the PC and one as the
> phone.
> 
> phone <-BT-> Repeater(spoof PC) <-Not BT-> Repeater(spoof phone) <-BT-> PC
> 
> More information on why I want to do this can be found at
> http://www.cs.ru.ac.za/research/students/g99m0302/masters/
> 
> Any comment of suggestions will be greatly appreciated

I made a quick look through your documents. Spoofing of a BD_ADDR's is
not what you really want and of course it is also not possible. You
should think more of service forwarding. This means tunneling of the
complete L2CAP layer or dedicated SDP service records/RFCOMM channel
tunneling.

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
