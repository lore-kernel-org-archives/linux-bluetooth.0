Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40FC2322.4060204@daimi.au.dk>
From: "Rolf E. Thorup" <rolft@daimi.au.dk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] SDP problems on embedded device
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
Date: Mon, 19 Jul 2004 21:38:10 +0200

Hi,

I have some problems with sdp on a Intrinsyc Cerfcube 255 
(http://www.intrinsyc.com/products/cerfcube/) running a Linux 2.4.19 
kernel patched with the mh17-patch (and some platform specific patches).

The problem is that I can't get to discover anything on the device. I 
have tried with two mobile phones, and a laptop running RH 9.0.

 From the laptop I either try 'spdtool browse bdaddr' or 'sdptool search 
SP' after adding SP service to the SDP record of the Cerfcube. I am able 
to browse the service record of the mobile phone, but not the Cerfcube. 
The output could be: 'Failed to connect to SDP server on 
00:0A:94:00:20:2A: Resource temporarily unavailable'. Other reasons I 
have experienced are:  'Host is down', 'Connection timed out', and 
'Connection refused'.

My final goal is to make a connection (SP profile) between a Midlet 
running on a Nokia 6600 and the Cerfcube. I have tested this setup with 
the laptop and the phone and it works. But this will only work if 
service discovery works.

At first I thought that maybe the problem was caused by using old 
versions of bluez on the Cerfcube, but I have just cross-compiled and 
installed bluez-2.8 (lib and utils) and the situation is the same.

Here's the output from 'hcidump -x' from the Cerfcube when trying 
'sdptool browse' from the laptop.

HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff
 > HCI Event: Connect Request (0x04) plen 10
   74 05 B1 76 0C 00 00 01 00 01
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
   74 05 B1 76 0C 00 01
 > HCI Event: Command Status (0x0f) plen 4
   00 01 09 04
 > HCI Event: Connect Complete (0x03) plen 11
   00 29 00 74 05 B1 76 0C 00 01 00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
   29 00 0F 00
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
   74 05 B1 76 0C 00 01
 > HCI Event: Command Complete (0x0e) plen 6
   01 0D 08 00 29 00
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
   29 00 18 CC
 > HCI Event: Max Slots Change (0x1b) plen 3
   29 00 05
 > HCI Event: Command Status (0x0f) plen 4
   00 01 0F 04
 > HCI Event: Connection Packet Type Changed (0x1d) plen 5
   00 29 00 18 CC
 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 0x0029 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
 > HCI Event: Disconn Complete (0x05) plen 4
   00 29 00 13

I'm using a USB bluetooth dongle for both the Cerfcube and the laptop.

So, what to do next?

Best regards, Rolf.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
