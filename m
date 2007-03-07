Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C76103.5A6FC37B"
Date: Wed, 7 Mar 2007 22:54:05 +0100
Message-ID: <CE5216C10C83944D9FD37B65CD33F3970CF48D@mplex01.mpl.access-company.com>
References: <45EF24C7.4070600@thebmwz3.co.uk>
From: "Frederic Dalleau" <Frederic.Dalleau@access-company.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] pand, bnep0 and no traffic flow
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C76103.5A6FC37B
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Your kernel is probably configured to not answer ping incoming request.
look in /proc/sys/net/ipv4/

-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net on behalf of Andy
Sent: Wed 3/7/2007 12:47 PM
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] pand, bnep0 and no traffic flow
=20
Hi all,
I'm trying to figure out where things are going wrong with my connection =

here.
Server A has /usr/bin/pand --listen -M --role=3DNAP
Server B has pand --connect 00:02:72:B2:EF:21

The two initiate the connection, and create the bnep0 interface. I set=20
the IP addresses
ifconfig bnep0 10.0.0.1 netmask 255.255.255.0
ifconfig bnep0 10.0.0.2 netmask 255.255.255.0
respectively, and neither can ping each other.

Checking the interface on server B, I see TX packets (pinging to server=20
A) but no RX packets. And on server A I see RX packets and no TX =
packets.

I started to think this was networking related, so disabled all iptables =

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
         Service Classes: Networking, Rendering, Capturing, Object=20
Transfer, Audio
         Device Class: Computer, Uncategorized
         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP=20
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
         HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP=20
Subver: 0x1fe
         Manufacturer: Integrated System Solution Corp. (57)

ip route
192.168.55.0/24 dev eth0  proto kernel  scope link  src 192.168.55.71
10.0.0.0/24 dev bnep0  proto kernel  scope link  src 10.0.0.1
default via 192.168.55.1 dev eth0

(they are both linked via ethernet at present also, so disregard the=20
eth0 links)

Can anyone suggest what I can try to get this working please? It seems=20
almost there!

Thanks in advance

--=20
Andy
e: andy @ thebmwz3.co.uk
e: andy @ broadcast-tech.co.uk

w: http://www.thebmwz3.co.uk
w: http://www.broadcast-tech.co.uk


-------------------------------------------------------------------------=

Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share =
your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


