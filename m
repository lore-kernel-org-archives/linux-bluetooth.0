Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44C73308.3010903@gmail.com>
Date: Wed, 26 Jul 2006 05:16:56 -0400
From: JP Freeley <jpf321@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Unable to get on on the D-Bus
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I have moved to the debian "sid" branch as it has 3.1 bluez included.

When I first apt-get'd the necessary packages everything seemed to work OK.
After REBOOT I am getting the following messages about HCID:

Jul 27 03:41:37  hcid[1460]: Bluetooth HCI daemon
Jul 27 03:41:37 sdpd[1462]: Bluetooth SDP daemon
Jul 27 03:41:37 hcid[1460]: Service could not become the primary owner.
Jul 27 03:41:37 hcid[1460]: Unable to get on D-Bus
Jul 27 03:41:38 dund[1481]: Bluetooth DUN daemon version 3.1

Yes, I have dbus installed and presumably running:
% ps -ef | grep dbus
100       1412     1  0 03:41 ?        00:00:00 /usr/bin/dbus-daemon 
--system

Here are my installed versions:
% apt-show-versions | grep -e dbus -e bluez
libdbus-1-2/sid uptodate 0.62-4
libdbus-glib-1-2/sid uptodate 0.62-4
bluez-utils/sid uptodate 3.1-2
bluez-firmware/sid uptodate 1.0-3
dbus/sid uptodate 0.62-4
bluez-hcidump/sid uptodate 1.31-1
libbluetooth2/sid uptodate 3.1-1

On boot-up here are the reported versions:
Kernel ver. 2.4.32
BlueZ Core 2.4
HCI USB 2.7
l2cap 2.3
rfcomm 1.1

I should mention, I suppose, that I am running low on available disk 
space, I will work towards cleaning that up, could this be the root of 
this error?

Thanks,

jpf

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
