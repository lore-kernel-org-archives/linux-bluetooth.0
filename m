Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 May 2012 10:32:19 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH 09/12] Bluetooth: check for already existent channel
 before create new one
Message-ID: <20120525073217.GE3089@aemeltch-MOBL1>
References: <1337900389-30915-1-git-send-email-gustavo@padovan.org>
 <1337900389-30915-9-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337900389-30915-9-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, May 24, 2012 at 07:59:49PM -0300, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> Move this check to before the channel time creation simplifies the code
> and avoid memory allocation if the channel already exist.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com> 

> ---
>  net/bluetooth/l2cap_core.c |   13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 7719508..0df7f49 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3340,21 +3340,16 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
>  
>  	result = L2CAP_CR_NO_MEM;
>  
> +	/* Check if we already have channel with that dcid */
> +	if (__l2cap_get_chan_by_dcid(conn, scid))
> +		goto response;
> +
>  	chan = pchan->ops->new_connection(pchan->data);
>  	if (!chan)
>  		goto response;
>  
>  	sk = chan->sk;
>  
> -	/* Check if we already have channel with that dcid */
> -	if (__l2cap_get_chan_by_dcid(conn, scid)) {
> -		if (chan->ops->teardown)
> -			chan->ops->teardown(chan->data, 0);
> -
> -		chan->ops->close(chan->data);
> -		goto response;
> -	}
> -
>  	hci_conn_hold(conn->hcon);
>  
>  	bacpy(&bt_sk(sk)->src, conn->src);
> -- 
> 1.7.10.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
