Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/alternative; boundary="=-6KTCHygmmiDQEwA6cN7v"
Message-Id: <1111624396.8922.12.camel@sparky.netsyncro.com>
Mime-Version: 1.0
From: Christopher =?ISO-8859-1?Q?Bergstr=F6m?= <codestrom@gmail.com>
Subject: [Bluez-users] btsco headset doesn't establish connection
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
Date: Thu, 24 Mar 2005 01:33:16 +0100


--=-6KTCHygmmiDQEwA6cN7v
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've had this working in the past and switched laptops since then.
(This is something simple I know.)

I have a cbt100u conceptronic usb adapter and Qware BT headset.

Steps :
compile and install package (success)
modprobe snd_bt_sco (success)
./btsco 00:0A:94:90:17:D6 (fails)

It currently looks like it's trying to establish a connection, but then
after a second or two just closes.  In the past when it was working it
would say establishing a connection over channel 2 or somthing along
those lines.  I'd click the button on the headset and voila it's
connected.

One thing that is different from before is I don't see the popup to
enter my pin, but I have already changed my /etc/bluetooth/pin file.

Below is some output while scanning, inq, info and dump while trying to
establish btsco.

In the past I think I had to change the class in my hci.conf file, but I
can't remember for certain.

I really appreciate the minute.

Thanks



sparky:/home/codestrom/btsco # hcitool scan
Scanning ...
        00:0A:94:90:17:D6       BT Headset-F
sparky:/home/codestrom/btsco # hcitool info 00:0A:94:90:17:D6
Requesting information ...
        BD Address:  00:0A:94:90:17:D6
        Device Name: BT Headset-F
        LMP Version: 1.1 (0x1) LMP Subversion: 0x2be
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot
offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2
packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging
scheme>
                <power control> <transparent SCO>
sparky:/home/codestrom/btsco # ./btsco 00:0A:94:90:17:D6
sparky:/home/codestrom/btsco # hci
hciattach  hciconfig  hcid       hcidump    hcitool
sparky:/home/codestrom/btsco # hcidump
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Command Complete (0x0e) plen 6
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> HCI Event: Max Slots Change (0x1b) plen 3
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0040 result 1 status 2
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0042 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 48
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 24
    L2CAP(d): cid 0x0042 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1108 (Headset)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 52
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x2b
          cnt 0x26
          srv rec #0
            aid 0x0000 (SrvRecHndl)
               uint 0x10000
            aid 0x0001 (SrvClassIDList)
               < uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio) >
            aid 0x0004 (ProtocolDescList)
               < < uuid-16 0x0100 (L2CAP) > <
               uuid-16 0x0200 str "" > >

          cont
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x0042 len 22 [psm 1]
        SDP SSA Req: tid 0x1 len 0x11
          pat uuid-16 0x1108 (Headset)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 22
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 46
    L2CAP(d): cid 0x0040 len 42 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x25
          cnt 0x22

ERROR: Unexpected syntax
          cont 03 08 01 09 00 09 35 08 35 06 19 11 08 09 01 00 09 01 00
25 07 48 65 61 64 73 65 74 09 03 02 28 01 00
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0042 scid 0x0040
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Command Complete (0x0e) plen 6
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0042 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0041 result 1 status 2
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0041 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0043 flags 0x0000 clen 4
    MTU 1024
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 4
    MTU 1024
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0043 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0043 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x0043 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 0
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0043 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0043 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0043 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
> ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 15
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 10 fcs 0x40
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x0043 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Mode Change (0x14) plen 6
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 2
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 10 fcs 0x5c credits 1
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x0043 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Mode Change (0x14) plen 6
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DISC: cr 0 dlci 2 pf 1 ilen 0 fcs 0xd9
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0043 len 4 [psm 3]
      RFCOMM(s): UA: cr 0 dlci 2 pf 1 ilen 0 fcs 0xf3
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0043 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0043 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0043 scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4


