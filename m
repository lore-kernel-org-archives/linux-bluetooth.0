Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4511AD88.6030904@gzunk.com>
Date: Wed, 20 Sep 2006 22:07:20 +0100
From: Alasdair Thomson <alasdair@gzunk.com>
MIME-Version: 1.0
To: Bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Minor Keyboard niggles
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

Hello,

I have a Belkin F8T013 dongle that I've got working succesfully, but 
there are a few things that I would like to improve - and hopefully 
someone reading this will be able to help me.

I've got a keyboard connected via HIDP - hidd --show gives:

00:07:61:06:CB:DE Bluetooth HID Boot Protocol Device [046d:b303] 
connected [boot-protocol]

But whenever I have to reboot, the connection remains between the dongle 
and the keyboard, so it then complains at next boot. I've updated my 
bluetooth init script to do "hciconfig hci0 reset" on shutdown and that 
works, but I'd like to know if there's a better way of doing it.

Next is that I've got multimedia keys on the keyboard that I can't seem 
to use. Does this HID support provided by Bluez map those extra keys as 
well?

Thanks

Alasdair

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
