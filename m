Return-Path: <cyrus@holtmann.org>
Message-ID: <e96e9eeb0806130507u139f58a2sa7094a65f9ecff17@mail.gmail.com>
Date: Fri, 13 Jun 2008 15:07:46 +0300
From: "Voni Hakau" <hakauvoni@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] Bluez build problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi all,

I'm cross compiling bluez-util to my platform, so I use something like
--prefix=/path/to/my/platform/root/filesystem/usr. Everything builds
and installs perfectly.

But, in my platform, bluez now thinks that all the files are located
in the path /path/to/my/platform/root/filesystem/usr (it is hard coded
in the binaries), which doesn't really exists on the platform - it was
just on my host, where I built my root fs for the platform. I need to
install everything on my host to that path, but on the platform I need
bluez to ignore it...

Any suggestions ? I can always use --prefix=/usr and then manually
copy all the files to /path/to/my/platform/root/filesystem/usr but
that is too hard... there must be a better way..

Thank you!
Voni

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
