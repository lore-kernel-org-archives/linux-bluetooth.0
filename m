Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] problems with nc6 with bluez support
From: Marcel Holtmann <marcel@holtmann.org>
To: Mauro Tortonesi <mtortonesi@ing.unife.it>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200401231218.50364.mtortonesi@ing.unife.it>
References: <200401221042.53134.mtortonesi@ing.unife.it>
	 <200401221231.10350.mtortonesi@ing.unife.it>
	 <1074771846.19046.19.camel@pegasus>
	 <200401231218.50364.mtortonesi@ing.unife.it>
Content-Type: text/plain
Message-Id: <1074864928.3071.120.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 23 Jan 2004 14:35:28 +0100

Hi Mauro,

> > this is not a limit of the SCO socket, it is a limit of the Bluetooth
> > design itself. A SCO link can have a different air coding and it is
> > possible that packets get dropped. The mailing list archive for more
> > details on it. The guys from CSR explained this very well.
> 
> do you mean this thread:
> 
> http://sourceforge.net/mailarchive/message.php?msg_id=6447630

no, there was another one, that explained why it is hard (mostly
impossible) to use SCO for data transfers.

> here it is. for the dlink dbt120 usb dongle:
> 
> [root@giskard test]# hciconfig hci0 version
> hci0:   Type: USB
>         BD Address: 00:0D:88:8E:CA:07 ACL MTU: 192:8  SCO MTU: 64:8
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb
>         Manufacturer: Cambridge Silicon Radio (10)
> [root@giskard test]# hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: 00:0D:88:8E:CA:07 ACL MTU: 192:8  SCO MTU: 64:8
>         HCI 15.3
>         Chip version: BlueCore02
>         Max key size: 56 bit
>         SCO mapping:  HCI

This is fine and should work.

> for the anycom 220 usb dongle:
> 
> [root@giskard test]# hciconfig hci0 version
> hci0:   Type: USB
>         BD Address: 00:0A:9A:00:EB:B5 ACL MTU: 339:4  SCO MTU: 64:0
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x93 LMP Ver: 1.1 (0x1) LMP Subver: 0x93
>         Manufacturer: Transilica, Inc. (24)
> [root@giskard test]# hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: 00:0A:9A:00:EB:B5 ACL MTU: 339:4  SCO MTU: 64:0
>         Unsupported manufacturer

I don't know if they map SCO over HCI or over PCM by default. From the
USB descriptor output it seems that they got this right, so it should be
no problem. But I don't know of anyone who had done sucessful SCO audio
transfers over HCI with other chips than CSR.

> i have an epox 8K5A mainboard with a VIA KT333 chipset. the usb chip is a VIA 
> VT8235:
> 
> [mauro@giskard mauro]$ lspci
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
> [...]
> 00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
> 00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
> 00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
> 00:11.1 IDE interface: VIA Technologies, Inc. 
> VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
> 00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
> [...]

Try the latest 2.4.25-pre and see if it works. I work with Intel and NEC
USB host adapters and never got a problem.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
