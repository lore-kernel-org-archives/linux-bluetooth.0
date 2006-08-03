Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060803072203.28576.qmail@web30315.mail.mud.yahoo.com>
Date: Thu, 3 Aug 2006 00:22:03 -0700 (PDT)
From: "Martin (KaFai), Lau" <iamkafai2002@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Problem with microsoft bluetooth keyboard and mouse
Reply-To: "Martin (KaFai), Lau" <iamkafai2002@yahoo.com>,
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

I have some questions/problems with my MS bluetooth keyboard and mouse that I bought a few years back:

kafai-desk ~ # uname -a
Linux kafai-desk 2.6.17-gentoo-r4 #2 PREEMPT Wed Aug 2 16:25:07 PDT 2006 i686 AMD Sempron(tm)   2200+ GNU/Linux

kafai-desk ~ # hidd --show
00:50:F2:E4:15:68 Bluetooth HID Boot Protocol Device [045e:007b] connected [boot-protocol]
00:50:F2:E3:0A:CA Bluetooth HID Boot Protocol Device [045e:007c] connected [boot-protocol]


1. The keyboard multimedia keys don't work. I tried to cat /dev/input/event2 but it did not show anything when I pressed the multimedia keys.  It is does in terminal (i.e. not under x11). xev also shows nothing. I can write some codes if it is necessary.  I appreciate someone can give me a pointer to the source.

2. I guess the following is xmodmap related.  My keypad does not print out 0-9 any more under xorg-x11 (in both xorg 6.8 and 7.0).  Instead, it move the cursor....it used to work...anyone knows how to xmodmap them properly so that I can get 0-9 back from my keypad?


3. Anyone has experience on how to map the side buttons of the mouse so that it can go to the forward and backward page in firefox?  I did try the googled page without any success.


Many Thanks

--Martin




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
