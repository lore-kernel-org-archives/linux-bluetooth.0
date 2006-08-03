Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060803073108.60537.qmail@web30306.mail.mud.yahoo.com>
Date: Thu, 3 Aug 2006 00:31:08 -0700 (PDT)
From: "Martin (KaFai), Lau" <iamkafai2002@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Problem with bluetooh mouse/keyboard + evdev + xorg
	7.0
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

I am using a microsoft bluetooth mouse and keyboard.  I am using evdev in xorg 7.0 to access them.  However, something weird happened when some kind of timeout occurs.  For example, my mouse used to be /dev/input/event3. After I didn't move the mouse for a few minutes, my mouse cannot move forever....After puzzling for awhile, I realized the /dev/input/event3 disappeared and /dev/input/event4 created instead...

Any clue what may be wrong?  Any workaround I can do?

kafai-desk ~ # uname -a
Linux kafai-desk 2.6.17-gentoo-r4 #2 PREEMPT Wed Aug 2 16:25:07 PDT 2006 i686 AMD Sempron(tm)   2200+ GNU/Linux

kafai-desk ~ # hidd --show
00:50:F2:E3:0A:CA Bluetooth HID Boot Protocol Device [045e:007c] connected [boot-protocol]
00:50:F2:E4:15:68 Bluetooth HID Boot Protocol Device [045e:007b] connected [boot-protocol]

Many thanks

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
