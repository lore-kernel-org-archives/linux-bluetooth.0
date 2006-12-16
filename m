Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <231dafb50612152211h1bc9ca42lade6687ac51c0@mail.gmail.com>
Date: Fri, 15 Dec 2006 23:11:03 -0700
From: "Dark Shadow" <shadowofdarkness@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Trouble loading firmware with bcm203x
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

I just bought a Bluetooth dongle that uses the Broadcom 4503 chipset
and I am having trouble getting stable use out of it. I have got it to
work twice before with the following steps

plug it in
modprobe bcm203x
hciconfig up
hciconfig reset (hours of googling to find out this is required)

My only problem is that the firmware loading works with the same
chances as winning the lottery. How can I make it just work on the
first try loading. After the firmware is loaded I can use the dongle
fine. But it is rare to get that to work as can be seen by my trying
for 3 hours last night till I just gave up.

I am running Ubuntu Edgy and have tried using various kernel versions
from 2.5.17-2.6.20-rc1

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
