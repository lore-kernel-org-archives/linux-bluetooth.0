Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Internal Bluetooth on dell latitude d610?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4291DFA9.6010401@logicacmg.com>
References: <4291DFA9.6010401@logicacmg.com>
Content-Type: text/plain
Message-Id: <1116857742.30044.88.camel@pegasus>
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
Date: Mon, 23 May 2005 16:15:42 +0200

Hi Thomas,

> my company gave me a latitude dell d610 notebook with built-in bluetooth
> (Dell Wireless 350 Bluetooth Module);
> unfortunately, I am not able to get it work under linux.
> 
> I have
> - centos 4.0, kernel 2.6.9, all modules load correctly,
> # rpm -qa | grep blue
> bluez-bluefw-1.0-6
> bluez-hcidump-1.11-1
> bluez-libs-2.10-2
> bluez-utils-2.10-2.1
> 
> /etc/init.d/bluetooth start even makes BT led lid ;) BUT
> 
> hciconfig -a does nothing, neither hcitool dev (shows empty lines 
> "Devices:") or hciconfig hci0 (Can't get device info: No such device")
> 
> google search did not find anything relevant, so I am politely asking 
> here :)
> Does anyone have any ideas, please?

check /proc/bus/usb/devices, but I assume that the module is switched
off by default. So you need to activate it, because otherwise it will
not show up on the USB bus and thus it can't picked up by the hci_usb
driver.

Most Dell notebooks should have a Fn-F2 switch or an extra BIOS option
for this. Otherwise the only option is to look for a Dell ACPI module to
modify the Bluetooth switch.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
