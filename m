Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120130100719.GA2618@aemeltch-MOBL1>
References: <1327674288-894-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CAA37ikZVzpDoLfJgPQ4MfGtsoPCCp2YWviWLhcA9Wyexgmtq-g@mail.gmail.com>
	<20120130100719.GA2618@aemeltch-MOBL1>
Date: Mon, 30 Jan 2012 10:14:15 -0200
Message-ID: <CAA37ikZY68yDWDdFNNctcYV69Q3-GF50xg41NJH+moOwK5_FaA@mail.gmail.com>
Subject: Re: [RFC Draft] Bluetooth: Change socket lock to l2cap_chan lock
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Jan 30, 2012 at 8:07 AM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> Hi Ulisses,
>
> On Fri, Jan 27, 2012 at 07:30:27PM -0200, Ulisses Furquim wrote:
>> Hi Andrei,
>>
>> On Fri, Jan 27, 2012 at 12:24 PM, Emeltchenko Andrei
>> <Andrei.Emeltchenko.news@gmail.com> wrote:
>> > +static void l2cap_state_change(struct l2cap_chan *chan, int state)
>> > +{
>> > +       lock_sock(chan->sk);
>> > +       __l2cap_state_change(chan, state);
>> > +       release_sock(chan->sk);
>> > +}
>>
>> Why do we lock sock here instead of l2cap_chan? What do you want to
>> chan lock protect?
>
> I want to protect access to sk->sk_state as it is checked in socket code
> inside critical section (look for example net/bluetooth/af_bluetooth.c).

Access to sk->sk_state in the callback you mean, right? Are you gonna
use the sock lock for access to chan->state?

>> >  /* ---- L2CAP connections ---- */
>> > @@ -747,15 +777,13 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>> >
>> >        BT_DBG("conn %p", conn);
>> >
>> > -       rcu_read_lock();
>> > -
>> > -       list_for_each_entry_rcu(chan, &conn->chan_l, list) {
>> > +       list_for_each_entry(chan, &conn->chan_l, list) {
>> >                struct sock *sk = chan->sk;
>> >
>> > -               bh_lock_sock(sk);
>> > +               l2cap_chan_lock(chan);
>> >
>> >                if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
>> > -                       bh_unlock_sock(sk);
>> > +                       l2cap_chan_unlock(chan);
>> >                        continue;
>> >                }
>> >
>> > @@ -764,7 +792,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>> >
>> >                        if (!l2cap_chan_check_security(chan) ||
>> >                                        !__l2cap_no_conn_pending(chan)) {
>> > -                               bh_unlock_sock(sk);
>> > +                               l2cap_chan_unlock(chan);
>> >                                continue;
>> >                        }
>> >
>> > @@ -774,7 +802,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>> >                                /* l2cap_chan_close() calls list_del(chan)
>> >                                 * so release the lock */
>> >                                l2cap_chan_close(chan, ECONNRESET);
>> > -                               bh_unlock_sock(sk);
>> > +                               l2cap_chan_unlock(chan);
>> >                                continue;
>> >                        }
>> >
>> > @@ -794,6 +822,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>> >                        rsp.dcid = cpu_to_le16(chan->scid);
>> >
>> >                        if (l2cap_chan_check_security(chan)) {
>> > +                               lock_sock(sk);
>> >                                if (bt_sk(sk)->defer_setup) {
>> >                                        struct sock *parent = bt_sk(sk)->parent;
>> >                                        rsp.result = cpu_to_le16(L2CAP_CR_PEND);
>> > @@ -802,10 +831,11 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>> >                                                parent->sk_data_ready(parent, 0);
>> >
>> >                                } else {
>> > -                                       l2cap_state_change(chan, BT_CONFIG);
>> > +                                       __l2cap_state_change(chan, BT_CONFIG);
>> >                                        rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
>> >                                        rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
>> >                                }
>> > +                               release_sock(sk);
>> >                        } else {
>> >                                rsp.result = cpu_to_le16(L2CAP_CR_PEND);
>> >                                rsp.status = cpu_to_le16(L2CAP_CS_AUTHEN_PEND);
>> > @@ -816,7 +846,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>> >
>> >                        if (test_bit(CONF_REQ_SENT, &chan->conf_state) ||
>> >                                        rsp.result != L2CAP_CR_SUCCESS) {
>> > -                               bh_unlock_sock(sk);
>> > +                               l2cap_chan_unlock(chan);
>> >                                continue;
>> >                        }
>> >
>> > @@ -826,10 +856,8 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>> >                        chan->num_conf_req++;
>> >                }
>> >
>> > -               bh_unlock_sock(sk);
>> > +               l2cap_chan_unlock(chan);
>> >        }
>> > -
>> > -       rcu_read_unlock();
>> >  }
>>
>> You are removing the RCU usage which was protecting conn->chan_l. What
>> are you going to use to protect this list? The RCU usage in the case
>> of conn->chan_l is missing a lock in the updaters of the list IMO,
>> though.
>
> I think that RCU usage is not correct here since we can delete element
> from the list and then take the reference, this shall be changed to
> list_for_each_entry_safe as it was originally.

