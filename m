Return-Path: <cyrus@holtmann.org>
Message-ID: <4852914F.6020209@earthlink.net>
Date: Fri, 13 Jun 2008 10:25:03 -0500
From: "Mumia W.." <paduille.4061.mumia.w+nospam@earthlink.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <e96e9eeb0806130507u139f58a2sa7094a65f9ecff17@mail.gmail.com>
In-Reply-To: <e96e9eeb0806130507u139f58a2sa7094a65f9ecff17@mail.gmail.com>
Subject: Re: [Bluez-users] Bluez build problem
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

On 06/13/2008 07:07 AM, Voni Hakau wrote:
> Hi all,
> 
> I'm cross compiling bluez-util to my platform, so I use something like
> --prefix=/path/to/my/platform/root/filesystem/usr. Everything builds
> and installs perfectly.
> 
> But, in my platform, bluez now thinks that all the files are located
> in the path /path/to/my/platform/root/filesystem/usr (it is hard coded
> in the binaries), which doesn't really exists on the platform - it was
> just on my host, where I built my root fs for the platform. I need to
> install everything on my host to that path, but on the platform I need
> bluez to ignore it...
> 
> Any suggestions ? I can always use --prefix=/usr and then manually
> copy all the files to /path/to/my/platform/root/filesystem/usr but
> that is too hard... there must be a better way..
> 
> Thank you!
> Voni
> 

Hi Voni.

Try to create a package instead. Use --prefix=/usr when you configure, 
but use DESTDIR=/tmp/buildplace when you install.

That should install the files to /tmp/buildplace. Use tar(1) to create a 
tarball of the files in /tmp/buildplace, or even better, use a packager 
for your preferred platform.

During configuration, your command line might look like this:

make --prefix=/usr

When you "install" the package, you'll use this command:

make install DESTDIR=/tmp/buildplace

Obviously, the files won't be installed to the right place. No problem, 
use tar(1).

cd /tmp/buildplace
tar czf /tmp/bluez-x.xx-i386.tar.gz *

Now you have a tarball that you can install wherever you wish, including 
the correct place for your platform, 
/path/to/my/platform/root/filesystem/usr.

Good luck.



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
