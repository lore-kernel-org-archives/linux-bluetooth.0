Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <9ec07a230602020153mfe5d62ckb447916a94f04d04@mail.gmail.com>
From: =?ISO-8859-1?Q?Israel_Gu=EDo?= <israzar@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7770_31322416.1138873986850"
Subject: [Bluez-devel] SCO link problem
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 2 Feb 2006 10:53:06 +0100

------=_Part_7770_31322416.1138873986850
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi!

I'm developing an application for voice transmission over a SCO link. My
first step was to compile and probe the utility scotest provided in
bluez-utils packet. However, I see in hcidump that I am sending the correct
frames(0x7f), but in receiver end, I get nothing but 0's or f's. I don't
really know where the problem is, so please help me.

Thanks.

This is my configuration. I have 2 computers with Debian and
2.6.15.1kernel. Each computer has its USB Bluetooth
2.0+EDR Adapter (Cellink BTA-6030). This is the "hciconfig hci0 revision"
output:
hci0:   Type: USB
        BD Address: 00:0A:94:02:45:BB ACL MTU: 384:8 SCO MTU: 64:8
        Build 1500
        Chip version: BlueCore4-External
        Max key size: 56 bit
        SCO mapping:  HCI

This is the "hcidump -X -V" in transmitter end:

HCI sniffer - Bluetooth packet analyzer ver 1.17
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: ac 44 02 94 0a 00 18 cc  02 00 00 00 01           .D...........
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:0A:94:02:44:AC type ACL encrypt 0x00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 2a 00 0f 00                                       *...
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    0000: 00 2a 00                                          .*.
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
  0000: 2a 00 e0 00                                       *...
> HCI Event: Command Status (0x0f) plen 4
    Add SCO Connection (0x01|0x0007) status 0x00 ncmd 0
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: ac 44 02 94 0a 00 01                              .D.....
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2a 00 05                                          *..
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2a 00 01                                          *..
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 45 bdaddr 00:0A:94:02:44:AC type SCO encrypt 0x00
> SCO data: handle 45 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
> SCO data: handle 45 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2a 00 03                                          *..
> SCO data: handle 45 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
< SCO data: handle 45 dlen 64
    0000: 00 00 00 00 a0 02 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ...............=
.
    0010: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ...............=
.
    0020: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ...............=
.
    0030: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ...............=
.
> SCO data: handle 45 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.

and so on until I press CTRL+C. The "hcidump -X -V" output in receiver end
is:

HCI sniffer - Bluetooth packet analyzer ver 1.17
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:0A:94:02:45:BB class 0x3e0100 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  0000: bb 45 02 94 0a 00 01                              .E.....
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:0A:94:02:45:BB type ACL encrypt 0x00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 2a 00 0f 00                                       *...
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: bb 45 02 94 0a 00 01                              .E.....
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2a 00 05                                          *..
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    0000: 00 2a 00                                          .*.
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  0000: 2a 00 18 cc                                       *...
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  0000: 00 2a 00 18 cc                                    .*...
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2a 00 01                                          *..
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:0A:94:02:45:BB class 0x3e0100 type SCO
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  0000: bb 45 02 94 0a 00 01                              .E.....
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 46 bdaddr 00:0A:94:02:45:BB type SCO encrypt 0x00
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  0000: 2e 00 e0 00                                       ....
> SCO data: handle 46 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
> SCO data: handle 46 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  0000: 00 2e 00 e0 00                                    .....
> SCO data: handle 46 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
> SCO data: handle 46 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
    0020: 00 00 00 00 ff ff ff ff  ff ff ff ff ff ff ff ff  ...............=
.
> SCO data: handle 46 dlen 48
    0000: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ...............=
.
    0010: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ...............=
.
    0020: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ...............=
.
> SCO data: handle 46 dlen 48
    0000: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ...............=
.
    0010: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ...............=
.
    0020: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ...............=
.
> SCO data: handle 46 dlen 48
    0000: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ...............=
.
    0010: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ...............=
.
    0020: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ...............=
.
> SCO data: handle 46 dlen 48
    0000: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ...............=
.
    0010: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ...............=
.
    0020: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ...............=
.

and so on until the end. I don't know if it is important, but when sending
0x7f, I get the frames above, but when sending 0x44, I get 0's, not f's.

