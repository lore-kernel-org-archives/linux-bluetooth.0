Return-Path: <cyrus@holtmann.org>
Message-ID: <1330446197.3392.82.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Save remote L2CAP fixed channel mask
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 28 Feb 2012 08:23:17 -0800
In-Reply-To: <1330435774-25961-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1330435774-25961-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Fixed channel mask needs to be stored to decide whether to
> use A2MP for example. So far save only one relevant byte which
> keeps all information we need.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    1 +
>  net/bluetooth/l2cap_core.c    |    9 +++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index d6d8ec8..a7fd1e1 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -522,6 +522,7 @@ struct l2cap_conn {
>  	unsigned int	mtu;
>  
>  	__u32		feat_mask;
> +	__u8		fc_mask;

make this fixed_chan_mask. The fc_ prefix is confusing.
 
>  	__u8		info_state;
>  	__u8		info_ident;
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index bdcfbf0..0b86a34 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3209,7 +3209,8 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
>  		return 0;
>  	}
>  
> -	if (type == L2CAP_IT_FEAT_MASK) {
> +	switch (type) {
> +	case L2CAP_IT_FEAT_MASK:
>  		conn->feat_mask = get_unaligned_le32(rsp->data);
>  
>  		if (conn->feat_mask & L2CAP_FEAT_FIXED_CHAN) {
> @@ -3226,11 +3227,15 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
>  
>  			l2cap_conn_start(conn);
>  		}
> -	} else if (type == L2CAP_IT_FIXED_CHAN) {
> +		break;
> +
> +	case L2CAP_IT_FIXED_CHAN:
> +		conn->fc_mask = rsp->data[0];
>  		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
>  		conn->info_ident = 0;
>  
>  		l2cap_conn_start(conn);
> +		break;
>  	}

Everything else looks fine to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


