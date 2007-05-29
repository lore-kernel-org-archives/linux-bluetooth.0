Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <80236d750705290911g619e3d9eu8c6cda81c884b44d@mail.gmail.com>
Date: Tue, 29 May 2007 18:11:38 +0200
From: "Emanuele Novelli" <ema.novelli@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] [Bluez Users] Page timeout during sdp on heavy
	traffic.
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0504008536=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0504008536==
Content-Type: multipart/alternative;
	boundary="----=_Part_125700_18159075.1180455098997"

------=_Part_125700_18159075.1180455098997
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

I wrote a little application to simulate an heavy traffic.
Simply discovers devices using hci0 and for each device discovered starts a
thread to search service using hci1.
Rinse and repeat forever.
Usually I have 5-6 bluetooth devices in the area.
I'm not using d-bus messaging (yet) but i guess i'll try that too to check

Anyway I noticed a large number of timeouts during search services on
devices who previously returned correct service record.


hcidump of a usual scenario

this one  a correct connect and answer

2007-05-29 16:46:53.268457 < HCI Command: Create Connection (0x01|0x0005)
plen 13
    bdaddr 00:17:E2:0A:79:8D ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-05-29 16:46:53.290125 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-05-29 16:46:53.653134 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:17:E2:0A:79:8D type ACL encrypt 0x00
2007-05-29 16:46:53.653155 < ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
2007-05-29 16:46:53.653161 < HCI Command: Read Remote Supported Features
(0x01|0x001b) plen 2
    handle 42
2007-05-29 16:46:53.664138 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
2007-05-29 16:46:53.676153 > HCI Event: Number of Completed Packets (0x13)
plen 5
    handle 42 packets 1
2007-05-29 16:46:53.678133 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
2007-05-29 16:46:53.687136 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
2007-05-29 16:46:53.687155 < HCI Command: Write Link Policy Settings
(0x02|0x000d) plen 4
    handle 42 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
2007-05-29 16:46:53.691132 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 42
2007-05-29 16:46:53.691143 < HCI Command: Remote Name Request (0x01|0x0019)
plen 10
    bdaddr 00:17:E2:0A:79:8D mode 2 clkoffset 0x0000
2007-05-29 16:46:53.694136 > ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
2007-05-29 16:46:53.694151 < ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
2007-05-29 16:46:53.696140 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2007-05-29 16:46:53.697137 > ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1024
2007-05-29 16:46:53.697151 < ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 1024
2007-05-29 16:46:53.700133 > HCI Event: Read Remote Supported Features
(0x0b) plen 11
    status 0x00 handle 42
    Features: 0xff 0xfe 0x0d 0x00 0x08 0x08 0x00 0x00
2007-05-29 16:46:53.701140 > HCI Event: Number of Completed Packets (0x13)
plen 5
    handle 42 packets 1
2007-05-29 16:46:53.703138 > HCI Event: Number of Completed Packets (0x13)
plen 5
    handle 42 packets 1
2007-05-29 16:46:53.714139 > ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
2007-05-29 16:46:53.714287 < ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1105 (OBEXObjPush)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
2007-05-29 16:46:53.723134 > HCI Event: Remote Name Req Complete (0x07) plen
255
    status 0x00 bdaddr 00:17:E2:0A:79:8D name 'Motorola PEBL'
2007-05-29 16:46:53.724144 > HCI Event: Number of Completed Packets (0x13)
plen 5
    handle 42 packets 1
2007-05-29 16:46:53.979159 > ACL data: handle 42 flags 0x02 dlen 339
2007-05-29 16:46:53.994167 > ACL data: handle 42 flags 0x01 dlen 220
    L2CAP(d): cid 0x0040 len 555 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x226
          count 547
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10008
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1105 (OBEXObjPush) >
              aid 0x0002 (SrvRecState)
                 uint 0x1
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x8 > <
                 uuid-16 0x0008 (OBEX) > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 uint 0x6672 uint 0x6a
