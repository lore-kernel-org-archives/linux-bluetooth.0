Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Linux-2.6, Zaapa USB Dongle - can't find near
	devices
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200406042022.58589.cijoml@volny.cz>
References: <1086372047.8985.14.camel@castle.budism.pt>
	 <200406042022.58589.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1086374092.4424.24.camel@pegasus>
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
Date: Fri, 04 Jun 2004 20:34:52 +0200

Hi Michal,

> send 
> hciconfig -a

this won't help if you can't bring the device up. You must show us
/proc/bus/usb/devices.

> But Zeevo is shit. You better buy CSR based dongle.

Let me put into perspective. The TC2001 is not a Bluetooth chip that
should ever been used in any end products. The upcoming ZV4002 is much
better and it looks like that Zeevo had learned many things. However
buying a CSR based device is the best decision at the moment.

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
