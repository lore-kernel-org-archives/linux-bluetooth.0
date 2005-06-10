Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42AA0EED.9060104@lesagepono.be>
From: Laurent Lesage <laurent@lesagepono.be>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] pairing plantronics M3000 with my laptop
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
Date: Fri, 10 Jun 2005 22:06:37 +0000

Hi all,

I finally got a plantronics M3000 and a bluetooth dongle trendnet TBW-102UB.
I'm using Debian Sarge, up to date, with bluez-utils 2.15, hcidump 1.17, 
kernel 2.6.8.2, debian patch for 2.6 kernel of 28th of march 2005.
First trial, dongle seems OK.
laptop:/etc/bluetooth# hciconfig -a
hci0:   Type: USB
        BD Address: 00:E0:98:FD:9A:BD ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:2135 acl:0 sco:0 events:82 errors:0
        TX bytes:1438 acl:0 sco:0 commands:59 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'laptop-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 
0x20d
        Manufacturer: Cambridge Silicon Radio (10)

for the M3000, I tried :
laptop:/etc/bluetooth# hcitool scan
Scanning ...
        00:03:89:4C:2D:C7       M3000 by Plantronics

And one of the very first times, I got info from the M3000 with hcitool 
info. "bluez-pin" asked me for the pin (0000) and got the info. After 
that, I used the headset under windows XP, with skype : it worked great 
as headset : clear sound, mic OK. Then back to Linux, and no way to get 
'hcitool info' again.

laptop:/etc/bluetooth# hcitool cc 00:03:89:4C:2D:C7
Can't create connection: Input/output error

I tried in pairing mode but always the same error. this is hcidump 
during "info", headset  in pairing mode or not :

laptop:/home/lesage# hcidump
HCI sniffer - Bluetooth packet analyzer ver 1.17
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
 > HCI Event: Command Complete (0x0e) plen 10
 > HCI Event: Connect Complete (0x03) plen 11

Finally, I don't understand why it worked the first time, and no more 
now. When it worked, I didn't have to give the PIN once given, to get 
the 'info" again. I suppose this is because the pairing was succesful?? 
How can I verify?

before I go further with 'blue-alsa' and so on, I suppose I have to be 
able to pair the device?

thanks for any link or information,

Laurent Lesage


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
