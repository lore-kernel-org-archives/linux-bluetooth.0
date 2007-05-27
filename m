Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1180265456.3030.9.camel@cookie.hadess.net>
References: <20060222091231.GM19185@null.research.nokia.com>
	<1140607245.4519.7.camel@localhost>
	<20060222125425.GQ19185@null.research.nokia.com>
	<20060224110357.GT19185@null.research.nokia.com>
	<1141188501.29216.1.camel@localhost>
	<1180265456.3030.9.camel@cookie.hadess.net>
Date: Sun, 27 May 2007 14:17:09 +0200
Message-Id: <1180268229.21432.63.camel@aeonflux.holtmann.net>
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

> > > Now I have more information about this problem.
> > > 
> > > I had debuggin enabled in net/bluetooth/rfcomm/core.c and I noticed that
> > > for some reson rfcomm_dlc_clear_timer() is called for allready freed
> > > dlc and lock_timer_base() gets stuck because it's trying to use invalid
> > > timer pointer. I also tried to reproduce bug in i386 without success.
> > > Also then debugging is on the bug much harder to reproduse. To me this
> > > looks like dlc locking doens't work as it should work.
> > > 
> > > And other notice. rfcomm_dlc_clear_timeri() uses timer_pending()
> > > together with del_timer() which allready calls timer_pending(). So
> > > timer_pending() is useless in rfcomm_dlc_clear_timer().
> > 
> > this all looks like we are missing a memory barrier somewhere. This
> > could also be the reason why it only gets triggered on OMAP systems. Any
> > further ideas?
> 
> I'm getting the same kind of trace (on both x86-64 and i386) when
> testing the gnome-vfs2-obexftp package with a patch to use the new
> serial service[1].
> 
> It happens on 2.6.19-1.2895.fc6 (x86-64) and 2.6.21-1.3191.fc7 (i386).
> 
> Here's what I could capture from the i386 crash:
> BUG warning at lib/kref.c:32/kref_get()

any chance you can test a 2.6.22-rc3 kernel. We fixed some potential
problems in RFCOMM and Greg pushed some driver model changes that might
make this go away. I really have no idea what triggers this at the
moment. However I would like to see a simple reproducer.

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
