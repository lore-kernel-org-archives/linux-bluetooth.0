Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <015f01c44c68$0a24a520$b67ba8c0@zaz1>
From: "Xavier Garreau" <x.garreau@prim-time.fr>
To: "David Mackie" <d.mackie@ru.ac.za>, <bluez-users@lists.sourceforge.net>
References: <20040606162154.GA94074@rucus.ru.ac.za>
Subject: Re: [Bluez-users] Can you spoof/forge Bluetooth Devices/Address?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Mon, 7 Jun 2004 10:18:38 +0200

> Does anyone know if you are able to spoof or forge a Bluetooth Device
> Address? I am wanting to pick up Bluetooth comms at one point and
> forward it on to another device but I am wanting the repeating
> devices to act like the original sending devices. Eg. If I have a
> phone that wants to communicate with my PC, I can have 2 repeaters,
> one spoofed as the PC and one as the phone.
>
> phone <-BT-> Repeater(spoof PC) <-Not BT-> Repeater(spoof phone)
> <-BT-> PC

As far as i know you can change the BD Address of a CSR BT chip by using CSR
vendor specific commands. At least, you can use an application they've made
to achieve this.

Hope it helps ...
-- 
Xavier Garreau <x.garreau@prim-time.fr>
Prim'Time Technology
http://www.prim-time.fr/



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
