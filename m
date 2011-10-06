Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Oct 2011 14:32:59 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 4/7] Bluetooth: EFS: parse l2cap config request
Message-ID: <20111006173259.GA5652@joana>
References: <1316179596-30906-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1316179596-30906-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316179596-30906-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-09-16 16:26:33 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Add parsing extended flowspec option in L2cap config request
> Based upon haijun.liu <haijun.liu@atheros.com> series of patches
> (sent Sun, 22 Aug 2010)
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   67 ++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 4b05248..f2aa2fe 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -338,6 +338,12 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
>  		chan->omtu = L2CAP_DEFAULT_MTU;
>  	}
>  
> +	chan->local_stype = L2CAP_SERV_BESTEFFORT;
> +	chan->local_msdu = L2CAP_DEFAULT_MAX_SDU_SIZE;
> +	chan->local_sdu_itime = L2CAP_DEFAULT_SDU_ARRIVAL_TIME;
> +	chan->local_acc_lat = L2CAP_DEFAULT_ACCESS_LATENCY;
> +	chan->local_flush_to = L2CAP_DEFAULT_FLUSH_TO;
> +
>  	chan_hold(chan);
>  
>  	list_add(&chan->list, &conn->chan_l);
> @@ -1895,6 +1901,11 @@ static inline __u8 l2cap_select_mode(__u8 mode, __u16 remote_feat_mask)
>  	}
>  }
>  
> +static inline bool __l2cap_efs_supported(struct l2cap_chan *chan)
> +{
> +	return enable_hs && chan->conn->feat_mask & L2CAP_FEAT_EXT_FLOW;
> +}
> +
>  static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
>  {
>  	struct l2cap_conf_req *req = data;
> @@ -2001,6 +2012,8 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
>  	int type, hint, olen;
>  	unsigned long val;
>  	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
> +	struct l2cap_conf_efs efs = { .service_type = L2CAP_SERV_BESTEFFORT };
> +	u8 remote_efs = 0;
>  	u16 mtu = L2CAP_DEFAULT_MTU;
>  	u16 result = L2CAP_CONF_SUCCESS;
>  
> @@ -2032,7 +2045,12 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
>  		case L2CAP_CONF_FCS:
>  			if (val == L2CAP_FCS_NONE)
>  				set_bit(CONF_NO_FCS_RECV, &chan->conf_state);
> +			break;
>  
> +		case L2CAP_CONF_EFS:
> +			remote_efs = 1;
> +			if (olen == sizeof(efs))
> +				memcpy(&efs, (void *) val, olen);
>  			break;
>  
>  		default:
> @@ -2057,7 +2075,10 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
>  			break;
>  		}
>  
> -		if (chan->mode != rfc.mode)
> +		if (remote_efs && __l2cap_efs_supported(chan))
> +			set_bit(FLAG_EFS_ENABLE, &chan->flags);
> +
> +		if (!l2cap_mode_supported(chan->mode, chan->conn->feat_mask))

The l2cap_mode_supported() check is fundamentally different from the check
chan->mode != rfc.mode. Any particularly why you changed this?

>  			return -ECONNREFUSED;
>  
>  		break;
> @@ -2075,8 +2096,35 @@ done:
>  					sizeof(rfc), (unsigned long) &rfc);
>  	}
>  
> +	/*
> +	   Add extended flow specification option check here.
> +	 */
> +	if (result == L2CAP_CONF_SUCCESS && remote_efs) {
> +		if (!test_bit(FLAG_EFS_ENABLE, &chan->flags)) {

If FLAG_EFS_ENABLE is enabled here it means remote_efs is 1, then you don't
need to check again for remote_efs in the line above.

> +			/* remote efs support , local efs not supported */
> +
> +			result = L2CAP_CONF_REJECT;
> +			return -ECONNREFUSED;
> +		}
> +
> +		if (chan->local_stype != L2CAP_SERV_NOTRAFIC &&
> +				efs.service_type != L2CAP_SERV_NOTRAFIC &&
> +				efs.service_type != chan->local_stype) {
> +
> +			result = L2CAP_CONF_UNACCEPT;
> +
> +			if (chan->num_conf_req >= 1)
> +				return -ECONNREFUSED;
>  
> -	if (result == L2CAP_CONF_SUCCESS) {
> +			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS,
> +					sizeof(efs), (unsigned long) &efs);
> +		} else {
> +			result = L2CAP_CONF_PENDING;
> +			set_bit(CONF_LOCAL_PEND, &chan->conf_state);
> +		}
> +	}
> +
> +	if (result == L2CAP_CONF_SUCCESS || result == L2CAP_CONF_PENDING) {

There is too much checks against L2CAP_CONF_SUCCESS, can we rework this part
of the code.

	Gustavo
