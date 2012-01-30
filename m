Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327936146-13897-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1327936146-13897-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1327936146-13897-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 30 Jan 2012 15:17:15 -0200
Message-ID: <CAA37ikb0CdLrhsDun70kf7WFFZ46qsOHtFX20HooH-sMWdiuoQ@mail.gmail.com>
Subject: Re: [RFCv0 1/5] Bluetooth: Use locks in RCU updater code
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Jan 30, 2012 at 1:09 PM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Code which makes changes to RCU list shall be locked.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 6991821..f54768e 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -743,13 +743,13 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
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
> @@ -829,7 +829,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>                bh_unlock_sock(sk);
>        }
>
> -       rcu_read_unlock();
> +       mutex_unlock(&conn->chan_lock);
>  }
>
>  /* Find socket with cid and source bdaddr.
> @@ -1009,6 +1009,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
>
>        kfree_skb(conn->rx_skb);
>
> +       mutex_lock(&conn->chan_lock);
> +
>        /* Kill channels */
>        list_for_each_entry_safe(chan, l, &conn->chan_l, list) {
>                sk = chan->sk;
> @@ -1018,6 +1020,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
>                chan->ops->close(chan->data);
>        }
>
> +       mutex_unlock(&conn->chan_lock);
> +
>        hci_chan_del(conn->hchan);
>
>        if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
> @@ -1075,6 +1079,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
>        conn->feat_mask = 0;
>
>        spin_lock_init(&conn->lock);
> +       mutex_init(&conn->chan_lock);
>
>        INIT_LIST_HEAD(&conn->chan_l);
>

I was under the impression you'd remove RCU for conn->chan_l
completely. You're adding a lock only in the updaters? If so, please
take a look at commit 3d57dc680 which shows all changes from mutex to
RCU. I don't think just adding a lock/unlock in l2cap_conn_start and
l2cap_conn_del will be enough. l2cap_chan_add seems to be called from
other contexts and it does a list_add_rcu(). Have you thought of that?

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
