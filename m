Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 08 Dec 2006 13:47:15 +0100
Message-Id: <969792183@web.de>
MIME-Version: 1.0
From: Christian Gebhard <gebhard_christian@web.de>
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] latency problems
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Good Afternoon

I have some problems concerning my round trip time using l2ping. I have two=
 PCs(kernel 2.6.17) each with a Bluegiga WT11 module connected via USB. Whe=
n I use l2ping the round trip time is between 14ms and up to sometimes 65ms=
. I also wrote  two programs that send and return numbers and count the tim=
e between sending and receiving a number. Here the times are similar. Howev=
er when I reduce the time between the pings the round trip time is a bit sh=
orter.

My questions:
   - are these times normal (average of 20ms)?
   - are the "extremely" varying times normal? =

   - are the times dependent to the power management of the BT-module

I would appreciate any help

Regards

Chris
___________________________________________________________________________=
___
"Ein Herz f=FCr Kinder" - Ihre Spende hilft! Aktion: www.deutschlandsegelt.=
de
Unser Dankesch=F6n: Ihr Name auf dem Segel der 1. deutschen America's Cup-Y=
acht!


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
