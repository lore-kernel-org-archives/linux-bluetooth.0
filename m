Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42C8E49D.5070401@yahoo.it>
From: Andrea Cimino <andreacima@yahoo.it>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: [Bluez-users] Motorola HS805 Headset Help Request
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
Date: Mon, 04 Jul 2005 09:26:21 +0200

Hi,
first of all sorry for my poor english! I have this problem: yesterday i 
bought an USB Bluetooth adaptor(TRUST BT180) + a HS805 Wireless Headset. 
With Windows XP no problem, so i'm quite sure that all things seems to 
work.  Obviously  i would like to get things work with Linux too! I have 
installed Ubuntu Hoary. Installed also the Bluez framework (first from 
packages, than from scratch).

That's the output of hciconfig -a

ci0:   Type: USB
       BD Address: 00:0B:0D:60:B5:F3 ACL MTU: 377:10 SCO MTU: 16:0
       UP RUNNING PSCAN ISCAN AUTH ENCRYPT
       RX bytes:1390 acl:15 sco:0 events:106 errors:0
       TX bytes:1673 acl:16 sco:0 commands:69 errors:0
       Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
       Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
       Link policy: RSWITCH HOLD SNIFF PARK
       Link mode: SLAVE ACCEPT
       Name: 'BlueZ (0)'
       Class: 0x3e0100
       Service Classes: Networking, Rendering, Capturing
       Device Class: Computer, Uncategorized
       HCI Ver: 1.2 (0x2) HCI Rev: 0x4 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
       Manufacturer: Broadcom Corporation (15)

Info for the headset using hcitool

BD Address:  00:0B:2E:31:33:36
       Device Name: Motorola HS805
       LMP Version: 1.2 (0x2) LMP Subversion: 0x60d
       Manufacturer: Cambridge Silicon Radio (10)
       Features: 0xff 0xff 0x0b 0x00 0x08 0x08 0x00 0x00
               <3-slot packets> <5-slot packets> <encryption> <slot offset>
               <timing accuracy> <role switch> <hold mode> <sniff mode>
               <park state> <RSSI> <channel quality> <SCO link> <HV2 
packets>
               <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
               <transparent SCO> <AFH cap. slave> <AFH cap. master>


i built alsa-bluetooth with success. After some work.. the connection 
worked: this is the output...

root@ubuntu:/susers/andrea/tmp/bluez-utils-2.17/tools# /usr/bin/btsco -v 
00:0B:2E:31:33:36
btsco v0.4c
Device is 0:0
Voice setting: 0x0060
RFCOMM channel 1 connected
recieved AT+CKPD=200
speaker volume: 11 mic volume: 1
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=11
Sending up speaker change 11
recieved AT+VGS=13
Sending up speaker change 13
recieved AT+VGS=11
Sending up speaker change 11
recieved AT+VGS=09
Sending up speaker change 9
recieved AT+CKPD=200
recieved AT+CKPD=200
recieved AT+VGS=11
Sending up speaker change 11
recieved AT+VGS=13
Sending up speaker change 13
recieved AT+VGS=15
Sending up speaker change 15
recieved AT+CKPD=200

If i press the buttons on my headset, the volume decrease and increase 
(look at the previous output)...
The problem is that i hear no sound! And mic doesn't work... but if i 
increase the volume i hear some "clips"... but nothing more... Maybe 
it's something related with SCO? What does mean
RX bytes:1390 acl:15 sco:0 events:106 errors:0
       TX bytes:1673 acl:16 sco:0 commands:69 errors:0 ?

I really appreciate your help!

Cheers,
Andrea


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
