Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200608271150.52362.akohlsmith-bluez@benshaw.com>
References: <200608261250.16206.cijoml@volny.cz>
	<200608261536.11895.akohlsmith-asterisk@benshaw.com>
	<1156687886.5613.3.camel@aeonflux.holtmann.net>
	<200608271150.52362.akohlsmith-bluez@benshaw.com>
Date: Sun, 27 Aug 2006 22:38:38 +0200
Message-Id: <1156711118.5613.26.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] need old bluez-libs and bluez-utils
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

Hi Andrew,

> > come on. I is actually not that hard to get the latest bluez-utils-2.x
> > release. If you don't know how to get them, then you might should not
> > get them at all. I am not going to announce old versions. They are
> 
> If you do not know the exact point-release then yes, it's a pain in the ass to 
> get the older version.  The latest release at the time I was messing around 
> with it was 3.2.  The release before was 2.25.  Without googling or going 
> through the archives to see what the rev before was, it is a pain in the ass.

you can look at the news list or the archive of the mailing list
archive. This is not a pain in the ass. It is kinda simple actually.

> Honestly, Marcel... we're not asking you to "announce" old releases, simply 
> give access to an indexed HTML or FTP directory so we can grab old versions 
> as needed.  May I ask why this is such a problem for you?  Do you presume 
> that the latest is always superior to the older releases and once something 
> new is released nobody would ever want an older release?

The latest release is of course always superior. The process is open and
all of the previous releases are available. The CVS also contains tags
for all releases. They are simply not linked from the main BlueZ website
and I don't see any need for it. Trying to stick with an old version is
never a good idea.

> > available, but not linked. I am not fixing stuff in old versions and so
> > there is no reason for linking them. People should us and test the
> > latest version.
> 
> I do understand that you're not fixing older versions, but you are adding more 
> and more "weight" to the BlueZ stack... dbus in particular.  I intend to get 
> the dbus stuff working on my particular cross-compilation environment, but to 
> get it working right now I needed an older version.  You make it difficult to 
> get older versions in some mistaken attempt to gain more testers, but all 
> you're doing is alienating users who have the wherewithal to help.

This is again about D-Bus. The choice for D-Bus was a hard one and I
resisted a very long time. However the problem was that the 2.x code
base became unmaintainable, because of its option to disable D-Bus. The
D-Bus interface is an essential part for driving the integration of
Bluetooth forward. At some point it made no longer sense to install it
without D-Bus support and so it became mandatory.

If you have problems with D-Bus then complain on their mailing list. I
think they are happy to hear about cross-complication and embedded
system problems and they are willing to help and solve them.

And even if BlueZ 4.x is a big step away, it seems that we go back to
require GLib support.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
