Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] "hciconfig -a" ok, but "hcitools scan" shows no
	devices
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <35275.80.146.4.18.1102802831.squirrel@schrell.de>
References: <35275.80.146.4.18.1102802831.squirrel@schrell.de>
Content-Type: text/plain
Message-Id: <1102804861.8750.2.camel@pegasus>
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
Date: Sat, 11 Dec 2004 23:41:01 +0100

Hi Andreas,

> I am new on this list with the following problem:
> 
> "hciconfig -a" shows
> 
> hci0:   Type: USB
>         BD Address: 00:10:C6:3A:B5:70 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:4187 acl:0 sco:0 events:370 errors:0
>         TX bytes:1902 acl:0 sco:0 commands:72 errors:0
>         Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
>         Packet type: DM1 DH1 HV1
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'delli-0'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x4f2 LMP Ver: 1.2 (0x2) LMP Subver:
> 0x4f2
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> "hcitools scan" or "hcitools inq" only show scanning but no device.
> 
> Kernel versions tested where 2.6.8.1 and 2.6.10-rc3 and the following
> debian packages
> 
> ii  bluez-firmware                1.0-2
> ii  bluez-hcidump                 1.12-1
> ii  bluez-pcmcia-support          2.10-5
> ii  bluez-pin                     0.24-1
> ii  bluez-utils                   2.10-5
> 
> dmesg:Bluetooth: Core ver 2.7
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> Bluetooth: HCI USB driver ver 2.7
> Bluetooth: L2CAP ver 2.6
> Bluetooth: L2CAP socket layer initialized
> Bluetooth: RFCOMM ver 1.3
> Bluetooth: RFCOMM socket layer initialized
> Bluetooth: RFCOMM TTY layer initialized
> 
> Tested also with --length=30, --flush
> 
> System is a Dell 8600 and a Siemens S65 mobile.

so this is the original firmware in the Bluetooth chip? You haven't
flashed it? Is there a wireless switch on that machine? Maybe you need
to activate the antenna.

Please show us "/proc/bus/usb/devices" and what "hcidump -X" showing.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
