Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 20 Sep 2006 12:22:40 +0200 (CEST)
From: SZABO Tamas <sza2king@freemail.hu>
To: bluez-users@lists.sourceforge.net
Message-ID: <freemail.20060820122240.8417@fm12.freemail.hu>
MIME-Version: 1.0
Subject: Re: [Bluez-users] 3 or more BT dongles over 1 USB-2.0 4-port HUB
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

hi Petr,

I was realising the same problem but in case of USB-Serial
converter. The solution for me was to remove ehci-hcd and
using the full speed uhci-hcd driver only. I think the lower
12MB/s speed  can not be a problem for BT.

Good luck!

/sza2

PS: Sorry, I don't now how to reply on the sourceforge page,
it is readonly although I logged in. So this may start a new
thread.


_______________________________________________________________________
25% kedvezm=E9ny 3 k=F6nyv v=E1s=E1rl=E1sa eset=E9n! Bookline.hu
http://www.bookline.hu/control/news?newsid=3D484&affiliate=3Dfre25skar3067



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
