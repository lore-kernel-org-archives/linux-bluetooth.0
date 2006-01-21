Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43D1F456.2060301@cs.bgu.ac.il>
From: Niv <nivv@cs.bgu.ac.il>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: [Bluez-users] not working after upgrading
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
Date: Sat, 21 Jan 2006 10:44:06 +0200

Pls help me make it work again:


1.uname -a Linux blacky 2.6.15-ck2 #1 Fri Jan 20 16:43:16 IST 2006 i686 
AMD Athlon(tm) XP 3200+ AuthenticAMD GNU/Linux


2. upgraded to bluez-utils ver 2.24


3. modprobe snd-bt-sco loads fine. and I can change volume using alsamixer.


4.  btsco -v $BT_HEADSET

btsco v0.41
Device is 3:0
Error: Failed to connect to SDP server: Permission denied
Assuming channel 2

Voice setting: 0x0060
Can't connect RFCOMM channel: Permission denied


hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.29
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0D:44:33:59:D8 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0D:44:33:59:D8
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:0D:44:33:59:D8 key D574F97C59C57B1867B34E65F716603F
 > HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:0D:44:33:59:D8
 > HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 41 bdaddr 00:0D:44:33:59:D8 type ACL encrypt 0x00
    Error: Authentication Failure
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
 > HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0D:44:33:59:D8 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0D:44:33:59:D8
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:0D:44:33:59:D8 key D574F97C59C57B1867B34E65F716603F
 > HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:0D:44:33:59:D8
 > HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 42 bdaddr 00:0D:44:33:59:D8 type ACL encrypt 0x00
    Error: Authentication Failure




5. then I notice

l2ping 00:0D:44:33:59:D8

Can't connect: Permission denied


6. hcitool scan , does find the headset.


what  would I need t check next,

Niv



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
