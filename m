Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <400195D5.90807@Fampeeters.com>
From: Francesco Peeters <Francesco@Fampeeters.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: [Bluez-users] Bluez with Tungsten|T3: DUND does not see new connection!!!  HELP!!!
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 11 Jan 2004 19:28:37 +0100

I sent this a few days ago, but I'll try again, to make sure whether 
there really is nobody that can help me...

I'm new on the list, and am trying to get my Tungsten|T3 to talk to my 
RedHat 9 (vanilla kernel, updated to the latest RedHat patch version 
shortly before trying) laptop/home automation server.

I have been trying several days now to get this working, but no go!

Sorry for the length, but I'll be trying to get all information needed 
in this e-mail...

First off I have set up a profile for ppp in /etc/ppp/peers/btpalm:
[root@mrhouse peers]# cat btpalm
debug
57600
noipdefault
proxyarp
10.50.164.20:10.50.164.21
ms-dns 10.50.164.9
ktune
noauth
local
asyncmap 0
idle 1000
noipx
passive
silent

For Bluez I have these settings:
[root@mrhouse peers]# cat /etc/bluetooth/hcid.conf
# HCId options
options {
       autoinit yes;
       security auto;
       pairing multi;
       pin_helper /bin/bluepin;
}

# Default settings for HCI devices
device {
       name "%h - BlueZ (%d)";
       class 0x100;
       iscan enable; pscan enable;
       lm accept,master;
       lp hold,sniff,park,rswitch;
}

[root@mrhouse peers]# cat /etc/bluetooth/rfcomm.conf
rfcomm0 {
       bind no;
       device 00:10:60:A3:0F:30;
       channel 3;
       comment "Sitecom BT Dongle";
}

And in the modules:
[root@mrhouse peers]# cat /etc/modules.conf
alias xirc2ps_cs
alias usb-controller usb-ohci
alias net-pf-31    bluez
alias bt-proto-0   l2cap
alias bt-proto-2   sco
alias bt-proto-3   rfcomm
alias bt-proto-4   bnep
alias tty-ldisc-15 hci_uart
alias char-major-10-250 hci_vhci

A snipped dump of lsmod shows:
Module                  Size  Used by    Not tainted
rfcomm                 34720  10  (autoclean)
l2cap                  17932   2  (autoclean)
hci_usb                 9272   1
bluez                  37860   4  [rfcomm l2cap hci_usb]
usbcore                73280   1  [hci_usb hid usb-ohci]

The HCI is up:
[root@mrhouse peers]# hciconfig -a
hci0:   Type: USB
       BD Address: 00:10:60:A3:0F:30 ACL MTU: 192:8  SCO MTU: 64:8
       UP RUNNING PSCAN ISCAN
       RX bytes:5192 acl:25 sco:0 events:289 errors:0
       TX bytes:1901 acl:25 sco:0 commands:134 errors:0
       Features: 0xff 0xff 0x0f 0x00
       Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
       Link policy: RSWITCH HOLD SNIFF PARK
       Link mode: ACCEPT MASTER
       Name: 'mrhouse.fampeeters.com - BlueZ (0)'
       Class: 0x000100
       Service Classes: Unspecified
       Device Class: Computer, Uncategorized
       HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 
0x20d
       Manufacturer: Cambridge Silicon Radio (10)

A scan finds the T|T3, and I was able to pair them already:
[root@mrhouse peers]# hcitool scan
Scanning ...
       00:07:E0:30:EA:48       Francesco Peeters
[root@mrhouse peers]# hcitool info 00:07:E0:30:EA:48
Requesting information ...
       BD Address:  00:07:E0:30:EA:48
       Device Name: Francesco Peeters
       LMP Version: 1.1 (0x1) LMP Subversion: 0x700
       Manufacturer: Broadcom Corporation (15)
       Features: 0xff 0xff 0x0d 0x00
               <3-slot packets> <5-slot packets> <encryption> <slot offset>
               <timing accuracy> <role switch> <hold mode> <sniff mode>
               <park mode> <RSSI> <channel quality> <SCO link>
               <HV2 packets> <HV3 packets> <u-law log> <A-law log>
               <CVSD> <power control> <transparent SCO>

hcid and sdpd are running:
3853 ?        SW     0:00 [krfcommd]
3973 ?        S      0:00 hcid: processing events
3979 ?        S      0:00 /usr/sbin/sdpd
3983 pts/2    R      0:00 ps ax

But sdp browse does not return anything useful:
[root@mrhouse peers]# sdptool browse 00:07:E0:30:EA:48
Browsing 00:07:E0:30:EA:48 ...

Lastly, I start dund and attempt a connection:
[root@mrhouse peers]# dund -s --persist -n call btpalm
dund[3985]: DUN daemon ver 1.1
dund[3985]: Accept failed. Interrupted system call(4)

hcidump then shows this:
[root@mrhouse /]# hcidump -a
HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
 > HCI Event: Connect Request(0x04) plen 10
 H . 0 . . . . . . .
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
 H . 0 . . . .
 > HCI Event: Command Status(0x0f) plen 4
 . . . .
 > HCI Event: Role Change(0x12) plen 8
 . H . 0 . . . .
 > HCI Event: Connect Complete(0x03) plen 11
 . ) . H . 0 . . . . .
 > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
 H . 0 . . . .
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
 ) . . .
 > HCI Event: Command Complete(0x0e) plen 6
 . . . . ) .
< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
 ) . . .
 > HCI Event: Command Status(0x0f) plen 4
 . . . .
 > HCI Event: Connection Packet Type Changed(0x1d) plen 5
 . ) . . .
 > HCI Event: Max Slots Change(0x1b) plen 3
 ) . .
 > HCI Event: Disconn Complete(0x05) plen 4
 . ) . .

The T|T3 is set up to connect to the PC over BT, and it successfully 
found the PC via BT. After trying to connect I see this error: 
Error:Serial:timeout.Could be bad cable or faulty Modem. (0x0305).

I can successfully connect to the Internet over my Ericsson T68 via BT...

Any help will be appreciated!

--FP



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
