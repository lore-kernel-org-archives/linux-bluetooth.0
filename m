Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Apr 2008 19:39:13 +0200
From: Stefan Seyfried <seife@suse.de>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20080404173913.GA27374@suse.de>
References: <16c4cb990804040152m6a6a3eecsc8ff1539cd5df158@mail.gmail.com>
	<16c4cb990804040328i3af92a0x2db7d7297d323d31@mail.gmail.com>
	<20080404133817.GA8298@suse.de>
MIME-Version: 1.0
In-Reply-To: <20080404133817.GA8298@suse.de>
Subject: Re: [Bluez-devel] Loading plugin error
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Fri, Apr 04, 2008 at 03:38:17PM +0200, Stefan Seyfried wrote:
> On Fri, Apr 04, 2008 at 03:58:31PM +0530, rahul tank wrote:
> > Ok .. i tried compiling bluez-utils with --enable-glib option and it so=
lved
> > the issue.
> =

> It did not for me.
> I configured like this:
> =

> ./configure --prefix=3D/usr \
> 	--mandir=3D/usr/share/man \
> 	--sysconfdir=3D/etc \
> 	--libdir=3D/usr/lib \
> 	--libexecdir=3D/lib \
> 	--localstatedir=3D/var \
> 	--enable-pie \
> 	--enable-all --enable-glib

Ok, doing a "make clean" after changing configure options was necessary.
Now it works.

> =

> (enable-all should IIUC include enable-glib, but i used it anyway, it did=
 not
> change anything)

This still applies: i gave "--enable-all" and this should, according to the
configure --help output also enable glib:
...
  --enable-all            enable all extra options below
  --enable-inotify        enable inotify support
  --enable-hal            enable HAL support
  --enable-usb            enable USB support
  --enable-alsa           enable ALSA support
  --enable-glib           enable GLib support
  --enable-gstreamer      enable GStreamer support
...

But it didn't.
Also, IMHO we should refuse to build the plugins if glib is not enabled.
Unfortunately i know next to nothing about auto$foo, so i have no patch
handy :-(

-- =

Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg | "Well, surrounding them's out." =


This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
