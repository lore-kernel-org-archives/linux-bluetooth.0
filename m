Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] problems with nc6 with bluez support
From: Marcel Holtmann <marcel@holtmann.org>
To: Mauro Tortonesi <mtortonesi@ing.unife.it>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200401221231.10350.mtortonesi@ing.unife.it>
References: <200401221042.53134.mtortonesi@ing.unife.it>
	 <200401221127.57516.mtortonesi@ing.unife.it>
	 <1074770040.19046.1.camel@pegasus>
	 <200401221231.10350.mtortonesi@ing.unife.it>
Content-Type: text/plain
Message-Id: <1074771846.19046.19.camel@pegasus>
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
Date: Thu, 22 Jan 2004 12:44:07 +0100

Hi Mauro,

> what do you mean when you say that SCO is not for data transfer? what are the 
> limits of SCO sockets?

this is not a limit of the SCO socket, it is a limit of the Bluetooth
design itself. A SCO link can have a different air coding and it is
possible that packets get dropped. The mailing list archive for more
details on it. The guys from CSR explained this very well.

> for the dlink dbt120 usb dongle:
> 
> [root@giskard root]# hciconfig hci0 version
> hci0:   Type: USB
>         BD Address: 00:0D:88:8E:CA:07 ACL MTU: 192:8  SCO MTU: 64:8
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb
>         Manufacturer: Cambridge Silicon Radio (10)
> [root@giskard root]# hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: 00:0D:88:8E:CA:07 ACL MTU: 192:8  SCO MTU: 64:8
>         HCI 15.3 (bc02x)
> 
> for the anycom 220 usb dongle:
> 
> [root@giskard root]# hciconfig hci0 version
> hci0:   Type: USB
>         BD Address: 00:0A:9A:00:EB:B5 ACL MTU: 339:4  SCO MTU: 64:0
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x93 LMP Ver: 1.1 (0x1) LMP Subver: 0x93
>         Manufacturer: Transilica, Inc. (24)
> [root@giskard root]# hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: 00:0A:9A:00:EB:B5 ACL MTU: 339:4  SCO MTU: 64:0
>         Unsupported manufacturer
> 
> i am using hciconfig from bluez-utils 2.3.

Install the latest bluez-libs and bluez-utils and do it again. Or use
the scoinfo utility from my website.

The Anycom dongle is problematic, because of the Transilica chip. I
don't know anything special about it. Please show us the content of
/proc/bus/usb/devices.

> BTW: clearly, when the usb/bluez subsystem hangs after trying to perform sco 
> transfers, hciconfig does not recognize any bluetooth interface.

What kind of USB chipset do you use? I heard of some problems with VIA
or ALI chipsets (can't remember what manufacturer it was).

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
