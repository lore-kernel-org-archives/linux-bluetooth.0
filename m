Return-Path: <cyrus@holtmann.org>
Message-ID: <1324160112.1965.91.camel@aeonflux>
Subject: Re: [RFC 19/22] Bluetooth: Change l2cap chan_list to use RCU
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 17 Dec 2011 14:15:12 -0800
In-Reply-To: <1324157382-1815-20-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-5-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-6-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-7-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-8-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-9-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-10-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-11-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-12-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-13-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-14-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-15-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-16-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-17-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-18-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-19-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-20-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> This list has much more reads than writes, so RCU makes senses here, also
> it avoid deadlock against the socket lock.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/l2cap_core.c |  117 +++++++++++++++++++++----------------------
>  1 files changed, 57 insertions(+), 60 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index d616519..a212295 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -89,24 +89,36 @@ static inline void chan_put(struct l2cap_chan *c)
>  
>  static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn, u16 cid)
>  {
> -	struct l2cap_chan *c;
> +	struct l2cap_chan *c, *r = NULL;
>  
> -	list_for_each_entry(c, &conn->chan_l, list) {
> -		if (c->dcid == cid)
> -			return c;
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(c, &conn->chan_l, list) {
> +		if (c->dcid == cid) {
> +			r = c;
> +			break;
> +		}
>  	}
> +
> +	rcu_read_unlock();
>  	return NULL;
>  }

shouldn't this say return r;
 
Regards

Marcel


