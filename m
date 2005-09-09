Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCID D-Bus
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050909132940.GE17543@spring.luon.net>
References: <e1effdeb050908125079935830@mail.gmail.com>
	 <1126220839.5286.57.camel@blade> <5256d0b050909012577fcb19c@mail.gmail.com>
	 <1126258645.5227.16.camel@blade>  <20050909132940.GE17543@spring.luon.net>
Content-Type: text/plain
Message-Id: <1126273252.5227.119.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 09 Sep 2005 15:40:52 +0200

Hi Sjoerd,

> > having 0.33 is better than 0.23 and this is what Debian unstable still
> > uses. However lets make a list of the distributions:
> > 
> > 	SuSE Linux 10.0		D-Bus 0.35
> > 	Fedora Core 4		D-Bus 0.33
> > 	Ubuntu Breezy		D-Bus 0.36
> > 	Debian unstable		D-Bus 0.23
>     Debian experimental D-Bus 0.50

this is good.

> > The only bad guy is Debian unstable and I don't care anymore. They use
> > Xorg finally and have GCC 4.0 etc., but they can't move over to the next
> > D-Bus generation. I think that is their problem now and the release of
> > bluez-utils-0.22 will definitely drop the support for the old D-Bus 0.23
> > version.
> 
> D-bus >= 0.3x has been in debian experimental for quite some time. There are
> various transitions going on in debian unstable currently which makes it
> inappropriate to do a dbus transition now too.

Last time I looked at it, the complete KDE part was broken and full of
wrong dependencies. So breaking D-Bus wouldn't even be notified ;)

> > I like to base everything around the current D-Bus 0.50 release, because
> > the C API should be quite stable now. I will accept small workarounds to
> > make D-Bus 0.3x work, but as soon as the distributions update their
> > D-Bus libraries I will drop them.
> > 
> > This is not a nice thing to do, I know, but a wrong usage of D-Bus lets
> > hcid segfault and this is not what I want.
> 
> As one of debian's dbus maintainers i would advise to indeed base everything on
> dbus >= 0.50. Hopefully it won't take too long before we can move the new dbus
> from experimental to unstable, so the workarounds for old dbus release are just
> not worth it.

This means I will release bluez-utils-2.21 on the weekend, because of
some memory leak fixes and then I will drop D-Bus 0.23 support. So if
any patches need to go in before, please send them now.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
