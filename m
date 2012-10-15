Return-Path: <cyrus@holtmann.org>
Message-ID: <1350326810.26318.22.camel@aeonflux>
Subject: Re: [PATCH 18/19] Bluetooth: Do not retransmit data during a
 channel move
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org
Date: Mon, 15 Oct 2012 20:46:50 +0200
In-Reply-To: <1350315248-7690-19-git-send-email-mathewm@codeaurora.org>
References: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
	 <1350315248-7690-19-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Do not retransmit previously-sent data when a "receiver ready" s-frame
> with the "final" flag is received during a move.
> 
> The ERTM state machines will resynchronize at the end of a channel
> move, and the state machine needs to avoid state changes during a
> move.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 57b1b02..d7819c1 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5615,8 +5615,9 @@ static int l2cap_rx_state_recv(struct l2cap_chan *chan,
>  		if (control->final) {
>  			clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
>  
> -			if (!test_and_clear_bit(CONN_REJ_ACT,
> -						&chan->conn_state)) {
> +			if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state)
> +			    && (chan->move_state == L2CAP_MOVE_STABLE ||

can we just break the line width limit and put && at the end.

> +				chan->move_state == L2CAP_MOVE_WAIT_PREPARE)) {

Otherwise this becomes hard to read.

>  				control->final = 0;
>  				l2cap_retransmit_all(chan, control);
>  			}

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


