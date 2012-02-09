Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328797057-26331-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1328797057-26331-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Thu, 9 Feb 2012 16:25:11 -0200
Message-ID: <CAA37ikaPnRheNYxZoNRYA6Qg+ndiW887k3ZqH51htEphCK8uBA@mail.gmail.com>
Subject: Re: [RFCv3 15/16] Bluetooth: Use l2cap chan lock in socket connect
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Feb 9, 2012 at 12:17 PM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> @@ -1261,23 +1266,30 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
>        /* Update source addr of the socket */
>        bacpy(src, conn->src);
>
> +       l2cap_chan_unlock(chan);
>        l2cap_chan_add(conn, chan);
> +       l2cap_chan_lock(chan);

Hum, do we really need to do this? Maybe l2cap_chan_add() can receive
chan already locked?

> -       __l2cap_state_change(chan, BT_CONNECT);
> +       l2cap_state_change(chan, BT_CONNECT);

Why? Is there a problem moving the release_sock() call to we don't
call the locked function here?

>        __set_chan_timer(chan, sk->sk_sndtimeo);
>
>        if (hcon->state == BT_CONNECTED) {
>                if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
>                        __clear_chan_timer(chan);
>                        if (l2cap_chan_check_security(chan))
> -                               __l2cap_state_change(chan, BT_CONNECTED);
> +                               l2cap_state_change(chan, BT_CONNECTED);

And here as well.

>                } else
>                        l2cap_do_start(chan);
>        }
>
>        err = 0;
> +       goto done;
> +
> +sock_release:
> +       release_sock(sk);
>
>  done:
> +       l2cap_chan_unlock(chan);
>        hci_dev_unlock(hdev);
>        hci_dev_put(hdev);
>        return err;
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index dea5418..ddac4cb 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -127,6 +127,8 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
>        if (err)
>                goto done;
>
> +       lock_sock(sk);
> +
>        err = bt_sock_wait_state(sk, BT_CONNECTED,
>                        sock_sndtimeo(sk, flags & O_NONBLOCK));
>  done:
> --
> 1.7.8.3

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
