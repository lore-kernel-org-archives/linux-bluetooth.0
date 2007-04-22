Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: CIJOML <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Date: Sun, 22 Apr 2007 21:39:42 +0200
References: <c38065090704221038ia8dacc9i84818502e76ecb67@mail.gmail.com>
In-Reply-To: <c38065090704221038ia8dacc9i84818502e76ecb67@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200704222139.42500.cijoml@volny.cz>
Subject: Re: [Bluez-users] Can't connect to Freedom Input Mini Duo keyboard
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

use hidd --server --master and later hidd --connect BDADDR

Michal

Dne ned=ECle 22 duben 2007 19:38 Philip S. Trasatti Jr. napsal(a):
> Recently I purchased a Freedom Input Mini Duo keyboard which has both the
> HID and SPP profile. The manufacturer also advertises that it supports
> Linux! I have tested it under Windows and it connects and functions
> properly as a HID keyboard.
>
> ... manufacturer web page is here...
> http://www.freedominput.com/site/index.php?option=3Dcom_content&task=3Dvi=
ew&id=3D
>14&Itemid=3D29
>
> I'm using Gentoo with manually updated bluez-libs-3.9 and bluez-tools-3.9
>
> I can scan and find the keyboard fine...
>
> # hcitool scan
> Scanning ...
>         00:0B:0D:6F:7F:88       KEYBOARD
>
> and also l2ping it...
>
> # l2ping 00:0B:0D:6F:7F:88
> Ping: 00:0B:0D:6F:7F:88 from 00:10:60:AF:BE:B6 (data size 44) ...
> 0 bytes from 00:0B:0D:6F:7F:88 id 0 time 56.62ms
> 0 bytes from 00:0B:0D:6F:7F:88 id 1 time 19.02ms
> 0 bytes from 00:0B:0D:6F:7F:88 id 2 time 12.02ms
> 0 bytes from 00:0B:0D:6F:7F:88 id 3 time 9.02ms
> 4 sent, 4 received, 0% loss
>
> but when I try to connect to it nothing happens...
>
> # hcitool cc 00:0B:0D:6F:7F:88
> # hcitool con
> Connections:
> #
>
> here is a hcidump of when I try to connect...
>
> # hcidump -X -V
> HCI sniffer - Bluetooth packet analyzer ver 1.34
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:0B:0D:6F:7F:88 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>
> > HCI Event: Command Status (0x0f) plen 4
>
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
>
> > HCI Event: Connect Complete (0x03) plen 11
>
>     status 0x00 handle 6 bdaddr 00:0B:0D:6F:7F:88 type ACL encrypt 0x00
> < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
>     handle 6
>
> > HCI Event: Command Status (0x0f) plen 4
>
>     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>     handle 6 policy 0x0f
>     Link policy: RSWITCH HOLD SNIFF PARK
>
> > HCI Event: Command Complete (0x0e) plen 6
>
>     Write Link Policy Settings (0x02|0x000d) ncmd 1
>     status 0x00 handle 6
> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>     bdaddr 00:0B:0D:6F:7F:88 mode 2 clkoffset 0x0000
>
> > HCI Event: Command Status (0x0f) plen 4
>
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
>
> > HCI Event: Max Slots Change (0x1b) plen 3
>
>     handle 6 slots 5
>
> > HCI Event: Read Remote Supported Features (0x0b) plen 11
>
>     status 0x00 handle 6
>     Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
>
> > HCI Event: Remote Name Req Complete (0x07) plen 255
>
>     status 0x00 bdaddr 00:0B:0D:6F:7F:88 name 'KEYBOARD'
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>     handle 6 reason 0x13
>     Reason: Remote User Terminated Connection
>
> > HCI Event: Command Status (0x0f) plen 4
>
>     Disconnect (0x01|0x0006) status 0x00 ncmd 1
>
> > HCI Event: Disconn Complete (0x05) plen 4
>
>     status 0x00 handle 6 reason 0x16
>     Reason: Connection Terminated by Local Host
>
> Can someone point me in the right direction?

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
