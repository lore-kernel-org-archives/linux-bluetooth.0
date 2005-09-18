Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <9c68c0a7050918021457e7fe3c@mail.gmail.com>
From: liang liping <lianglip@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] multi connection with dund and rfcomm
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
Date: Sun, 18 Sep 2005 17:14:47 +0800

 I have three pc, they are ubuntu linux 5.0.4(kernel 2.6.10)
and three bluetooth usb adapters.
Then I have one pc to listen using command:
"sdptool add --channel=3D2 SP"
"dund -n --listen --channel 2 --msdun file /etc/bluetooth/hcid.conf"

Another pc to connect to the first one using
"dund --search --msdun -n"
the connection establish.

but when i let the third pc connect to the first one using
"dund --search --msdun -n"
it fails.It seams that the third one even can not scan the first one.

"hciconfig -a"
first one:
hci0: Type: USB
BD Address: 00:11:67:10:71:D2 ACL MTU: 678:8 SCO MTU: 48:10
UP RUNNING PSCAN ISCAN
RX bytes:1243 acl:36 sco:0 events:93 errors:0
TX bytes:1252 acl:36 sco:0 commands:39 errors:0
Features: 0xff 0xff 0x8d 0x78 0x08 0x18 0x00 0x00
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
Link policy: RSWITCH HOLD SNIFF PARK
Link mode: SLAVE ACCEPT
Name: 'ubuntu-a-0'
Class: 0x000100
Service Classes: Unspecified
Device Class: Computer, Uncategorized
HCI Ver: 1.2 (0x2) HCI Rev: 0x1ae LMP Ver: 1.2 (0x2) LMP Subver: 0x1ae
Manufacturer: Integrated System Solution Corp. (57)

second one:
hci0: Type: USB
BD Address: 00:11:67:10:72:CA ACL MTU: 678:8 SCO MTU: 48:10
UP RUNNING PSCAN ISCAN
RX bytes:1573 acl:22 sco:0 events:91 errors:0
TX bytes:1070 acl:21 sco:0 commands:40 errors:0
Features: 0xff 0xff 0x8d 0x78 0x08 0x18 0x00 0x00
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
Link policy: RSWITCH HOLD SNIFF PARK
Link mode: SLAVE ACCEPT
Name: 'ubuntu-0'
Class: 0x000100
Service Classes: Unspecified
Device Class: Computer, Uncategorized
HCI Ver: 1.2 (0x2) HCI Rev: 0x1ae LMP Ver: 1.2 (0x2) LMP Subver: 0x1ae
Manufacturer: Integrated System Solution Corp. (57)

third one:hci0: Type: USB
BD Address: 00:11:67:0D:EC:22 ACL MTU: 678:8 SCO MTU: 48:10
UP RUNNING PSCAN ISCAN
RX bytes:1595 acl:45 sco:0 events:122 errors:0
TX bytes:1765 acl:46 sco:0 commands:45 errors:0
Features: 0xff 0xff 0x8d 0x78 0x08 0x18 0x00 0x00
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
Link policy: RSWITCH HOLD SNIFF PARK
Link mode: MASTER
Name: 'ubuntu-b-0'
Class: 0x000100
Service Classes: Unspecified
Device Class: Computer, Uncategorized
HCI Ver: 1.2 (0x2) HCI Rev: 0x1ae LMP Ver: 1.2 (0x2) LMP Subver: 0x1ae
Manufacturer: Integrated System Solution Corp. (57)

and all their hcid.conf are:

options {

autoinit yes;

security auto;
pairing multi;
pin_helper /usr/bin/bluez-pin;
}

device {
name "%h-%d";

class 0x100;

iscan enable; pscan enable;
lm accept;
lp rswitch,hold,sniff,park;
}

and /etc/ppp/options are:
first one:
noauth
defaultroute
crtscts
10.0.0.1:
ms-dns 10.0.0.1
ipcp-accept-local
ipcp-accept-remote
debug
noipdefault
asyncmap 0
persist

the other two:
noauth
crtscts
ms-dns 10.0.0.1
ipcp-accept-local
ipcp-accept-remote
debug
noipdefault
asyncmap 0

That is a server and two client.
why the third adapter can not connect to the first one?

Then I do another thing.
I have the first pc to listen using command
"rfcomm listen hci0 1"

the second pc to connect
"rfcomm connect hci0 <first BD_ADDR> 1"
the connection is done.

the third pc to connect
"rfcomm connect hci0 <first BD_ADDR> 1"
it prints an error:"Can't connect RFCOMM socket: Host is down".
Can several adapters connect to another addpters at the same time and
using the same channel?

after that i try using different channel:
first pc:
"rfcomm listen hci0 1"
"rfcomm listen hci0 2"

second pc:
"rfcomm connect hci0 <first BD_ADDR> 1"
connection is done

thrid pc:
"rfcomm connect hci0 <first BD_ADDR> 2"
the error is the same: "Host is down".

what does this mean?
How can i have several adapters connect to the same server adapter?
Thank you very much!


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
