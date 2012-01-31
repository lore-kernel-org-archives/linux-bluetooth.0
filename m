Return-Path: <cyrus@holtmann.org>
Date: Tue, 31 Jan 2012 10:11:50 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv0 5/5] Bluetooth: Change sk lock to l2cap_chan lock
Message-ID: <20120131081149.GB15048@aemeltch-MOBL1>
References: <1327936146-13897-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1327936146-13897-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAA37ikagCOsChX5bSJdckx0aQRWKY3HFn2AFCBFWyXKy2e3FPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikagCOsChX5bSJdckx0aQRWKY3HFn2AFCBFWyXKy2e3FPg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Mon, Jan 30, 2012 at 03:46:27PM -0200, Ulisses Furquim wrote:
> Hi Andrei,
> 
> On Mon, Jan 30, 2012 at 1:09 PM, Emeltchenko Andrei
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > Change socket lock to l2cap_chan lock. This is needed for use l2cap
> > channels without opening kernel socket for locking.
> >
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/l2cap_core.c |  220 +++++++++++++++++++++++++++-----------------
> >  net/bluetooth/l2cap_sock.c |   13 ++-
> >  2 files changed, 146 insertions(+), 87 deletions(-)
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 4a22602..85b4572 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -275,12 +275,12 @@ static void l2cap_chan_timeout(struct work_struct *work)
> >  {
> >        struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
> >                                                        chan_timer.work);
> > -       struct sock *sk = chan->sk;
> >        int reason;
> >
> >        BT_DBG("chan %p state %d", chan, chan->state);
> >
> > -       lock_sock(sk);
> > +       mutex_lock(&chan->conn->chan_lock);
> > +       l2cap_chan_lock(chan);
> 
> Ugh, this doesn't look right or even pretty. Why do we need it this way?

I try to keep order of locking, first conn->chan_lock and then chan->lock
otherwise I get warnings from lockdep. I am open to suggestions how to
make it better.

> >        if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
> >                reason = ECONNREFUSED;
> > @@ -292,7 +292,8 @@ static void l2cap_chan_timeout(struct work_struct *work)
> >
> >        l2cap_chan_close(chan, reason);
> >
> > -       release_sock(sk);
> > +       l2cap_chan_unlock(chan);
> > +       mutex_unlock(&chan->conn->chan_lock);
> >
> >        chan->ops->close(chan->data);
> >        l2cap_chan_put(chan);
> > @@ -406,11 +407,13 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
> >                hci_conn_put(conn->hcon);
> >        }
> >
> > -       l2cap_state_change(chan, BT_CLOSED);
> > +       lock_sock(sk);
> > +
> > +       __l2cap_state_change(chan, BT_CLOSED);
> >        sock_set_flag(sk, SOCK_ZAPPED);
> >
> >        if (err)
> > -               sk->sk_err = err;
> > +               __l2cap_set_sock_err(sk, err);
> >
> >        if (parent) {
> >                bt_accept_unlink(sk);
> > @@ -418,6 +421,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
> >        } else
> >                sk->sk_state_change(sk);
> >
> > +       release_sock(sk);
> > +
> >        if (!(test_bit(CONF_OUTPUT_DONE, &chan->conf_state) &&
> >                        test_bit(CONF_INPUT_DONE, &chan->conf_state)))
> >                return;
> > @@ -449,10 +454,14 @@ static void l2cap_chan_cleanup_listen(struct sock *parent)
> >        /* Close not yet accepted channels */
> >        while ((sk = bt_accept_dequeue(parent, NULL))) {
> >                struct l2cap_chan *chan = l2cap_pi(sk)->chan;
> > +
> > +               mutex_lock(&chan->conn->chan_lock);
> > +               l2cap_chan_lock(chan);
> 
> Again.
> 
> >                __clear_chan_timer(chan);
> > -               lock_sock(sk);
> >                l2cap_chan_close(chan, ECONNRESET);
> > -               release_sock(sk);
> > +               l2cap_chan_unlock(chan);
> > +               mutex_unlock(&chan->conn->chan_lock);
> > +
> >                chan->ops->close(chan->data);
> >        }
> >  }
> 
> <snip>
> 
> > @@ -964,29 +985,31 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
> >        if (conn->hcon->out && conn->hcon->type == LE_LINK)
> >                smp_conn_security(conn, conn->hcon->pending_sec_level);
> >
> > -       rcu_read_lock();
> > +       mutex_lock(&conn->chan_lock);
> >
> > -       list_for_each_entry_rcu(chan, &conn->chan_l, list) {
> > -               struct sock *sk = chan->sk;
> > +       list_for_each_entry(chan, &conn->chan_l, list) {
> 
> Why are you removing RCU read locks here?

Because I use mutexes in l2cap_chan_lock. So I can sleep which is not
allowed inside rcu_read_lock/unlock.

> > -               bh_lock_sock(sk);
> > +               l2cap_chan_lock(chan);
> >
> >                if (conn->hcon->type == LE_LINK) {
> >                        if (smp_conn_security(conn, chan->sec_level))
> >                                l2cap_chan_ready(chan);
> >
> >                } else if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
> > +                       struct sock *sk = chan->sk;
> >                        __clear_chan_timer(chan);
> > -                       l2cap_state_change(chan, BT_CONNECTED);
> > +                       lock_sock(sk);
> > +                       __l2cap_state_change(chan, BT_CONNECTED);
> >                        sk->sk_state_change(sk);
> > +                       release_sock(sk);
> >
> >                } else if (chan->state == BT_CONNECT)
> >                        l2cap_do_start(chan);
> >
> > -               bh_unlock_sock(sk);
> > +               l2cap_chan_unlock(chan);
> >        }
> >
> > -       rcu_read_unlock();
> > +       mutex_unlock(&conn->chan_lock);
> >  }
> 
> <snip>
> 
> This patch still mixes the return of using conn->chan_lock with
> locking of l2cap_chan. It should be possible and better to have these
> changes in different patches. Another question is will you remove RCU
> usage for conn->chan_l completely or not?

As I said the change is only to updaters and to the places where I need to
sleep.

Best regards 
Andrei Emeltchenko 

