Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1180304170.3030.23.camel@cookie.hadess.net>
References: <20060222091231.GM19185@null.research.nokia.com>
	<1140607245.4519.7.camel@localhost>
	<20060222125425.GQ19185@null.research.nokia.com>
	<20060224110357.GT19185@null.research.nokia.com>
	<1141188501.29216.1.camel@localhost>
	<1180265456.3030.9.camel@cookie.hadess.net>
	<1180268229.21432.63.camel@aeonflux.holtmann.net>
	<1180277003.3030.18.camel@cookie.hadess.net>
	<1180283308.21432.67.camel@aeonflux.holtmann.net>
	<1180304170.3030.23.camel@cookie.hadess.net>
Date: Mon, 28 May 2007 10:39:23 +0200
Message-Id: <1180341563.21432.97.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Soft lockup
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Bastien,

> > > > > Here's what I could capture from the i386 crash:
> > > > > BUG warning at lib/kref.c:32/kref_get()
> > > > 
> > > > any chance you can test a 2.6.22-rc3 kernel. We fixed some potential
> > > > problems in RFCOMM and Greg pushed some driver model changes that might
> > > > make this go away. I really have no idea what triggers this at the
> > > > moment. However I would like to see a simple reproducer.
> > > 
> > > Works with 2.6.22-rc3 (for a meaning of works, my code doesn't seem to
> > > work, but that's a different matter).
> > 
> > so this is actually fixed now within the upstream kernel. This also
> > means that I didn't really bother about older kernels.
> 
> Any plans for a backport? It would be most useful, at least for testing.

I don't really have plans for a backport. Mainly because I don't know
which patch it finally solved. Meaning if it was one of the Bluetooth
patches or one Greg's for the driver model.

> > > I can reproduce the crash at will on 2 different machines. It might be
> > > easier to create a minimal reproducer if you have a debug version of the
> > > serial service.
> > 
> > Actually using SIGUSR2 should switch debugging mode on/off, but I think
> > we forgot to introduce that within the service implementation. Need to
> > fix that at some point.
> 
> It would also be useful if the different functions could have debugging
> output of their different entry points, after argument parsing.

That might be a little bit too much debug overhead. However all services
can be started with -s and then they work standalone. So you can use gdb
and valgrind with them.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
