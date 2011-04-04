Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1301697200-2446-2-git-send-email-padovan@profusion.mobi>
References: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-2-git-send-email-padovan@profusion.mobi>
Date: Mon, 4 Apr 2011 15:22:29 -0400
Message-ID: <BANLkTi=Ct=DwwJaU+qCk=SYFcD-ELz4XiA@mail.gmail.com>
Subject: Re: [PATCH 01/15] Bluetooth: Create struct l2cap_chan
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Apr 1, 2011 at 6:33 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> @@ -203,13 +217,14 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk)
>                l2cap_pi(sk)->omtu = L2CAP_DEFAULT_MTU;
>        }
>
> -       __l2cap_chan_link(l, sk);
> +       __l2cap_chan_link(l, chan);
>  }
>
>  /* Delete channel.
>  * Must be called on the locked socket. */
> -void l2cap_chan_del(struct sock *sk, int err)
> +void l2cap_chan_del(struct l2cap_chan *chan, int err)
>  {
> +       struct sock *sk = chan->sk;
>        struct l2cap_conn *conn = l2cap_pi(sk)->conn;
>        struct sock *parent = bt_sk(sk)->parent;
>
> @@ -219,7 +234,7 @@ void l2cap_chan_del(struct sock *sk, int err)
>
>        if (conn) {
>                /* Unlink from channel list */
> -               l2cap_chan_unlink(&conn->chan_list, sk);
> +               l2cap_chan_unlink(&conn->chan_list, chan);
>                l2cap_pi(sk)->conn = NULL;
>                hci_conn_put(conn->hcon);
>        }
> @@ -253,6 +268,8 @@ void l2cap_chan_del(struct sock *sk, int err)
>                        kfree(l);
>                }
>        }
> +
> +       kfree(chan);

Just wondering: isn't also necessary to do "l2cap_pi(sk)->chan =
NULL;" here, supposing the underlying struct sock will still be
allocated?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
