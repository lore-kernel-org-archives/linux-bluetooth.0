Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth problem under FC3 on a D600
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <16dd70ff050211012063a9c6f5@mail.gmail.com>
References: <16dd70ff050211012063a9c6f5@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1108123347.18099.14.camel@pegasus>
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
Date: Fri, 11 Feb 2005 13:02:27 +0100

Hi Cristian,

> I have tried to get the bluetooth running under FC3 for the last 2
> days without any luck. The laptop can not detect any bluetooth device,
> nor is detected by any other device (phone, mac)
> 
> Here is my setup:
> 
> [crt@dhcp-44-206 ~]$ lsmod
> Module                  Size  Used by
> rfcomm                 37853  0
> hci_usb                15945  3
> hidp                   26817  2
> l2cap                  26053  10 rfcomm,hidp
> bluetooth              48453  10 rfcomm,hci_usb,hidp,l2cap
> 
> [crt@dhcp-44-206 ~]$ hciconfig -a
> hci0:   Type: USB
>       BD Address: <addr> ACL MTU: 192:8  SCO MTU: 64:8
>       UP RUNNING PSCAN ISCAN
>       RX bytes:10530 acl:0 sco:0 events:469 errors:0
>       TX bytes:1162 acl:0 sco:0 commands:133 errors:0
>       Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
>       Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>       Link policy: RSWITCH HOLD SNIFF PARK
>       Link mode: SLAVE ACCEPT
>       Name: <name>
>       Class: 0x120104
>       Service Classes: Networking, Object Transfer
>       Device Class: Computer, Desktop workstation
>       HCI Ver: 1.2 (0x2) HCI Rev: 0x4f2 LMP Ver: 1.2 (0x2) LMP Subver: 0x4f2
>       Manufacturer: Cambridge Silicon Radio (10)
> 
> When I do hcitool scan here is what I get:
> [crt@dhcp-44-206 ~]$ hcitool scan
> Scanning ...
> [crt@dhcp-44-206 ~]$
> 
> The hcidump associated with this is:
> [crt@dhcp-44-206 ~]$ hcidump
> HCIDump - HCI packet analyzer ver 1.11
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Inquiry Complete (0x01) plen 1
> 
> Any ideas what I am doing wrong? If you need extra information please
> let me know.

do a "hcidump -X" and what kind of dongle is this?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
