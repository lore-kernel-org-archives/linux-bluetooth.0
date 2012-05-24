Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 12:38:18 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 2/8] Bluetooth: Remove extra
 l2cap_state_change(BT_CONNECTED)
Message-ID: <20120524093816.GK24715@aemeltch-MOBL1>
References: <1337821964-4618-1-git-send-email-gustavo@padovan.org>
 <1337821964-4618-2-git-send-email-gustavo@padovan.org>
 <1337821964-4618-3-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337821964-4618-3-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, May 23, 2012 at 10:12:38PM -0300, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> This is already performed inside l2cap_chan_ready(), so we don't need it
> here again.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com> 

> ---
>  net/bluetooth/l2cap_core.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index e7a598c..f77b134 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3608,8 +3608,6 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
>  	if (test_bit(CONF_INPUT_DONE, &chan->conf_state)) {
>  		set_default_fcs(chan);
>  
> -		l2cap_state_change(chan, BT_CONNECTED);
> -
>  		if (chan->mode == L2CAP_MODE_ERTM ||
>  		    chan->mode == L2CAP_MODE_STREAMING)
>  			err = l2cap_ertm_init(chan);
> @@ -3740,7 +3738,6 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
>  	if (test_bit(CONF_OUTPUT_DONE, &chan->conf_state)) {
>  		set_default_fcs(chan);
>  
> -		l2cap_state_change(chan, BT_CONNECTED);
>  		if (chan->mode == L2CAP_MODE_ERTM ||
>  		    chan->mode == L2CAP_MODE_STREAMING)
>  			err = l2cap_ertm_init(chan);
> -- 
> 1.7.10.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
