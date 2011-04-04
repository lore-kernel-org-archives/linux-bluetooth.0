Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1301697200-2446-3-git-send-email-padovan@profusion.mobi>
References: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-2-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-3-git-send-email-padovan@profusion.mobi>
Date: Mon, 4 Apr 2011 16:28:09 -0400
Message-ID: <BANLkTine2FnjGdYs3u0Kh0E1O5QdEKVTtA@mail.gmail.com>
Subject: Re: [PATCH 02/15] Bluetooth: Use struct list_head for L2CAP channels list
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Apr 1, 2011 at 6:33 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> @@ -724,26 +709,27 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
>                bh_unlock_sock(sk);
>        }
>
> -       read_unlock(&l->lock);
> +       read_unlock(&conn->chan_lock);
>  }
>
>  /* Notify sockets that we cannot guaranty reliability anymore */
>  static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
>  {
> -       struct l2cap_chan_list *l = &conn->chan_list;
>        struct l2cap_chan *chan;
> +       struct sock *sk;

You can move this declaration to the  list_for_each_entry() block
(like you did in other places).

>
>        BT_DBG("conn %p", conn);
>
> -       read_lock(&l->lock);
> +       read_lock(&conn->chan_lock);
> +
> +       list_for_each_entry(chan, &conn->chan_l, list) {
> +               sk = chan->sk;
>
> -       for (chan = l->head; chan; chan = chan->next_c) {
> -               struct sock *sk = chan->sk;
>                if (l2cap_pi(sk)->force_reliable)
>                        sk->sk_err = err;
>        }
>
> -       read_unlock(&l->lock);
> +       read_unlock(&conn->chan_lock);
>  }
>
>  static void l2cap_info_timeout(unsigned long arg)
> @@ -783,7 +769,9 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
>        conn->feat_mask = 0;
>
>        spin_lock_init(&conn->lock);
> -       rwlock_init(&conn->chan_list.lock);
> +       rwlock_init(&conn->chan_lock);
> +
> +       INIT_LIST_HEAD(&conn->chan_l);
>
>        if (hcon->type != LE_LINK)
>                setup_timer(&conn->info_timer, l2cap_info_timeout,
> @@ -797,7 +785,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
>  static void l2cap_conn_del(struct hci_conn *hcon, int err)
>  {
>        struct l2cap_conn *conn = hcon->l2cap_data;
> -       struct l2cap_chan *chan;
> +       struct l2cap_chan *chan, *l;
>        struct sock *sk;
>
>        if (!conn)
> @@ -808,7 +796,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
>        kfree_skb(conn->rx_skb);
>
>        /* Kill channels */
> -       while ((chan = conn->chan_list.head)) {
> +       list_for_each_entry_safe(chan, l, &conn->chan_l, list) {
>                sk = chan->sk;
>                bh_lock_sock(sk);
>                l2cap_chan_del(chan, err);
> @@ -825,10 +813,9 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
>
>  static inline void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
>  {
> -       struct l2cap_chan_list *l = &conn->chan_list;
> -       write_lock_bh(&l->lock);
> +       write_lock_bh(&conn->chan_lock);
>        __l2cap_chan_add(conn, chan);
> -       write_unlock_bh(&l->lock);
> +       write_unlock_bh(&conn->chan_lock);
>  }
>
>  /* ---- Socket interface ---- */
> @@ -1426,14 +1413,13 @@ static void l2cap_chan_ready(struct sock *sk)
>  /* Copy frame to all raw sockets on that connection */
>  static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
>  {
> -       struct l2cap_chan_list *l = &conn->chan_list;
>        struct sk_buff *nskb;
>        struct l2cap_chan *chan;
>
>        BT_DBG("conn %p", conn);
>
> -       read_lock(&l->lock);
> -       for (chan = l->head; chan; chan = chan->next_c) {
> +       read_lock(&conn->chan_lock);
> +       list_for_each_entry(chan, &conn->chan_l, list) {
>                struct sock *sk = chan->sk;
>                if (sk->sk_type != SOCK_RAW)
>                        continue;
> @@ -1448,7 +1434,7 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
>                if (sock_queue_rcv_skb(sk, nskb))
>                        kfree_skb(nskb);
>        }
> -       read_unlock(&l->lock);
> +       read_unlock(&conn->chan_lock);
>  }
>
>  /* ---- L2CAP signalling commands ---- */
> @@ -2015,7 +2001,6 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn, struct l2cap_cmd_hd
>
>  static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
>  {
> -       struct l2cap_chan_list *list = &conn->chan_list;
>        struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
>        struct l2cap_conn_rsp rsp;
>        struct l2cap_chan *chan;
> @@ -2062,11 +2047,11 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
>                goto response;
>        }
>
> -       write_lock_bh(&list->lock);
> +       write_lock_bh(&conn->chan_lock);
>
>        /* Check if we already have channel with that dcid */
> -       if (__l2cap_get_chan_by_dcid(list, scid)) {
> -               write_unlock_bh(&list->lock);
> +       if (__l2cap_get_chan_by_dcid(conn, scid)) {
> +               write_unlock_bh(&conn->chan_lock);
>                sock_set_flag(sk, SOCK_ZAPPED);
>                l2cap_sock_kill(sk);
>                goto response;
> @@ -2115,7 +2100,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
>                status = L2CAP_CS_NO_INFO;
>        }
>
> -       write_unlock_bh(&list->lock);
> +       write_unlock_bh(&conn->chan_lock);
>
>  response:
>        bh_unlock_sock(parent);
> @@ -2169,11 +2154,11 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
>        BT_DBG("dcid 0x%4.4x scid 0x%4.4x result 0x%2.2x status 0x%2.2x", dcid, scid, result, status);
>
>        if (scid) {
> -               chan = l2cap_get_chan_by_scid(&conn->chan_list, scid);
> +               chan = l2cap_get_chan_by_scid(conn, scid);
>                if (!chan)
>                        return -EFAULT;
>        } else {
> -               chan = l2cap_get_chan_by_ident(&conn->chan_list, cmd->ident);
> +               chan = l2cap_get_chan_by_ident(conn, cmd->ident);
>                if (!chan)
>                        return -EFAULT;
>        }
> @@ -2243,7 +2228,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
>
>        BT_DBG("dcid 0x%4.4x flags 0x%2.2x", dcid, flags);
>
> -       chan = l2cap_get_chan_by_scid(&conn->chan_list, dcid);
> +       chan = l2cap_get_chan_by_scid(conn, dcid);
>        if (!chan)
>                return -ENOENT;
>
> @@ -2338,7 +2323,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
>        BT_DBG("scid 0x%4.4x flags 0x%2.2x result 0x%2.2x",
>                        scid, flags, result);
>
> -       chan = l2cap_get_chan_by_scid(&conn->chan_list, scid);
> +       chan = l2cap_get_chan_by_scid(conn, scid);
>        if (!chan)
>                return 0;
>
> @@ -2418,7 +2403,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
>
>        BT_DBG("scid 0x%4.4x dcid 0x%4.4x", scid, dcid);
>
> -       chan = l2cap_get_chan_by_scid(&conn->chan_list, dcid);
> +       chan = l2cap_get_chan_by_scid(conn, dcid);
>        if (!chan)
>                return 0;
>
> @@ -2458,7 +2443,7 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
>
>        BT_DBG("dcid 0x%4.4x scid 0x%4.4x", dcid, scid);
>
> -       chan = l2cap_get_chan_by_scid(&conn->chan_list, scid);
> +       chan = l2cap_get_chan_by_scid(conn, scid);
>        if (!chan)
>                return 0;
>
> @@ -3612,7 +3597,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
>        u8 tx_seq;
>        int len;
>
> -       chan = l2cap_get_chan_by_scid(&conn->chan_list, cid);
> +       chan = l2cap_get_chan_by_scid(conn, cid);
>        if (!chan) {
>                BT_DBG("unknown cid 0x%4.4x", cid);
>                goto drop;
> @@ -3855,21 +3840,20 @@ static inline void l2cap_check_encryption(struct sock *sk, u8 encrypt)
>
>  static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>  {
> -       struct l2cap_chan_list *l;
>        struct l2cap_conn *conn = hcon->l2cap_data;
>        struct l2cap_chan *chan;
> +       struct sock *sk;

Same here.

>
>        if (!conn)
>                return 0;
>
> -       l = &conn->chan_list;
> -
>        BT_DBG("conn %p", conn);
>
> -       read_lock(&l->lock);
> +       read_lock(&conn->chan_lock);
> +
> +       list_for_each_entry(chan, &conn->chan_l, list) {
> +               sk = chan->sk;
>
> -       for (chan = l->head; chan; chan = chan->next_c) {
> -               struct sock *sk = chan->sk;
>                bh_lock_sock(sk);
>
>                if (l2cap_pi(sk)->conf_state & L2CAP_CONF_CONNECT_PEND) {
> @@ -3923,7 +3907,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>                bh_unlock_sock(sk);
>        }
>
> -       read_unlock(&l->lock);
> +       read_unlock(&conn->chan_lock);
>
>        return 0;
>  }
> @@ -3980,7 +3964,7 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
>                        goto drop;
>                }
>
> -               chan = l2cap_get_chan_by_scid(&conn->chan_list, cid);
> +               chan = l2cap_get_chan_by_scid(conn, cid);
>
>                if (chan && chan->sk) {
>                        struct sock *sk = chan->sk;
> @@ -3996,6 +3980,7 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
>                        bh_unlock_sock(sk);
>                }
>
> +

Unnecessary empty line.

>                /* Allocate skb for the complete frame (with header) */
>                conn->rx_skb = bt_skb_alloc(len, GFP_ATOMIC);
>                if (!conn->rx_skb)

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