------_=_NextPart_001_01C76103.5A6FC37B
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IiwVAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAMgAAAFJFOiBbQmx1ZXotdXNlcnNd
IHBhbmQsIGJuZXAwIGFuZCBubyB0cmFmZmljIGZsb3cAFREBBYADAA4AAADXBwMABwAWADYABQAD
ADwBASCAAwAOAAAA1wcDAAcAFgA3ACsAAwBjAQEJgAEAIQAAADk4MEMzQUM2OEZGQThENDQ5Mzk4
MjFGMUExM0UzQUI4AEkHAQOQBgCYEQAAOQAAAAMAJgAAAAAAAwA2AAAAAABAADkAMdhgIANhxwEe
AD0AAQAAAAUAAABSRTogAAAAAAIBRwABAAAAOAAAAGM9VVM7YT0gO3A9QWNjZXNzLUNvbXBhbnk7
bD1NUExFWDAxLTA3MDMwNzIxNTU0M1otMTgzNzYAHgBJAAEAAAAuAAAAW0JsdWV6LXVzZXJzXSBw
YW5kLCBibmVwMCBhbmQgbm8gdHJhZmZpYyBmbG93AAAAQABOAIB9hcL5YMcBHgBaAAEAAAAqAAAA
Ymx1ZXotdXNlcnMtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAACAVsAAQAAAHEAAAAA
AAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABibHVlei11c2Vycy1ib3VuY2VzQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldABTTVRQAGJsdWV6LXVzZXJzLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAA
AAIBXAABAAAALwAAAFNNVFA6QkxVRVotVVNFUlMtQk9VTkNFU0BMSVNUUy5TT1VSQ0VGT1JHRS5O
RVQAAB4AXQABAAAABQAAAEFuZHkAAAAAAgFeAAEAAAA2AAAAAAAAAIErH6S+oxAZnW4A3QEPVAIA
AAAAQW5keQBTTVRQAGFuZHlAdGhlYm13ejMuY28udWsAAAACAV8AAQAAABkAAABTTVRQOkFORFlA
VEhFQk1XWjMuQ08uVUsAAAAAHgBmAAEAAAAFAAAAU01UUAAAAAAeAGcAAQAAACoAAABibHVlei11
c2Vycy1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAB4AaAABAAAABQAAAFNNVFAAAAAA
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
sMKBT/H3wpBb4EOfQEUyV6A+6TLy/ztYkiAkkEafMvJItEizHQBdP0AvXzBEFw9afUyQAB4ANRAB
AAAASAAAADxDRTUyMTZDMTBDODM5NDREOUZEMzdCNjVDRDMzRjM5NzBDRjQ4REBtcGxleDAxLm1w
bC5hY2Nlc3MtY29tcGFueS5jb20+AB4AORABAAAAIgAAADw0NUVGMjRDNy40MDcwNjAwQHRoZWJt
d3ozLmNvLnVrPgAAAB4ARxABAAAADwAAAG1lc3NhZ2UvcmZjODIyAAALAPIQAQAAAB8A8xABAAAA
cAAAAFIARQAlADMAQQAgAFsAQgBsAHUAZQB6AC0AdQBzAGUAcgBzAF0AIABwAGEAbgBkACwAIABi
AG4AZQBwADAAIABhAG4AZAAgAG4AbwAgAHQAcgBhAGYAZgBpAGMAIABmAGwAbwB3AC4ARQBNAEwA
AAALAPYQAAAAAEAABzAx2GAgA2HHAUAACDDfTHlaA2HHAQMA3j+vbwAAAwDxPwkEAAAeAPg/AQAA
ABEAAABGcmVkZXJpYyBEYWxsZWF1AAAAAAIB+T8BAAAAXwAAAAAAAADcp0DIwEIQGrS5CAArL+GC
AQAAAAAAAAAvTz1BQ0NFU1MtQ09NUEFOWS9PVT1NT05UUEVMTElFUi9DTj1SRUNJUElFTlRTL0NO
PUZSRURFUklDLkRBTExFQVUAAB4A+j8BAAAAFQAAAFN5c3RlbSBBZG1pbmlzdHJhdG9yAAAAAAIB
+z8BAAAAHgAAAAAAAADcp0DIwEIQGrS5CAArL+GCAQAAAAAAAAAuAAAAAwD9P+QEAAADABlAAAAA
AAMAGkAAAAAAAwAdQAAAAAADAB5AAAAAAB4AMEABAAAAEQAAAEZSRURFUklDLkRBTExFQVUAAAAA
HgAxQAEAAAARAAAARlJFREVSSUMuREFMTEVBVQAAAAAeADJAAQAAACoAAABibHVlei11c2Vycy1i
b3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAB4AM0ABAAAAFAAAAGFuZHlAdGhlYm13ejMu
Y28udWsAHgA4QAEAAAARAAAARlJFREVSSUMuREFMTEVBVQAAAAAeADlAAQAAAAIAAAAuAAAAAwB2
QP////8LACkAAAAAAAsAIwAAAAAAAwAGEGezfb4DAAcQeAwAAAMAEBAAAAAAAwAREAAAAAAeAAgQ
AQAAAGUAAABZT1VSS0VSTkVMSVNQUk9CQUJMWUNPTkZJR1VSRURUT05PVEFOU1dFUlBJTkdJTkNP
TUlOR1JFUVVFU1RMT09LSU4vUFJPQy9TWVMvTkVUL0lQVjQvLS0tLS1PUklHSU5BTE1FAAAAAAIB
fwABAAAASAAAADxDRTUyMTZDMTBDODM5NDREOUZEMzdCNjVDRDMzRjM5NzBDRjQ4REBtcGxleDAx
Lm1wbC5hY2Nlc3MtY29tcGFueS5jb20+ABua

------_=_NextPart_001_01C76103.5A6FC37B
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C76103.5A6FC37B
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------_=_NextPart_001_01C76103.5A6FC37B--
