Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1444817927-18834-4-git-send-email-Dean_Jenkins@mentor.com>
References: <1444817927-18834-1-git-send-email-Dean_Jenkins@mentor.com>
	<1444817927-18834-4-git-send-email-Dean_Jenkins@mentor.com>
Date: Wed, 14 Oct 2015 13:56:50 +0300
Message-ID: <CABBYNZ+bn2CyvZi5JMpn_uhMwg0-UXCOEOhx=83jD0j2=gCuxA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] Bluetooth: l2cap_disconnection_req priority over shutdown
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Harish Jenny K N <harish_kandiga@mentor.com>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

On Wed, Oct 14, 2015 at 1:18 PM, Dean Jenkins <Dean_Jenkins@mentor.com> wrote:
> There is a L2CAP protocol race between the local peer and
> the remote peer demanding disconnection of the L2CAP link.
>
> When L2CAP ERTM is used, l2cap_sock_shutdown() can be called
> from userland to disconnect L2CAP. However, there can be a
> delay introduced by waiting for ACKs. During this waiting
> period, the remote peer may have sent a Disconnection Request.
> Therefore, recheck the shutdown status of the socket
> after waiting for ACKs because there is no need to do
> further processing if the connection has gone.
>
> Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> ---
>  net/bluetooth/l2cap_sock.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index d06fb54..1bb5515 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1129,9 +1129,17 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
>
>         if (chan->mode == L2CAP_MODE_ERTM &&
>             chan->unacked_frames > 0 &&
> -           chan->state == BT_CONNECTED)
> +           chan->state == BT_CONNECTED) {
>                 err = __l2cap_wait_ack(sk, chan);
>
> +               /* After waiting for ACKs, check whether shutdown
> +                * has already been actioned to close the L2CAP
> +                * link such as by l2cap_disconnection_req().
> +                */
> +               if (sk->sk_shutdown)
> +                       goto has_shutdown;

This still looks like blocking would still be possible, maybe it won't
block indefinitely but it still could block until ack timeout, which
should only happen when SOL_LINGER is set. But there is the more
fundamental question here which is why do we need to wait unacked
packets? Isn't it better to let the remote know we are disconnecting
by sending the disconnect request then it can flush any pending acks
or drop then instead of waiting like this? This also blocks receiving
data because the sk would be locked, anyway userspace would be
blocking on close at this point, so this means we cannot ack packets
either so I don't think the unacked packets could make any difference
if the idea was to prevent loosing data.

> +       }
> +
>         sk->sk_shutdown = SHUTDOWN_MASK;
>         release_sock(sk);
>
> @@ -1162,6 +1170,7 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
>                 err = bt_sock_wait_state(sk, BT_CLOSED,
>                                          sk->sk_lingertime);
>
> +has_shutdown:
>         l2cap_chan_put(chan);
>         sock_put(sk);
>
> --
> 1.8.5.6
>



-- 
Luiz Augusto von Dentz
