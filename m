Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <e96e9eeb0705100523q62fde54r9bc674da0ac822f5@mail.gmail.com>
References: <e96e9eeb0705100523q62fde54r9bc674da0ac822f5@mail.gmail.com>
Date: Thu, 10 May 2007 15:10:28 +0200
Message-Id: <1178802628.25565.121.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
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

Hi Voni,

> >This would be my response as well.  Marcel has purposely made it difficult to
> >locate older versions of BlueZ in the (IMO) misguided attempt to force
> >everyone to test and use the new stuff.
> 
> I think i found it :
> 
> http://bluez.sf.net/download/bluez-utils-2.10.tar.gz
> http://bluez.sf.net/download/bluez-libs-2.10.tar.gz

the latest 2.x release is actually 2.25 and there exists a
bluez-announce mailing list. Maybe time to subscribe to it.

> >d-bus, but yes; it's seems to be unsuitable for light embedded systems and
> >you're probably better off with another stack.  There aren't many uses for a
> >message bus in small embedded systems.
> 
> hmm going for a nother stack is no option for most of the projects
> because Bluez has become a standard.

And D-Bus has become a standard, too. And not only for the desktop. It
has been successfully used in various embedded projects. And yes I know
that embedded describes a lot of systems. If you go really really small
and D-Bus causes troubles then please fix D-Bus.

> but.
> maybe a fork of the bluez user space application is a good solution.
> get rid of the dbus dependancies.

Be my guest, but once you see the functional difference between 2.x and
3.x generation you might really wanna use 3.x and its D-Bus API. It
became really nice, easy and simple in the last two years.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
