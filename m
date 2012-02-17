Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329486252-25252-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329486252-25252-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1329486252-25252-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 17 Feb 2012 19:22:41 -0200
Message-ID: <CAA37ikbgxQxySgBUxKOjakxCrG1rAKk=aPfEW+JYL7g8PJLueA@mail.gmail.com>
Subject: Re: [RFCv5 02/16] Bluetooth: Revert to mutexes from RCU list
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Feb 17, 2012 at 11:43 AM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Usage of RCU list looks not reasonalbe for a number of reasons:
> our code sleep and we have to use socket spinlocks, some parts
> of code are updaters thus we need to use mutexes anyway.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   98 ++++++++++++++++++++-----------------------
>  1 files changed, 46 insertions(+), 52 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 63539f9..109b62d 100644
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
>
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
> @@ -331,7 +317,9 @@ static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
>
>        l2cap_chan_hold(chan);
>
> -       list_add_rcu(&chan->list, &conn->chan_l);
> +       mutex_lock(&conn->chan_lock);
> +       list_add(&chan->list, &conn->chan_l);
> +       mutex_unlock(&conn->chan_lock);
>  }
>
>  /* Delete channel.
> @@ -348,8 +336,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
>
>        if (conn) {
>                /* Delete from channel list */
> -               list_del_rcu(&chan->list);
> -               synchronize_rcu();
> +               list_del(&chan->list);
>
>                l2cap_chan_put(chan);
>
> @@ -400,10 +387,12 @@ static void l2cap_chan_cleanup_listen(struct sock *parent)
>        /* Close not yet accepted channels */
>        while ((sk = bt_accept_dequeue(parent, NULL))) {
>                struct l2cap_chan *chan = l2cap_pi(sk)->chan;
> +
>                __clear_chan_timer(chan);
>                lock_sock(sk);
>                l2cap_chan_close(chan, ECONNRESET);
>                release_sock(sk);
> +
>                chan->ops->close(chan->data);
>        }
>  }
> @@ -718,13 +707,13 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
>  /* ---- L2CAP connections ---- */
>  static void l2cap_conn_start(struct l2cap_conn *conn)
>  {
> -       struct l2cap_chan *chan;
> +       struct l2cap_chan *chan, *tmp;
>
>        BT_DBG("conn %p", conn);
>
> -       rcu_read_lock();
> +       mutex_lock(&conn->chan_lock);
>
> -       list_for_each_entry_rcu(chan, &conn->chan_l, list) {
> +       list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
>                struct sock *sk = chan->sk;
>
>                bh_lock_sock(sk);
> @@ -804,7 +793,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>                bh_unlock_sock(sk);
>        }
>
> -       rcu_read_unlock();
> +       mutex_unlock(&conn->chan_lock);
>  }
>
>  /* Find socket with cid and source bdaddr.
> @@ -916,9 +905,9 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
>        if (conn->hcon->out && conn->hcon->type == LE_LINK)
>                smp_conn_security(conn, conn->hcon->pending_sec_level);
>
> -       rcu_read_lock();
> +       mutex_lock(&conn->chan_lock);
>
> -       list_for_each_entry_rcu(chan, &conn->chan_l, list) {
> +       list_for_each_entry(chan, &conn->chan_l, list) {
>                struct sock *sk = chan->sk;
>
>                bh_lock_sock(sk);
> @@ -938,7 +927,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
>                bh_unlock_sock(sk);
>        }
>
> -       rcu_read_unlock();
> +       mutex_unlock(&conn->chan_lock);
>  }
>
>  /* Notify sockets that we cannot guaranty reliability anymore */
> @@ -948,16 +937,16 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
>
>        BT_DBG("conn %p", conn);
>
> -       rcu_read_lock();
> +       mutex_lock(&conn->chan_lock);
>
> -       list_for_each_entry_rcu(chan, &conn->chan_l, list) {
> +       list_for_each_entry(chan, &conn->chan_l, list) {
>                struct sock *sk = chan->sk;
>
>                if (test_bit(FLAG_FORCE_RELIABLE, &chan->flags))
>                        sk->sk_err = err;
>        }
>
> -       rcu_read_unlock();
> +       mutex_unlock(&conn->chan_lock);
>  }
>
>  static void l2cap_info_timeout(struct work_struct *work)
> @@ -984,6 +973,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
>
>        kfree_skb(conn->rx_skb);
>
> +       mutex_lock(&conn->chan_lock);
> +
>        /* Kill channels */
>        list_for_each_entry_safe(chan, l, &conn->chan_l, list) {
>                sk = chan->sk;
> @@ -993,6 +984,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
>                chan->ops->close(chan->data);
>        }
>
> +       mutex_unlock(&conn->chan_lock);
> +
>        hci_chan_del(conn->hchan);
>
>        if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
> @@ -1050,6 +1043,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
>        conn->feat_mask = 0;
>
>        spin_lock_init(&conn->lock);
> +       mutex_init(&conn->chan_lock);
>
>        INIT_LIST_HEAD(&conn->chan_l);
>
> @@ -1792,9 +1786,9 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
>
>        BT_DBG("conn %p", conn);
>
> -       rcu_read_lock();
> +       mutex_lock(&conn->chan_lock);
>
> -       list_for_each_entry_rcu(chan, &conn->chan_l, list) {
> +       list_for_each_entry(chan, &conn->chan_l, list) {
>                struct sock *sk = chan->sk;
>                if (chan->chan_type != L2CAP_CHAN_RAW)
>                        continue;
> @@ -1810,7 +1804,7 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
>                        kfree_skb(nskb);
>        }
>
> -       rcu_read_unlock();
> +       mutex_unlock(&conn->chan_lock);
>  }
>
>  /* ---- L2CAP signalling commands ---- */
> @@ -4492,9 +4486,9 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>                cancel_delayed_work(&conn->security_timer);
>        }
>
> -       rcu_read_lock();
> +       mutex_lock(&conn->chan_lock);
>
> -       list_for_each_entry_rcu(chan, &conn->chan_l, list) {
> +       list_for_each_entry(chan, &conn->chan_l, list) {
>                struct sock *sk = chan->sk;
>
>                bh_lock_sock(sk);
> @@ -4574,7 +4568,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>                bh_unlock_sock(sk);
>        }
>
> -       rcu_read_unlock();
> +       mutex_unlock(&conn->chan_lock);
>
>        return 0;
>  }

Why don't you squash together patches 2, 3 and 4? Is there a reason?
Only with patch 2 the change becomes incomplete and prone to errors.
With patch 3 you add some needed changes but then adds an imbalance of
lock/release sock locks which is only solved in patch 4. Why?

Best regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
