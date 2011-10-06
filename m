Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Oct 2011 14:44:46 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 6/7] Bluetooth: EFS: add efs option in l2cap conf req
Message-ID: <20111006174446.GE5652@joana>
References: <1316179596-30906-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1316179596-30906-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316179596-30906-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-09-16 16:26:35 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Adds extended flowspec option when building l2cap config request
> EFS is added if both the local and remote L2CAP entities have
> indicated support for the Extended Flow Specification for BR/EDR
> 
> Based upon haijun.liu <haijun.liu@atheros.com> series of patches
> (sent Sun, 22 Aug 2010)
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   42 +++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 41 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 6e7a680f..b4a620d 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1910,6 +1910,7 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
>  {
>  	struct l2cap_conf_req *req = data;
>  	struct l2cap_conf_rfc rfc = { .mode = chan->mode };
> +	struct l2cap_conf_efs efs = { .service_type = L2CAP_SERV_BESTEFFORT };
>  	void *ptr = req->data;
>  
>  	BT_DBG("chan %p", chan);
> @@ -1923,7 +1924,11 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
>  		if (test_bit(CONF_STATE2_DEVICE, &chan->conf_state))
>  			break;
>  
> -		/* fall through */
> +		if (__l2cap_efs_supported(chan))
> +			set_bit(FLAG_EFS_ENABLE, &chan->flags);
> +
> +		break;

Are you sure that this break here doesn't change the behaviour of the code?
This L2CAP code was tested against PTS, and it's fully working. Can you assure
me that you are keeping the old behaviour?

> +
>  	default:
>  		chan->mode = l2cap_select_mode(rfc.mode, chan->conn->feat_mask);
>  		break;
> @@ -1963,6 +1968,25 @@ done:
>  		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
>  							(unsigned long) &rfc);
>  
> +		if (test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
> +			efs.service_type = chan->local_stype;
> +			efs.max_sdu_size = cpu_to_le16(chan->local_msdu);
> +			efs.sdu_inter_time = cpu_to_le32(chan->local_sdu_itime);
> +
> +			if (chan->local_stype != L2CAP_SERV_BESTEFFORT)
> +				break;
> +
> +			chan->local_id = 1;
> +			efs.id = chan->local_id;
> +			efs.access_latency =
> +				cpu_to_le32(L2CAP_DEFAULT_ACCESS_LATENCY);
> +			efs.flush_timeout =
> +				cpu_to_le32(L2CAP_DEFAULT_FLUSH_TO);
> +
> +			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS,
> +					sizeof(efs), (unsigned long) &efs);
> +		}
> +
>  		if (!(chan->conn->feat_mask & L2CAP_FEAT_FCS))
>  			break;
>  
> @@ -1971,6 +1995,7 @@ done:
>  			chan->fcs = L2CAP_FCS_NONE;
>  			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, chan->fcs);
>  		}
> +

Extra blank line.

>  		break;
>  
>  	case L2CAP_MODE_STREAMING:
> @@ -1986,6 +2011,20 @@ done:
>  		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
>  							(unsigned long) &rfc);
>  
> +		if (test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
> +			efs.id = 1;
> +			efs.service_type = L2CAP_SERV_BESTEFFORT;
> +			efs.max_sdu_size =
> +				cpu_to_le16(chan->local_msdu);
> +			efs.sdu_inter_time =
> +				cpu_to_le32(chan->local_sdu_itime);
> +			efs.access_latency = 0;
> +			efs.flush_timeout = 0;
> +
> +			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS,
> +					sizeof(efs), (unsigned long) &efs);
> +		}
> +
>  		if (!(chan->conn->feat_mask & L2CAP_FEAT_FCS))
>  			break;
>  
> @@ -1994,6 +2033,7 @@ done:
>  			chan->fcs = L2CAP_FCS_NONE;
>  			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, chan->fcs);
>  		}
> +

Same here.

	Gustavo