uint 0xc800 uint 0x6465 uint 0x6a uint 0xc803 uint 0x6974 uint 0x6a uint
0xc806 uint 0x6573 uint 0x6a uint 0xc809 uint 0x7472 uint 0x6a uint 0xc80c
uint 0x656c uint 0x6a uint 0xc80f >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1105 (OBEXObjPush) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "OBEX Object Push"
              aid 0x0101 (SrvDesc)
                 str "OBEX Object Push"
              aid 0x0102 (ProviderName)
                 str "Motorola"
              aid 0x0303 (SuppFormatsList)
                 < uint 0xff >
              aid 0xc800 (unknown)
                 str "Push objet OBEX"
              aid 0xc801 (unknown)
                 str "Push objet OBEX"
              aid 0xc802 (unknown)
                 str "Motorola"
              aid 0xc803 (unknown)
                 str "OBEX Objekt senden"
              aid 0xc804 (unknown)
                 str "OBEX Objekt senden"
              aid 0xc805 (unknown)
                 str "Motorola"
              aid 0xc806 (unknown)
                 str "Invio oggetto OBEX"
              aid 0xc807 (unknown)
                 str "Invio oggetto OBEX"
              aid 0xc808 (unknown)
                 str "Motorola"
              aid 0xc809 (unknown)
                 str "OBEX Object Push"
              aid 0xc80a (unknown)
                 str "OBEX Object Push"
              aid 0xc80b (unknown)
                 str "Motorola"
              aid 0xc80c (unknown)
                 str "OBEX Object Push"
              aid 0xc80d (unknown)
                 str "OBEX Object Push"
              aid 0xc80e (unknown)
                 str "Motorola"
              aid 0xc80f (unknown)
                 str ce 91 ce bd cf 84 ce b9 ce ba ce b5 ce af ce bc 2e 50
75 73
              aid 0xc810 (unknown)
                 str ce 91 ce bd cf 84 ce b9 ce ba ce b5 ce af ce bc 2e 50
75 73
              aid 0xc811 (unknown)
                 str "Motorola"
          cont 00
2007-05-29 16:46:53.994523 < ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
2007-05-29 16:46:54.000158 > HCI Event: Number of Completed Packets (0x13)
plen 5
    handle 42 packets 1
2007-05-29 16:46:54.010167 > ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
2007-05-29 16:46:56.009566 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 42 reason 0x13
    Reason: Remote User Terminated Connection
2007-05-29 16:46:56.014212 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
2007-05-29 16:46:56.017211 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x16
    Reason: Connection Terminated by Local Host


this one is a page timeout some minutes later (on the same device)

2007-05-29 16:57:46.372114 < HCI Command: Create Connection (0x01|0x0005)
plen 13
    bdaddr 00:17:E2:0A:79:8D ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-05-29 16:57:46.393452 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-05-29 16:57:56.397591 > HCI Event: Connect Complete (0x03) plen 11
    status 0x04 handle 0 bdaddr 00:17:E2:0A:79:8D type ACL encrypt 0x00
    Error: Page Timeout

This happens almost on all devices I contact. I wonder since this is a
rather close loop if something does not close on remote device during the
various attempts or if the problem is on the local HCI. Maybe the page
timeout is from the local device ? (hci1)

Going further ahead with the test the same devices start again answering
without problems and then again they timeout.

Any hint is welcome :)

