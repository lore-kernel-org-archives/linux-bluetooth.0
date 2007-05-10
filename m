Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Andrew Kohlsmith <akohlsmith-bluez@benshaw.com>
To: bluez-users@lists.sourceforge.net
Date: Thu, 10 May 2007 09:47:59 -0400
References: <e96e9eeb0705100523q62fde54r9bc674da0ac822f5@mail.gmail.com>
In-Reply-To: <e96e9eeb0705100523q62fde54r9bc674da0ac822f5@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200705100947.59821.akohlsmith-bluez@benshaw.com>
Subject: Re: [Bluez-users] API documentation?
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

On Thursday 10 May 2007 8:23 am, Voni Hakau wrote:
> sounds like no-fun to me. but hey, if you can post the solution for this
> you will probably help a lot of people.

It wasn't really all that difficult, as it does use the autoconf system, and 
autoconf is generally pretty good about cross-compilation.  Most of my 
troubles came due to vfork(), but that wasn't difficult to fix, and also due 
to my build environment being ... wonky.  :-)

> hmm going for a nother stack is no option for most of the projects
> because Bluez has become a standard.
> but.
> maybe a fork of the bluez user space application is a good solution.
> get rid of the dbus dependancies.

See my other post about perhaps a better solution being "dbus-lite" -- an 
API-matched library which strips away all of the magic and essentially gives 
you a bare-bones IPC that lines up as good as possible to the dbus API.

-A.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
