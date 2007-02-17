Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45D6DA8B.4060405@sneakemail.com>
Date: Sat, 17 Feb 2007 11:35:55 +0100
From: =?ISO-8859-1?Q?Peter_Valdemar_M=F8rch?= <swp5jhu02@sneakemail.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Request FAQ entries: (need for) passkey-agent +
 replug dongle for it to work...
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi there,

Thanks for great software. It rocks when its configured right. Which
took some time - at least for me.

First, I spent a long time wondering why `hcitool scan` was empty /
didn't show any output other than "Scanning ..."

I had plugged in my brand new Bluetooth USB dongle and seen that it
loaded the USB and bluetooth drivers! Great! Then I installed and
bluez-utils and gnokii. `hcitool scan` kept showing empty output until I
unplugged and reconnected the dongle!!! How was I to know *that*? I
remember struggling with this before and also tearing my hair out when I
discovered it back then... :D I found several questions about this (with
some suggestions about pin_helper!! ) but no good answers/solutions.

Next, I spent *forever* trying to get pin_helper to work on my new
installation! And it didn't because I'm using 3.X versions. There are
*so* many posts out there talking about pin_helper, that I didn't even
question that they all might be invalid.

Somewhere along the line I discovered Marcel Holtmann mentioning =

something about passkey-agent. 3 minutes later all was working fine.

I've now spent almost 5 hours getting a new bluetooth dongle and my
phone to communicate, even though I already had a laptop working with
bluez setup right next to it.

May I please suggest that these two be added as FAQs?
(At the very least, I'll now be able to find these two valuable tips in
the mailing list archives next time! :D)

Ciao, and thanks for great code!

Peter

-- =

Peter Valdemar M=F8rch
http://www.morch.com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
