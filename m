Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Oct 2012 10:57:10 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org, marcel@holtmann.org
Subject: Re: [PATCHv3 04/18] Bluetooth: Lookup channel structure based on DCID
Message-ID: <20121019075709.GC4249@aemeltch-MOBL1>
References: <1350583130-3241-1-git-send-email-mathewm@codeaurora.org>
 <1350583130-3241-5-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350583130-3241-5-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Oct 18, 2012 at 10:58:36AM -0700, Mat Martineau wrote:
> Processing a move channel request involves getting the channel
> structure using the destination channel ID.  Previous code could only
> look up using the source channel ID.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com> 

> ---
>  net/bluetooth/l2cap_core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ec2b4d9..e826420 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -100,6 +100,22 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn,
>  	return c;
>  }
>  
> +/* Find channel with given DCID.
> + * Returns locked channel. */
> +static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
> +						 u16 cid)
> +{
> +	struct l2cap_chan *c;
> +
> +	mutex_lock(&conn->chan_lock);
> +	c = __l2cap_get_chan_by_dcid(conn, cid);
> +	if (c)
> +		l2cap_chan_lock(c);
> +	mutex_unlock(&conn->chan_lock);
> +
> +	return c;
> +}
> +
>  static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn,
>  						    u8 ident)
>  {
> -- 
> 1.7.12.3
> 
> --
> Mat Martineau
> 
> Employee of Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
