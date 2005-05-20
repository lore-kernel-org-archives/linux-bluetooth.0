Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <428E6F46.901@gmx-topmail.de>
From: Jan H <jan.h@gmx-topmail.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: btsco - headset profile activated but no sco
 packets transmitted ???
References: <c1afa04d0505151420720b5bad@mail.gmail.com> <4287C079.20208@gmx.ch>	 <428825B8.2070103@metalan.net>	 <c1afa04d050516134921746de0@mail.gmail.com> <c1afa04d05052010462a27c0d6@mail.gmail.com> <428E4445.7080509@gmx-topmail.de> <428E4632.1030806@xmission.com>
In-Reply-To: <428E4632.1030806@xmission.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Sat, 21 May 2005 01:14:14 +0200

Brad Midgley schrieb:

> Jan
>
>> My question is who did you find out ehci_hcd driver is used?
>
>
> look at the window you get when running "usbview" or try to read
> /proc/bus/usb/devices and you can see how things connect.

Ok, useful program. Now i know its not connected to ehci controller.
My Bluetooth Dongle is not fully supported hciconfig dumps
name:/home/jan# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:04:0E:88:CA:25 ACL MTU: 120:20 SCO MTU: 64:0
        Unknown type

Thanks anyway and sorry for referencing to Jesús Cano Navarro
Jan


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
