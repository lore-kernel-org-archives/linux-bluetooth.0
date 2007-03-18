Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <f045cde30703181333t6e9c1f39v5937ef483ac2b0a8@mail.gmail.com>
Date: Sun, 18 Mar 2007 13:33:51 -0700
From: "kyle cronan" <kyle@pbx.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Billionton pc card fails with "BCSP initialization
	timed out"
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

I have a bluetooth PC card made by Billionton, which I believe uses
the CSR chip and the BCSP protocol.  pccardctl shows the hardware ID
as 0279-950B, same as in the 'hciattach -l' list under billionton.
Anyway, I got this card working before, when I was using Gentoo, but
now I have Fedora Core 6 and I'm not having any luck so far.  Though I
have no idea what could be different about my new distro.

When I insert the card, dmesg shows a new serial device at /dev/ttyS0.
 I then try

hciattach /dev/ttyS0 billionton

but I get the "BCSP initialization timed out" message.  I've searched
and searched for info on this problem, and found a number of
suggestions (although mostly regarding the CF version of the card +
linux PDAs).  One of these was to set the baud_base to 921600 with
setserial--that didn't change anything.  I also found a page that
suggested patching the 2.6 kernel to allow the 16c950 to be set to the
nonstandard baudrate 230400.  But I downloaded the sources rpm for my
kernel and I see that it already has this patch.

I've also tried various baudrate options for the hciattach program,
and specifying bcsp directly instead of using the "billionton"
bluetooth device type.  There don't seem to be any error messages or
anything else relevant in my logs.  The kernel version is 2.6.20.

Any suggestions would be most appreciated!

Kyle Cronan
<kyle@pbx.org>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
