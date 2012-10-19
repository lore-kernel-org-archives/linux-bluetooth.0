Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Oct 2012 11:48:15 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org, marcel@holtmann.org
Subject: Re: [PATCHv3 17/18] Bluetooth: Do not retransmit data during a
 channel move
Message-ID: <20121019084813.GL4249@aemeltch-MOBL1>
References: <1350583130-3241-1-git-send-email-mathewm@codeaurora.org>
 <1350583130-3241-18-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350583130-3241-18-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Oct 18, 2012 at 10:58:49AM -0700, Mat Martineau wrote:
> Do not retransmit previously-sent data when a "receiver ready" s-frame
> with the "final" flag is received during a move.
> 
> The ERTM state machines will resynchronize at the end of a channel
> move, and the state machine needs to avoid state changes during a
> move.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com> 

> ---
>  net/bluetooth/l2cap_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index e89af62..8fa46de 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5612,8 +5612,8 @@ static int l2cap_rx_state_recv(struct l2cap_chan *chan,
>  		if (control->final) {
>  			clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
>  
> -			if (!test_and_clear_bit(CONN_REJ_ACT,
> -						&chan->conn_state)) {
> +			if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state) &&
> +			    !__chan_is_moving(chan)) {
>  				control->final = 0;
>  				l2cap_retransmit_all(chan, control);
>  			}
> -- 
> 1.7.12.3
> 
> --
> Mat Martineau
> 
> Employee of Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
