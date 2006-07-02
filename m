Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <aa7ce83b0607020701m3885f893s41df751ddf6f62c@mail.gmail.com>
Date: Mon, 3 Jul 2006 00:01:40 +1000
From: "Ken Robinson" <kenrobinsonster@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] No bnep0 interface occuring - Problem now fixed
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

I finally think I found the source of the problem. I beleive the
korebot card was confused with the existing ethernet interface usbf
(my bluetooth connection was via usb and hci_usb). Once this interface
was brought down (using ifconfig usbf down) the interface seemed to
work correctly.



 An update to my earlier post below.

 on the korebot
 I changed the device -> class id in hcid.conf so it was 0x0203xx which meant
 it was Networking /Adhoc device with an access point. I don't think this
 really changed anything when I ran a pand --connect <bluetooth address>.

 I then tried to reconnect several times. I found this constant connection
 woke up the host computer in some way and I was able to get a bnep0
 interface. I don't understand how this happens.
 I then assigned ip address on both the korebot and the host computer and
 made sure both interfaces were up and running. I got this message on the
 korebot when I tried to ping.

       PING 192.168.1.23 (192.168.1.23): 56 data bytes
 NETDEV WATCHDOG: usbf: transmit timed out
 NETDEV WATCHDOG: usbf: transmit timed out
 NETDEV WATCHDOG: usbf: transmit timed out
 NETDEV WATCHDOG: usbf: transmit timed out
 NETDEV WATCHDOG: usbf: transmit timed out
 NETDEV WATCHDOG: usbf: transmit timed out
 NETDEV WATCHDOG: usbf: transmit timed out

 Is there some other trick to initialisation of the bnep0 interface?

 oot@Possibility:/home/krobinson# hcidump
 HCI sniffer - Bluetooth packet analyzer ver 1.23
 device: hci0 snap_len: 1028 filter: 0xffffffff
 > HCI Event: Connect Request (0x04) plen 10
 < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Role Change (0x12) plen 8
 > HCI Event: Connect Complete (0x03) plen 11
 < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
 > HCI Event: Max Slots Change (0x1b) plen 3
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Connection Packet Type Changed (0x1d) plen 5
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 15 scid 0x0040
 < ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 1691
 < ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
 < ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 1691
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 15 scid 0x0041
 < ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
       MTU 1691
 < ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
       Success
 < ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
       MTU 1691
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 15 scid 0x0042
 < ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0042 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 4
       MTU 1691
 < ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0
       Success
 < ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 4
       MTU 1691
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 15 scid 0x0043
 < ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0043 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen 4
       MTU 1691
 < ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 0 clen 0
       Success
 < ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen 4
       MTU 1691
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 15 scid 0x0044
 < ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0044 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0044 flags 0x00 clen 4
       MTU 1691
 < ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0044 flags 0x00 result 0 clen 0
       Success
 < ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0044 flags 0x00 clen 4
       MTU 1691
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0044 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 15 scid 0x0045
 < ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0045 scid 0x0045 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0045 flags 0x00 clen 4
       MTU 1691
 < ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0045 flags 0x00 result 0 clen 0
       Success
 < ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0045 flags 0x00 clen 4
       MTU 1691
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0045 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 15 scid 0x0046
 < ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0046 scid 0x0046 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0046 flags 0x00 clen 4
       MTU 1691
 < ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0046 flags 0x00 result 0 clen 0
       Success
 < ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0046 flags 0x00 clen 4
       MTU 1691
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0046 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 15 scid 0x0047
 < ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0047 scid 0x0047 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0047 flags 0x00 clen 4
       MTU 1691
 < ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0047 flags 0x00 result 0 clen 0
       Success
 < ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0047 flags 0x00 clen 4
       MTU 1691
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0047 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 42 flags 0x02 dlen 11
     L2CAP(d): cid 0x0047 len 7 [psm 15]
       BNEP: Control(0x01|0)
         Setup Req(0x01) size 0x02 dst 0x1116(NAP) src 0x1115(PANU)
 < ACL data: handle 42 flags 0x02 dlen 8
     L2CAP(d): cid 0x0047 len 4 [psm 15]
       BNEP: Control(0x01|0)
         Setup Rsp(0x02) res 0x0000
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 3
     L2CAP(d): cid 0x0047 len 16 [psm 15]
       BNEP: Control(0x01|0)
         Filter MultAddr Set(0x05) len 0x000c
           ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
 < ACL data: handle 42 flags 0x02 dlen 8
     L2CAP(d): cid 0x0047 len 4 [psm 15]
       BNEP: Control(0x01|0)
         Filter MultAddr Rsp(0x06) res 0x0000
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 3
     L2CAP(d): cid 0x0047 len 16 [psm 15]
       BNEP: Control(0x01|0)
         Filter MultAddr Set(0x05) len 0x000c
           ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
 < ACL data: handle 42 flags 0x02 dlen 8
     L2CAP(d): cid 0x0047 len 4 [psm 15]
       BNEP: Control(0x01|0)
         Filter MultAddr Rsp(0x06) res 0x0000
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 3
     L2CAP(d): cid 0x0047 len 16 [psm 15]
       BNEP: Control(0x01|0)
         Filter MultAddr Set(0x05) len 0x000c
           ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
 < ACL data: handle 42 flags 0x02 dlen 8
     L2CAP(d): cid 0x0047 len 4 [psm 15]
       BNEP: Control(0x01|0)
         Filter MultAddr Rsp(0x06) res 0x0000
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 5
 > ACL data: handle 42 flags 0x01 dlen 121
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 3
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 90
 > ACL data: handle 42 flags 0x01 dlen 13
     L2CAP(d): cid 0x0047 len 585 [psm 15]
       BNEP: Compressed DestOnly(0x04|0)
         dst ff:ff:ff:ff:ff:ff [proto 0x0800]
 > ACL data: handle 42 flags 0x02 dlen 121
 > ACL data: handle 42 flags 0x01 dlen 71
 > ACL data: handle 42 flags 0x01 dlen 121
 > ACL data: handle 42 flags 0x01 dlen 71
 > ACL data: handle 42 flags 0x01 dlen 121
 > ACL data: handle 42 flags 0x01 dlen 71
 > ACL data: handle 42 flags 0x01 dlen 13
     L2CAP(d): cid 0x0047 len 585 [psm 15]
       BNEP: Compressed DestOnly(0x04|0)
         dst ff:ff:ff:ff:ff:ff [proto 0x0800]
 > ACL data: handle 42 flags 0x02 dlen 121
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 3
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 90
 > ACL data: handle 42 flags 0x01 dlen 121
 > ACL data: handle 42 flags 0x01 dlen 71
 > ACL data: handle 42 flags 0x01 dlen 13
     L2CAP(d): cid 0x0047 len 585 [psm 15]
       BNEP: Compressed DestOnly(0x04|0)
         dst ff:ff:ff:ff:ff:ff [proto 0x0800]
 > ACL data: handle 42 flags 0x02 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 5
 > ACL data: handle 42 flags 0x01 dlen 121
 > ACL data: handle 42 flags 0x01 dlen 71
 > ACL data: handle 42 flags 0x01 dlen 121
 > ACL data: handle 42 flags 0x01 dlen 71
 > ACL data: handle 42 flags 0x01 dlen 13
     L2CAP(d): cid 0x0047 len 585 [psm 15]
       BNEP: Compressed DestOnly(0x04|0)
         dst ff:ff:ff:ff:ff:ff [proto 0x0800]
 > ACL data: handle 42 flags 0x02 dlen 32
     L2CAP(d): cid 0x0047 len 28 [psm 15]
       BNEP: Control(0x01|0)
         Filter MultAddr Set(0x05) len 0x0018
           ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
           01:00:5e:00:00:01 - 01:00:5e:00:00:01
 < ACL data: handle 42 flags 0x02 dlen 8
     L2CAP(d): cid 0x0047 len 4 [psm 15]
       BNEP: Control(0x01|0)
         Filter MultAddr Rsp(0x06) res 0x0000
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 42 flags 0x02 dlen 32
     L2CAP(d): cid 0x


			
 			
 			
 		 	


 				 			 		 		    	
 	
About SourceForge.net
About OSTG
Privacy Statement
Terms of Use
Advertise
Get Support
RSS 	

 		Powered by the SourceForge(r) collaborative development environment
from VA Software
 		(c)Copyright 2006 - OSTG Open Source Technology Group, All Rights Reserved

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
