Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 18 Feb 2007 13:29:49 +0100
From: Michael Mauch <michael.mauch@gmx.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070218122948.GA4968@elmicha>
References: <1171735666.9069.1.camel@violet>
	<743295.39090.qm@web31708.mail.mud.yahoo.com>
MIME-Version: 1.0
In-Reply-To: <743295.39090.qm@web31708.mail.mud.yahoo.com>
Subject: Re: [Bluez-users] ./configure tells me dbus is required
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

tim culwins wrote:

>    So I ran make install and everything seemed to
> work. However now when I look in synaptic it tells me
> that 3.7 is still installed. How can I tell if 3.9 is
> working?

If you installed from source and did not make a package (.deb), your
package manager cannot know.

Tell synaptic to uninstall 3.7, then run "make install" again to be sure
that everything from 3.9 is installed.

Regards...
		Michael

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
