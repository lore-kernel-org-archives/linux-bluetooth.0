Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 10 Dec 2006 13:37:49 +0800
From: amateur <ztl.post@gmail.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20061210053749.GA11996@163.com>
References: <e4f1f0110612091109r3a89fa38t96afa23c7167e9d4@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <e4f1f0110612091109r3a89fa38t96afa23c7167e9d4@mail.gmail.com>
Subject: Re: [Bluez-users] Has my passkey agent registered?
Reply-To: amateur <ztl.post@gmail.com>,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Sat, Dec 09, 2006 at 07:09:16PM +0000, jonny Linux wrote:
> Hi,
> 
> I get the following message even when I have the passkey-agent from utils,
> or the gnome bluetooth-applet.
> 
> I've heard I should be able to find out if the passkey-agent is registered
> by reading the syslog. I use Fedora Core 5, but I don't know where that is -
> do I need to set a config file somewhere to tell bluez where to log to?
> 
> 
> HCI sniffer - Bluetooth packet analyzer ver 1.32
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>    bdaddr 00:16:53:03:1D:31 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> >HCI Event: Command Status (0x0f) plen 4
>    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> >HCI Event: Link Key Request (0x17) plen 6
>    bdaddr 00:16:53:03:1D:31
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>    bdaddr 00:16:53:03:1D:31 key 918D88F4AB15B646C499779B3252344B
> >HCI Event: Command Complete (0x0e) plen 10
>    Link Key Request Reply (0x01|0x000b) ncmd 1
>    status 0x00 bdaddr 00:16:53:03:1D:31
> >HCI Event: Connect Complete (0x03) plen 11
>    status 0x05 handle 11 bdaddr 00:16:53:03:1D:31 type ACL encrypt 0x00
>    Error: Authentication Failure
Hi Jonny!
It seems that your computer have paired with the device before and
stored the link key. So there is no need to call the passkey-agent to
get a new PIN code from the user. You can use 
	hcitool key device_addr
to change the link key, and this will ask you for a new PIN code.

> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-------------------------

-- 
Q:	What does a WASP Mom make for dinner?
A:	A crisp salad, a hearty soup, a lovely entree, followed by
	a delicious dessert.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