Thank you for your help again.

------=_Part_7770_31322416.1138873986850
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi!<br>
<br>
I'm developing an application for voice transmission over a SCO link.
My first step was to compile and probe the utility scotest provided in
bluez-utils packet. However, I see in hcidump that I am sending the
correct frames(0x7f), but in receiver end, I get nothing but 0's or
f's. I don't really know where the problem is, so please help me.<br>
<br>
Thanks.<br>
<br>
This is my configuration. I have 2 computers with Debian and <a href=3D"htt=
p://2.6.15.1">2.6.15.1</a>
kernel. Each computer has its USB Bluetooth 2.0+EDR Adapter (Cellink
BTA-6030). This is the &quot;hciconfig hci0 revision&quot; output:<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:0A:94:02:45:BB AC=
L MTU: 384:8 SCO MTU: 64:8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Build 1500<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Chip version: BlueCore4-External=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Max key size: 56 bit<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCO mapping:&nbsp; HCI<br>
<br>
This is the &quot;hcidump -X -V&quot; in transmitter end:<br>
<br>
HCI sniffer - Bluetooth packet analyzer ver 1.17<br>
device: hci0 snap_len: 1028 filter: 0xffffffff<br>
&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<br>
&nbsp; 0000: ac 44 02 94 0a 00 18 cc&nbsp; 02 00 00 00
01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.D...........<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Create Connection (0x01|0x0005) status 0x00 ncmd 1<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 42 bdaddr 00:0A:94:02:44:AC type ACL =
encrypt 0x00<br>
&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<br>
&nbsp; 0000: 2a 00 0f
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
*...<br>
&gt; HCI Event: Command Complete (0x0e) plen 6<br>
&nbsp;&nbsp;&nbsp; Write Link Policy Settings (0x02|0x000d) ncmd 1<br>
&nbsp;&nbsp;&nbsp; 0000: 00 2a
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
.*.<br>
&lt; HCI Command: Add SCO Connection (0x01|0x0007) plen 4<br>
&nbsp; 0000: 2a 00 e0
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
*...<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Add SCO Connection (0x01|0x0007) status 0x00 ncmd 0<br>
&gt; HCI Event: Page Scan Repetition Mode Change (0x20) plen 7<br>
&nbsp; 0000: ac 44 02 94 0a 00
01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
.D.....<br>
&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>
&nbsp; 0000: 2a 00
05&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
*..<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Unknown (0x00|0x0000) status 0x00 ncmd 1<br>
&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>
&nbsp; 0000: 2a 00
01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
*..<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 45 bdaddr 00:0A:94:02:44:AC type SCO =
encrypt 0x00<br>
&gt; SCO data: handle 45 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0010: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0020: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&gt; SCO data: handle 45 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0010: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0020: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>
&nbsp; 0000: 2a 00
03&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
*..<br>
&gt; SCO data: handle 45 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0010: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0020: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&lt; SCO data: handle 45 dlen 64<br>
&nbsp;&nbsp;&nbsp; 0000: 00 00 00 00 a0 02 7f 7f&nbsp; 7f 7f 7f 7f 7f 7f 7f=
 7f&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0010: 7f 7f 7f 7f 7f 7f 7f 7f&nbsp; 7f 7f 7f 7f 7f 7f 7f=
 7f&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0020: 7f 7f 7f 7f 7f 7f 7f 7f&nbsp; 7f 7f 7f 7f 7f 7f 7f=
 7f&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0030: 7f 7f 7f 7f 7f 7f 7f 7f&nbsp; 7f 7f 7f 7f 7f 7f 7f=
 7f&nbsp; ................<br>
&gt; SCO data: handle 45 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0010: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0020: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
<br>
and so on until I press CTRL+C. The &quot;hcidump -X -V&quot; output in rec=
eiver end is:<br>
<br>
HCI sniffer - Bluetooth packet analyzer ver 1.17<br>
device: hci0 snap_len: 1028 filter: 0xffffffff<br>
&gt; HCI Event: Connect Request (0x04) plen 10<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:0A:94:02:45:BB class 0x3e0100 type ACL<br>
&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7<br>
&nbsp; 0000: bb 45 02 94 0a 00
01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
.E.....<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Accept Connection Request (0x01|0x0009) status 0x00 ncmd=
 1<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 42 bdaddr 00:0A:94:02:45:BB type ACL =
