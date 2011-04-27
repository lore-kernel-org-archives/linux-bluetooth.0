Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1303940957-22694-3-git-send-email-padovan@profusion.mobi>
References: <1303940957-22694-1-git-send-email-padovan@profusion.mobi>
	<1303940957-22694-2-git-send-email-padovan@profusion.mobi>
	<1303940957-22694-3-git-send-email-padovan@profusion.mobi>
Date: Wed, 27 Apr 2011 19:19:35 -0400
Message-ID: <BANLkTimYW2ZweS5GSnVQ6nn_WTs9+b0RcA@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: Remove l2cap_sk_list
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Apr 27, 2011 at 5:49 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> @@ -883,33 +891,34 @@ static inline void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *ch
>  /* Find socket with psm and source bdaddr.
>  * Returns closest match.
>  */
> -static struct sock *l2cap_get_sock_by_psm(int state, __le16 psm, bdaddr_t *src)
> +static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm, bdaddr_t *src)
>  {
> -       struct sock *sk = NULL, *sk1 = NULL;
> -       struct hlist_node *node;
> +       struct l2cap_chan *c, *c1 = NULL;
>
> -       read_lock(&l2cap_sk_list.lock);
> +       read_lock(&chan_list_lock);
>
> -       sk_for_each(sk, node, &l2cap_sk_list.head) {
> -               struct l2cap_chan *chan = l2cap_pi(sk)->chan;
> +       list_for_each_entry(c, &chan_list, global_l) {
> +               struct sock *sk = c->sk;
>
>                if (state && sk->sk_state != state)
>                        continue;
>
> -               if (chan->psm == psm) {
> +               if (c->psm == psm) {
>                        /* Exact match. */
> -                       if (!bacmp(&bt_sk(sk)->src, src))
> -                               break;
> +                       if (!bacmp(&bt_sk(sk)->src, src)) {
> +                               read_unlock_bh(&chan_list_lock);
> +                               return c;

What about this instead of the above:

c1 = c;
break;

This avoids a duplicated read_unlock_bh() and keeps a single exit
point for the function.

> +                       }
>
>                        /* Closest match */
>                        if (!bacmp(&bt_sk(sk)->src, BDADDR_ANY))
> -                               sk1 = sk;
> +                               c1 = c;
>                }
>        }
>
> -       read_unlock(&l2cap_sk_list.lock);
> +       read_unlock(&chan_list_lock);
>
> -       return node ? sk : sk1;
> +       return c1;
>  }
>
>  int l2cap_chan_connect(struct l2cap_chan *chan)

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
