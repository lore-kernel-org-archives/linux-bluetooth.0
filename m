Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7846f1440511211104p22ad2e23x719cc21ae6ea1d46@mail.gmail.com>
From: Arthur Chiu <arthurchiu@gmail.com>
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_25454_3970275.1132599881976"
Subject: [Bluez-users] symbol lookup error
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
Date: Mon, 21 Nov 2005 11:04:41 -0800

------=_Part_25454_3970275.1132599881976
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I compiled blueZ libs and utils without a problem. (using ./configure for
libs and ./configure --enable-test for utils)
After this, I ran hciconfig hci0 up, then hciconfig, both ran fine:
hci0: Type: USB
BD Address: 00:11:67:0F:C0:E7 ACL MTU: 678:8 SCO MTU: 48:10
UP RUNNING PSCAN ISCAN
RX bytes:77 acl:0 sco:0 events:9 errors:0
TX bytes:34 acl:0 sco:0 commands:9 errors:0

However, when I try to run hcitool -i hci0 inq:

Inquiring ...
00:0D:93:0F:32:F5 clock offset: 0x34fa class: 0x102104
00:0D:93:17:D7:C1 clock offset: 0x15f1 class: 0x102104
00:0E:07:15:64:B3 clock offset: 0x1069 class: 0x520204
00:13:46:A7:12:CE clock offset: 0x4c61 class: 0x000000
00:0D:93:19:E8:D4 clock offset: 0x2966 class: 0x102104
00:0D:93:1C:2E:31 clock offset: 0x18cb class: 0x102104
00:0D:93:16:49:33 clock offset: 0x38ca class: 0x102104
hcitool: symbol lookup error: hcitool: undefined symbol: bt_free

I get this symbol lookup error. Then when I try hcitool -i hci0 scan:

Scanning ...
hcitool: symbol lookup error: hcitool: undefined symbol:
hci_read_remote_name_with_clock_offset

Yet another lookup error.

Dump for the inq:

# hcidump -X
HCI sniffer - Bluetooth packet analyzer ver 1.27
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
0000: 33 8b 9e 08 c8 3....
> HCI Event: Command Status (0x0f) plen 4
0000: 00 01 01 04 ....
> HCI Event: Inquiry Result (0x02) plen 15
0000: 01 31 2e 1c 93 0d 00 01 02 00 04 21 10 ca 18 .1.........!...
> HCI Event: Inquiry Result (0x02) plen 15
0000: 01 f5 32 0f 93 0d 00 01 02 00 04 21 10 fa 34 ..2........!..4
> HCI Event: Inquiry Result (0x02) plen 15
0000: 01 ce 12 a7 46 13 00 01 00 00 00 00 00 5d 4c ....F........]L
> HCI Event: Inquiry Result (0x02) plen 15
0000: 01 d4 e8 19 93 0d 00 01 02 00 04 21 10 66 29 ...........!.f)
> HCI Event: Inquiry Result (0x02) plen 15
0000: 01 33 49 16 93 0d 00 01 02 00 04 21 10 c9 38 .3I........!..8
> HCI Event: Inquiry Complete (0x01) plen 1
0000: 00


Dump for the scan (very similar, i guess scan uses inquiry as well)
< HCI Command: Inquiry (0x01|0x0001) plen 5
0000: 33 8b 9e 08 c8 3....
> HCI Event: Command Status (0x0f) plen 4
0000: 00 01 01 04 ....
> HCI Event: Inquiry Result (0x02) plen 15
0000: 01 f5 32 0f 93 0d 00 01 02 00 04 21 10 fa 34 ..2........!..4
> HCI Event: Inquiry Result (0x02) plen 15
0000: 01 d4 e8 19 93 0d 00 01 02 00 04 21 10 66 29 ...........!.f)
> HCI Event: Inquiry Result (0x02) plen 15
0000: 01 c1 d7 17 93 0d 00 01 02 00 04 21 10 f0 15 ...........!...
> HCI Event: Inquiry Result (0x02) plen 15
0000: 01 ce 12 a7 46 13 00 01 00 00 00 00 00 5c 4c ....F........\L
> HCI Event: Inquiry Result (0x02) plen 15
0000: 01 33 49 16 93 0d 00 01 02 00 04 21 10 c9 38 .3I........!..8
> HCI Event: Inquiry Result (0x02) plen 15
0000: 01 31 2e 1c 93 0d 00 01 02 00 04 21 10 c9 18 .1.........!...
> HCI Event: Inquiry Complete (0x01) plen 1
0000: 00

Would anyone know what might be wrong? Thanks.

Cheers,

Arthur

------=_Part_25454_3970275.1132599881976
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
I compiled blueZ libs and utils without a problem. (using ./configure for l=
ibs and ./configure --enable-test for utils)<br>
After this, I ran hciconfig hci0 up, then hciconfig, both ran fine:<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:11:67:0F:C0:E7 AC=
L MTU: 678:8 SCO MTU: 48:10<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:77 acl:0 sco:0 events:9=
 errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:34 acl:0 sco:0 commands=
