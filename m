Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem Connecting to Logitech HS01-V14
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200501261244.47898.jschindele@arcor.de>
References: <200501261244.47898.jschindele@arcor.de>
Content-Type: text/plain
Message-Id: <1107118940.8384.19.camel@pegasus>
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
Date: Sun, 30 Jan 2005 22:02:20 +0100

Hi Juergen,

> I try in vain to connect btsco to this new nice headset.
> It work only once and till the first try it don't work any more
> 
> Here the details :
> 
> hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:0C:76:48:06:D8 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN AUTH ENCRYPT
>         RX bytes:7762 acl:0 sco:0 events:325 errors:0
>         TX bytes:2930 acl:0 sco:0 commands:188 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x7e0100
>         Service Classes: Networking, Rendering, Capturing
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)

only use "auth" and "encrypt" (which means security mode 3) when you
know what you are doing. It is off by default for a reason.

> After discovering i tried manually to do :
> --------------------
> hcitool name 00:0D:44:02:E5:B7
> Logitech HS01-V14
> 
> hcitool cc 00:0D:44:02:E5:B7
> Can't create connection: Input/output error
> 
> And here the coresponding hcidump -x is :
> -----------------
> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>   B7 E5 02 44 0D 00 02 00 00 00
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 19 04
> > HCI Event: Remote Name Req Complete (0x07) plen 255
>   00 B7 E5 02 44 0D 00 4C 6F 67 69 74 65 63 68 20 48 53 30 31
>   2D 56 31 34 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>   B7 E5 02 44 0D 00 18 CC 02 00 00 00 01
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 05 04
> > HCI Event: Link Key Request (0x17) plen 6
>   B7 E5 02 44 0D 00
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>   B7 E5 02 44 0D 00 E4 AC 30 9D 93 2A D5 64 09 2E 0E 2B 4A B1
>   85 9A
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0B 04 00 B7 E5 02 44 0D 00
> > HCI Event: Connect Complete (0x03) plen 11
>   05 29 00 B7 E5 02 44 0D 00 01 00
> 
> Why i'am not even asked for the pin ??
> (using "/bin/bluepincat")
> What is goning wrong ??

You provide a link key, but it seems that the link key is wrong or
oudated (if you used it under Windows). The final result is then an
authentication error. This can happen with security mode 3.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