------=_Part_125700_18159075.1180455098997
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi<br><br>I wrote a little application to simulate an heavy traffic.<br>Simply discovers devices using hci0 and for each device discovered starts a thread to search service using hci1.<br>Rinse and repeat forever.<br>Usually I have 5-6 bluetooth devices in the area.
<br>I&#39;m not using d-bus messaging (yet) but i guess i&#39;ll try that too to check<br><br>Anyway I noticed a large number of timeouts during search services on devices who previously returned correct service record.<br>
<br><br>hcidump of a usual scenario<br><br>this one&nbsp; a correct connect and answer<br><br>2007-05-29 16:46:53.268457 &lt; HCI Command: Create Connection (0x01|0x0005) plen 13<br>&nbsp;&nbsp;&nbsp; bdaddr 00:17:E2:0A:79:8D ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
<br>&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 <br>2007-05-29 16:46:53.290125 &gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Create Connection (0x01|0x0005) status 0x00 ncmd 1<br>2007-05-29 16:46:53.653134 &gt; HCI Event: Connect Complete (0x03) plen 11
<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 42 bdaddr 00:17:E2:0A:79:8D type ACL encrypt 0x00<br>2007-05-29 16:46:53.653155 &lt; ACL data: handle 42 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 1 scid 0x0040<br>2007-05-29 16:46:53.653161
 &lt; HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2<br>&nbsp;&nbsp;&nbsp; handle 42<br>2007-05-29 16:46:53.664138 &gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
