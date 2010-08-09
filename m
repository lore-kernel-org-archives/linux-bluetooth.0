Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/9] Bluetooth: Only enable for L2CAP FCS for ERTM or
 streaming.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1281048867-32630-2-git-send-email-mathewm@codeaurora.org>
References: <1281048867-32630-1-git-send-email-mathewm@codeaurora.org>
	 <1281048867-32630-2-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 08 Aug 2010 22:43:00 -0400
Message-ID: <1281321780.12579.184.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> This fixes a bug which caused the FCS setting to show L2CAP_FCS_CRC16
> with L2CAP modes other than ERTM or streaming.  At present, this only
> affects the FCS value shown with getsockopt() for basic mode.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |   16 ++++++++++++----
>  1 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 3e3cd9d..bc10be8 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -3072,6 +3072,16 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
>  	return 0;
>  }
>  
> +static inline int l2cap_fcs_needed(struct l2cap_pinfo *pi)
> +{
> +	if (pi->mode != L2CAP_MODE_ERTM && pi->mode != L2CAP_MODE_STREAMING)
> +		return 0;
> +
> +	/* FCS is enabled if one or both sides request it. */
> +	return !(pi->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
> +		pi->fcs == L2CAP_FCS_CRC16;
> +}

so I think a switch statement is easier to read:

	switch (pi->mode) {
	case L2CAP_MODE_ERTM:
	case L2CAP_MODE_STREAMING:
		return !(pi->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
					pi->fcs == L2CAP_FCS_CRC16;
	}

	return 0;

>  static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
>  {
>  	struct l2cap_conf_req *req = (struct l2cap_conf_req *) data;
> @@ -3136,8 +3146,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
>  		goto unlock;
>  
>  	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_INPUT_DONE) {
> -		if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
> -		    l2cap_pi(sk)->fcs != L2CAP_FCS_NONE)
> +		if (l2cap_fcs_needed(l2cap_pi(sk)))
>  			l2cap_pi(sk)->fcs = L2CAP_FCS_CRC16;

While this is just fine, I think we might should make this a lot
simpler:

	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_INPUT_DONE) {
		set_default_fcs(pi);

		...
	}

With then set_default_fcs() doing all the checks etc. and setting either
FCS_NONE or FCS_CRC16.

Would this work or do we have to deal with some funny default behavior?

Regards

Marcel


