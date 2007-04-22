Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c38065090704221038ia8dacc9i84818502e76ecb67@mail.gmail.com>
Date: Sun, 22 Apr 2007 12:38:51 -0500
From: "Philip S. Trasatti Jr." <trasatti@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Can't connect to Freedom Input Mini Duo keyboard
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0270908147=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0270908147==
Content-Type: multipart/alternative;
	boundary="----=_Part_133121_6093348.1177263531082"

------=_Part_133121_6093348.1177263531082
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Recently I purchased a Freedom Input Mini Duo keyboard which has both the
HID and SPP profile. The manufacturer also advertises that it supports
Linux! I have tested it under Windows and it connects and functions properly
as a HID keyboard.

... manufacturer web page is here...
http://www.freedominput.com/site/index.php?option=com_content&task=view&id=14&Itemid=29

I'm using Gentoo with manually updated bluez-libs-3.9 and bluez-tools-3.9

I can scan and find the keyboard fine...

# hcitool scan
Scanning ...
        00:0B:0D:6F:7F:88       KEYBOARD

and also l2ping it...

# l2ping 00:0B:0D:6F:7F:88
Ping: 00:0B:0D:6F:7F:88 from 00:10:60:AF:BE:B6 (data size 44) ...
0 bytes from 00:0B:0D:6F:7F:88 id 0 time 56.62ms
0 bytes from 00:0B:0D:6F:7F:88 id 1 time 19.02ms
0 bytes from 00:0B:0D:6F:7F:88 id 2 time 12.02ms
0 bytes from 00:0B:0D:6F:7F:88 id 3 time 9.02ms
4 sent, 4 received, 0% loss

but when I try to connect to it nothing happens...

# hcitool cc 00:0B:0D:6F:7F:88
# hcitool con
Connections:
#

here is a hcidump of when I try to connect...

# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.34
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0B:0D:6F:7F:88 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 6 bdaddr 00:0B:0D:6F:7F:88 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 6
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 6 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 6
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:0B:0D:6F:7F:88 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 6 slots 5
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 6
    Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:0B:0D:6F:7F:88 name 'KEYBOARD'
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 6 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 6 reason 0x16
    Reason: Connection Terminated by Local Host

Can someone point me in the right direction?

------=_Part_133121_6093348.1177263531082
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Recently I purchased a Freedom Input Mini Duo keyboard which has both the HID and SPP profile. The manufacturer also advertises that it supports Linux! I have tested it under Windows and it connects and functions properly as a HID keyboard.
<br><br>... manufacturer web page is here...<br><a href="http://www.freedominput.com/site/index.php?option=com_content&amp;task=view&amp;id=14&amp;Itemid=29">http://www.freedominput.com/site/index.php?option=com_content&amp;task=view&amp;id=14&amp;Itemid=29
</a><br><br>I&#39;m using Gentoo with manually updated bluez-libs-3.9 and bluez-tools-3.9<br><br>I can scan and find the keyboard fine...<br><br># hcitool scan<br>Scanning ...<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00:0B:0D:6F:7F:88&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KEYBOARD<br>
<br>and also l2ping it...<br><br># l2ping 00:0B:0D:6F:7F:88<br>Ping: 00:0B:0D:6F:7F:88 from 00:10:60:AF:BE:B6 (data size 44) ...<br>0 bytes from 00:0B:0D:6F:7F:88 id 0 time 56.62ms<br>0 bytes from 00:0B:0D:6F:7F:88 id 1 time 
19.02ms<br>0 bytes from 00:0B:0D:6F:7F:88 id 2 time 12.02ms<br>0 bytes from 00:0B:0D:6F:7F:88 id 3 time 9.02ms<br>4 sent, 4 received, 0% loss<br><br>but when I try to connect to it nothing happens...<br><br># hcitool cc 00:0B:0D:6F:7F:88
<br># hcitool con<br>Connections:<br>#<br><br>here is a hcidump of when I try to connect...<br><br># hcidump -X -V<br>HCI sniffer - Bluetooth packet analyzer ver 1.34<br>device: hci0 snap_len: 1028 filter: 0xffffffff<br>&lt; HCI Command: Create Connection (0x01|0x0005) plen 13
<br>&nbsp;&nbsp;&nbsp; bdaddr 00:0B:0D:6F:7F:88 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000<br>&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Create Connection (0x01|0x0005) status 0x00 ncmd 1
<br>&gt; HCI Event: Connect Complete (0x03) plen 11<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 6 bdaddr 00:0B:0D:6F:7F:88 type ACL encrypt 0x00<br>&lt; HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2<br>&nbsp;&nbsp;&nbsp; handle 6<br>&gt; HCI Event: Command Status (0x0f) plen 4
<br>&nbsp;&nbsp;&nbsp; Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1<br>&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<br>&nbsp;&nbsp;&nbsp; handle 6 policy 0x0f<br>&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br>&gt; HCI Event: Command Complete (0x0e) plen 6
<br>&nbsp;&nbsp;&nbsp; Write Link Policy Settings (0x02|0x000d) ncmd 1<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 6<br>&lt; HCI Command: Remote Name Request (0x01|0x0019) plen 10<br>&nbsp;&nbsp;&nbsp; bdaddr 00:0B:0D:6F:7F:88 mode 2 clkoffset 0x0000<br>&gt; HCI Event: Command Status (0x0f) plen 4
<br>&nbsp;&nbsp;&nbsp; Remote Name Request (0x01|0x0019) status 0x00 ncmd 1<br>&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>&nbsp;&nbsp;&nbsp; handle 6 slots 5<br>&gt; HCI Event: Read Remote Supported Features (0x0b) plen 11<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 6
<br>&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00<br>&gt; HCI Event: Remote Name Req Complete (0x07) plen 255<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:0B:0D:6F:7F:88 name &#39;KEYBOARD&#39;<br>&lt; HCI Command: Disconnect (0x01|0x0006) plen 3
<br>&nbsp;&nbsp;&nbsp; handle 6 reason 0x13<br>&nbsp;&nbsp;&nbsp; Reason: Remote User Terminated Connection<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Disconnect (0x01|0x0006) status 0x00 ncmd 1<br>&gt; HCI Event: Disconn Complete (0x05) plen 4
<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 6 reason 0x16<br>&nbsp;&nbsp;&nbsp; Reason: Connection Terminated by Local Host<br><br>Can someone point me in the right direction?<br><br><br>

------=_Part_133121_6093348.1177263531082--


--===============0270908147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0270908147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0270908147==--
