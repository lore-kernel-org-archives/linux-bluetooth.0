Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: bluetooth 1.2 and 2.0 dongles support
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <01C5D0BE.7F71DF60.emonturus@teltronic.es>
References: <01C5D0BE.7F71DF60.emonturus@teltronic.es>
Content-Type: text/plain
Message-Id: <1129287610.5057.42.camel@localhost.localdomain>
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
Date: Fri, 14 Oct 2005 13:00:10 +0200

Hi Esteban,

> >> 2.	I have a Cellink BTA-3120 dongle. Although Cellink says that it is 
> >> Bluetooth 1.2 compliant, when I use it with BlueZ, the HCI version I get 
> >> with hciconfig is 1.1. Is that wright?
> 
> >Send in the "hciconfig hci0 features" output.
> 
> EWS4:/ # hciconfig hci0 features
> hci0:   Type: USB
>         BD Address: 00:0A:94:11:77:F5 ACL MTU: 120:20 SCO MTU: 64:0
>         Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset> 
>                 <timing accuracy> <role switch> <hold mode> <sniff mode> 
>                 <park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <power control>

this is a Bluetooth 1.1 dongle.

> >> 3.	I also have an old Belkin F8T001 dongle. When I plugged it BlueZ loaded 
> >> always some firmware stuff and it worked properly. My old version of BlueZ
> >> had a bluez-bluefw-1.0-202 rpm packet. I think this is equivalent to the 
> >> new tarball bluez-firmware that I have downloaded from BlueZ's homepage and 
> >> installed, but the reality is that this dongle doesn't work anymore.
> 
> >Use bluez-firmware and the bcm203x kernel driver for the 2.6 kernels.
> 
> How do I use this driver? I have tried to load it with insmod and I get the following:
> 
> 	EWS4:~/paquetes_rpm # insmod /lib/modules/2.6.4-52-smp/kernel/drivers/bluetooth/bcm203x.ko
> 	insmod: error inserting '/lib/modules/2.6.4-52-smp/kernel/drivers/bluetooth/bcm203x.ko': -1 Unknown symbol in module
> 
> At the same time the following lines appear in the /var/log/messages file:
> 
> 	Oct 14 12:38:07 EWS4 kernel: bcm203x: Unknown symbol release_firmware
> 	Oct 14 12:38:07 EWS4 kernel: bcm203x: Unknown symbol request_firmware

Load the firmware_class kernel module and place the firmware files
under /lib/firmware/

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
