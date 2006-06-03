Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <549053140606021732w4263c5c2g93efa4cdf9a7614d@mail.gmail.com>
Date: Fri, 2 Jun 2006 19:32:31 -0500
From: "Carl Karsten" <cfkarsten@gmail.com>
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] PM325 by LG cell phone
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0156245556=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0156245556==
Content-Type: multipart/alternative;
	boundary="----=_Part_5923_6242189.1149294751579"

------=_Part_5923_6242189.1149294751579
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am trying to figure out what I can do with my new cell phone and .  Here
is what I have so far:

carl@asus17:/etc/bluetooth$ sudo lshw
    product: M6VA
    vendor: ASUSTeK Computer Inc.


carl@asus17:/etc/bluetooth$ lsusb
Bus 003 Device 002: ID 044e:3001 Alps Electric Co., Ltd UGTZ4 Bluetooth

carl@asus17:~$ hciconfig
hci0:   Type: USB
        BD Address: 00:02:C7:97:22:6C ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:10657 acl:36 sco:0 events:236 errors:0
        TX bytes:2218 acl:36 sco:0 commands:106 errors:0

carl@asus17:~$ sudo hcitool scan
Scanning ...
        08:00:37:03:EF:36       PM325 by LG

carl@asus17:~$ sudo hcitool info 08:00:37:03:EF:36
Password:
Requesting information ...
        BD Address:  08:00:37:03:EF:36
        LMP Version: 1.2 (0x2) LMP Subversion: 0xdb0
        Manufacturer: Texas Instruments Inc. (13)
        Features: 0xff 0xff 0x2d 0xf8 0x1b 0x18 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2
packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <power control>
                <transparent SCO> <enhanced iscan> <interlaced iscan>
                <interlaced pscan> <inquiry with RSSI> <extended SCO>
                <EV4 packets> <EV5 packets> <AFH cap. slave>
                <AFH class. slave> <AFH cap. master> <AFH class. master>
                <extended features>

carl@asus17:~$ sdptool browse 08:00:37:03:EF:36
Browsing 08:00:37:03:EF:36 ...
Service Name: WBTEXT
Service RecHandle: 0x10000
Service Class ID List:
  "Error: This is UUID-128" (0xdb1d8f12-95f3-402c-9b97-bc504c9a55c4)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Error: This is UUID-128" (0x1cdb1d8f-1295-f340-2c9b-97bc504c9a55)
    Version: 0x0100

Service Name: LG LX325 Headset AG Service
Service RecHandle: 0x10001
Service Class ID List:
  "Headset Audio Gateway" (0x1112)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 2
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100

Service Name: LG LX325 Hands-Free AG Service
Service RecHandle: 0x10002
Service Class ID List:
  "Handfree Audio Gateway" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0100

Service Name: Dialup Networking
Service RecHandle: 0x10003
Service Class ID List:
  "Dialup Networking" (0x1103)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 4
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100

I am not sure what to do next.  looks like audio and dun are the only
profiles the phone supports, so DUN seems like a good place to start.

