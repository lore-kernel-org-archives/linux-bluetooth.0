Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Felix Homann <fexpop@onlinehome.de>
To: bluez-users@lists.sourceforge.net
Date: Thu, 27 Jul 2006 12:40:49 +0200
MIME-Version: 1.0
Message-Id: <200607271240.49400.fexpop@onlinehome.de>
Subject: [Bluez-users] Several problems with bluez-utils 3.1,
	kbluetoothd and a Belkin dongle in Debian
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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

Hi,

though I already filed bug reports to the Debian BTS [1],[2] I'd like to ask 
for advice here, too.

First, using bluez-utils 3.1-* from Debian/Sid I can't discover my PC from 
other BT devices. I tried this with 3 different BT cards/dongles. Downgrading 
to bluez-utils 2.25-1 makes my system visible again.

Second, kbluetoothd will not find other BT devices when I use a Belkin F8T013 
dongle and bluez-utils 3.1-*, 'hcitool scan' works fine, though. While a  
SPHINX PCMCIA card and an EPoX BT-DG03 work fine with kbluetoothd and 
bluez-utils 3.1-* the Belkin dongle will only play together with bluez-utils 
<=2.25-1.

Any ideas?

Kind regards,

Felix

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=379401
[2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=379403

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
