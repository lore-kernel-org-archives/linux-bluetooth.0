Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329821707-11817-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329821707-11817-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1329821707-11817-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 21 Feb 2012 15:18:45 -0200
Message-ID: <CAA37ikbY4GGGgBeT8XfYzozOFTevfAhr-oJ4zaS_XT0Hzv-EjA@mail.gmail.com>
Subject: Re: [PATCHv1 08/14] Bluetooth: Use chan lock in L2CAP sig commands
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Feb 21, 2012 at 8:55 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Convert sk lock to chan lock for L2CAP signalling commands.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   61 +++++++++++++++++++++++++------------------
>  net/bluetooth/l2cap_sock.c |    7 +++-
>  2 files changed, 40 insertions(+), 28 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index c008608..ab6bede 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -377,6 +377,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
>                hci_conn_put(conn->hcon);
>        }
>
> +       lock_sock(sk);
> +
>        __l2cap_state_change(chan, BT_CLOSED);
>        sock_set_flag(sk, SOCK_ZAPPED);
>
> @@ -389,6 +391,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
>        } else
>                sk->sk_state_change(sk);
>
> +       release_sock(sk);
> +
>        if (!(test_bit(CONF_OUTPUT_DONE, &chan->conf_state) &&
>                        test_bit(CONF_INPUT_DONE, &chan->conf_state)))
>                return;

You're making l2cap_chan_del() deal with sock lock so please remove
the comment above the function signature. It doesn't make sense to
leave old comments around.

> @@ -421,10 +425,10 @@ static void l2cap_chan_cleanup_listen(struct sock *parent)
>        while ((sk = bt_accept_dequeue(parent, NULL))) {
>                struct l2cap_chan *chan = l2cap_pi(sk)->chan;
>
> +               l2cap_chan_lock(chan);
>                __clear_chan_timer(chan);
> -               lock_sock(sk);
>                l2cap_chan_close(chan, ECONNRESET);
> -               release_sock(sk);
> +               l2cap_chan_unlock(chan);
>
>                chan->ops->close(chan->data);
>        }

Ok.

> @@ -440,10 +444,12 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
>
>        switch (chan->state) {
>        case BT_LISTEN:
> +               lock_sock(sk);
>                l2cap_chan_cleanup_listen(sk);
>
>                __l2cap_state_change(chan, BT_CLOSED);
>                sock_set_flag(sk, SOCK_ZAPPED);
> +               release_sock(sk);
>                break;
>
>        case BT_CONNECTED:

Do we need to lock sock around l2cap_chan_cleanup_listen() as well?
l2cap_chan_close() will call l2cap_chan_del() which now does
lock_sock/release_sock, right?

> @@ -486,7 +492,9 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
>                break;
>
>        default:
> +               lock_sock(sk);
>                sock_set_flag(sk, SOCK_ZAPPED);
> +               release_sock(sk);
>                break;
>        }
>  }

Hmm, this indeed looks correct. However, it'd be good to later revisit
this as we want core without any sock handling, right?

> @@ -714,6 +722,7 @@ static inline int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
>
>  static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *chan, int err)
>  {
> +       struct sock *sk = chan->sk;
>        struct l2cap_disconn_req req;
>
>        if (!conn)
> @@ -730,8 +739,10 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
>        l2cap_send_cmd(conn, l2cap_get_ident(conn),
>                        L2CAP_DISCONN_REQ, sizeof(req), &req);
>
> +       lock_sock(sk);
>        __l2cap_state_change(chan, BT_DISCONN);
>        __l2cap_chan_set_err(chan, err);
> +       release_sock(sk);
>  }
>
>  /* ---- L2CAP connections ---- */

It seems we didn't have any locking around these before. Why? Do we
really need it now?

<snip>

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