------=_Part_5923_6242189.1149294751579
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am trying to figure out what I can do with my new cell phone and .&nbsp; Here is what I have so far:<br><br>carl@asus17:/etc/bluetooth$ sudo lshw<br>&nbsp;&nbsp;&nbsp; product: M6VA<br>&nbsp;&nbsp;&nbsp; vendor: ASUSTeK Computer Inc.<br><br><br>carl@asus17
:/etc/bluetooth$ lsusb<br>Bus 003 Device 002: ID 044e:3001 Alps Electric Co., Ltd UGTZ4 Bluetooth<br><br>carl@asus17:~$ hciconfig<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:02:C7:97:22:6C ACL MTU: 192:8 SCO MTU: 64:8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:10657 acl:36 sco:0 events:236 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:2218 acl:36 sco:0 commands:106 errors:0<br><br>carl@asus17:~$ sudo hcitool scan<br>
Scanning ...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 08:00:37:03:EF:36&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PM325 by LG<br>
<br>carl@asus17:~$ sudo hcitool info 08:00:37:03:EF:36<br>Password:<br>Requesting information ...<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:&nbsp; 08:00:37:03:EF:36<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 1.2 (0x2) LMP Subversion: 0xdb0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Texas Instruments Inc. (13)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x2d 0xf8 0x1b 0x18 0x00 0x80<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryption&gt; &lt;slot offset&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt; &lt;sniff mode&gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;park state&gt; &lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO link&gt; &lt;HV2 packets&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt; &lt;CVSD&gt; &lt;power control&gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;transparent SCO&gt; &lt;enhanced iscan&gt; &lt;interlaced iscan&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;interlaced pscan&gt; &lt;inquiry with RSSI&gt; &lt;extended SCO&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;EV4 packets&gt; &lt;EV5 packets&gt; &lt;AFH cap. slave&gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;AFH class. slave&gt; &lt;AFH cap. master&gt; &lt;AFH class. master&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;extended features&gt;<br><br>carl@asus17:~$ sdptool browse 08:00:37:03:EF:36<br>Browsing 08:00:37:03:EF:36 ...
<br>Service Name: WBTEXT<br>Service RecHandle: 0x10000<br>Service Class ID List:<br>&nbsp; &quot;Error: This is UUID-128&quot; (0xdb1d8f12-95f3-402c-9b97-bc504c9a55c4)<br>Protocol Descriptor List:<br>&nbsp; &quot;L2CAP&quot; (0x0100)
<br>&nbsp; &quot;RFCOMM&quot; (0x0003)<br>&nbsp;&nbsp;&nbsp; Channel: 1<br>Language Base Attr List:<br>&nbsp; code_ISO639: 0x656e<br>&nbsp; encoding:&nbsp;&nbsp;&nbsp; 0x6a<br>&nbsp; base_offset: 0x100<br>Profile Descriptor List:<br>&nbsp; &quot;Error: This is UUID-128&quot; (0x1cdb1d8f-1295-f340-2c9b-97bc504c9a55)
<br>&nbsp;&nbsp;&nbsp; Version: 0x0100<br><br>Service Name: LG LX325 Headset AG Service<br>Service RecHandle: 0x10001<br>Service Class ID List:<br>&nbsp; &quot;Headset Audio Gateway&quot; (0x1112)<br>&nbsp; &quot;Generic Audio&quot; (0x1203)<br>Protocol Descriptor List:
<br>&nbsp; &quot;L2CAP&quot; (0x0100)<br>&nbsp; &quot;RFCOMM&quot; (0x0003)<br>&nbsp;&nbsp;&nbsp; Channel: 2<br>Profile Descriptor List:<br>&nbsp; &quot;Headset&quot; (0x1108)<br>&nbsp;&nbsp;&nbsp; Version: 0x0100<br><br>Service Name: LG LX325 Hands-Free AG Service<br>
Service RecHandle: 0x10002<br>Service Class ID List:<br>&nbsp; &quot;Handfree Audio Gateway&quot; (0x111f)<br>&nbsp; &quot;Generic Audio&quot; (0x1203)<br>Protocol Descriptor List:<br>&nbsp; &quot;L2CAP&quot; (0x0100)<br>&nbsp; &quot;RFCOMM&quot; (0x0003)
<br>&nbsp;&nbsp;&nbsp; Channel: 3<br>Profile Descriptor List:<br>&nbsp; &quot;Handsfree&quot; (0x111e)<br>&nbsp;&nbsp;&nbsp; Version: 0x0100<br><br>Service Name: Dialup Networking<br>Service RecHandle: 0x10003<br>Service Class ID List:<br>&nbsp; &quot;Dialup Networking&quot; (0x1103)
<br>Protocol Descriptor List:<br>&nbsp; &quot;L2CAP&quot; (0x0100)<br>&nbsp; &quot;RFCOMM&quot; (0x0003)<br>&nbsp;&nbsp;&nbsp; Channel: 4<br>Profile Descriptor List:<br>&nbsp; &quot;Dialup Networking&quot; (0x1103)<br>&nbsp;&nbsp;&nbsp; Version: 0x0100<br><br>I am not sure what to do next.&nbsp; looks like audio and dun are the only profiles the phone supports, so DUN seems like a good place to start.
<br>

------=_Part_5923_6242189.1149294751579--


--===============0156245556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0156245556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0156245556==--
