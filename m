Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328279789-10870-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1328279789-10870-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 3 Feb 2012 19:14:24 -0200
Message-ID: <CAA37ikYTzV=At6H3xgh33pWTL8aV==CYMa_N+-0exENG=9y3zg@mail.gmail.com>
Subject: Re: [RFCv2 04/10] Bluetooth: Revert to mutexes from RCU list
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Feb 3, 2012 at 12:36 PM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Usage of RCU list looks not reasonalbe for a number of reasons:
> our code sleep and we have to use socket spinlocks, some parts
> of code are updaters thus we need to use mutexes anyway.

Just a comment. RCU updater side should be locked in most cases so
that's not really a big reason for removing RCU usage here.

> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |  110 ++++++++++++++++++++++---------------------
>  1 files changed, 56 insertions(+), 54 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index f1a6b3c..010ef75 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -77,36 +77,24 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn,
>
>  static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn, u16 cid)
>  {
> -       struct l2cap_chan *c, *r = NULL;
> -
> -       rcu_read_lock();
> +       struct l2cap_chan *c;
>
> -       list_for_each_entry_rcu(c, &conn->chan_l, list) {
> -               if (c->dcid == cid) {
> -                       r = c;
> -                       break;
> -               }
> +       list_for_each_entry(c, &conn->chan_l, list) {
> +               if (c->dcid == cid)
> +                       return c;
>        }
> -
> -       rcu_read_unlock();
> -       return r;
> +       return NULL;
>  }
>
>  static struct l2cap_chan *__l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 cid)
>  {
> -       struct l2cap_chan *c, *r = NULL;
> -
> -       rcu_read_lock();
> +       struct l2cap_chan *c;
>
> -       list_for_each_entry_rcu(c, &conn->chan_l, list) {
> -               if (c->scid == cid) {
> -                       r = c;
> -                       break;
> -               }
> +       list_for_each_entry(c, &conn->chan_l, list) {
> +               if (c->scid == cid)
> +                       return c;
>        }
> -
> -       rcu_read_unlock();
> -       return r;
> +       return NULL;
>  }
>
>  /* Find channel with given SCID.
> @@ -115,36 +103,34 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 ci
>  {
>        struct l2cap_chan *c;
>
> +       mutex_lock(&conn->chan_lock);
>        c = __l2cap_get_chan_by_scid(conn, cid);
>        if (c)
>                lock_sock(c->sk);
> +       mutex_unlock(&conn->chan_lock);
>        return c;
>  }

Ok. We have now chan_lock around the unlocked versions and we still
return a locked sock. However, we do have to be careful not to open
windows where we can deadlock. See my other comments below about that.

>  static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn, u8 ident)
>  {
> -       struct l2cap_chan *c, *r = NULL;
> -
> -       rcu_read_lock();
> +       struct l2cap_chan *c;
>
> -       list_for_each_entry_rcu(c, &conn->chan_l, list) {
> -               if (c->ident == ident) {
> -                       r = c;
> -                       break;
> -               }
> +       list_for_each_entry(c, &conn->chan_l, list) {
> +               if (c->ident == ident)
> +                       return c;
>        }
> -
> -       rcu_read_unlock();
> -       return r;
> +       return NULL;
>  }
>
>  static inline struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn, u8 ident)
>  {
>        struct l2cap_chan *c;
>
> +       mutex_lock(&conn->chan_lock);
>        c = __l2cap_get_chan_by_ident(conn, ident);
>        if (c)
>                lock_sock(c->sk);
> +       mutex_unlock(&conn->chan_lock);
>        return c;
>  }
>
> @@ -259,6 +245,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
>
>        BT_DBG("chan %p state %d", chan, chan->state);
>
> +       mutex_lock(&chan->conn->chan_lock);
>        lock_sock(sk);
>
>        if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
> @@ -272,6 +259,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
>        l2cap_chan_close(chan, reason);
>
>        release_sock(sk);
> +       mutex_unlock(&chan->conn->chan_lock);
>
>        chan->ops->close(chan->data);
>        l2cap_chan_put(chan);
> @@ -357,7 +345,9 @@ static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
>
>        l2cap_chan_hold(chan);
>
> -       list_add_rcu(&chan->list, &conn->chan_l);
> +       mutex_lock(&conn->chan_lock);
> +       list_add(&chan->list, &conn->chan_l);
> +       mutex_unlock(&conn->chan_lock);
>  }

Hmm, I'm not sure this is correct. Have you seen l2cap_connect_req()
calls __l2cap_get_chan_by_dcid() without the chan_lock? It's like that
because it was relying on RCU but now we do need to lock chan_lock
there as well. I'd recommend we turn l2cap_chan_add() into
__l2cap_chan_add() and lock chan_lock in the callers. Do you agree?

>  /* Delete channel.
> @@ -374,8 +364,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
>
>        if (conn) {
>                /* Delete from channel list */
> -               list_del_rcu(&chan->list);
> -               synchronize_rcu();
> +               list_del(&chan->list);
>
>                l2cap_chan_put(chan);
>
> @@ -426,10 +415,14 @@ static void l2cap_chan_cleanup_listen(struct sock *parent)
>        /* Close not yet accepted channels */
>        while ((sk = bt_accept_dequeue(parent, NULL))) {
>                struct l2cap_chan *chan = l2cap_pi(sk)->chan;
> +
> +               mutex_lock(&chan->conn->chan_lock);
>                __clear_chan_timer(chan);
>                lock_sock(sk);
>                l2cap_chan_close(chan, ECONNRESET);
>                release_sock(sk);
> +               mutex_unlock(&chan->conn->chan_lock);
> +
>                chan->ops->close(chan->data);
>        }
>  }

