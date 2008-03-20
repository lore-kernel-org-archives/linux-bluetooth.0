Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Mar 2008 10:45:26 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Marcel Holtmann <marcel@holtmann.org>
cc: bluez-devel@lists.sourceforge.net, maxk@qualcomm.com
Subject: Re: [PATCH] BLUETOOTH:  Use newer, non-deprecated __RW_LOCK_UNLOCKED
 macro.
In-Reply-To: <1206021236.7678.12.camel@californication>
Message-ID: <alpine.LFD.1.00.0803201043240.3714@localhost.localdomain>
References: <alpine.LFD.1.00.0803151348180.24734@localhost.localdomain> <1206021236.7678.12.camel@californication>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 20 Mar 2008, Marcel Holtmann wrote:

> Hi Robert,
>
> > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> >
> > ---
> >
> >   not compile tested, but a fairly trivial transformation.
> >
> >
> >  net/bluetooth/hci_sock.c    |    2 +-
> >  net/bluetooth/l2cap.c       |    2 +-
> >  net/bluetooth/rfcomm/sock.c |    2 +-
> >  net/bluetooth/sco.c         |    2 +-
> >  4 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> > index b5d4019..1d36c09 100644
> > --- a/net/bluetooth/hci_sock.c
> > +++ b/net/bluetooth/hci_sock.c
> > @@ -84,7 +84,7 @@ static struct hci_sec_filter hci_sec_filter = {
> >  };
> >
> >  static struct bt_sock_list hci_sk_list = {
> > -	.lock = RW_LOCK_UNLOCKED
> > +	.lock = __RW_LOCK_UNLOCKED(hci_sk_list.lock)
> >  };
>
> is that the way we do init of locks now? I haven't realized that
> RW_LOCK_UNLOCKED is deprecated.

yup, see Documentation/spinlocks.txt:

"SPIN_LOCK_UNLOCKED and RW_LOCK_UNLOCKED defeat lockdep state tracking
and are hence deprecated.

"Please use DEFINE_SPINLOCK()/DEFINE_RWLOCK() or
__SPIN_LOCK_UNLOCKED()/__RW_LOCK_UNLOCKED() as appropriate for static
initialization."

rday
--

========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================
