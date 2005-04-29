Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Attila Zsigmond <mail@backend-wizard.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200504291833.26111@ByZsA>
Subject: [Bluez-users] Something strange with minicom
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
Date: Fri, 29 Apr 2005 18:33:25 +0200

Hello

I'm trying to connect to my new mobile phone via a usb bluetooth 
dongle. I solved many problems (and learned a lot) but I'm 
stuck. I downloaded and installed the latest bluez stuff. 
(Version 2.16 at this time) It seems to work but I still can not 
comminicate with my phone. I can start everything and could pair 
my phone with my PC. When I start minicom to test the 
connection, I can type anything but phone answers with "error". 
I tried it with hyperterminal under windows and it works. So we 
shouldn't talk about hardware problems.

Here is my hciconfig -a output:
hci0:   Type: USB
        BD Address: 00:09:DD:10:6D:32 ACL MTU: 192:8 SCO MTU: 
64:8
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:1990 acl:51 sco:0 events:91 errors:0
        TX bytes:1174 acl:49 sco:0 commands:28 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'Cornflower'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x460 LMP Ver: 1.1 (0x1) LMP 
Subver: 0x460
        Manufacturer: Cambridge Silicon Radio (10)

And here is the "hcidump -x" result when I enter an "atz" modem 
command in minicom:
HCI sniffer - Bluetooth packet analyzer ver 1.20
device: hci0 snap_len: 1028 filter: 0xffffffff
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 0]
      0B EF 03 61 9A
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 0]
      09 FF 01 01 5C
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 0]
      0B EF 03 74 9A
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 0]
      09 FF 01 01 5C
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 0]
      0B EF 03 7A 9A
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 0]
      09 FF 01 01 5C
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 0]
      0B EF 03 0D 9A
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 0]
      09 FF 01 01 5C
> ACL data: handle 41 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 0]
      09 EF 13 0D 0A 45 52 52 4F 52 0D 0A 40

I noticed in the last line that there was "09 ef 13" echoed back 
instead of "atz". So I can understand why the modem says error 
but I can't understand how can it receive these characters.

What I missed? Can anybody help?

Attila 



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
