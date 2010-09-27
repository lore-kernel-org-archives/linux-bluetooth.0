Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Sep 2010 14:22:07 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: set sk_sndbuf and sk_rcvbuf properly in
 ERTM
In-Reply-To: <1285618609-11499-1-git-send-email-padovan@profusion.mobi>
Message-ID: <alpine.DEB.2.00.1009271355090.27215@linux-sea-02>
References: <1285618609-11499-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Gustavo -

On Mon, 27 Sep 2010, Gustavo F. Padovan wrote:

> Setting both this value to MPS * TxWin * 1.2 guarantees that we are
> reserving space to fit the whole txwindow in the memory, and that
> sendmsg() will block when the transmission window is full avoid
> overloading the system memory.
> I don't have a strong reason about the 1.2 constant in the account, we
> can do another tests in the future and change that value.
>
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
> net/bluetooth/l2cap_core.c |   10 +++++++++-
> 1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 44aa034..1e2ab05 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3129,9 +3129,17 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
> 		l2cap_pi(sk)->next_tx_seq = 0;
> 		l2cap_pi(sk)->expected_tx_seq = 0;
> 		__skb_queue_head_init(TX_QUEUE(sk));
> -		if (l2cap_pi(sk)->mode ==  L2CAP_MODE_ERTM)
> +		if (l2cap_pi(sk)->mode ==  L2CAP_MODE_ERTM) {
> 			l2cap_ertm_init(sk);
>
> +			sk->sk_sndbuf = (l2cap_pi(sk)->remote_tx_win * 1.2 *
> +						(sizeof(struct l2cap_pinfo) +
> +						l2cap_pi(sk)->mps));
> +			sk->sk_rcvbuf = (l2cap_pi(sk)->tx_win * 1.2 *
> +						(sizeof(struct l2cap_pinfo) +
> +						l2cap_pi(sk)->remote_mps));
> +		}
> +
> 		l2cap_chan_ready(sk);
> 	}
>
> -- 
> 1.7.3

I think sizeof(struct sk_buff) would be better than
sizeof(struct l2cap_pinfo), since these limits apply to data buffers, 
not per-socket overhead.

The 1.2 constant would need to be increased if we allow ERTM MPS
bigger than the HCI MTU, since there would be multiple sk_buffs per 
PDU.  However, the calculation could be updated when those MPS changes 
are made.

It would also help to enforce some limits:
SOCK_MIN_SNDBUF < sk->sk_sndbuf < sysctl_wmem_max
SOCK_MIN_RCVBUF < sk->sk_rcvbuf < sysctl_rmem_max


Regards,

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

