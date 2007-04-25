Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <462F8FCE.3090102@idlum.be>
Date: Wed, 25 Apr 2007 19:28:46 +0200
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------070006000700090206010301"
Subject: [Bluez-devel] Extremely slow SDP extraction from phone
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070006000700090206010301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm using BlueZ 3.9 and the DBus API from a custom application to 
extract the SDP records from a phone. To achieve this, I first perform a 
call to

array{uint32} GetRemoteServiceHandles(string address, string match)

with an empty "match" string. It does connect to Public Browse Group,
and returns handles for all the ServiceRecords. I then perform a call

array{byte} GetRemoteServiceRecord(string address, uint32 handle)

for each of these handles, and I get all the data in binary form, and I 
  deal with them myself in this form.

Problem is that I sometimes encounter very long delays to extract a 
record using its handle. Here is a summary of an example session (device 
was disconnected because of a timeout at higher level). Relevant portion 
of hcidump -XV output is attached.

09:53:19,339  Connection established (ACL link)
09:53:19,541  We got all the 6 handles (took 202ms)
09:53:19,841  Request for record on handle 0x0 sent
09:53:23,591  Record received (took 4050 ms)
09:53:23,841  Request for record on handle 0x10000 sent
09:53:33,886  Record received (took 10045 ms)
09:53:34,091  Request for record on handle 0x10001 sent
09:53:39,016  Record received (took 4925 ms)
09:53:39,340  Request for record on handle 0x10003 sent
09:53:44,186  Record received (took 4846 ms)
09:53:44,302  Request for record on handle 0x10005 sent
09:53:44,357  Record received (took 55ms)
09:53:44,591  Request for record on handle 0x10006 sent
09:53:44,775  Record received (took 184ms)
09:53:44,863  Request for record on handle 0x10007 sent
09:53:45,660  Connection disconnected due to my app

In this example (which is only a sample), we can see that time to 
extract a record is varying between 55 and 10045ms, which is quite a 
huge amount!

Is this kind of delay normal, and to be expected, or is something going 
wrong here? What strikes me is that as a test, I performed a full SDP 
extraction using another symbian phone using btdiscovery.sis, and it 
completed much faster than what I had just experienced with bluez. Right 
after that, I then re-tried from bluez, and again it was very slow.


Thanks in advance,
Best Regards.

Pierre-Yves Paulus


--------------070006000700090206010301
Content-Type: text/x-log;
 name="hcidump.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcidump.log"

