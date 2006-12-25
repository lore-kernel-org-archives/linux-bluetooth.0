Return-Path: <pkg-bluetooth-maintainers-bounces+marcel=holtmann.org@lists.alioth.debian.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Bram Stolk <bram@sara.nl>
In-Reply-To: <1167071406.5265.54.camel@suske>
References: <1167052771.5265.7.camel@suske>
	<20061225165542.GA970@esaurito.net> <1167066856.11510.22.camel@violet>
	<1167069204.5265.35.camel@suske>  <1167070266.11510.27.camel@violet>
	<1167071406.5265.54.camel@suske>
Content-Type: text/plain
Date: Mon, 25 Dec 2006 19:43:53 +0100
Message-Id: <1167072233.11510.36.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [Pkg-bluetooth-maintainers] dbus dependency
	introduces unwanted X11 dependency
Cc: pkg-bluetooth-maintainers@lists.alioth.debian.org,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers>,
	<mailto:pkg-bluetooth-maintainers-request@lists.alioth.debian.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/pkg-bluetooth-maintainers>
List-Post: <mailto:pkg-bluetooth-maintainers@lists.alioth.debian.org>
List-Help: <mailto:pkg-bluetooth-maintainers-request@lists.alioth.debian.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers>,
	<mailto:pkg-bluetooth-maintainers-request@lists.alioth.debian.org?subject=subscribe>
Sender: pkg-bluetooth-maintainers-bounces+marcel=holtmann.org@lists.alioth.debian.org
Errors-To: pkg-bluetooth-maintainers-bounces+marcel=holtmann.org@lists.alioth.debian.org
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Bram,

> > > > the bluez-utils depends on a working D-Bus system bus. It has no
> > > > dependency on X or anything else (besides the Bluetooth library). So if
> > > > it pulls in X related stuff then this is a fault of D-Bus or its package
> > > > and not a problem within the bluez-utils package.
> > > 
> > > I'll take this up with the dbus maintainer then.
> > > 
> > > I still think that there is no need for X11 client stuff if you
> > > want to run a PAN daemon. Bluetooth communication has nothing to
> > > do with graphics devices. The 2.x version of bluez-utils demonstrated
> > > it can do without.
> > 
> > you still don't understand it. BlueZ is _not_ using any X functionality
> 
> With all due respect:
> 
> I think it is you who does not understand (or not read).
> In my very first mail I wrote:
> "And with dbus, X11 is introduced."

you wrote "Bluetooth communication has nothing to do with graphics ..."
and that is even more true with the bluez-utils-3.x packages since we
dropped the PIN helper which could have introduced a Python-GTK
dependency and was really pulling in unneeded packages. All
communication is done via D-Bus and this makes it language independent
and also graphical desktop independent.

You comparison between how 2.x is working and how 3.x is doing things
simply doesn't work here. Major version are meant to break things or do
things completely different.

> > in its daemons. We never have and we never will be. Period. However we
> > use D-Bus as general communication method and that is a hard dependency
> > now and it won't change in the future. So if you wanna use something
> > that doesn't use D-Bus then stick to the 2.x releases. There was a
> > reason why we changed the major version number.
> 
> Ok, fine.
> It's just that when you compare dependencies between 2.x and 3.x, it 
> is *not* that the communication method changed: libdbus was a dependency
> for both versions. I do not think that you realized this.

This is not important, because you have hard (mandatory) and soft
(optional) dependency and you simply can't express these within a binary
package. You must look at the source package to see how that works.

Regards

Marcel



_______________________________________________
Pkg-bluetooth-maintainers mailing list
Pkg-bluetooth-maintainers@lists.alioth.debian.org
http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers
