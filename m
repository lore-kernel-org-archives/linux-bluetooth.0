Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Jun 2010 20:59:29 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: Re: [PATCH] Bluetooth: Don't accept ConfigReq if we aren't in the
 BT_CONFIG state
Message-ID: <20100618235929.GB14514@vigoh>
References: <20100614005041.GB6390@vigoh>
 <1276493175-9650-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1276493175-9650-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Gustavo F. Padovan <gustavo@padovan.org> [2010-06-14 02:26:15 -0300]:

> From: Gustavo F. Padovan <padovan@profusion.mobi>
> 
> If such event happens we shall reply with a Command Reject, because we are
> not expecting any configure request.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/l2cap.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 9753b69..f725fcc 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -2741,8 +2741,14 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
>  	if (!sk)
>  		return -ENOENT;
>  
> -	if (sk->sk_state == BT_DISCONN)
> +	if (sk->sk_state != BT_CONFIG) {
> +		struct l2cap_cmd_rej rej;
> +
> +		rej.reason = cpu_to_le16(0x0002);
> +		l2cap_send_cmd(conn, cmd.ident, L2CAP_COMMAND_REJ,
> +				sizeof(rej), &rej);
>  		goto unlock;
> +	}
>  
>  	/* Reject if config buffer is too small. */
>  	len = cmd_len - sizeof(*req);

I tested this one by myself. I'm queueing it for -next. 
With a little modification it works.

-               l2cap_send_cmd(conn, cmd.ident, L2CAP_COMMAND_REJ,
+               l2cap_send_cmd(conn, cmd->ident, L2CAP_COMMAND_REJ,

i.e., the original patch even compile. ;)


-- 
Gustavo F. Padovan
http://padovan.org
