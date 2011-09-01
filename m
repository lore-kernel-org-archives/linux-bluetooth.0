Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Subject: Re: [RFCv2 6/7] Bluetooth: add EFS option in l2cap conf req
Date: Thu, 1 Sep 2011 14:45:03 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1314875256-6904-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>  <1314875256-6904-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1314875256-6904-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201109011445.03117.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

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
>  include/net/bluetooth/l2cap.h |    2 +
>  net/bluetooth/l2cap_core.c    |   70 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 71 insertions(+), 1 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 1f26a39..fc81771 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -445,6 +445,8 @@ struct l2cap_conn {
>  	__u32		rx_len;
>  	__u8		tx_ident;
>  
> +	__u8		flowspec_ident;
> +
>  	__u8		disc_reason;
>  
>  	__u8		preq[7]; /* SMP Pairing Request */
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 02908f0..c2c5eb7 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -549,6 +549,26 @@ static u8 l2cap_get_ident(struct l2cap_conn *conn)
>  	return id;
>  }
>  
> +static inline u8 l2cap_flowspec_ident(struct l2cap_conn *conn)
> +{
> +	u8 id;
> +
> +	/* Get next available ident for the flow spec of guaranteed channel.
> +	 *    2 - 255 are used.
> +	 */
> +
> +	spin_lock_bh(&conn->lock);
> +
> +	if (++conn->flowspec_ident > 256)
> +		conn->flowspec_ident = 2;

flowspec_ident is u8, shouldn't this be 'if (++conn->flowspec_ident < 2)' ?
Also shouldn't you check if there is no channel with specified id before using that id?

> +
> +	id = conn->flowspec_ident;
> +
> +	spin_unlock_bh(&conn->lock);
> +
> +	return id;
> +}
> +
>  static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *data)
>  {
>  	struct sk_buff *skb = l2cap_build_cmd(conn, code, ident, len, data);
> @@ -1908,6 +1928,7 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
>  {
>  	struct l2cap_conf_req *req = data;
>  	struct l2cap_conf_rfc rfc = { .mode = chan->mode };
> +	struct l2cap_conf_efs efs = { .service_type = L2CAP_SERV_BESTEFFORT };
>  	void *ptr = req->data;
>  
>  	BT_DBG("chan %p", chan);
> @@ -1921,7 +1942,11 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
>  		if (test_bit(CONF_STATE2_DEVICE, &chan->conf_state))
>  			break;
>  
> -		/* fall through */
> +		if (__l2cap_efs_supported(chan))
> +			set_bit(FLAG_EFS_ENABLE, &chan->flags);
> +
> +		break;
> +
>  	default:
>  		chan->mode = l2cap_select_mode(rfc.mode, chan->conn->feat_mask);
>  		break;
> @@ -1961,6 +1986,33 @@ done:
>  		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
>  							(unsigned long) &rfc);
>  
> +		if (test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
> +			efs.service_type = chan->local_stype;
> +			efs.max_sdu_size = cpu_to_le16(chan->local_msdu);
> +			efs.sdu_inter_time = cpu_to_le32(chan->local_sdu_itime);
> +
> +			if (chan->local_stype == L2CAP_SERV_BESTEFFORT) {
> +				chan->local_id = 1;
> +				efs.id = chan->local_id;
> +				efs.access_latency =
> +					cpu_to_le32(L2CAP_DEFAULT_ACCESS_LATENCY);
> +				efs.flush_timeout =
> +					cpu_to_le32(L2CAP_DEFAULT_FLUSH_TO);
> +			} else {
> +				/* As spec, the ident shall be unique within
> +				   the scope of a physical link.
> +				 */
> +				chan->local_id = l2cap_flowspec_ident(chan->conn);
> +				efs.id = chan->local_id;
> +				efs.access_latency =
> +					cpu_to_le32(chan->local_acc_lat);
> +				efs.flush_timeout =
> +					cpu_to_le32(chan->local_flush_to);
> +			}
> +			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS,
> +					sizeof(efs), (unsigned long) &efs);
> +		}
> +
>  		if (!(chan->conn->feat_mask & L2CAP_FEAT_FCS))
>  			break;
>  
> @@ -1969,6 +2021,7 @@ done:
>  			chan->fcs = L2CAP_FCS_NONE;
>  			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, chan->fcs);
>  		}
> +
>  		break;
>  
>  	case L2CAP_MODE_STREAMING:
> @@ -1984,6 +2037,20 @@ done:
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
> @@ -1992,6 +2059,7 @@ done:
>  			chan->fcs = L2CAP_FCS_NONE;
>  			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, chan->fcs);
>  		}
> +
>  		break;
>  	}
>  
> 

-- 
BR
Szymon Janc
