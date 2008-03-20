Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
In-Reply-To: <alpine.LFD.1.00.0803201043240.3714@localhost.localdomain>
References: <alpine.LFD.1.00.0803151348180.24734@localhost.localdomain>
	<1206021236.7678.12.camel@californication>
	<alpine.LFD.1.00.0803201043240.3714@localhost.localdomain>
Date: Thu, 20 Mar 2008 15:50:11 +0100
Message-Id: <1206024611.7678.25.camel@californication>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net, maxk@qualcomm.com
Subject: Re: [Bluez-devel] [PATCH] BLUETOOTH:  Use newer,
	non-deprecated	__RW_LOCK_UNLOCKED macro.
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

Hi Robert,

> > > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> > >
> > > ---
> > >
> > >   not compile tested, but a fairly trivial transformation.
> > >
> > >
> > >  net/bluetooth/hci_sock.c    |    2 +-
> > >  net/bluetooth/l2cap.c       |    2 +-
> > >  net/bluetooth/rfcomm/sock.c |    2 +-
> > >  net/bluetooth/sco.c         |    2 +-
> > >  4 files changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> > > index b5d4019..1d36c09 100644
> > > --- a/net/bluetooth/hci_sock.c
> > > +++ b/net/bluetooth/hci_sock.c
> > > @@ -84,7 +84,7 @@ static struct hci_sec_filter hci_sec_filter = {
> > >  };
> > >
> > >  static struct bt_sock_list hci_sk_list = {
> > > -	.lock = RW_LOCK_UNLOCKED
> > > +	.lock = __RW_LOCK_UNLOCKED(hci_sk_list.lock)
> > >  };
> >
> > is that the way we do init of locks now? I haven't realized that
> > RW_LOCK_UNLOCKED is deprecated.
> 
> yup, see Documentation/spinlocks.txt:
> 
> "SPIN_LOCK_UNLOCKED and RW_LOCK_UNLOCKED defeat lockdep state tracking
> and are hence deprecated.
> 
> "Please use DEFINE_SPINLOCK()/DEFINE_RWLOCK() or
> __SPIN_LOCK_UNLOCKED()/__RW_LOCK_UNLOCKED() as appropriate for static
> initialization."

then add an Acked-by: Marcel Holtmann <marcel@holtmann.org> into your
commit message and post it to the netdev mailing list (me on CC). This
way it is faster since I am stuck with a heavy workload for the next
BlueZ release.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
