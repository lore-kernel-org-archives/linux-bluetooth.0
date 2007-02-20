Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45DA65D9.7050306@xmission.com>
Date: Mon, 19 Feb 2007 20:07:05 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <a72d33330702180733jc643ec1v857be8c144ab25a7@mail.gmail.com>
In-Reply-To: <a72d33330702180733jc643ec1v857be8c144ab25a7@mail.gmail.com>
Subject: Re: [Bluez-users] Plugz: compile errors with latest CVS
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

Ma

> a2dpd_uinput.c: In function `init_uinput':
> a2dpd_uinput.c:58: error: unknown field `id' specified in initializer

I think the problem is we include kernel headers for the uinput driver
and things have changed in the kernel. Almost everything else is
independent of the kernel version, so this is unfortunate.

bluez does not include linux/uinput.h. I'm looking around in hidd to see
how we should handle uinput.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
