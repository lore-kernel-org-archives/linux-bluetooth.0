Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44870369.2050102@biblio.polimi.it>
Date: Wed, 07 Jun 2006 18:48:41 +0200
From: Alessandro Boggiano <boggiano@biblio.polimi.it>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Motorola HS 810 Device or resource busy
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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

Hello all,
just trying to have my motorola HS810 to work,everything works fine 
until I try to play a wav; I alway get:


[root@localhost alsa-plugins]# btsco -v 00:07:A4:34:3E:F8
btsco v0.42
Device is 2:0
Voice setting: 0x0060
RFCOMM channel 1 connected
Using interface hci0

(now I try to play a sound)

speaker volume: 2 mic volume: 1
i/o needed: connecting sco...
Can't connect SCO audio channel
: Device or resource busy
RFCOMM channel lost
i/o needed: connecting sco...
Can't connect SCO audio channel
: Device or resource busy




this is what I see with hcidump:


< ACL data: handle 1 flags 0x02 dlen 17
     L2CAP(d): cid 0x0041 len 13 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 9 fcs 0x9a
< ACL data: handle 1 flags 0x02 dlen 17
     L2CAP(d): cid 0x0041 len 13 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 9 fcs 0x9a
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
     handle 1 ptype 0x00e0
     Packet type: HV1 HV2 HV3
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Disconn Complete (0x05) plen 4
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:07:A4:34:3E:F8 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
     bdaddr 00:07:A4:34:3E:F8
     Link key: e44ec54cb61df78d07dc617bf6a7169a
 > HCI Event: Command Complete (0x0e) plen 10
 > HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
     handle 1 policy 0x0f
     Link policy: RSWITCH HOLD SNIFF PARK
 > HCI Event: Max Slots Change (0x1b) plen 3
 > HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
     handle 1 ptype 0x00e0
     Packet type: HV1 HV2 HV3
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Connection Packet Type Changed (0x1d) plen 5
< HCI Command: Disconnect (0x01|0x0006) plen 3
     handle 1 reason 0x13
     Reason: Remote User Teminated Connection
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Disconn Complete (0x05) plen 4


sco,snd_bt_sco,snd_hwdep,l2cap and rfcomm are loaded


Any help,please?

Thanks
Alessandro



_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
