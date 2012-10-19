Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Oct 2012 12:37:57 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org, marcel@holtmann.org
Subject: Re: [PATCHv3 18/18] Bluetooth: Start channel move when socket option
 is changed
Message-ID: <20121019093756.GM4249@aemeltch-MOBL1>
References: <1350583130-3241-1-git-send-email-mathewm@codeaurora.org>
 <1350583130-3241-19-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350583130-3241-19-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Oct 18, 2012 at 10:58:50AM -0700, Mat Martineau wrote:
> Channel moves are triggered by changes to the BT_CHANNEL_POLICY
> sockopt when an ERTM or streaming-mode channel is connected.
> 
> Moves are only started if enable_hs is true.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/l2cap.h |  1 +
>  net/bluetooth/l2cap_core.c    | 20 ++++++++++++++++++++
>  net/bluetooth/l2cap_sock.c    |  5 +++++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index b4c3c65..49783e9 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -809,5 +809,6 @@ void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
>  void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
>  void l2cap_chan_del(struct l2cap_chan *chan, int err);
>  void l2cap_send_conn_req(struct l2cap_chan *chan);
> +void l2cap_move_start(struct l2cap_chan *chan);
>  
>  #endif /* __L2CAP_H */
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 8fa46de..b3d3f4f 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4452,6 +4452,26 @@ static void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
>  	}
>  }
>  
> +void l2cap_move_start(struct l2cap_chan *chan)
> +{
> +	BT_DBG("chan %p", chan);
> +
> +	if (chan->local_amp_id == 0) {

I would rather use "if (!chan->local_amp_id)" or event better if compare to
use "if (chan->local_amp_id == HCI_BRDER_ID)

> +		if (chan->chan_policy != BT_CHANNEL_POLICY_AMP_PREFERRED)
> +			return;
> +		chan->move_role = L2CAP_MOVE_ROLE_INITIATOR;
> +		chan->move_state = L2CAP_MOVE_WAIT_PREPARE;

Isn't it a bit earlier to start move? We should first to query remote AMP
controllers to find out AMP id, etc. Or how this supposed to work? Where
do you move?

Best regards 
Andrei Emeltchenko 

> +		/* Placeholder - start physical link setup */
> +	} else {
> +		chan->move_role = L2CAP_MOVE_ROLE_INITIATOR;
> +		chan->move_state = L2CAP_MOVE_WAIT_RSP_SUCCESS;
> +		chan->move_id = 0;
> +		l2cap_move_start(chan);
> +		l2cap_send_move_chan_req(chan, 0);
> +		__set_chan_timer(chan, L2CAP_MOVE_TIMEOUT);
> +	}
> +}
> +
>  static void l2cap_do_create(struct l2cap_chan *chan, int result,
>  			    u8 local_amp_id, u8 remote_amp_id)
>  {
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 5fae2bd..7cb4d73 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -735,6 +735,11 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
>  		}
>  
>  		chan->chan_policy = (u8) opt;
> +
> +		if (sk->sk_state == BT_CONNECTED &&
> +		    chan->move_role == L2CAP_MOVE_ROLE_NONE)
> +			l2cap_move_start(chan);
> +
>  		break;
>  
>  	default:
> -- 
> 1.7.12.3
> 
> --
> Mat Martineau
> 
> Employee of Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
