Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <441EF1B4.5040201@cs.bgu.ac.il>
From: Niv <nivv@cs.bgu.ac.il>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Some variety of user guide?
References: <440B9460.3050004@lycosmax.co.uk> 	<ef9938ec0603060910r6e4b13e4jf294590947342a09@mail.gmail.com> <441EEB9B.70907@cs.bgu.ac.il>
In-Reply-To: <441EEB9B.70907@cs.bgu.ac.il>
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
Date: Mon, 20 Mar 2006 20:17:24 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

traced it down to:
# ps -ae | grep hcid
moshe linux #
# ps -ae | grep sdpd
14200 ?        00:00:00 sdpd

# fgrep -i hci /usr/src/linux/.config
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
# CONFIG_SCSI_SATA_AHCI is not set
CONFIG_IEEE1394_OHCI1394=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=y

# modprobe hci_uart bpa10x bfusb bcm203x hci_vhci hci_usb bluetooth
l2cap sco rfcomm hidp bnep
# /etc/init.d/bluetooth restart
 * Shutting down Bluetooth ...
 *     Stopping rfcomm ...                                        [ ok ]
 *     Stopping sdpd ...                                          [ ok ]
 *     Stopping hcid ...                                          [ ok ]
 * Starting Bluetooth ...
 *     Starting hcid ...                                          [ ok ]
 *     Starting sdpd ...                                          [ ok ]
 *     Starting rfcomm ...                                        [ ok ]

# ps -ae | grep hcid

nothing :-(

What the hell am I missing here?

Niv

Niv wrote:
> Dear Ben,
> I would encourage you to take a look at
> http://www.gentoo.org/doc/en/bluetooth-guide.xml
> 
> Albert and the rest of the gang: I followed the guide and had great
> success using BT in my home pc. however I just can't do that magic at work.
> I followed the guide , and when I scan I see the cellphone as well as
> the headset (which is in pairing mode) . I can ping my Nokia 6600 phone,
> but the headset - just doesn't replay.
> 
> Here is my dump:
>  $ hcitool scan
> Scanning ...
>         00:0D:44:33:E1:63       Logitech HS02-V07
>         00:0E:6D:45:97:A1       Niv
> # hcidump -X -V
> HCI sniffer - Bluetooth packet analyzer ver 1.30
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Inquiry (0x01|0x0001) plen 5
>     lap 0x9e8b33 len 8 num 0
>>> HCI Event: Command Status (0x0f) plen 4
>     Inquiry (0x01|0x0001) status 0x00 ncmd 1
>>> HCI Event: Inquiry Result (0x02) plen 15
>     bdaddr 00:0E:6D:45:97:A1 mode 1 clkoffset 0x1611 class 0x500204
>>> HCI Event: Inquiry Result (0x02) plen 15
>     bdaddr 00:0D:44:33:E1:63 mode 1 clkoffset 0x722f class 0x200404
>>> HCI Event: Inquiry Complete (0x01) plen 1
>     status 0x00
> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>     bdaddr 00:0D:44:33:E1:63 mode 1 clkoffset 0x722f (valid)
>>> HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
>>> HCI Event: Remote Name Req Complete (0x07) plen 255
>     status 0x00 bdaddr 00:0D:44:33:E1:63 name 'Logitech HS02-V07'
> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>     bdaddr 00:0E:6D:45:97:A1 mode 1 clkoffset 0x1611 (valid)
>>> HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
>>> HCI Event: Remote Name Req Complete (0x07) plen 255
>     status 0x00 bdaddr 00:0E:6D:45:97:A1 name 'Niv'
> 
> ----
> l2ping 00:0D:44:33:E1:63
> Can't connect: Function not implemented
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:0D:44:33:E1:63 ptype 0xcc18 rswitch 0x01 clkoffset 0x722f
> (valid)
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>>> HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
>>> HCI Event: PIN Code Request (0x16) plen 6
>     bdaddr 00:0D:44:33:E1:63
>>> HCI Event: Connect Complete (0x03) plen 11
>     status 0x22 handle 41 bdaddr 00:0D:44:33:E1:63 type ACL encrypt 0x00
>     Error: LMP Response Timeout
> 
> more info: uname -a
> Linux moshe 2.6.15.1 #9 PREEMPT Wed Mar 15 20:33:07 IST 2006 i686
> Intel(R) Pentium(R) 4 CPU 2.00GHz GenuineIntel GNU/Linux
>  hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:10:60:A8:86:A3 ACL MTU: 192:8 SCO MTU: 64:8
>         UP RUNNING
>         RX bytes:667 acl:0 sco:0 events:19 errors:0
>         TX bytes:77 acl:0 sco:0 commands:11 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x000000
>         Service Classes: Unspecified
>         Device Class: Miscellaneous,
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver:
> 0x33c
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> net-wireless/bluez-utils 2.25
> 
> 
> Niv
> 
> Albert Huang wrote:
>>>>     Is there any sort of user guide or user documentation for BlueZ.
>>>> I've installed it but have no idea how to use it... I have no idea how
>>>> to search for varius bluetooth devices, for example.
>>>
>>> hcitool scan
>>>
>>>
>>>> I'd like to contect
>>>> to my phone and download pictures.
>>>
>>> obexserver, and obexftp
>>>
>>>     Further more, do I have to do everything through the terminal or is
>>>> there a graphical user interface out there. I noticed BlueThing on
>>>> Sourceforge, but it apparently hasn't got any files to be downloaded yet.
>>>
>>> individual distros and deskopt environments have their own way of doing
>>> things, afaik (e.g. gnome bluetooth).  I do everything by command line, so
>>> don't know much about this.
>>>
>>> Regards,
>>> Albert
>>>
> 

- -------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEHvG0kwazfG0MmCYRAkabAKC4tZJktgNSdbK0R/oQXMnouZ75VgCfXYDb
uyw+8SJhkG0L1hwRMQhMdVs=
=0ZPi
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
