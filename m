Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Gareth Reakes <gareth@apache.org>
To: bluez-users@lists.sourceforge.net
Message-ID: <20031105093947.J63252@minotaur.apache.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] Problems with MS mouse and keyboard
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 5 Nov 2003 09:48:34 -0800 (PST)

Hi all,
	I tried to get this all to work about 6 months ago and could not.
I have now tried again from scratch after the recent mail regarding this
subject. I have everything installed and a brand spanking new 2.4.22
kernel. I find it very difficult to connect and when I do connect it will
not maintain the connection. I know these devices go into sleep mode, but
talking to other people on this list, they come out of it. This is not
possible for me. Frequently, after I try to wiggle the mouse in sleep
mode, bthid start to take up 100% of the CPU. I find it unlikely that this
is the bthid code itself.
	It is more than possible that this is a hardware problem with my
mouse etc but I would really like to know this before trying to exchange
them. I do have 1 more piece of information with the new kernel. As you
can see at the end of the message below there is a message which may help.
I am willing and able to provide whatever information will help solve this
problem. I really do not want to lose against MS ;)

Any help is greatly appreciated,

Gareth

PS thanks for those slides Marcel, they were informative



Nov  5 17:17:48 somme bthid[2266]: Bluetooth HID daemon by Peter Klausler
<pmk@cray.com>
Nov  5 17:17:48 somme bthid[2266]: socket 5 bound to BD 00:00:00:00:00:00
PSM 17
Nov  5 17:17:48 somme bthid[2266]: socket 6 bound to BD 00:00:00:00:00:00
PSM 19
Nov  5 17:19:26 somme bthid[2273]: Bluetooth HID daemon by Peter Klausler
<pmk@cray.com>
Nov  5 17:19:26 somme bthid[2274]: attempting connection to BD
00:50:F2:7F:AA:A5
Nov  5 17:19:26 somme bthid[2274]: L2CAP socket 5 connected to BD
00:50:F2:7F:AA:A5 PSM 17
Nov  5 17:19:26 somme bthid[2274]: L2CAP socket 6 connected to BD
00:50:F2:7F:AA:A5 PSM 19
Nov  5 17:19:26 somme bthid[2274]: Serving Bluetooth HID at BD
00:50:F2:7F:AA:A5
Nov  5 17:19:26 somme bthid[2274]: L2CAP socket 7 connected to BD
00:50:F2:7F:AA:A5 PSM 1
Nov  5 17:19:26 somme bthid[2274]: Wireless IntelliMouse Explorer for
Bluetooth
Nov  5 17:19:26 somme bthid[2274]: made by Microsoft
Nov  5 17:19:26 somme bthid[2274]: device version 1.0
Nov  5 17:31:45 somme bthid[2274]: EOF on Interrupt channel


Nov  5 17:37:08 somme kernel: hci_acldata_packet: hci0 ACL packet for
unknown connection handle 41
Nov  5 17:41:24 somme last message repeated 166 times




hciconfig -a

[gareth@somme gareth]$ /sbin/hciconfig -a
hci0:	Type: USB
	BD Address: 00:50:F2:7E:29:D0 ACL MTU: 192:8  SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN
	RX bytes:17308 acl:1125 sco:0 events:123 errors:0
	TX bytes:1225 acl:39 sco:0 commands:27 errors:0
	Features: 0xff 0xff 0x0f 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
	Link policy: HOLD SNIFF PARK
	Link mode: SLAVE ACCEPT
	Name: 'BlueZ (0)'
	Class: 0x000100
	Service Classes: Unspecified
	Device Class: Computer, Uncategorized
	HCI Ver: 1.1 (0x1) HCI Rev: 0x1f9 LMP Ver: 1.1 (0x1) LMP Subver:
0x1f9
	Manufacturer: Cambridge Silicon Radio (10)




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
