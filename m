Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Igor Chudov <ichudov@Algebra.Com>
Message-Id: <200703150019.l2F0JDxL032191@manifold.algebra.com>
To: bluez-users@lists.sourceforge.net
Date: Wed, 14 Mar 2007 19:19:13 -0500
Subject: [Bluez-users] FOLLOWUP -- finally,
	the PPP over Bluetooth/Cell Phone WORKS!
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

[This message has also been posted to comp.os.linux.misc,comp.os.linux.networking .]
[Cc: to bluez-user mailing list]

I have finally made my linux laptop connect to internet using my cell
phone. 

I resolved the problem of cell phone and laptop not seeing one
another, by means of gnome-phone-manager. After the initial handshake
and exchange of PIN, they would recognize one another.

After that, I write a ppp script to connect to Cingular. Struggled for
a few hours with the issue of cingular dropping me instantly after
authentication. 

Turns out that the customer service rep dummy with whom I spoke
yesterday, put me on a wrong plan and I was not provisioned for a cell
phone modem connection. After 20 minutes of trying to convince a
similarly clueless rep to let me talk to someone more knowledgeable
(she was trying to prove to me that I could not use my cell phone as a
modem), I was connected to a more knowledgeable rep who put me on the
right plan.

After that, voila, everything is working just fine. I get IP addresses
assigned, routing works, everything is fine. I will add my bluetooth
to my autodiscover network script. This script makes sure that my
laptop finds the best possible internet connection (home ethernet,
home wifi, work ethernet, and now Cingular) all by itself without icon
clicking and other nonsense. 

Big kudos go to the BlueZ team and to authors of gnome-phone-manager. 

Thank you guys!

i
PS my next plan is to make my laptop into a wifi station so that other
people (my wife) could connect to me on the train, while my laptop is
connected to Cingular via cell phone. 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
