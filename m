Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Nov 2012 08:25:17 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 3/5] Bluetooth: Fix missing L2CAP EWS Conf parameter
Message-ID: <20121129102517.GA26707@joana>
References: <1354118382-25571-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1354118382-25571-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354118382-25571-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-11-28 17:59:40 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> If L2CAP_FEAT_FCS is not supported we sould miss EWS option
> configuration because of break. Make code more readable by
> combining FCS configuration in the single block.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index d8cffdb..f10e4be 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3106,18 +3106,16 @@ done:
>  		if (test_bit(FLAG_EFS_ENABLE, &chan->flags))
>  			l2cap_add_opt_efs(&ptr, chan);
>  
> -		if (!(chan->conn->feat_mask & L2CAP_FEAT_FCS))
> -			break;
> -
> -		if (chan->fcs == L2CAP_FCS_NONE ||
> -		    test_bit(CONF_NO_FCS_RECV, &chan->conf_state)) {
> -			chan->fcs = L2CAP_FCS_NONE;
> -			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, chan->fcs);
> -		}
> -
>  		if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>  			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EWS, 2,
>  					   chan->tx_win);
> +
> +		if (chan->conn->feat_mask & L2CAP_FEAT_FCS)
> +			if (chan->fcs == L2CAP_FCS_NONE ||
> +			    test_bit(CONF_NO_FCS_RECV, &chan->conf_state)) {
> +				chan->fcs = L2CAP_FCS_NONE;
> +				l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, chan->fcs);

Can you break a line here, please?


> +			}
>  		break;
>  
>  	case L2CAP_MODE_STREAMING:
> @@ -3139,14 +3137,12 @@ done:
>  		if (test_bit(FLAG_EFS_ENABLE, &chan->flags))
>  			l2cap_add_opt_efs(&ptr, chan);
>  
> -		if (!(chan->conn->feat_mask & L2CAP_FEAT_FCS))
> -			break;
> -
> -		if (chan->fcs == L2CAP_FCS_NONE ||
> -		    test_bit(CONF_NO_FCS_RECV, &chan->conf_state)) {
> -			chan->fcs = L2CAP_FCS_NONE;
> -			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, chan->fcs);
> -		}
> +		if (chan->conn->feat_mask & L2CAP_FEAT_FCS)
> +			if (chan->fcs == L2CAP_FCS_NONE ||
> +			    test_bit(CONF_NO_FCS_RECV, &chan->conf_state)) {
> +				chan->fcs = L2CAP_FCS_NONE;
> +				l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, chan->fcs);

here as well.

	Gustavo
