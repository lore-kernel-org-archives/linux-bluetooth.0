Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
From: Marcel Holtmann <marcel@holtmann.org>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001d01c4a02c$9aaeab00$1a01010a@baked>
References: <001d01c4a02c$9aaeab00$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1095851321.6223.15.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 22 Sep 2004 13:08:41 +0200

Hi Daryl,

> > maybe this one helps:
> > 
> > --- 1.29/net/bluetooth/rfcomm/sock.c    2004-06-04 02:41:47 +02:00
> > +++ edited/net/bluetooth/rfcomm/sock.c  2004-09-22 00:12:34 +02:00
> > @@ -104,8 +104,13 @@
> >                 if (d->state == BT_CONNECTED)
> >                         rfcomm_session_getaddr(d->session, 
> > &bt_sk(sk)->src, NULL);
> >                 sk->sk_state_change(sk);
> > -       } else
> > +       } else {
> > +               if (d->state == BT_CLOSED) {
> > +                       bt_accept_unlink(sk);
> > +                       sk->sk_zapped = 1;
> > +               }
> >                 parent->sk_data_ready(parent, 0);
> > +       }
> >  
> >         bh_unlock_sock(sk);
> >  }
> 
> No luck.
> 
> Same behaviour as without the close and kill calls.

the correct approach seems to be:

	sk->sk_zapped = 1;
	rfcomm_sock_kill(sk);

The problem is that rfcomm_sock_kill() must be called on an unlocked
socket and I think that we will deadlock on a SMP machine or get some
NULL pointer dereferences.

> I noticed in l2cap.c that after l2cap_chan_del() is called (which now does
> the accept_unlink()), l2cap_sock_kill() is often called which decrements its
> use count which was incremented in l2cap_sock_alloc() (much like in rfcomm).
> But in rfcomm, there don't appear to be any calls to ...sock_kill() for
> similar circumstances.

That is right and I agree that a ...sock_kill() is missing that calls
sock_put() to decrease the reference count.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
