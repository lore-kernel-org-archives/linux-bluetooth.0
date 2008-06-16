Return-Path: <cyrus@holtmann.org>
Message-ID: <e96e9eeb0806160505m44d366e7if9cea8e1d3c6978b@mail.gmail.com>
Date: Mon, 16 Jun 2008 15:05:10 +0300
From: "Voni Hakau" <hakauvoni@gmail.com>
To: paduille.4061.mumia.w+nospam@earthlink.net
In-Reply-To: <4852914F.6020209@earthlink.net>
MIME-Version: 1.0
References: <e96e9eeb0806130507u139f58a2sa7094a65f9ecff17@mail.gmail.com>
	<4852914F.6020209@earthlink.net>
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
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

On Fri, Jun 13, 2008 at 6:25 PM, Mumia W..
<paduille.4061.mumia.w+nospam@earthlink.net> wrote:
> On 06/13/2008 07:07 AM, Voni Hakau wrote:
>> I'm cross compiling bluez-util to my platform, so I use something like
>> --prefix=/path/to/my/platform/root/filesystem/usr.

> Try to create a package instead. Use --prefix=/usr when you configure,
> but use DESTDIR=/tmp/buildplace when you install.
>
> That should install the files to /tmp/buildplace. Use tar(1) to create a
> tarball of the files in /tmp/buildplace, or even better, use a packager
> for your preferred platform.
>
> During configuration, your command line might look like this:
>
> make --prefix=/usr
>
> When you "install" the package, you'll use this command:
>
> make install DESTDIR=/tmp/buildplace
>
> Obviously, the files won't be installed to the right place. No problem,
> use tar(1).
>
> cd /tmp/buildplace
> tar czf /tmp/bluez-x.xx-i386.tar.gz *
>
> Now you have a tarball that you can install wherever you wish, including
> the correct place for your platform,
> /path/to/my/platform/root/filesystem/usr.

Wow this is an amazing idea !! Thank you so much !!

I didn't know I can give --prefix to make. Or did you mean to ./configure ?

and I didn't know there is DESTDIR for make install. great great tip !!!

So I can just do make install DESTDIR with the prefix of my platform
root filesystem,
right ? I don't have to do the package, right ?

Thank you so much for this!! it's a really great idea..

Voni


>
> Good luck.
>
>
>
> -------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
