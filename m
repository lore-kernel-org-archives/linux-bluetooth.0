Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: James Fitzsimons <james.fitzsimons@gmail.com>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1111528750.12076.18.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] btsco and Nokia HDW-3 headset not working
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
Date: Tue, 22 Mar 2005 21:59:10 +0000

Hi all,

I am trying to get btsco working with my Nokia HDW-3 headset so I can
use skype from linux. I am can use skype under Windoze at the moment
with the headset and dongle so I know this setup works.

The thing is, I can connect and pair with the headset under linux. I can
even control the volume in alsamixer using the headset controls. I just
can't get any sound! For example if I configure XMMS to use the headset
as output it simply doesn't play.

I have included the following output suggested to assist with debugging
from http://bluetooth-alsa.sourceforge.net.

The output of hciconfig hci0 -a:
hci0:   Type: USB
        BD Address: 00:10:60:AC:B0:7A ACL MTU: 377:10  SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN 
        RX bytes:1394 acl:36 sco:0 events:62 errors:0
        TX bytes:849 acl:23 sco:0 commands:25 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'Athos'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x1 LMP Ver: 1.2 (0x2) LMP Subver:
0x6963
        Manufacturer: Broadcom Corporation (15)


athos root # hciconfig hci0 revsion
hci0:   Type: USB
        BD Address: 00:10:60:AC:B0:7A ACL MTU: 377:10  SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN 
        RX bytes:1671 acl:36 sco:0 events:65 errors:0
        TX bytes:858 acl:23 sco:0 commands:28 errors:0

So I think this dongle should be fine right?

Now when I try to connect I get the following:

athos root # sdptool search --bdaddr 00:03:89:67:8F:F7 0x1108
Class 0x1108
Searching for 0x1108 on 00:03:89:67:8F:F7 ...
Service Name: Headset
Service RecHandle: 0x10000
Service Class ID List:
  "Headset" (0x1108)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100

athos root # btsco 00:03:89:67:8F:F7 1
Device is 2:0
Voice setting: 0x0060
RFCOMM channel 1 connected
recieved AT+CKPD=200
opened hwdep
connected SCO channel
Setting sco fd
Done setting sco fd
recieved AT+VGS=15
Sending up speaker change 15
recieved AT+VGS=11
Sending up speaker change 11
recieved AT+VGS=09
Sending up speaker change 9
recieved AT+VGS=08
Sending up speaker change 8
recieved AT+VGS=09
Sending up speaker change 9
recieved AT+VGS=11
Sending up speaker change 11
recieved AT+VGS=15

That last bit is me fiddling with the volume controls on the headset.

athos root # hcitool info 00:03:89:67:8F:F7 (headset address)
Requesting information ...
        BD Address:  00:03:89:67:8F:F7
        Device Name: Nokia HDW-3
        LMP Version: 1.2 (0x2) LMP Subversion: 0x615
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xbc 0x28 0x01 0x00 0x08 0x08 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role
switch> 
                <sniff mode> <SCO link> <HV3 packets> <CVSD> <AFH cap.
slave> 
                <AFH cap. master>

athos root # hcidump -X
HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> ACL data: handle 0x0006 flags 0x02 dlen 17
> ACL data: handle 0x0006 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 15 [psm 0]
      0000: 09 ff 15 01 41 54 2b 56  47 53 3d 31 35 0d 5c    
....AT+VGS=15.\
< ACL data: handle 0x0006 flags 0x02 dlen 14
    L2CAP(d): cid 0x0048 len 10 [psm 0]
      0000: 0b ef 0d 0d 0a 4f 4b 0d  0a 9a                    .....OK...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 0x0006 flags 0x02 dlen 17
> ACL data: handle 0x0006 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 15 [psm 0]
      0000: 09 ff 15 01 41 54 2b 56  47 53 3d 31 31 0d 5c    
....AT+VGS=11.\
< ACL data: handle 0x0006 flags 0x02 dlen 14
    L2CAP(d): cid 0x0048 len 10 [psm 0]
      0000: 0b ef 0d 0d 0a 4f 4b 0d  0a 9a                    .....OK...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....

I am running gentoo linux with the following kernel:
athos root # uname -a
Linux athos.porthosnet.com 2.6.9-gentoo-r14 #11 Fri Mar 4 18:30:23 Local
time zone must be set--see zic manu x86_64 AMD Athlon(tm) 64 Processor
3400+ AuthenticAMD GNU/Linux

net-wireless/bluez-libs
      Latest version available: 2.10
      Latest version installed: 2.10
      Size of downloaded files: 261 kB
      Homepage:    http://bluez.sourceforge.net/
      Description: Bluetooth Userspace Libraries
      License:     GPL-2

*  net-wireless/bluez-utils
      Latest version available: 2.10-r1
      Latest version installed: 2.10-r1
      Size of downloaded files: 283 kB
      Homepage:    http://bluez.sourceforge.net/
      Description: bluetooth utilities
      License:     GPL-2

I appreciate any assistance you can provide.

Cheers,
James
-- 
It's 5.50 a.m.... Do you know where your stack pointer is ?



-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