This is one of the reader sides of RCU for conn->chan_l so there's no
need to use the _safe() version for list traversal. The write sides
you haven't touched with this patch. Moreover, there's no problem with
list RCU and removing elements, deleting more than one element needs
the _safe() version of list traversal using RCU or not.

> I am also thinking about returning chan_lock mutex.

Ok, if you want to remove RCU for conn->chan_l then do it _before_
this patch and don't mix them up. Right now in your patch you removed
all reader side rcu_read_lock/rcu_read_unlock calls but haven't done
anything to the updater side. :-/

>> You are also changing bh_lock_sock which is a spin_lock to chan_lock
>> on a mutex and that might lead to issues. IIRC Padovan left
>> bh_lock_sock here so we don't sleep inside RCU reader section which
>> was causing deadlocks and long delays.
>
> I think that you cannot sleep in the RCU critical section in principle.
> bh_lock_sock looks like a hack to allow use RCU critical section but as I
> said above it looks completely wrong.

Padovan wanted to revisit this sock spinlock usage later but it's
certainly not completely wrong. Send your proposal to revert it back
to chan_lock mutex and let's see what he says.

>> <snip>
>>
>> >                if (conn->hcon->type == LE_LINK) {
>> >                        if (smp_conn_security(conn, chan->sec_level))
>> >                                l2cap_chan_ready(chan);
>> >
>> >                } else if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
>> > +                       struct sock *sk = chan->sk;
>> >                        __clear_chan_timer(chan);
>> > -                       l2cap_state_change(chan, BT_CONNECTED);
>> > +                       lock_sock(sk);
>> > +                       __l2cap_state_change(chan, BT_CONNECTED);
>> >                        sk->sk_state_change(sk);
>> > +                       release_sock(sk);
>>
>> So we are grabbing l2cap_chan lock and then sock lock. Is that order
>> always the same? We're using mutexes in process context so we need to
>> be careful with deadlocks even on UP machines.
>
> Hopefully the order is always the same.

Hopefully? :-)

>> >                } else if (chan->state == BT_CONNECT)
>> >                        l2cap_do_start(chan);
>> >
>> > -               bh_unlock_sock(sk);
>> > +               l2cap_chan_unlock(chan);
>> >        }
>> >
>> > -       rcu_read_unlock();
>> >  }
>>
>> <snip>
>>
>> > @@ -4517,12 +4564,8 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>> >                __cancel_delayed_work(&conn->security_timer);
>> >        }
>> >
>> > -       rcu_read_lock();
>> > -
>> > -       list_for_each_entry_rcu(chan, &conn->chan_l, list) {
>> > -               struct sock *sk = chan->sk;
>> > -
>> > -               bh_lock_sock(sk);
>> > +       list_for_each_entry(chan, &conn->chan_l, list) {
>> > +               l2cap_chan_lock(chan);
>> >
>> >                BT_DBG("chan->scid %d", chan->scid);
>>
>> Again removing RCU protecting conn->chan_l. There are other places
>> where you are removing reader side protection of conn->chan_l, so
>> please take a look at what you are going to do.
>
> Here it is removed because I use mutex which sleeps and this does not work
> in RCU critical section.
>
> I really think that it is better to remove RCU critical section at all
> then to use dirty hacks with bh_lock_sock.

Ok, then send the patch changing that first in your series and then this one.

>> <snip>
>>
>> Well, I had just a quick look. Have you done some testing with this?
>
> Thanks for reviewing.
>
>> How was it? Maybe running PTS against it would be good.
>
> Actually this works. The only issues I had so far were kernel crashes
> related to wrong RCU usage, I have sent patches changing RCU list
> iteration to _safe list iteration last week.

These are actually wrong list traversal usage and not wrong RCU usage.

> I've tested so far with my l2test test scripts.
>
> There are also warnings related to delayed work for which I think you sent
> patches also.

Ok. After all these changes to core L2CAP we'll need to test it
properly at some point.

Best regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
