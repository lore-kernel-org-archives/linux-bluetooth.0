Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Bearcat M. Sandor" <Bearcat@feline-soul.com>
To: Nils Faerber <nils.faerber@kernelconcepts.de>
Date: Thu, 27 Jul 2006 18:18:37 -0600
References: <20060727074608.19672.qmail@web27901.mail.ukl.yahoo.com>
	<200607271130.03437.Bearcat@feline-soul.com>
	<44C8FB2F.9070403@kernelconcepts.de>
In-Reply-To: <44C8FB2F.9070403@kernelconcepts.de>
MIME-Version: 1.0
Message-Id: <200607271818.37902.Bearcat@feline-soul.com>
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Mouse works now,
	but can't connect Logitech Cordless Elite keyboard
Reply-To: Bearcat@feline-soul.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Linux: 2.6.17
bluez (utils and libs) 3.1 
kdebluetooth 1.0_beta

Nothing seems to work when trying to connect this keyboard. The mouse works 
just fine. 

I entered pin_helper /usr/lib/kdebluetooth/kbluepin; into 
my /etc/bluetooth/hid.conf file.

If i do a "hciconfig /dev/usb/hiddev0 auth" and then jiggle the mouse i can 
see kdebluetooth trying to reconnect. It fails with a "LMP Responce Timeout". 
I never get asked for a pin. I have run kbluepin just do see what it would 
do. It does indeed run and return what i type in it.

Turning off auth via hciconfig and jiggling the mouse brings it back just 
fine.

Following Nils' instructions in the responce to Wolfram, i tried getting the 
keyboard to work that way. If i give the command "hcitool cc 
00:07:61:1B:50:9B" (the keyboards id) i get "Can't create connection: 
Input/output error"

A "hcitool scan", "hidd --search", "hcitool inq", "hcitool scan" find nothing, 
but a "hidd --show" shows me the mouse.

When the mouse is disconnected and i move it around i see the kbluetooth 
emblem blinking and it comes up. When i press the connect button on the 
keyboard or hit keys the kdebluetooth emblem doesn't so much as blink.

I know the keyboard works, and both keyboard and mouse work in pure hid (no 
hci) mode.

Any ideas at all?  Where do i start? I'm just chasing my tail here.

The  hub info:
hci0:   Type: USB
        BD Address: 00:07:61:1C:9F:D3 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:6053157 acl:423452 sco:0 events:15327 errors:0
        TX bytes:72942 acl:166 sco:0 commands:13618 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x34e LMP Ver: 1.1 (0x1) LMP Subver: 0x34e
        Manufacturer: Cambridge Silicon Radio (10)

Thank you in advance for the help,

Bearcat



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
