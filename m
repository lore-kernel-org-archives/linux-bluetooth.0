Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Message-ID: <d7uvkf$jm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-devel] btsco and Jabra Headset
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 05 Jun 2005 15:48:17 +0200

Hi!

As the feedback I got in -user@ suggests that it may not be
misconfiguration, I'm now posting here as well, with updated information.
Any pointers to further documentation are greatly appreciated. As I'm a
complete bluetooth newbie I may well have missed some vital information
required to get everything running.

I've had a hard time trying to get my headset working but had no success so
far. :-(

I've found single report on the syptoms I get on the net
(http://www.linuxforen.de/forums/archive/index.php/t-182494.html), but
unfortunately no solution/follow up posting...

The same problem happened with vanilla kernels 2.6.9 @i386 and 2.6.11.11
@AMD64, the bluetooth drivers were compiled as modules in both cases. I'm
suing a CSR USB bleutooth stick as recommended, driven by the ohci-hcd
drivers as I read about possible problems with the ehci ones.

These are the symptoms:

,----[ btsco -v 00:07:A4:05:2E:14 ]
| btsco v0.4c
| Device is 2:0
| Error: Failed to connect to SDP server: Permission denied
| Assuming channel 2
| 
| Voice setting: 0x0060
| Can't connect RFCOMM channel: Permission denied
`----

This happens no matter if I run it as root or my normal user. (which is in
group dialup, all the /dev/rfcomm* belong to group dialup) The btsco is a
CVS checkout from few days ago.

Even using sdptool directly fails badly:

,----[ sdptool search --bdaddr 00:07:A4:05:2E:14 0x1108 ]
| Class 0x1108
| Failed to connect to SDP server on 00:07:A4:05:2E:14: Permission denied
`----

Although the bluetooth stick seems to be detected correctly and finds the
headset when scanning for it:

,----[ hcitool scan ]
| Scanning ...
|         00:07:A4:05:2E:14       JABRA BT200
`----

strace says btsco fails during a connect call:

,----
| connect(4, {sa_family=AF_BLUETOOTH, sa_data="\1\0\24
| \5\244\7\0\0\0\0\0\0\0"}, 10) = -1 EACCES (Permission denied)
| close(4)                                = 0
| write(2, "Error: ", 7Error: )                  = 7
| write(2, "Failed to connect to SDP server:"..., 70Failed to connect to SDP
| server: Permission denied
`----

I'm I missing some reqiured kernel support here?

,----[ .config ]
| (...)
| CONFIG_BT_HCIUSB=m
| CONFIG_BT_HCIUSB_SCO=y
| CONFIG_BT_HCIUART=m
| CONFIG_BT_HCIUART_H4=y
| CONFIG_BT_HCIUART_BCSP=y
| CONFIG_BT_HCIUART_BCSP_TXCRC=y
| # CONFIG_BT_HCIBCM203X is not set
| # CONFIG_BT_HCIBPA10X is not set
| # CONFIG_BT_HCIBFUSB is not set
| # CONFIG_BT_HCIVHCI is not set
| (...)
`----

,----[ lsmod ]
| Module                  Size  Used by
| snd_bt_sco             14848  0
| snd_hwdep              10336  1 snd_bt_sco
| hci_usb                16264  2
| rfcomm                 42288  0
| l2cap                  25928  5 rfcomm
| bluetooth              53252  7 hci_usb,rfcomm,l2cap
| (...)
| snd_pcm                99020  6
| snd_bt_sco,snd_ca0106,snd_intel8x0,snd_ac97_codec,snd_pcm_oss
| (...)
| snd                    57832  19
snd_bt_sco,snd_hwdep,snd_ca0106,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
| soundcore              11040  1 snd
| snd_page_alloc         11464  4 snd_bt_sco,snd_ca0106,snd_intel8x0,snd_pcm
| ehci_hcd               35080  0
| usbhid                 35776  0
| ohci_hcd               22024  0
| (...)
`----

Details about the USB stick:

   kernel: usb 1-7: new full speed USB device using ohci_hcd and address 10

,----[ hciconfig -a ]
| hci0:   Type: USB
|         BD Address: 00:09:DD:10:62:ED ACL MTU: 192:8 SCO MTU: 64:8
|         UP RUNNING PSCAN ISCAN
|         RX bytes:107 acl:0 sco:0 events:14 errors:0
|         TX bytes:300 acl:0 sco:0 commands:13 errors:0
|         Features: 0xff 0xff 0x8f 0xf8 0x18 0x18 0x00 0x80
|         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
|         Link policy: RSWITCH HOLD SNIFF PARK
|         Link mode: SLAVE ACCEPT
|         Name: 'CoriCelesti-0'
|         Class: 0x3e0100
|         Service Classes: Networking, Rendering, Capturing,
|                          Object Transfer, Audio 
|         Device Class: Computer, Uncategorized
|         HCI Ver: 1.1 (0x1) HCI Rev: 0x639 LMP Ver: 1.1 (0x1)
|         LMP Subver: 0x639
|         Manufacturer: Cambridge Silicon Radio (10)
`----

Any hints?

Greetings,

  Gunter

-- 
Due to hw failure, I'm thinking buying a new laptop.  I would like to 
know what is the worst laptop with ACPI atm?        -- Linux ACPI 
driver hacker Bruno Ducrot looking for a "good" laptop... ;)
*** PGP-Verschlüsselung bei eMails erwünscht :-) *** PGP: 0x1128F25F ***



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