--=-6KTCHygmmiDQEwA6cN7v
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.2.2">
</HEAD>
<BODY>
I've had this working in the past and switched laptops since then.&nbsp; (This is something simple I know.)<BR>
<BR>
I have a cbt100u conceptronic usb adapter and Qware BT headset.<BR>
<BR>
Steps :<BR>
compile and install package (success)<BR>
modprobe snd_bt_sco (success)<BR>
./btsco 00:0A:94:90:17:D6 (fails)<BR>
<BR>
It currently looks like it's trying to establish a connection, but then after a second or two just closes.&nbsp; In the past when it was working it would say establishing a connection over channel 2 or somthing along those lines.&nbsp; I'd click the button on the headset and voila it's connected.<BR>
<BR>
One thing that is different from before is I don't see the popup to enter my pin, but I have already changed my /etc/bluetooth/pin file.<BR>
<BR>
Below is some output while scanning, inq, info and dump while trying to establish btsco.<BR>
<BR>
In the past I think I had to change the class in my hci.conf file, but I can't remember for certain.<BR>
<BR>
I really appreciate the minute.<BR>
<BR>
Thanks<BR>
<BR>
<BR>
<BR>
sparky:/home/codestrom/btsco # hcitool scan<BR>
Scanning ...<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00:0A:94:90:17:D6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BT Headset-F<BR>
sparky:/home/codestrom/btsco # hcitool info 00:0A:94:90:17:D6<BR>
Requesting information ...<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:&nbsp; 00:0A:94:90:17:D6<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Name: BT Headset-F<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 1.1 (0x1) LMP Subversion: 0x2be<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryption&gt; &lt;slot offset&gt;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt; &lt;sniff mode&gt;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;park state&gt; &lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO link&gt; &lt;HV2 packets&gt;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt; &lt;CVSD&gt; &lt;paging scheme&gt;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;power control&gt; &lt;transparent SCO&gt;<BR>
sparky:/home/codestrom/btsco # ./btsco 00:0A:94:90:17:D6<BR>
sparky:/home/codestrom/btsco # hci<BR>
hciattach&nbsp; hciconfig&nbsp; hcid&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hcidump&nbsp;&nbsp;&nbsp; hcitool<BR>
sparky:/home/codestrom/btsco # hcidump<BR>
HCIDump - HCI packet analyzer ver 1.11<BR>
device: hci0 snap_len: 1028 filter: 0xffffffff<BR>
&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<BR>
&gt; HCI Event: Command Status (0x0f) plen 4<BR>
&gt; HCI Event: Link Key Request (0x17) plen 6<BR>
&lt; HCI Command: Link Key Request Reply (0x01|0x000b) plen 22<BR>
&gt; HCI Event: Command Complete (0x0e) plen 10<BR>
&gt; HCI Event: Connect Complete (0x03) plen 11<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 12<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 1 scid 0x0040<BR>
&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; HCI Event: Command Complete (0x0e) plen 6<BR>
&gt; HCI Event: Page Scan Repetition Mode Change (0x20) plen 7<BR>
&gt; HCI Event: Max Slots Change (0x1b) plen 3<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 16<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0040 result 1 status 2<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 16<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0040 result 0 status 0<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 12<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0042 flags 0x0000 clen 0<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 14<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 16<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4<BR>
&nbsp;&nbsp;&nbsp; MTU 48<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 14<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0042 flags 0x0000 result 0 clen 0<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 24<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0042 len 20 [psm 1]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x0 len 0xf<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-16 0x1108 (Headset)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 0xffff<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0000 - 0xffff<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 52<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 48 [psm 1]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x0 len 0x2b<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cnt 0x26<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; srv rec #0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x10000<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio) &gt;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &lt;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0200 str &quot;&quot; &gt; &gt;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 26<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0042 len 22 [psm 1]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x1 len 0x11<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-16 0x1108 (Headset)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 0xffff<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0000 - 0xffff<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 02 00 22<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 46<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 42 [psm 1]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 len 0x25<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cnt 0x22<BR>
<BR>
ERROR: Unexpected syntax<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 03 08 01 09 00 09 35 08 35 06 19 11 08 09 01 00 09 01 00 25 07 48 65 61 64 73 65 74 09 03 02 28 01 00<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 12<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0042 scid 0x0040<BR>
&lt; HCI Command: Read Voice Setting (0x03|0x0025) plen 0<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; HCI Event: Command Complete (0x0e) plen 6<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 12<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 3 scid 0x0041<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 12<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0042 scid 0x0040<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 16<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0041 result 1 status 2<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 16<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0041 result 0 status 0<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 16<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0043 flags 0x0000 clen 4<BR>
&nbsp;&nbsp;&nbsp; MTU 1024<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 14<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 16<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 4<BR>
&nbsp;&nbsp;&nbsp; MTU 1024<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 14<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0043 flags 0x0000 result 0 clen 0<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 8<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 4 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 8<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 4 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 18<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 14 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 1019 max_retrans 0 credits 7<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 18<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 14 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 127 max_retrans 0 credits 0<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 8<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 4 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 8<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 4 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 12<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 8 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 12<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 8 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 12<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 8 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 12<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 8 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 9<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 5 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 9<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 15<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 18<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 14 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 10 fcs 0x40<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 14<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 10 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; HCI Event: Mode Change (0x14) plen 6<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 17<BR>
&gt; ACL data: handle 0x0029 flags 0x01 dlen 2<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 15 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 10 fcs 0x5c credits 1<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 14<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 10 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; HCI Event: Mode Change (0x14) plen 6<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 8<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 4 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DISC: cr 0 dlci 2 pf 1 ilen 0 fcs 0xd9<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 8<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 4 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 0 dlci 2 pf 1 ilen 0 fcs 0xf3<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 8<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0043 len 4 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 12<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0043 scid 0x0041<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 8<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 4 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 12<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0043 scid 0x0041<BR>
&lt; HCI Command: Disconnect (0x01|0x0006) plen 3<BR>
&gt; HCI Event: Command Status (0x0f) plen 4<BR>
&gt; HCI Event: Disconn Complete (0x05) plen 4<BR>
<BR>
</BODY>
</HTML>

--=-6KTCHygmmiDQEwA6cN7v--



-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