encrypt 0x00<br>
&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<br>
&nbsp; 0000: 2a 00 0f
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
*...<br>
&gt; HCI Event: Page Scan Repetition Mode Change (0x20) plen 7<br>
&nbsp; 0000: bb 45 02 94 0a 00
01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
.E.....<br>
&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>
&nbsp; 0000: 2a 00
05&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
*..<br>
&gt; HCI Event: Command Complete (0x0e) plen 6<br>
&nbsp;&nbsp;&nbsp; Write Link Policy Settings (0x02|0x000d) ncmd 1<br>
&nbsp;&nbsp;&nbsp; 0000: 00 2a
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
.*.<br>
&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4<br>
&nbsp; 0000: 2a 00 18
cc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
*...<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Change Connection Packet Type (0x01|0x000f) status 0x00 =
ncmd 1<br>
&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 5<br>
&nbsp; 0000: 00 2a 00 18
cc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.*...<br>
&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>
&nbsp; 0000: 2a 00
01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
*..<br>
&gt; HCI Event: Connect Request (0x04) plen 10<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:0A:94:02:45:BB class 0x3e0100 type SCO<br>
&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7<br>
&nbsp; 0000: bb 45 02 94 0a 00
01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
.E.....<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Accept Connection Request (0x01|0x0009) status 0x00 ncmd=
 1<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 46 bdaddr 00:0A:94:02:45:BB type SCO =
encrypt 0x00<br>
&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4<br>
&nbsp; 0000: 2e 00 e0
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
....<br>
&gt; SCO data: handle 46 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0010: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0020: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&gt; SCO data: handle 46 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0010: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0020: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Change Connection Packet Type (0x01|0x000f) status 0x00 =
ncmd 1<br>
&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 5<br>
&nbsp; 0000: 00 2e 00 e0
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.....<br>
&gt; SCO data: handle 46 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0010: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0020: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&gt; SCO data: handle 46 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0010: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00=
 00&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0020: 00 00 00 00 ff ff ff ff&nbsp; ff ff ff ff ff ff ff=
 ff&nbsp; ................<br>
&gt; SCO data: handle 46 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: ff ff ff ff ff ff ff ff&nbsp; ff ff ff ff ff ff ff=
 ff&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0010: ff ff ff ff ff ff ff ff&nbsp; ff ff ff ff ff ff ff=
 ff&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0020: ff ff ff ff ff ff ff ff&nbsp; ff ff ff ff ff ff ff=
 ff&nbsp; ................<br>
&gt; SCO data: handle 46 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: ff ff ff ff ff ff ff ff&nbsp; ff ff ff ff ff ff ff=
 ff&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0010: ff ff ff ff ff ff ff ff&nbsp; ff ff ff ff ff ff ff=
 ff&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0020: ff ff ff ff ff ff ff ff&nbsp; ff ff ff ff ff ff ff=
 ff&nbsp; ................<br>
&gt; SCO data: handle 46 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: ff ff ff ff ff ff ff ff&nbsp; ff ff ff ff ff ff ff=
 ff&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0010: ff ff ff ff ff ff ff ff&nbsp; ff ff ff ff ff ff ff=
 ff&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0020: ff ff ff ff ff ff ff ff&nbsp; ff ff ff ff ff ff ff=
 ff&nbsp; ................<br>
&gt; SCO data: handle 46 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: ff ff ff ff ff ff ff ff&nbsp; ff ff ff ff ff ff ff=
 ff&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0010: ff ff ff ff ff ff ff ff&nbsp; ff ff ff ff ff ff ff=
 ff&nbsp; ................<br>
&nbsp;&nbsp;&nbsp; 0020: ff ff ff ff ff ff ff ff&nbsp; ff ff ff ff ff ff ff=
 ff&nbsp; ................<br>
<br>
and so on until the end. I don't know if it is important, but when
sending 0x7f, I get the frames above, but when sending 0x44, I get 0's,
not f's.<br>
<br>
Thank you for your help again.<br>

------=_Part_7770_31322416.1138873986850--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
