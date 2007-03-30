Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Christoph Burger-Scheidlin <andersin@freenet.de>
To: bluez-users@lists.sourceforge.net
Date: Fri, 30 Mar 2007 23:17:37 +0100
MIME-Version: 1.0
Message-Id: <200703302317.37908.andersin@freenet.de>
Subject: [Bluez-users] Logitech diNovo Desktop: keyboard keys and Mouse
	buttons
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

Hello all,

I have a logitech diNovo desktop and connect it directly to my bluetooth 
adapter in my laptop. I noticed that the F11, F12 and the Refresh button do 
not work and are not reported by xev. However, hciconfig shows an increase in 
the RX bytes and acl counters. Does this mean that the keyboard transmits 
data to the computer? I want to find out if the keyboard is transmitting a 
keycode, can someone point me to some resources that tell me how to listen in 
on the traffic.

I have a similar issue with the mouse buttons, i.e. that they report the same 
buttons to xev and an evtest program. I want to figure out how to see what 
the mouse is actually reporting.

Thanks you,

Christoph Burger-Scheidlin

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
