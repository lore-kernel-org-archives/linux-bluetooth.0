Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hci_acldata_packet error in a Palm connection.
From: Marcel Holtmann <marcel@holtmann.org>
To: Eduardo Moreno A <emoreno@dim.uchile.cl>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.60.0406101528420.10156@cain.borelian.dns2go.com>
References: <40C85761.4060201@dim.uchile.cl>
	 <1086873349.7930.2.camel@pegasus>
	 <Pine.LNX.4.60.0406101528420.10156@cain.borelian.dns2go.com>
Content-Type: text/plain
Message-Id: <1086874967.7930.19.camel@pegasus>
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
Date: Thu, 10 Jun 2004 15:42:47 +0200

Hi Eduardo,

> I have a "freeControl" usb dongle using chipset Broadcom (it's supported 
> in http://www.holtmann.org/linux/bluetooth/devices.html using 
> hci_usb+bluefw). I tried using bluefw and bcm203x module but I don't know 
> if the firmware was loaded (there is  no message in any log, how can I 
> see if it was loaded or not?), and if it  was loaded, I still have the 
> same problem.
> 
> My hciconfig -a:
> 
> hci0:   Type: USB
>          BD Address: 00:0A:9A:00:68:AC ACL MTU: 339:4  SCO MTU: 64:0
>          UP RUNNING PSCAN ISCAN
>          RX bytes:3203 acl:69 sco:0 events:171 errors:0
>          TX bytes:2658 acl:65 sco:0 commands:56 errors:0
>          Features: 0xff 0xff 0x3d 0x00 0x00 0x00 0x00 0x00
>          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>          Link policy: RSWITCH HOLD SNIFF PARK
>          Link mode: ACCEPT MASTER
>          Name: 'BlueZ (0)'
>          Class: 0x000100
>          Service Classes: Unspecified
>          Device Class: Computer, Uncategorized
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x8a LMP Ver: 1.1 (0x1) LMP Subver: 
> 0x8a
>          Manufacturer: Transilica, Inc. (24)

this is not a Broadcom dongle and so it don't need bluefw. I must update
my devices list, because it seems freeControl has changed the Bluetooth
chip on their dongles. Do you have some more information about your
device for me?

Try to buy yourself CSR based dongle. You will have less problems,
because this Transilicia chip are not so good.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