2007-04-25 09:53:02,174 hci1  Going to run "/usr/sbin/hcidump -XV -i hci1"
2007-04-25 09:53:03,323 hci1  HCI sniffer - Bluetooth packet analyzer ver 1.32
2007-04-25 09:53:03,325 hci1  device: hci1 snap_len: 1028 filter: 0xffffffff
2007-04-25 09:53:03,330 hci1  < HCI Command: Write Local Name (0x03|0x0013) plen 248
2007-04-25 09:53:03,333 hci1      name ' '
2007-04-25 09:53:03,335 hci1  > HCI Event: Command Complete (0x0e) plen 4
2007-04-25 09:53:03,337 hci1      Write Local Name (0x03|0x0013) ncmd 1
2007-04-25 09:53:03,340 hci1      status 0x00
2007-04-25 09:53:03,342 hci1  < HCI Command: Read Local Name (0x03|0x0014) plen 0
2007-04-25 09:53:03,360 hci1  > HCI Event: Command Complete (0x0e) plen 252
2007-04-25 09:53:03,362 hci1      Read Local Name (0x03|0x0014) ncmd 1
2007-04-25 09:53:03,410 hci1      status 0x00 name ' '
2007-04-25 09:53:05,279 hci1  < HCI Command: Write Local Name (0x03|0x0013) plen 248
2007-04-25 09:53:05,290 hci1      name 'Dongles1'
2007-04-25 09:53:05,655 hci1  > HCI Event: Command Complete (0x0e) plen 4
2007-04-25 09:53:05,663 hci1      Write Local Name (0x03|0x0013) ncmd 1
2007-04-25 09:53:05,665 hci1      status 0x00
2007-04-25 09:53:05,667 hci1  < HCI Command: Read Local Name (0x03|0x0014) plen 0
2007-04-25 09:53:05,669 hci1  > HCI Event: Command Complete (0x0e) plen 252
2007-04-25 09:53:05,671 hci1      Read Local Name (0x03|0x0014) ncmd 1
2007-04-25 09:53:05,673 hci1      status 0x00 name 'Dongles1'
2007-04-25 09:53:11,208 hci1  Going to run "/usr/sbin/hcidump -XV -i hci1"
2007-04-25 09:53:12,275 hci1  HCI sniffer - Bluetooth packet analyzer ver 1.32
2007-04-25 09:53:12,280 hci1  device: hci1 snap_len: 1028 filter: 0xffffffff
2007-04-25 09:53:12,282 hci1  < HCI Command: Write Local Name (0x03|0x0013) plen 248
2007-04-25 09:53:12,285 hci1      name ' '
2007-04-25 09:53:12,287 hci1  > HCI Event: Command Complete (0x0e) plen 4
2007-04-25 09:53:12,302 hci1      Write Local Name (0x03|0x0013) ncmd 1
2007-04-25 09:53:12,304 hci1      status 0x00
2007-04-25 09:53:12,306 hci1  < HCI Command: Read Local Name (0x03|0x0014) plen 0
2007-04-25 09:53:12,322 hci1  > HCI Event: Command Complete (0x0e) plen 252
2007-04-25 09:53:12,546 hci1      Read Local Name (0x03|0x0014) ncmd 1
2007-04-25 09:53:12,548 hci1      status 0x00 name ' '
2007-04-25 09:53:13,017 hci1  < HCI Command: Write Local Name (0x03|0x0013) plen 248
2007-04-25 09:53:13,022 hci1      name 'Dongles1'
2007-04-25 09:53:13,024 hci1  > HCI Event: Command Complete (0x0e) plen 4
2007-04-25 09:53:13,026 hci1      Write Local Name (0x03|0x0013) ncmd 1
2007-04-25 09:53:13,028 hci1      status 0x00
2007-04-25 09:53:13,030 hci1  < HCI Command: Read Local Name (0x03|0x0014) plen 0
2007-04-25 09:53:13,050 hci1  > HCI Event: Command Complete (0x0e) plen 252
2007-04-25 09:53:13,052 hci1      Read Local Name (0x03|0x0014) ncmd 1
2007-04-25 09:53:13,054 hci1      status 0x00 name 'Dongles1'
2007-04-25 09:53:18,640 hci1  < HCI Command: Create Connection (0x01|0x0005) plen 13
2007-04-25 09:53:18,642 hci1      bdaddr 00:60:57:4F:EB:A0 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
2007-04-25 09:53:18,644 hci1      Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
2007-04-25 09:53:18,646 hci1  > HCI Event: Command Status (0x0f) plen 4
2007-04-25 09:53:18,648 hci1      Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-04-25 09:53:19,235 hci1  > HCI Event: Connect Complete (0x03) plen 11
2007-04-25 09:53:19,237 hci1      status 0x00 handle 11 bdaddr 00:60:57:4F:EB:A0 type ACL encrypt 0x00
2007-04-25 09:53:19,239 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:19,241 hci1      L2CAP(s): Connect req: psm 1 scid 0x0040
2007-04-25 09:53:19,243 hci1  < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
2007-04-25 09:53:19,247 hci1      handle 11
2007-04-25 09:53:19,249 hci1  > HCI Event: Command Status (0x0f) plen 4
2007-04-25 09:53:19,251 hci1      Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2007-04-25 09:53:19,253 hci1  < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
2007-04-25 09:53:19,273 hci1      handle 11 policy 0x0f
2007-04-25 09:53:19,274 hci1      Link policy: RSWITCH HOLD SNIFF PARK 
2007-04-25 09:53:19,278 hci1  > HCI Event: Read Remote Supported Features (0x0b) plen 11
2007-04-25 09:53:19,280 hci1      status 0x00 handle 11
2007-04-25 09:53:19,282 hci1      Features: 0xbf 0x28 0x21 0x00 0x00 0x00 0x00 0x00
2007-04-25 09:53:19,284 hci1  > HCI Event: Command Complete (0x0e) plen 6
2007-04-25 09:53:19,286 hci1      Write Link Policy Settings (0x02|0x000d) ncmd 1
2007-04-25 09:53:19,288 hci1      status 0x00 handle 11
2007-04-25 09:53:19,289 hci1  < HCI Command: Remote Name Request (0x01|0x0019) plen 10
2007-04-25 09:53:19,291 hci1      bdaddr 00:60:57:4F:EB:A0 mode 2 clkoffset 0x0000
2007-04-25 09:53:19,293 hci1  > HCI Event: Command Status (0x0f) plen 4
2007-04-25 09:53:19,295 hci1      Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2007-04-25 09:53:19,297 hci1  > HCI Event: Max Slots Change (0x1b) plen 3
2007-04-25 09:53:19,299 hci1      handle 11 slots 5
2007-04-25 09:53:19,326 hci1  > ACL data: handle 11 flags 0x02 dlen 16
2007-04-25 09:53:19,328 hci1      L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 1 status 2
2007-04-25 09:53:19,330 hci1        Connection pending - Authorization pending
2007-04-25 09:53:19,332 hci1  > HCI Event: Remote Name Req Complete (0x07) plen 255
2007-04-25 09:53:19,333 hci1      status 0x00 bdaddr 00:60:57:4F:EB:A0 name 'Nokia3650-JMM'
2007-04-25 09:53:19,380 hci1  > HCI Event: QoS Setup Complete (0x0d) plen 21
2007-04-25 09:53:19,393 hci1      status 0x00 handle 11 flags 0
2007-04-25 09:53:19,395 hci1      Service type: 1
2007-04-25 09:53:19,397 hci1      Token rate: 44800
2007-04-25 09:53:19,399 hci1      Peak bandwith: 0
2007-04-25 09:53:19,400 hci1      Latency: 5000
2007-04-25 09:53:19,402 hci1      Delay variation: -1
2007-04-25 09:53:19,404 hci1  > ACL data: handle 11 flags 0x02 dlen 16
2007-04-25 09:53:19,405 hci1      L2CAP(s): Connect rsp: dcid 0x007a scid 0x0040 result 0 status 0
2007-04-25 09:53:19,407 hci1        Connection successful
2007-04-25 09:53:19,410 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:19,412 hci1      L2CAP(s): Config req: dcid 0x007a flags 0x00 clen 0
2007-04-25 09:53:19,414 hci1  > ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:19,415 hci1      L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
2007-04-25 09:53:19,417 hci1  < ACL data: handle 11 flags 0x02 dlen 14
2007-04-25 09:53:19,419 hci1      L2CAP(s): Config rsp: scid 0x007a flags 0x00 result 0 clen 0
2007-04-25 09:53:19,421 hci1        Success
2007-04-25 09:53:19,454 hci1  > ACL data: handle 11 flags 0x02 dlen 14
2007-04-25 09:53:19,456 hci1      L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
2007-04-25 09:53:19,458 hci1        Success
2007-04-25 09:53:19,460 hci1  < ACL data: handle 11 flags 0x02 dlen 17
2007-04-25 09:53:19,462 hci1      L2CAP(d): cid 0x007a len 13 [psm 1]
2007-04-25 09:53:19,463 hci1          SDP SS Req: tid 0x0 len 0x8
2007-04-25 09:53:19,465 hci1            pat uuid-16 0x1002 (PubBrwsGrp)
2007-04-25 09:53:19,467 hci1            max 64
2007-04-25 09:53:19,469 hci1            cont 00
2007-04-25 09:53:19,471 hci1  > HCI Event: Number of Completed Packets (0x13) plen 5
2007-04-25 09:53:19,482 hci1      handle 11 packets 4
2007-04-25 09:53:19,487 hci1  > ACL data: handle 11 flags 0x02 dlen 38
2007-04-25 09:53:19,489 hci1      L2CAP(d): cid 0x0040 len 34 [psm 1]
2007-04-25 09:53:19,491 hci1          SDP SS Rsp: tid 0x0 len 0x1d
2007-04-25 09:53:19,493 hci1            count 6
2007-04-25 09:53:19,495 hci1            handles 0x10000 0x10001 0x10003 0x10005 0x10006 0x10007
2007-04-25 09:53:19,497 hci1            cont 00
2007-04-25 09:53:19,499 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:19,500 hci1      L2CAP(s): Disconn req: dcid 0x007a scid 0x0040
2007-04-25 09:53:19,502 hci1  > ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:19,504 hci1      L2CAP(s): Disconn rsp: dcid 0x007a scid 0x0040
2007-04-25 09:53:19,564 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:19,566 hci1      L2CAP(s): Connect req: psm 1 scid 0x0040
2007-04-25 09:53:19,585 hci1  > ACL data: handle 11 flags 0x02 dlen 16
2007-04-25 09:53:19,587 hci1      L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 1 status 2
2007-04-25 09:53:19,590 hci1        Connection pending - Authorization pending
2007-04-25 09:53:19,601 hci1  > ACL data: handle 11 flags 0x02 dlen 16
2007-04-25 09:53:19,603 hci1      L2CAP(s): Connect rsp: dcid 0x007b scid 0x0040 result 0 status 0
2007-04-25 09:53:19,605 hci1        Connection successful
2007-04-25 09:53:19,607 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:19,609 hci1      L2CAP(s): Config req: dcid 0x007b flags 0x00 clen 0
2007-04-25 09:53:19,611 hci1  > ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:19,613 hci1      L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
2007-04-25 09:53:19,615 hci1  < ACL data: handle 11 flags 0x02 dlen 14
2007-04-25 09:53:19,617 hci1      L2CAP(s): Config rsp: scid 0x007b flags 0x00 result 0 clen 0
2007-04-25 09:53:19,619 hci1        Success
2007-04-25 09:53:19,622 hci1  > HCI Event: Number of Completed Packets (0x13) plen 5
2007-04-25 09:53:19,624 hci1      handle 11 packets 4
2007-04-25 09:53:19,625 hci1  > ACL data: handle 11 flags 0x02 dlen 14
2007-04-25 09:53:19,627 hci1      L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
2007-04-25 09:53:19,630 hci1        Success
2007-04-25 09:53:19,631 hci1  < ACL data: handle 11 flags 0x02 dlen 23
2007-04-25 09:53:19,633 hci1      L2CAP(d): cid 0x007b len 19 [psm 1]
2007-04-25 09:53:19,635 hci1          SDP SA Req: tid 0x0 len 0xe
2007-04-25 09:53:19,637 hci1            handle 0x0
2007-04-25 09:53:19,639 hci1            max 65535
2007-04-25 09:53:19,641 hci1            aid(s) 0x0000 - 0xffff
2007-04-25 09:53:19,642 hci1            cont 00
2007-04-25 09:53:19,841 hci1  > HCI Event: Number of Completed Packets (0x13) plen 5
2007-04-25 09:53:19,843 hci1      handle 11 packets 1
2007-04-25 09:53:23,526 hci1  > ACL data: handle 11 flags 0x02 dlen 199
2007-04-25 09:53:23,528 hci1      L2CAP(d): cid 0x0040 len 195 [psm 1]
2007-04-25 09:53:23,530 hci1          SDP SA Rsp: tid 0x0 len 0xbe
2007-04-25 09:53:23,532 hci1            count 187
2007-04-25 09:53:23,533 hci1            aid 0x0000 (SrvRecHndl)
2007-04-25 09:53:23,535 hci1               uint 0x0
2007-04-25 09:53:23,537 hci1            aid 0x0001 (SrvClassIDList)
2007-04-25 09:53:23,539 hci1               < uuid-16 0x1000 (SDServer) >
2007-04-25 09:53:23,540 hci1            aid 0x0002 (SrvRecState)
2007-04-25 09:53:23,542 hci1               uint 0x0
2007-04-25 09:53:23,544 hci1            aid 0x0004 (ProtocolDescList)
2007-04-25 09:53:23,545 hci1               < < uuid-16 0x0100 (L2CAP) > >
2007-04-25 09:53:23,547 hci1            aid 0x0005 (BrwGrpList)
2007-04-25 09:53:23,549 hci1               < uuid-16 0x1000 (SDServer) >
2007-04-25 09:53:23,551 hci1            aid 0x0006 (LangBaseAttrIDList)
2007-04-25 09:53:23,552 hci1               < uint 0x656e uint 0x6a uint 0x100 >
2007-04-25 09:53:23,554 hci1            aid 0x0007 (SrvInfoTimeToLive)
2007-04-25 09:53:23,557 hci1               uint 0x4b0
2007-04-25 09:53:23,569 hci1            aid 0x0008 (SrvAvail)
2007-04-25 09:53:23,571 hci1               uint 0xff
2007-04-25 09:53:23,573 hci1            aid 0x0100 (SrvName)
2007-04-25 09:53:23,575 hci1               str "SDP Server"
2007-04-25 09:53:23,577 hci1            aid 0x0101 (SrvDesc)
2007-04-25 09:53:23,579 hci1               str "Provides local service information for remote devices."
2007-04-25 09:53:23,580 hci1            aid 0x0102 (ProviderName)
2007-04-25 09:53:23,582 hci1               str "Symbian Ltd."
2007-04-25 09:53:23,584 hci1            aid 0x0200 (VersionNumList)
2007-04-25 09:53:23,586 hci1               < uint 0x100 uint 0x101 >
2007-04-25 09:53:23,588 hci1            aid 0x0201 (SrvDBState)
2007-04-25 09:53:23,590 hci1               uint 0xa
2007-04-25 09:53:23,591 hci1            cont 00
2007-04-25 09:53:23,593 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:23,595 hci1      L2CAP(s): Disconn req: dcid 0x007b scid 0x0040
2007-04-25 09:53:23,597 hci1  > ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:23,599 hci1      L2CAP(s): Disconn rsp: dcid 0x007b scid 0x0040
2007-04-25 09:53:23,601 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:23,603 hci1      L2CAP(s): Connect req: psm 1 scid 0x0040
2007-04-25 09:53:23,605 hci1  > ACL data: handle 11 flags 0x02 dlen 16
2007-04-25 09:53:23,607 hci1      L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 1 status 2
2007-04-25 09:53:23,609 hci1        Connection pending - Authorization pending
2007-04-25 09:53:23,632 hci1  > ACL data: handle 11 flags 0x02 dlen 16
2007-04-25 09:53:23,634 hci1      L2CAP(s): Connect rsp: dcid 0x007c scid 0x0040 result 0 status 0
2007-04-25 09:53:23,636 hci1        Connection successful
2007-04-25 09:53:23,638 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:23,640 hci1      L2CAP(s): Config req: dcid 0x007c flags 0x00 clen 0
2007-04-25 09:53:23,644 hci1  > ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:23,646 hci1      L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
2007-04-25 09:53:23,648 hci1  < ACL data: handle 11 flags 0x02 dlen 14
2007-04-25 09:53:23,650 hci1      L2CAP(s): Config rsp: scid 0x007c flags 0x00 result 0 clen 0
2007-04-25 09:53:23,651 hci1        Success
2007-04-25 09:53:23,654 hci1  > HCI Event: Number of Completed Packets (0x13) plen 5
2007-04-25 09:53:23,655 hci1      handle 11 packets 4
2007-04-25 09:53:23,659 hci1  > ACL data: handle 11 flags 0x02 dlen 14
2007-04-25 09:53:23,672 hci1      L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
2007-04-25 09:53:23,674 hci1        Success
2007-04-25 09:53:23,676 hci1  < ACL data: handle 11 flags 0x02 dlen 23
2007-04-25 09:53:23,678 hci1      L2CAP(d): cid 0x007c len 19 [psm 1]
2007-04-25 09:53:23,680 hci1          SDP SA Req: tid 0x0 len 0xe
2007-04-25 09:53:23,681 hci1            handle 0x10000
2007-04-25 09:53:23,683 hci1            max 65535
2007-04-25 09:53:23,685 hci1            aid(s) 0x0000 - 0xffff
2007-04-25 09:53:23,687 hci1            cont 00
2007-04-25 09:53:23,841 hci1  > HCI Event: Number of Completed Packets (0x13) plen 5
2007-04-25 09:53:23,843 hci1      handle 11 packets 1
2007-04-25 09:53:33,837 hci1  > ACL data: handle 11 flags 0x02 dlen 101
2007-04-25 09:53:33,850 hci1      L2CAP(d): cid 0x0040 len 97 [psm 1]
2007-04-25 09:53:33,851 hci1          SDP SA Rsp: tid 0x0 len 0x5c
2007-04-25 09:53:33,853 hci1            count 89
2007-04-25 09:53:33,855 hci1            aid 0x0000 (SrvRecHndl)
2007-04-25 09:53:33,856 hci1               uint 0x10000
2007-04-25 09:53:33,858 hci1            aid 0x0001 (SrvClassIDList)
2007-04-25 09:53:33,860 hci1               < uuid-16 0x1111 (Fax) uuid-16 0x1204 (Telephony) >
2007-04-25 09:53:33,861 hci1            aid 0x0002 (SrvRecState)
2007-04-25 09:53:33,863 hci1               uint 0x6
2007-04-25 09:53:33,865 hci1            aid 0x0004 (ProtocolDescList)
2007-04-25 09:53:33,866 hci1               < < uuid-16 0x0100 (L2CAP) > <
2007-04-25 09:53:33,868 hci1               uuid-16 0x0003 (RFCOMM) uint 0x1 > >
2007-04-25 09:53:33,870 hci1            aid 0x0005 (BrwGrpList)
2007-04-25 09:53:33,872 hci1               < uuid-16 0x1002 (PubBrwsGrp) >
2007-04-25 09:53:33,873 hci1            aid 0x0006 (LangBaseAttrIDList)
2007-04-25 09:53:33,875 hci1               < uint 0x656e uint 0x6a uint 0x100 >
2007-04-25 09:53:33,877 hci1            aid 0x0009 (BTProfileDescList)
2007-04-25 09:53:33,880 hci1               < < uuid-16 0x1111 (Fax) uint 0x100 > >
2007-04-25 09:53:33,882 hci1            aid 0x0100 (SrvName)
2007-04-25 09:53:33,884 hci1               str "Fax"
2007-04-25 09:53:33,886 hci1            cont 00
2007-04-25 09:53:33,887 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:33,889 hci1      L2CAP(s): Disconn req: dcid 0x007c scid 0x0040
2007-04-25 09:53:33,891 hci1  > ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:33,892 hci1      L2CAP(s): Disconn rsp: dcid 0x007c scid 0x0040
2007-04-25 09:53:33,894 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:33,896 hci1      L2CAP(s): Connect req: psm 1 scid 0x0040
2007-04-25 09:53:33,898 hci1  > ACL data: handle 11 flags 0x02 dlen 16
2007-04-25 09:53:33,900 hci1      L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 1 status 2
2007-04-25 09:53:33,903 hci1        Connection pending - Authorization pending
2007-04-25 09:53:33,905 hci1  > ACL data: handle 11 flags 0x02 dlen 16
2007-04-25 09:53:33,907 hci1      L2CAP(s): Connect rsp: dcid 0x007d scid 0x0040 result 0 status 0
2007-04-25 09:53:33,910 hci1        Connection successful
2007-04-25 09:53:33,914 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:33,916 hci1      L2CAP(s): Config req: dcid 0x007d flags 0x00 clen 0
2007-04-25 09:53:33,918 hci1  > ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:33,930 hci1      L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
2007-04-25 09:53:33,932 hci1  < ACL data: handle 11 flags 0x02 dlen 14
2007-04-25 09:53:33,934 hci1      L2CAP(s): Config rsp: scid 0x007d flags 0x00 result 0 clen 0
2007-04-25 09:53:33,935 hci1        Success
2007-04-25 09:53:33,937 hci1  > HCI Event: Number of Completed Packets (0x13) plen 5
2007-04-25 09:53:33,939 hci1      handle 11 packets 4
2007-04-25 09:53:33,943 hci1  > ACL data: handle 11 flags 0x02 dlen 14
2007-04-25 09:53:33,944 hci1      L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
2007-04-25 09:53:33,946 hci1        Success
2007-04-25 09:53:33,948 hci1  < ACL data: handle 11 flags 0x02 dlen 23
2007-04-25 09:53:33,951 hci1      L2CAP(d): cid 0x007d len 19 [psm 1]
2007-04-25 09:53:33,953 hci1          SDP SA Req: tid 0x0 len 0xe
2007-04-25 09:53:33,955 hci1            handle 0x10001
2007-04-25 09:53:33,956 hci1            max 65535
2007-04-25 09:53:33,958 hci1            aid(s) 0x0000 - 0xffff
2007-04-25 09:53:33,959 hci1            cont 00
2007-04-25 09:53:34,091 hci1  > HCI Event: Number of Completed Packets (0x13) plen 5
2007-04-25 09:53:34,095 hci1      handle 11 packets 1
2007-04-25 09:53:38,965 hci1  > ACL data: handle 11 flags 0x02 dlen 116
2007-04-25 09:53:38,967 hci1      L2CAP(d): cid 0x0040 len 112 [psm 1]
2007-04-25 09:53:38,970 hci1          SDP SA Rsp: tid 0x0 len 0x6b
2007-04-25 09:53:38,972 hci1            count 104
2007-04-25 09:53:38,973 hci1            aid 0x0000 (SrvRecHndl)
2007-04-25 09:53:38,975 hci1               uint 0x10001
2007-04-25 09:53:38,977 hci1            aid 0x0001 (SrvClassIDList)
2007-04-25 09:53:38,978 hci1               < uuid-16 0x1103 (DUN) uuid-16 0x1201 (Networking) >
2007-04-25 09:53:38,980 hci1            aid 0x0002 (SrvRecState)
2007-04-25 09:53:38,982 hci1               uint 0x6
2007-04-25 09:53:38,995 hci1            aid 0x0004 (ProtocolDescList)
2007-04-25 09:53:38,997 hci1               < < uuid-16 0x0100 (L2CAP) > <
2007-04-25 09:53:38,998 hci1               uuid-16 0x0003 (RFCOMM) uint 0x1 > >
2007-04-25 09:53:39,000 hci1            aid 0x0005 (BrwGrpList)
2007-04-25 09:53:39,004 hci1               < uuid-16 0x1002 (PubBrwsGrp) >
2007-04-25 09:53:39,006 hci1            aid 0x0006 (LangBaseAttrIDList)
2007-04-25 09:53:39,007 hci1               < uint 0x656e uint 0x6a uint 0x100 >
2007-04-25 09:53:39,009 hci1            aid 0x0009 (BTProfileDescList)
2007-04-25 09:53:39,011 hci1               < < uuid-16 0x1103 (DUN) uint 0x100 > >
2007-04-25 09:53:39,012 hci1            aid 0x0100 (SrvName)
2007-04-25 09:53:39,014 hci1               str "Dial-up Networking"
2007-04-25 09:53:39,016 hci1            cont 00
2007-04-25 09:53:39,017 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:39,019 hci1      L2CAP(s): Disconn req: dcid 0x007d scid 0x0040
2007-04-25 09:53:39,021 hci1  > ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:39,022 hci1      L2CAP(s): Disconn rsp: dcid 0x007d scid 0x0040
2007-04-25 09:53:39,028 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:39,030 hci1      L2CAP(s): Connect req: psm 1 scid 0x0040
2007-04-25 09:53:39,052 hci1  > ACL data: handle 11 flags 0x02 dlen 16
2007-04-25 09:53:39,054 hci1      L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 1 status 2
2007-04-25 09:53:39,056 hci1        Connection pending - Authorization pending
2007-04-25 09:53:39,122 hci1  > ACL data: handle 11 flags 0x02 dlen 16
2007-04-25 09:53:39,123 hci1      L2CAP(s): Connect rsp: dcid 0x007e scid 0x0040 result 0 status 0
2007-04-25 09:53:39,125 hci1        Connection successful
2007-04-25 09:53:39,127 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:39,128 hci1      L2CAP(s): Config req: dcid 0x007e flags 0x00 clen 0
2007-04-25 09:53:39,142 hci1  > ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:39,143 hci1      L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
2007-04-25 09:53:39,145 hci1  < ACL data: handle 11 flags 0x02 dlen 14
2007-04-25 09:53:39,147 hci1      L2CAP(s): Config rsp: scid 0x007e flags 0x00 result 0 clen 0
2007-04-25 09:53:39,149 hci1        Success
2007-04-25 09:53:39,151 hci1  > HCI Event: Number of Completed Packets (0x13) plen 5
2007-04-25 09:53:39,152 hci1      handle 11 packets 4
2007-04-25 09:53:39,161 hci1  > ACL data: handle 11 flags 0x02 dlen 14
2007-04-25 09:53:39,173 hci1      L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
2007-04-25 09:53:39,175 hci1        Success
2007-04-25 09:53:39,177 hci1  < ACL data: handle 11 flags 0x02 dlen 23
2007-04-25 09:53:39,180 hci1      L2CAP(d): cid 0x007e len 19 [psm 1]
2007-04-25 09:53:39,182 hci1          SDP SA Req: tid 0x0 len 0xe
2007-04-25 09:53:39,184 hci1            handle 0x10003
2007-04-25 09:53:39,186 hci1            max 65535
2007-04-25 09:53:39,187 hci1            aid(s) 0x0000 - 0xffff
2007-04-25 09:53:39,189 hci1            cont 00
2007-04-25 09:53:39,340 hci1  > HCI Event: Number of Completed Packets (0x13) plen 5
2007-04-25 09:53:39,342 hci1      handle 11 packets 1
2007-04-25 09:53:44,153 hci1  > ACL data: handle 11 flags 0x02 dlen 101
2007-04-25 09:53:44,155 hci1      L2CAP(d): cid 0x0040 len 97 [psm 1]
2007-04-25 09:53:44,157 hci1          SDP SA Rsp: tid 0x0 len 0x5c
2007-04-25 09:53:44,158 hci1            count 89
2007-04-25 09:53:44,160 hci1            aid 0x0000 (SrvRecHndl)
2007-04-25 09:53:44,161 hci1               uint 0x10003
2007-04-25 09:53:44,163 hci1            aid 0x0001 (SrvClassIDList)
2007-04-25 09:53:44,165 hci1               < uuid-16 0x1101 (SP) >
2007-04-25 09:53:44,166 hci1            aid 0x0004 (ProtocolDescList)
2007-04-25 09:53:44,168 hci1               < < uuid-16 0x0100 (L2CAP) > <
2007-04-25 09:53:44,169 hci1               uuid-16 0x0003 (RFCOMM) uint 0x2 > >
2007-04-25 09:53:44,171 hci1            aid 0x0005 (BrwGrpList)
2007-04-25 09:53:44,173 hci1               < uuid-16 0x1002 (PubBrwsGrp) >
2007-04-25 09:53:44,174 hci1            aid 0x0006 (LangBaseAttrIDList)
2007-04-25 09:53:44,176 hci1               < uint 0x656e uint 0x6a uint 0x100 >
2007-04-25 09:53:44,178 hci1            aid 0x0100 (SrvName)
2007-04-25 09:53:44,179 hci1               str "Bluetooth Serial Port"
2007-04-25 09:53:44,186 hci1            cont 00
2007-04-25 09:53:44,188 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:44,189 hci1      L2CAP(s): Disconn req: dcid 0x007e scid 0x0040
2007-04-25 09:53:44,191 hci1  > ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:44,192 hci1      L2CAP(s): Disconn rsp: dcid 0x007e scid 0x0040
2007-04-25 09:53:44,194 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:44,196 hci1      L2CAP(s): Connect req: psm 1 scid 0x0040
2007-04-25 09:53:44,198 hci1  > ACL data: handle 11 flags 0x02 dlen 16
2007-04-25 09:53:44,200 hci1      L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 1 status 2
2007-04-25 09:53:44,201 hci1        Connection pending - Authorization pending
2007-04-25 09:53:44,242 hci1  > ACL data: handle 11 flags 0x02 dlen 16
2007-04-25 09:53:44,244 hci1      L2CAP(s): Connect rsp: dcid 0x007f scid 0x0040 result 0 status 0
2007-04-25 09:53:44,245 hci1        Connection successful
2007-04-25 09:53:44,247 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:44,249 hci1      L2CAP(s): Config req: dcid 0x007f flags 0x00 clen 0
2007-04-25 09:53:44,266 hci1  > ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:44,268 hci1      L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
2007-04-25 09:53:44,269 hci1  < ACL data: handle 11 flags 0x02 dlen 14
2007-04-25 09:53:44,271 hci1      L2CAP(s): Config rsp: scid 0x007f flags 0x00 result 0 clen 0
2007-04-25 09:53:44,272 hci1        Success
2007-04-25 09:53:44,274 hci1  > HCI Event: Number of Completed Packets (0x13) plen 5
2007-04-25 09:53:44,276 hci1      handle 11 packets 4
2007-04-25 09:53:44,277 hci1  > ACL data: handle 11 flags 0x02 dlen 14
2007-04-25 09:53:44,279 hci1      L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
2007-04-25 09:53:44,280 hci1        Success
2007-04-25 09:53:44,282 hci1  < ACL data: handle 11 flags 0x02 dlen 23
2007-04-25 09:53:44,284 hci1      L2CAP(d): cid 0x007f len 19 [psm 1]
2007-04-25 09:53:44,285 hci1          SDP SA Req: tid 0x0 len 0xe
2007-04-25 09:53:44,287 hci1            handle 0x10005
2007-04-25 09:53:44,299 hci1            max 65535
2007-04-25 09:53:44,301 hci1            aid(s) 0x0000 - 0xffff
2007-04-25 09:53:44,302 hci1            cont 00
2007-04-25 09:53:44,304 hci1  > ACL data: handle 11 flags 0x02 dlen 123
2007-04-25 09:53:44,306 hci1      L2CAP(d): cid 0x0040 len 119 [psm 1]
2007-04-25 09:53:44,308 hci1          SDP SA Rsp: tid 0x0 len 0x72
2007-04-25 09:53:44,310 hci1            count 111
2007-04-25 09:53:44,312 hci1            aid 0x0000 (SrvRecHndl)
2007-04-25 09:53:44,314 hci1               uint 0x10005
2007-04-25 09:53:44,315 hci1            aid 0x0001 (SrvClassIDList)
2007-04-25 09:53:44,317 hci1               < uuid-16 0x1105 (OBEXObjPush) >
2007-04-25 09:53:44,319 hci1            aid 0x0002 (SrvRecState)
2007-04-25 09:53:44,321 hci1               uint 0x7
2007-04-25 09:53:44,322 hci1            aid 0x0004 (ProtocolDescList)
2007-04-25 09:53:44,324 hci1               < < uuid-16 0x0100 (L2CAP) > <
2007-04-25 09:53:44,326 hci1               uuid-16 0x0003 (RFCOMM) uint 0x9 > <
2007-04-25 09:53:44,327 hci1               uuid-16 0x0008 (OBEX) > >
2007-04-25 09:53:44,329 hci1            aid 0x0005 (BrwGrpList)
2007-04-25 09:53:44,330 hci1               < uuid-16 0x1002 (PubBrwsGrp) >
2007-04-25 09:53:44,342 hci1            aid 0x0006 (LangBaseAttrIDList)
2007-04-25 09:53:44,344 hci1               < uint 0x656e uint 0x6a uint 0x100 >
2007-04-25 09:53:44,346 hci1            aid 0x0009 (BTProfileDescList)
2007-04-25 09:53:44,348 hci1               < < uuid-16 0x1105 (OBEXObjPush) uint 0x100 > >
2007-04-25 09:53:44,350 hci1            aid 0x0100 (SrvName)
2007-04-25 09:53:44,351 hci1               str "OBEX Object Push"
2007-04-25 09:53:44,353 hci1            aid 0x0303 (SuppFormatsList)
2007-04-25 09:53:44,354 hci1               < uint 0xff >
2007-04-25 09:53:44,357 hci1            cont 00
2007-04-25 09:53:44,358 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:44,360 hci1      L2CAP(s): Disconn req: dcid 0x007f scid 0x0040
2007-04-25 09:53:44,362 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:44,363 hci1      L2CAP(s): Connect req: psm 1 scid 0x0041
2007-04-25 09:53:44,365 hci1  > ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:44,367 hci1      L2CAP(s): Disconn rsp: dcid 0x007f scid 0x0040
2007-04-25 09:53:44,369 hci1  > ACL data: handle 11 flags 0x02 dlen 16
2007-04-25 09:53:44,371 hci1      L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 1 status 2
2007-04-25 09:53:44,372 hci1        Connection pending - Authorization pending
2007-04-25 09:53:44,374 hci1  > ACL data: handle 11 flags 0x02 dlen 16
2007-04-25 09:53:44,376 hci1      L2CAP(s): Connect rsp: dcid 0x0080 scid 0x0041 result 0 status 0
2007-04-25 09:53:44,377 hci1        Connection successful
2007-04-25 09:53:44,379 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:44,380 hci1      L2CAP(s): Config req: dcid 0x0080 flags 0x00 clen 0
2007-04-25 09:53:44,382 hci1  > HCI Event: Number of Completed Packets (0x13) plen 5
2007-04-25 09:53:44,386 hci1      handle 11 packets 4
2007-04-25 09:53:44,387 hci1  > ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:44,389 hci1      L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
2007-04-25 09:53:44,391 hci1  < ACL data: handle 11 flags 0x02 dlen 14
2007-04-25 09:53:44,392 hci1      L2CAP(s): Config rsp: scid 0x0080 flags 0x00 result 0 clen 0
2007-04-25 09:53:44,397 hci1        Success
2007-04-25 09:53:44,399 hci1  > ACL data: handle 11 flags 0x02 dlen 14
2007-04-25 09:53:44,400 hci1      L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
2007-04-25 09:53:44,402 hci1        Success
2007-04-25 09:53:44,404 hci1  < ACL data: handle 11 flags 0x02 dlen 23
2007-04-25 09:53:44,405 hci1      L2CAP(d): cid 0x0080 len 19 [psm 1]
2007-04-25 09:53:44,407 hci1          SDP SA Req: tid 0x0 len 0xe
2007-04-25 09:53:44,417 hci1            handle 0x10006
2007-04-25 09:53:44,419 hci1            max 65535
2007-04-25 09:53:44,420 hci1            aid(s) 0x0000 - 0xffff
2007-04-25 09:53:44,422 hci1            cont 00
2007-04-25 09:53:44,591 hci1  > HCI Event: Number of Completed Packets (0x13) plen 5
2007-04-25 09:53:44,596 hci1      handle 11 packets 2
2007-04-25 09:53:44,728 hci1  > ACL data: handle 11 flags 0x02 dlen 118
2007-04-25 09:53:44,730 hci1      L2CAP(d): cid 0x0041 len 114 [psm 1]
2007-04-25 09:53:44,732 hci1          SDP SA Rsp: tid 0x0 len 0x6d
2007-04-25 09:53:44,733 hci1            count 106
2007-04-25 09:53:44,735 hci1            aid 0x0000 (SrvRecHndl)
2007-04-25 09:53:44,737 hci1               uint 0x10006
2007-04-25 09:53:44,738 hci1            aid 0x0001 (SrvClassIDList)
2007-04-25 09:53:44,740 hci1               < uuid-16 0x1106 (OBEXObjTrnsf) >
2007-04-25 09:53:44,741 hci1            aid 0x0002 (SrvRecState)
2007-04-25 09:53:44,743 hci1               uint 0x6
2007-04-25 09:53:44,744 hci1            aid 0x0004 (ProtocolDescList)
2007-04-25 09:53:44,746 hci1               < < uuid-16 0x0100 (L2CAP) > <
2007-04-25 09:53:44,748 hci1               uuid-16 0x0003 (RFCOMM) uint 0xa > <
2007-04-25 09:53:44,749 hci1               uuid-16 0x0008 (OBEX) > >
2007-04-25 09:53:44,751 hci1            aid 0x0005 (BrwGrpList)
2007-04-25 09:53:44,753 hci1               < uuid-16 0x1002 (PubBrwsGrp) >
2007-04-25 09:53:44,755 hci1            aid 0x0006 (LangBaseAttrIDList)
2007-04-25 09:53:44,756 hci1               < uint 0x656e uint 0x6a uint 0x100 >
2007-04-25 09:53:44,758 hci1            aid 0x0009 (BTProfileDescList)
2007-04-25 09:53:44,760 hci1               < < uuid-16 0x1106 (OBEXObjTrnsf) uint 0x100 > >
2007-04-25 09:53:44,761 hci1            aid 0x0100 (SrvName)
2007-04-25 09:53:44,764 hci1               str "OBEX File Transfer"
2007-04-25 09:53:44,775 hci1            cont 00
2007-04-25 09:53:44,777 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:44,778 hci1      L2CAP(s): Disconn req: dcid 0x0080 scid 0x0041
2007-04-25 09:53:44,780 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:44,782 hci1      L2CAP(s): Connect req: psm 1 scid 0x0040
2007-04-25 09:53:44,784 hci1  > ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:44,786 hci1      L2CAP(s): Disconn rsp: dcid 0x0080 scid 0x0041
2007-04-25 09:53:44,787 hci1  > ACL data: handle 11 flags 0x02 dlen 16
2007-04-25 09:53:44,789 hci1      L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 1 status 2
2007-04-25 09:53:44,790 hci1        Connection pending - Authorization pending
2007-04-25 09:53:44,792 hci1  > ACL data: handle 11 flags 0x02 dlen 16
2007-04-25 09:53:44,794 hci1      L2CAP(s): Connect rsp: dcid 0x0081 scid 0x0040 result 0 status 0
2007-04-25 09:53:44,795 hci1        Connection successful
2007-04-25 09:53:44,797 hci1  < ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:44,798 hci1      L2CAP(s): Config req: dcid 0x0081 flags 0x00 clen 0
2007-04-25 09:53:44,831 hci1  > ACL data: handle 11 flags 0x02 dlen 12
2007-04-25 09:53:44,833 hci1      L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
2007-04-25 09:53:44,834 hci1  < ACL data: handle 11 flags 0x02 dlen 14
2007-04-25 09:53:44,836 hci1      L2CAP(s): Config rsp: scid 0x0081 flags 0x00 result 0 clen 0
2007-04-25 09:53:44,838 hci1        Success
2007-04-25 09:53:44,842 hci1  > HCI Event: Number of Completed Packets (0x13) plen 5
2007-04-25 09:53:44,844 hci1      handle 11 packets 4
2007-04-25 09:53:44,848 hci1  > ACL data: handle 11 flags 0x02 dlen 14
2007-04-25 09:53:44,850 hci1      L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
2007-04-25 09:53:44,851 hci1        Success
2007-04-25 09:53:44,853 hci1  < ACL data: handle 11 flags 0x02 dlen 23
2007-04-25 09:53:44,855 hci1      L2CAP(d): cid 0x0081 len 19 [psm 1]
2007-04-25 09:53:44,856 hci1          SDP SA Req: tid 0x0 len 0xe
2007-04-25 09:53:44,858 hci1            handle 0x10007
2007-04-25 09:53:44,860 hci1            max 65535
2007-04-25 09:53:44,861 hci1            aid(s) 0x0000 - 0xffff
2007-04-25 09:53:44,863 hci1            cont 00
2007-04-25 09:53:45,091 hci1  > HCI Event: Number of Completed Packets (0x13) plen 5
2007-04-25 09:53:45,103 hci1      handle 11 packets 1
2007-04-25 09:53:45,643 hci1  < HCI Command: Disconnect (0x01|0x0006) plen 3
2007-04-25 09:53:45,645 hci1      handle 11 reason 0x13
2007-04-25 09:53:45,656 hci1      Reason: Remote User Terminated Connection
2007-04-25 09:53:45,659 hci1  > HCI Event: Command Status (0x0f) plen 4
2007-04-25 09:53:45,660 hci1      Disconnect (0x01|0x0006) status 0x00 ncmd 1
2007-04-25 09:53:45,870 hci1  > HCI Event: Disconn Complete (0x05) plen 4
2007-04-25 09:53:45,876 hci1      status 0x00 handle 11 reason 0x16
2007-04-25 09:53:45,877 hci1      Reason: Connection Terminated by Local Host

--------------070006000700090206010301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------070006000700090206010301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------070006000700090206010301--
