Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jan 2012 14:45:34 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC Draft] Bluetooth: Change socket lock to l2cap_chan lock
Message-ID: <20120130124528.GB2618@aemeltch-MOBL1>
References: <1327674288-894-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAA37ikZVzpDoLfJgPQ4MfGtsoPCCp2YWviWLhcA9Wyexgmtq-g@mail.gmail.com>
 <20120130100719.GA2618@aemeltch-MOBL1>
 <CAA37ikZY68yDWDdFNNctcYV69Q3-GF50xg41NJH+moOwK5_FaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikZY68yDWDdFNNctcYV69Q3-GF50xg41NJH+moOwK5_FaA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Mon, Jan 30, 2012 at 10:14:15AM -0200, Ulisses Furquim wrote:
> Hi Andrei,
> 
> On Mon, Jan 30, 2012 at 8:07 AM, Emeltchenko Andrei
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > Hi Ulisses,
> >
> > On Fri, Jan 27, 2012 at 07:30:27PM -0200, Ulisses Furquim wrote:
> >> Hi Andrei,
> >>
> >> On Fri, Jan 27, 2012 at 12:24 PM, Emeltchenko Andrei
> >> <Andrei.Emeltchenko.news@gmail.com> wrote:
> >> > +static void l2cap_state_change(struct l2cap_chan *chan, int state)
> >> > +{
> >> > +       lock_sock(chan->sk);
> >> > +       __l2cap_state_change(chan, state);
> >> > +       release_sock(chan->sk);
> >> > +}
> >>
> >> Why do we lock sock here instead of l2cap_chan? What do you want to
> >> chan lock protect?
> >
> > I want to protect access to sk->sk_state as it is checked in socket code
> > inside critical section (look for example net/bluetooth/af_bluetooth.c).
> 
> Access to sk->sk_state in the callback you mean, right? Are you gonna
> use the sock lock for access to chan->state?

Yes to sk_state, chan->state gets locked as a bonus being in the same
function ;)

> >> >  /* ---- L2CAP connections ---- */
> >> > @@ -747,15 +777,13 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
> >> >
> >> >        BT_DBG("conn %p", conn);
> >> >
> >> > -       rcu_read_lock();
> >> > -
> >> > -       list_for_each_entry_rcu(chan, &conn->chan_l, list) {
> >> > +       list_for_each_entry(chan, &conn->chan_l, list) {
> >> >                struct sock *sk = chan->sk;
> >> >
> >> > -               bh_lock_sock(sk);
> >> > +               l2cap_chan_lock(chan);
> >> >
> >> >                if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
> >> > -                       bh_unlock_sock(sk);
> >> > +                       l2cap_chan_unlock(chan);
> >> >                        continue;
> >> >                }
> >> >
> >> > @@ -764,7 +792,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
> >> >
> >> >                        if (!l2cap_chan_check_security(chan) ||
> >> >                                        !__l2cap_no_conn_pending(chan)) {
> >> > -                               bh_unlock_sock(sk);
> >> > +                               l2cap_chan_unlock(chan);
> >> >                                continue;
> >> >                        }
> >> >
> >> > @@ -774,7 +802,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
> >> >                                /* l2cap_chan_close() calls list_del(chan)
> >> >                                 * so release the lock */
> >> >                                l2cap_chan_close(chan, ECONNRESET);
> >> > -                               bh_unlock_sock(sk);
> >> > +                               l2cap_chan_unlock(chan);
> >> >                                continue;
> >> >                        }
> >> >
> >> > @@ -794,6 +822,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
> >> >                        rsp.dcid = cpu_to_le16(chan->scid);
> >> >
> >> >                        if (l2cap_chan_check_security(chan)) {
> >> > +                               lock_sock(sk);
> >> >                                if (bt_sk(sk)->defer_setup) {
> >> >                                        struct sock *parent = bt_sk(sk)->parent;
> >> >                                        rsp.result = cpu_to_le16(L2CAP_CR_PEND);
> >> > @@ -802,10 +831,11 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
> >> >                                                parent->sk_data_ready(parent, 0);
> >> >
> >> >                                } else {
> >> > -                                       l2cap_state_change(chan, BT_CONFIG);
> >> > +                                       __l2cap_state_change(chan, BT_CONFIG);
> >> >                                        rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
> >> >                                        rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
> >> >                                }
> >> > +                               release_sock(sk);
> >> >                        } else {
> >> >                                rsp.result = cpu_to_le16(L2CAP_CR_PEND);
> >> >                                rsp.status = cpu_to_le16(L2CAP_CS_AUTHEN_PEND);
> >> > @@ -816,7 +846,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
> >> >
> >> >                        if (test_bit(CONF_REQ_SENT, &chan->conf_state) ||
> >> >                                        rsp.result != L2CAP_CR_SUCCESS) {
> >> > -                               bh_unlock_sock(sk);
> >> > +                               l2cap_chan_unlock(chan);
> >> >                                continue;
> >> >                        }
> >> >
> >> > @@ -826,10 +856,8 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
> >> >                        chan->num_conf_req++;
> >> >                }
> >> >
> >> > -               bh_unlock_sock(sk);
> >> > +               l2cap_chan_unlock(chan);
> >> >        }
> >> > -
> >> > -       rcu_read_unlock();
> >> >  }
> >>
> >> You are removing the RCU usage which was protecting conn->chan_l. What
> >> are you going to use to protect this list? The RCU usage in the case
> >> of conn->chan_l is missing a lock in the updaters of the list IMO,
> >> though.
> >
> > I think that RCU usage is not correct here since we can delete element
> > from the list and then take the reference, this shall be changed to
> > list_for_each_entry_safe as it was originally.
> 
> This is one of the reader sides of RCU for conn->chan_l so there's no

I think that l2cap_chan_close deletes channel so this is not the reader.

> need to use the _safe() version for list traversal. The write sides
> you haven't touched with this patch. Moreover, there's no problem with
> list RCU and removing elements, deleting more than one element needs
> the _safe() version of list traversal using RCU or not.

I think that freeing element needs the _safe version since list_del
poisons next and prev pointers (with RCU case only prev is poisoned but in our
code we give no chance by freeing also list element ;)).

> > I am also thinking about returning chan_lock mutex.
> 
> Ok, if you want to remove RCU for conn->chan_l then do it _before_
> this patch and don't mix them up. Right now in your patch you removed
> all reader side rcu_read_lock/rcu_read_unlock calls but haven't done
> anything to the updater side. :-/

Yes, I am thinking about splitting patches for better review.

> >> You are also changing bh_lock_sock which is a spin_lock to chan_lock
> >> on a mutex and that might lead to issues. IIRC Padovan left
> >> bh_lock_sock here so we don't sleep inside RCU reader section which
> >> was causing deadlocks and long delays.
> >
> > I think that you cannot sleep in the RCU critical section in principle.
> > bh_lock_sock looks like a hack to allow use RCU critical section but as I
> > said above it looks completely wrong.
> 
> Padovan wanted to revisit this sock spinlock usage later but it's
> certainly not completely wrong. Send your proposal to revert it back
> to chan_lock mutex and let's see what he says.

I am thinking about using chan_lock mutex in updater side and when we have
to sleep.

<snip>

> > I've tested so far with my l2test test scripts.
> >
> > There are also warnings related to delayed work for which I think you sent
> > patches also.
> 
> Ok. After all these changes to core L2CAP we'll need to test it
> properly at some point.

Agree with this.

Best regards 
Andrei Emeltchenko 

