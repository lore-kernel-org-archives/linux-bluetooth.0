Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <e4f1f0110612091109r3a89fa38t96afa23c7167e9d4@mail.gmail.com>
Date: Sat, 9 Dec 2006 19:09:16 +0000
From: "jonny Linux" <jonnylinux@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] Has my passkey agent registered?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1657161665=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1657161665==
Content-Type: multipart/alternative;
	boundary="----=_Part_79220_2448073.1165691356230"

------=_Part_79220_2448073.1165691356230
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm trying to connect to my Lego Mindstorms NXT using bluez-libs and
bluez-utils 3.7.
I've tried various programs to connect, but I basically just need a
/dev/rfcomm0, but no program seems to be able to use it.

I get the following message even when I have the passkey-agent from utils,
or the gnome bluetooth-applet.

I've heard I should be able to find out if the passkey-agent is registered
by reading the syslog. I use Fedora Core 5, but I don't know where that is -
do I need to set a config file somewhere to tell bluez where to log to?

Thanks,

Jonny

HCI sniffer - Bluetooth packet analyzer ver 1.32
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:16:53:03:1D:31 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:16:53:03:1D:31
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:16:53:03:1D:31 key 918D88F4AB15B646C499779B3252344B
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:16:53:03:1D:31
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 11 bdaddr 00:16:53:03:1D:31 type ACL encrypt 0x00
    Error: Authentication Failure

------=_Part_79220_2448073.1165691356230
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I'm trying to connect to my Lego Mindstorms NXT using bluez-libs and bluez-utils 3.7.<br>I've tried various programs to connect, but I basically just need a /dev/rfcomm0, but no program seems to be able to use it.
<br><br>I get the following message even when I have the passkey-agent from utils, or the gnome bluetooth-applet.<br><br>I've heard I should be able to find out if the passkey-agent is registered by reading the syslog. I use Fedora Core 5, but I don't know where that is - do I need to set a config file somewhere to tell bluez where to log to?
<br><br>Thanks,<br><br>Jonny<br><br>HCI sniffer - Bluetooth packet analyzer ver 1.32<br>device: hci0 snap_len: 1028 filter: 0xffffffff<br>&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<br>&nbsp;&nbsp;&nbsp; bdaddr 00:16:53:03:1D:31 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
<br>&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Create Connection (0x01|0x0005) status 0x00 ncmd 1<br>&gt; HCI Event: Link Key Request (0x17) plen 6<br>&nbsp;&nbsp;&nbsp; bdaddr 00:16:53:03:1D:31
<br>&lt; HCI Command: Link Key Request Reply (0x01|0x000b) plen 22<br>&nbsp;&nbsp;&nbsp; bdaddr 00:16:53:03:1D:31 key 918D88F4AB15B646C499779B3252344B<br>&gt; HCI Event: Command Complete (0x0e) plen 10<br>&nbsp;&nbsp;&nbsp; Link Key Request Reply (0x01|0x000b) ncmd 1
<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:16:53:03:1D:31<br>&gt; HCI Event: Connect Complete (0x03) plen 11<br>&nbsp;&nbsp;&nbsp; status 0x05 handle 11 bdaddr 00:16:53:03:1D:31 type ACL encrypt 0x00<br>&nbsp;&nbsp;&nbsp; Error: Authentication Failure<br><br>

------=_Part_79220_2448073.1165691356230--


--===============1657161665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1657161665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1657161665==--