<br>2007-05-29 16:46:53.676153 &gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>2007-05-29 16:46:53.678133 &gt; HCI Event: Max Slots Change (0x1b) plen 3<br>&nbsp;&nbsp;&nbsp; handle 42 slots 5<br>
2007-05-29 16:46:53.687136 &gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Unknown (0x00|0x0000) status 0x00 ncmd 1<br>2007-05-29 16:46:53.687155 &lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<br>&nbsp;&nbsp;&nbsp; handle 42 policy 0x0f
<br>&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK <br>2007-05-29 16:46:53.691132 &gt; HCI Event: Command Complete (0x0e) plen 6<br>&nbsp;&nbsp;&nbsp; Write Link Policy Settings (0x02|0x000d) ncmd 1<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 42<br>2007-05-29 16:46:
53.691143 &lt; HCI Command: Remote Name Request (0x01|0x0019) plen 10<br>&nbsp;&nbsp;&nbsp; bdaddr 00:17:E2:0A:79:8D mode 2 clkoffset 0x0000<br>2007-05-29 16:46:53.694136 &gt; ACL data: handle 42 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>2007-05-29 16:46:53.694151 &lt; ACL data: handle 42 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0<br>2007-05-29 16:46:53.696140 &gt; HCI Event: Command Status (0x0f) plen 4
<br>&nbsp;&nbsp;&nbsp; Remote Name Request (0x01|0x0019) status 0x00 ncmd 1<br>2007-05-29 16:46:53.697137 &gt; ACL data: handle 42 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1024 <br>2007-05-29 16:46:
53.697151 &lt; ACL data: handle 42 flags 0x02 dlen 18<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1024 <br>2007-05-29 16:46:53.700133 &gt; HCI Event: Read Remote Supported Features (0x0b) plen 11
<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 42<br>&nbsp;&nbsp;&nbsp; Features: 0xff 0xfe 0x0d 0x00 0x08 0x08 0x00 0x00<br>2007-05-29 16:46:53.701140 &gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>2007-05-29 16:46:
53.703138 &gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>2007-05-29 16:46:53.714139 &gt; ACL data: handle 42 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>2007-05-29 16:46:53.714287 &lt; ACL data: handle 42 flags 0x02 dlen 24<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 20 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x0 len 0xf<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-16 0x1105 (OBEXObjPush)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 65535<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0000 - 0xffff<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>2007-05-29 16:46:53.723134 &gt; HCI Event: Remote Name Req Complete (0x07) plen 255<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:17:E2:0A:79:8D name &#39;Motorola PEBL&#39;
<br>2007-05-29 16:46:53.724144 &gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>2007-05-29 16:46:53.979159 &gt; ACL data: handle 42 flags 0x02 dlen 339<br>2007-05-29 16:46:53.994167 &gt; ACL data: handle 42 flags 0x01 dlen 220
<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 555 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x0 len 0x226<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 547<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x10008<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1105 (OBEXObjPush) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0002 (SrvRecState)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &lt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0003 (RFCOMM) uint 0x8 &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0008 (OBEX) &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0005 (BrwGrpList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1002 (PubBrwsGrp) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0006 (LangBaseAttrIDList)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0x656e uint 0x6a uint 0x100 uint 0x6672 uint 0x6a uint 0xc800 uint 0x6465 uint 0x6a uint 0xc803 uint 0x6974 uint 0x6a uint 0xc806 uint 0x6573 uint 0x6a uint 0xc809 uint 0x7472 uint 0x6a uint 0xc80c uint 0x656c uint 0x6a uint 0xc80f &gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0009 (BTProfileDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x1105 (OBEXObjPush) uint 0x100 &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;OBEX Object Push&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0101 (SrvDesc)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;OBEX Object Push&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0102 (ProviderName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Motorola&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0303 (SuppFormatsList)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0xff &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0xc800 (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Push objet OBEX&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0xc801 (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Push objet OBEX&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0xc802 (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Motorola&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0xc803 (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;OBEX Objekt senden&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0xc804 (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;OBEX Objekt senden&quot;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0xc805 (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Motorola&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0xc806 (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Invio oggetto OBEX&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0xc807 (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Invio oggetto OBEX&quot;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0xc808 (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Motorola&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0xc809 (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;OBEX Object Push&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0xc80a (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;OBEX Object Push&quot;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0xc80b (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Motorola&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0xc80c (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;OBEX Object Push&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0xc80d (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;OBEX Object Push&quot;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0xc80e (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Motorola&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0xc80f (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str ce 91 ce bd cf 84 ce b9 ce ba ce b5 ce af ce bc 2e 50 75 73<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0xc810 (unknown)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str ce 91 ce bd cf 84 ce b9 ce ba ce b5 ce af ce bc 2e 50 75 73<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0xc811 (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Motorola&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>2007-05-29 16:46:53.994523 &lt; ACL data: handle 42 flags 0x02 dlen 12
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040<br>2007-05-29 16:46:54.000158 &gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>2007-05-29 16:46:54.010167 &gt; ACL data: handle 42 flags 0x02 dlen 12
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040<br>2007-05-29 16:46:56.009566 &lt; HCI Command: Disconnect (0x01|0x0006) plen 3<br>&nbsp;&nbsp;&nbsp; handle 42 reason 0x13<br>&nbsp;&nbsp;&nbsp; Reason: Remote User Terminated Connection<br>2007-05-29 16:46:
56.014212 &gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Disconnect (0x01|0x0006) status 0x00 ncmd 1<br>2007-05-29 16:46:56.017211 &gt; HCI Event: Disconn Complete (0x05) plen 4<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 42 reason 0x16
<br>&nbsp;&nbsp;&nbsp; Reason: Connection Terminated by Local Host<br><br><br>this one is a page timeout some minutes later (on the same device)<br>
<br>
2007-05-29 16:57:46.372114 &lt; HCI Command: Create Connection (0x01|0x0005) plen 13<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:17:E2:0A:79:8D ptype 0xcc18 rswitch 0x01 clkoffset 0x0000<br>
&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 <br>
2007-05-29 16:57:46.393452 &gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Create Connection (0x01|0x0005) status 0x00 ncmd 1<br>
2007-05-29 16:57:56.397591 &gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp;&nbsp;&nbsp; status 0x04 handle 0 bdaddr 00:17:E2:0A:79:8D type ACL encrypt 0x00<br>
&nbsp;&nbsp;&nbsp; Error: Page Timeout<br>
<br>This happens almost on all devices I contact. I wonder since this is a rather close loop if something does not close on remote device during the various attempts or if the problem is on the local HCI. Maybe the page timeout is from the local device ? (hci1)
<br><br>Going further ahead with the test the same devices start again answering without problems and then again they timeout.<br><br>Any hint is welcome :)<br><br><br>

------=_Part_125700_18159075.1180455098997--


--===============0504008536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0504008536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0504008536==--