:9 errors:0<br>
<br>
However, when I try to run hcitool -i hci0 inq:<br>
<br>
Inquiring ...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
00:0D:93:0F:32:F5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock offset:
0x34fa&nbsp;&nbsp;&nbsp; class: 0x102104<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
00:0D:93:17:D7:C1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock offset:
0x15f1&nbsp;&nbsp;&nbsp; class: 0x102104<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
00:0E:07:15:64:B3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock offset:
0x1069&nbsp;&nbsp;&nbsp; class: 0x520204<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
00:13:46:A7:12:CE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock offset:
0x4c61&nbsp;&nbsp;&nbsp; class: 0x000000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
00:0D:93:19:E8:D4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock offset:
0x2966&nbsp;&nbsp;&nbsp; class: 0x102104<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
00:0D:93:1C:2E:31&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock offset:
0x18cb&nbsp;&nbsp;&nbsp; class: 0x102104<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
00:0D:93:16:49:33&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock offset:
0x38ca&nbsp;&nbsp;&nbsp; class: 0x102104<br>
hcitool: symbol lookup error: hcitool: undefined symbol: bt_free&nbsp; <br>
<br>
I get this symbol lookup error. Then when I try hcitool -i hci0 scan:<br>
<br>
Scanning ...<br>
hcitool: symbol lookup error: hcitool: undefined symbol: hci_read_remote_na=
me_with_clock_offset<br>
<br>
Yet another lookup error.<br>
<br>
Dump for the inq: <br>
<br>
# hcidump -X<br>
HCI sniffer - Bluetooth packet analyzer ver 1.27<br>
device: hci0 snap_len: 1028 filter: 0xffffffff<br>
&lt; HCI Command: Inquiry (0x01|0x0001) plen 5<br>
&nbsp; 0000: 33 8b 9e 08
c8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
3....<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 0000: 00 01 01
04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
....<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 0000: 01 31 2e 1c 93 0d 00 01&nbsp; 02 00 04 21 10 ca 18&nbsp;&nbsp;=
&nbsp;&nbsp; .1.........!...<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 0000: 01 f5 32 0f 93 0d 00 01&nbsp; 02 00 04 21 10 fa 34&nbsp;&nbsp;=
&nbsp;&nbsp; ..2........!..4<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 0000: 01 ce 12 a7 46 13 00 01&nbsp; 00 00 00 00 00 5d 4c&nbsp;&nbsp;=
&nbsp;&nbsp; ....F........]L<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 0000: 01 d4 e8 19 93 0d 00 01&nbsp; 02 00 04 21 10 66 29&nbsp;&nbsp;=
&nbsp;&nbsp; ...........!.f)<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 0000: 01 33 49 16 93 0d 00 01&nbsp; 02 00 04 21 10 c9 38&nbsp;&nbsp;=
&nbsp;&nbsp; .3I........!..8<br>
&gt; HCI Event: Inquiry Complete (0x01) plen 1<br>
&nbsp; 0000: 00<br>
<br>
<br>
Dump for the scan (very similar, i guess scan uses inquiry as well)<br>
&lt; HCI Command: Inquiry (0x01|0x0001) plen 5<br>
&nbsp; 0000: 33 8b 9e 08
c8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
3....<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 0000: 00 01 01
04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
....<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 0000: 01 f5 32 0f 93 0d 00 01&nbsp; 02 00 04 21 10 fa 34&nbsp;&nbsp;=
&nbsp;&nbsp; ..2........!..4<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 0000: 01 d4 e8 19 93 0d 00 01&nbsp; 02 00 04 21 10 66 29&nbsp;&nbsp;=
&nbsp;&nbsp; ...........!.f)<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 0000: 01 c1 d7 17 93 0d 00 01&nbsp; 02 00 04 21 10 f0 15&nbsp;&nbsp;=
&nbsp;&nbsp; ...........!...<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 0000: 01 ce 12 a7 46 13 00 01&nbsp; 00 00 00 00 00 5c 4c&nbsp;&nbsp;=
&nbsp;&nbsp; ....F........\L<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 0000: 01 33 49 16 93 0d 00 01&nbsp; 02 00 04 21 10 c9 38&nbsp;&nbsp;=
&nbsp;&nbsp; .3I........!..8<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 0000: 01 31 2e 1c 93 0d 00 01&nbsp; 02 00 04 21 10 c9 18&nbsp;&nbsp;=
&nbsp;&nbsp; .1.........!...<br>
&gt; HCI Event: Inquiry Complete (0x01) plen 1<br>
&nbsp; 0000: 00<br>
<br>
Would anyone know what might be wrong? Thanks.<br>
<br>
Cheers,<br>
<br>
&nbsp; Arthur<br>
<br>

------=_Part_25454_3970275.1132599881976--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
