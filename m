Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40FCF471.4010501@daimi.au.dk>
From: "Rolf E. Thorup" <rolft@daimi.au.dk>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] SDP problems on embedded device
References: <40FC2322.4060204@daimi.au.dk> <1090270387.4400.100.camel@pegasus>
In-Reply-To: <1090270387.4400.100.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Tue, 20 Jul 2004 12:31:13 +0200

Marcel Holtmann wrote:
> Hi Rolf,

Hi Marcel

>>I have some problems with sdp on a Intrinsyc Cerfcube 255 
>>(http://www.intrinsyc.com/products/cerfcube/) running a Linux 2.4.19 
>>kernel patched with the mh17-patch (and some platform specific patches).
>>
>>The problem is that I can't get to discover anything on the device. I 
>>have tried with two mobile phones, and a laptop running RH 9.0.
>>
>> From the laptop I either try 'spdtool browse bdaddr' or 'sdptool search 
>>SP' after adding SP service to the SDP record of the Cerfcube. I am able 
>>to browse the service record of the mobile phone, but not the Cerfcube. 
>>The output could be: 'Failed to connect to SDP server on 
>>00:0A:94:00:20:2A: Resource temporarily unavailable'. Other reasons I 
>>have experienced are:  'Host is down', 'Connection timed out', and 
>>'Connection refused'.

[SNIP, some details and initial hcidump]

>>So, what to do next?
> 
> looks like a kernel or scheduling bug. Run "hcidump -x -t" on both sides
> so we can compare the data flow and the timestamps.

Here's the output from the laptop (browsing the Cerfcube):

HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff
1090319067.842941 < HCI Command: Create Connection (0x01|0x0005) plen 13
   2A 20 00 94 0A 00 18 CC 00 00 00 00 01
1090319067.846445 > HCI Event: Command Status (0x0f) plen 4
   00 01 05 04
1090319068.636871 > HCI Event: Connect Complete (0x03) plen 11
   00 29 00 2A 20 00 94 0A 00 01 00
1090319068.637297 < ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
1090319068.637345 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
   29 00 0F 00
1090319068.648902 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1090319068.658112 > HCI Event: Command Complete (0x0e) plen 6
   01 0D 08 00 29 00
1090319068.666028 > HCI Event: Page Scan Repetition Mode Change (0x20) 
plen 7
   2A 20 00 94 0A 00 01
1090319068.667769 > HCI Event: Max Slots Change (0x1b) plen 3
   29 00 05
1090319068.715975 > ACL data: handle 0x0029 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
1090319068.716411 < ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
1090319068.722627 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1090319068.745926 > ACL data: handle 0x0029 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
1090319107.835421 < ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
1090319107.849809 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1090319107.866512 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
1090319109.835420 < HCI Command: Disconnect (0x01|0x0006) plen 3
   29 00 13
1090319109.837924 > HCI Event: Command Status (0x0f) plen 4
   00 01 06 04
1090319109.875959 > HCI Event: Disconn Complete (0x05) plen 4
   00 29 00 16

and here's the output from the Cerfcube:

HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff
1090319478.496750 > HCI Event: Connect Request (0x04) plen 10
   74 05 B1 76 0C 00 00 01 00 01
1090319478.497886 < HCI Command: Accept Connection Request (0x01|0x0009) 
plen 7
   74 05 B1 76 0C 00 01
1090319478.512733 > HCI Event: Command Status (0x0f) plen 4
   00 01 09 04
1090319478.546741 > HCI Event: Connect Complete (0x03) plen 11
   00 29 00 74 05 B1 76 0C 00 01 00
1090319478.547821 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
   29 00 0F 00
1090319478.550769 > HCI Event: Page Scan Repetition Mode Change (0x20) 
plen 7
   74 05 B1 76 0C 00 01
1090319478.564746 > HCI Event: Command Complete (0x0e) plen 6
   01 0D 08 00 29 00
1090319478.565797 < HCI Command: Change Connection Packet Type 
(0x01|0x000f) plen 4
   29 00 18 CC
1090319478.584718 > HCI Event: Max Slots Change (0x1b) plen 3
   29 00 05
1090319478.588740 > HCI Event: Command Status (0x0f) plen 4
   00 01 0F 04
1090319478.592739 > HCI Event: Connection Packet Type Changed (0x1d) plen 5
   00 29 00 18 CC
1090319478.602746 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
1090319478.604041 < ACL data: handle 0x0029 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
1090319478.612733 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1090319478.618741 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
1090319478.619937 < ACL data: handle 0x0029 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
1090319478.620053 < ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
1090319478.642724 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1090319517.746003 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
1090319517.746236 < ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
1090319517.768987 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1090319519.848575 > HCI Event: Disconn Complete (0x05) plen 4
   00 29 00 13

Regards, Rolf


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
