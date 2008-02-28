Return-Path: <cyrus@holtmann.org>
From: Guillaume Bedot <littletux@zarb.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <918680.33243.qm@web8402.mail.in.yahoo.com>
References: <918680.33243.qm@web8402.mail.in.yahoo.com>
Date: Thu, 28 Feb 2008 12:37:52 +0100
Message-Id: <1204198672.9466.37.camel@littletux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] BT headset doesn't work: SCO connection timeout
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On jeu, 2008-02-28 at 08:54 +0530, pramod gurav wrote:
> Hi andrea Same problem used to occur with me. My hciconfig also used
> to
>  show this sco mtu SCO MTU: 64:0 whereas others on the list it was
>   something SCO MTU: 64:8. So i changed my dongle. and it simply
>  worked. I bought one new BT dongle which clamed it supports HS audio
>  Gtaeway.  It is a product of ENTER multimedia. this is it.
>  [root@localhost  Pramod]# /usr/local/sbin/hciconfig -a hci0:   Type:
>  USB         BD  Address: 11:11:11:11:11:11 ACL MTU: 678:8 SCO MTU:
>  48:10         UP  RUNNING PSCAN ISCAN         RX bytes:10283222
>  acl:386 sco:201151  events:719 errors:0         TX bytes:10319322
>  acl:347 sco:202172  commands:192 errors:0         Features: 0xbf 0xfe
>  0x8d 0x78 0x08 0x18  0x00 0x00         Packet type: DM1 DM3 DM5 DH1
>  DH3 DH5 HV1 HV2 HV3          Link policy: RSWITCH HOLD SNIFF
>  PARK         Link mode: SLAVE  ACCEPT         Name: 'BlueZ
>  (0)'         Class: 0x080100          Service Classes:
>  Capturing         Device Class: Computer,  Uncategorized         HCI
>  Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2  (0x2) LMP Subver:
>  0x1fe         Manufacturer: Integrated System  Solution Corp. (57)

It's fine you solved your problem, but...

I currently have a similar dongle "Souyo (r) Bluetooth (tm)", that doesn't 
work with either usb2 or integrated usb 1.1 (i use no hub).

# hciconfig -a
hci0:	Type: USB
	BD Address: 11:11:11:11:11:11 ACL MTU: 678:8 SCO MTU: 64:8
	UP RUNNING PSCAN 
	RX bytes:1224 acl:0 sco:0 events:28 errors:0
	TX bytes:608 acl:0 sco:0 commands:28 errors:0
	Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'littletux-1'
Can't read class of device on hci0: Connection timed out (110)

# lsusb
Bus 003 Device 004: ID 1131:1001 Integrated System Solution Corp.
KY-BT100 Bluetooth Adapter

Tried without force_scofix, in case of (maybe needed only for the other
dongle).

There is an other quirk needed (reset), so I haven't tried btusb module.

I produces various kind of error messages in syslog :
Feb 28 12:22:42 littletux kernel: hub 5-0:1.0: port 2 disabled by hub
(EMI?), re-enabling...
Feb 28 12:22:42 littletux kernel: usb 5-2: USB disconnect, address 2
Feb 28 12:22:42 littletux hcid[9880]: Can't init device hci0: No such
device (19)
Feb 28 12:22:42 littletux hcid[9672]: HCI dev 0 unregistered
Feb 28 12:22:42 littletux hcid[9672]: Unregister path: /org/bluez/hci0
Feb 28 12:22:42 littletux hcid[9672]: Device hci0 has been removed
Feb 28 12:22:42 littletux bluetooth: Starting bluetooth service
Feb 28 12:22:42 littletux kernel: usb 5-2: new full speed USB device
using uhci_hcd and address 3
Feb 28 12:22:42 littletux bluetooth: Starting hidd
Feb 28 12:22:42 littletux kernel: usb 5-2: device not accepting address
3, error -71
Feb 28 12:22:42 littletux kernel: usb 5-2: new full speed USB device
using uhci_hcd and address 4
Feb 28 12:22:43 littletux kernel: usb 5-2: device not accepting address
4, error -71
Feb 28 12:22:43 littletux kernel: usb 5-2: new full speed USB device
using uhci_hcd and address 5
Feb 28 12:22:43 littletux kernel: usb 5-2: device descriptor read/64,
error -71
Feb 28 12:22:43 littletux kernel: usb 5-2: device descriptor read/64,
error -71
Feb 28 12:22:43 littletux kernel: usb 5-2: new full speed USB device
using uhci_hcd and address 6
Feb 28 12:22:43 littletux kernel: usb 5-2: device descriptor read/64,
error -71
Feb 28 12:22:44 littletux kernel: usb 5-2: device descriptor read/64,
error -71


It used to work (before i had the usb2 card, or wi-fi maybe) but is no
more use to me now.

I wouldn't recommend these old dongles. Mailing-list readers should get
a bluetooth 2.0 or more dongle, it's the same price as a 1.2 one.

Best regards,

Guillaume B.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