I see you're adding locks around l2cap_chan_close() instead of just
locking list_del() which might be a good approach. Is that what you
want? Before we had to drop the lock to call l2cap_chan_close()
because it would be locked again to change the list (which I thought
wasn't good). And could you please remove the leftover comment in
l2cap_conn_start() about releasing the lock before calling
l2cap_chan_close()?

Have you seen l2cap_sock_shutdown() in l2cap_sock.c also calls
l2cap_chan_close()? Why don't we need to lock chan_lock there?

If that's what you wanted then please describe this kind of change in
the commit message (at least). This way we can refer to it if anything
happens or if we need to understand the change. I do think you write
short commit messages so please be more verbose.

>  /* ---- L2CAP signalling commands ---- */
> @@ -2755,6 +2753,7 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
>                        return -EFAULT;
>        }
>
> +       mutex_lock(&conn->chan_lock);
>        sk = chan->sk;
>
>        switch (result) {
> @@ -2782,6 +2781,8 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
>        }
>
>        release_sock(sk);
> +       mutex_unlock(&conn->chan_lock);
> +
>        return 0;
>  }
> @@ -3032,6 +3033,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
>        if (!chan)
>                return 0;
>
> +       mutex_lock(&conn->chan_lock);
>        sk = chan->sk;
>
>        rsp.dcid = cpu_to_le16(chan->scid);
> @@ -3042,6 +3044,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
>
>        l2cap_chan_del(chan, ECONNRESET);
>        release_sock(sk);
> +       mutex_unlock(&conn->chan_lock);
>
>        chan->ops->close(chan->data);
>        return 0;

Here in l2cap_connect_rsp() and l2cap_disconnect_req() it seems we
have a window where we can deadlock chan_lock and sock lock. Have you
seen that? It can be that it may never happen but it'd be good to
avoid that IMO. We receive a locked sock from either
l2cap_get_chan_by_scid() or l2cap_get_chan_by_ident() and then we try
to lock chan_lock. That's a different order you've been locking them.
Maybe we can lock chan_lock then use the unlocked versions and
explicitly lock sock after receiving chan?

> @@ -3063,6 +3066,7 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
>        if (!chan)
>                return 0;
>
> +       mutex_lock(&conn->chan_lock);
>        sk = chan->sk;
>
>        l2cap_chan_del(chan, 0);

The last comment also applies here. Besides, aren't we missing an unlock?

<snip>

How much have you been testing these changes? I'd like to avoid
introducing more bugs with changes are supposed to fix things so
please do test this as much as you can.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
