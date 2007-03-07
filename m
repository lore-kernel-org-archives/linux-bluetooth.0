Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45EF24C7.4070600@thebmwz3.co.uk>
Date: Wed, 07 Mar 2007 20:47:03 +0000
From: Andy <andy@thebmwz3.co.uk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] pand, bnep0 and no traffic flow
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

Hi all,
I'm trying to figure out where things are going wrong with my connection 
here.
Server A has /usr/bin/pand --listen -M --role=NAP
Server B has pand --connect 00:02:72:B2:EF:21

The two initiate the connection, and create the bnep0 interface. I set 
the IP addresses
ifconfig bnep0 10.0.0.1 netmask 255.255.255.0
ifconfig bnep0 10.0.0.2 netmask 255.255.255.0
respectively, and neither can ping each other.

Checking the interface on server B, I see TX packets (pinging to server 
A) but no RX packets. And on server A I see RX packets and no TX packets.

I started to think this was networking related, so disabled all iptables 
firewalls (flushed, then all rules set to PERMIT) but still nothing
When pings are running from B to A I see this (hcidump on server A):
 > ACL data: handle 41 flags 0x02 dlen 17
 > ACL data: handle 41 flags 0x01 dlen 17
 > ACL data: handle 41 flags 0x01 dlen 7
     L2CAP(d): cid 0x0040 len 37 [psm 0]
 > ACL data: handle 41 flags 0x02 dlen 17
 > ACL data: handle 41 flags 0x01 dlen 17
 > ACL data: handle 41 flags 0x01 dlen 7
     L2CAP(d): cid 0x0040 len 37 [psm 0]
 > ACL data: handle 41 flags 0x02 dlen 17
 > ACL data: handle 41 flags 0x01 dlen 17
 > ACL data: handle 41 flags 0x01 dlen 7
     L2CAP(d): cid 0x0040 len 37 [psm 0]


Server A:
hciconfig -a
hci0:   Type: USB
         BD Address: 00:02:72:B2:EF:DF ACL MTU: 192:8 SCO MTU: 64:8
         UP RUNNING PSCAN
         RX bytes:3347915 acl:39829 sco:0 events:100518 errors:0
         TX bytes:1048399 acl:24626 sco:0 commands:34394 errors:0
         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'geostat'
         Class: 0x3e0100
         Service Classes: Networking, Rendering, Capturing, Object 
Transfer, Audio
         Device Class: Computer, Uncategorized
         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP 
Subver: 0x20d
         Manufacturer: Cambridge Silicon Radio (10)

ip route
192.168.55.0/24 dev eth0  proto kernel  scope link  src 192.168.55.1
10.0.0.0/24 dev bnep0  proto kernel  scope link  src 10.0.0.2
default via 192.168.55.252 dev eth0



Server B:
  hciconfig -a
hci0:   Type: USB
         BD Address: 11:11:11:11:11:11 ACL MTU: 678:8 SCO MTU: 64:10
         UP RUNNING PSCAN ISCAN
         RX bytes:17351 acl:251 sco:0 events:569 errors:0
         TX bytes:24822 acl:464 sco:0 commands:37 errors:0
         Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy:
         Link mode: SLAVE ACCEPT
         Name: 'ISSCBTA'
         Class: 0x000000
         Service Classes: Unspecified
         Device Class: Miscellaneous,
         HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP 
Subver: 0x1fe
         Manufacturer: Integrated System Solution Corp. (57)

ip route
192.168.55.0/24 dev eth0  proto kernel  scope link  src 192.168.55.71
10.0.0.0/24 dev bnep0  proto kernel  scope link  src 10.0.0.1
default via 192.168.55.1 dev eth0

(they are both linked via ethernet at present also, so disregard the 
eth0 links)

Can anyone suggest what I can try to get this working please? It seems 
almost there!

Thanks in advance

-- 
Andy
e: andy @ thebmwz3.co.uk
e: andy @ broadcast-tech.co.uk

w: http://www.thebmwz3.co.uk
w: http://www.broadcast-tech.co.uk


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
