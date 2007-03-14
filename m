Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 14 Mar 2007 08:54:09 -0500
From: Igor Chudov <ichudov@Algebra.Com>
To: BlueZ Users <bluez-users@lists.sourceforge.net>
Message-ID: <20070314135409.GA9801@manifold.algebra.com>
Mime-Version: 1.0
Subject: [Bluez-users] Connecting to cell phone DOES NOT WORK
Reply-To: ichudov@Algebra.Com, BlueZ users <bluez-users@lists.sourceforge.net>
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

I have Fedora Core 6, and its stock BlueZ stack. I also have a
motorola V557 phone and a TrendNET USB based bluetooth device.

Things do not work well so far.

I have the following symptoms:

1) hcitool scan works and sees my phone
2) hcitool cc does not report any errors. 
3) hcitool auth does NOT seem to connect
4) The phone, when asked to "look around" to find Bluetooth devices,
does NOT see my laptop.

What I want is to find a 100% pure scripting solution (preferably no
GUI). I guess I am misunderstanding who should be connecting to whom,
so

* Who is the master (laptop vs phone) and who is the slave

* Who should be initiating connection to whom

* Who should set a PIN and who should supply same PIN for authentication

I feel that once I get past this confusion, I will be able to go
forward, I have been a linux user for 12 years (have only linux at
home). ppp should not be a huge problem, though it's been 6 or so
years since I used it. 

Thanks A LOT for your help!

i

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
