Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40C40B2D.7040403@nue.et-inf.uni-siegen.de>
From: Michael Schmidt <schmidt@nue.et-inf.uni-siegen.de>
MIME-Version: 1.0
To: d.mackie@ru.ac.za
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Can you spoof/forge Bluetooth Devices/Address?
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Mon, 07 Jun 2004 08:29:01 +0200

Hi David,

> Does anyone know if you are able to spoof or forge a Bluetooth Device
> Address? I am wanting to pick up Bluetooth comms at one point and forward it
> on to another device but I am wanting the repeating devices to act like the
> original sending devices. Eg. If I have a phone that wants to communicate
> with my PC, I can have 2 repeaters, one spoofed as the PC and one as the
> phone.
> 
> phone <-BT-> Repeater(spoof PC) <-Not BT-> Repeater(spoof phone) <-BT-> PC

It is possible to change the BD_ADDR of certain BT devices. This 
requires the use of "undocumented", vendor-proprietary commands. In the 
source code of the Axis 'OpenBT' Bluetooth stack you can find how to do 
this for certain Ericsson and CSR-based devices.

However, you need to perform a full reset of the device in order to make 
the change effective. Also, a device (at least the ones that I know) can 
only have one address at a time. In other words, the BD_ADDR cannot be 
changed on a per-packet basis.

This is probably not want you want.


Cheers,

Michael

-- 
=================================================
Michael Schmidt
-------------------------------------------------
Institute for Data Communications Systems
University of Siegen, Germany
-------------------------------------------------
http:   www.nue.et-inf.uni-siegen.de/~schmidt/
e-mail: schmidt@nue.et-inf.uni-siegen.de
mobile: +49 179 7810214
=================================================


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
