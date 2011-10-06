Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Oct 2011 15:05:14 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/5] Bluetooth: EWS: extended window size option support
Message-ID: <20111006180514.GF5652@joana>
References: <1316180379-31607-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1316180379-31607-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316180379-31607-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-09-16 16:39:35 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Adds support for EWS option. Code partly based on Qualcomm and Atheros
> patches sent upstream a year ago.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |   11 ++++++--
>  net/bluetooth/l2cap_core.c    |   53 +++++++++++++++++++++++++++++++++++++---
>  net/bluetooth/l2cap_sock.c    |   10 ++++----
>  3 files changed, 62 insertions(+), 12 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 1f26a39..92eac16 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -31,7 +31,7 @@
>  #define L2CAP_DEFAULT_MTU		672
>  #define L2CAP_DEFAULT_MIN_MTU		48
>  #define L2CAP_DEFAULT_FLUSH_TO		0xffff
> -#define L2CAP_DEFAULT_TX_WINDOW		63
> +#define L2CAP_DEFAULT_MAX_TX_WINDOW	63

Just keep this macro as is.

>  #define L2CAP_DEFAULT_MAX_TX		3
>  #define L2CAP_DEFAULT_RETRANS_TO	2000    /* 2 seconds */
>  #define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
> @@ -42,6 +42,8 @@
>  #define L2CAP_DEFAULT_SDU_ARRIVAL_TIME	0xFFFFFFFF
>  #define L2CAP_DEFAULT_ACCESS_LATENCY	0xFFFFFFFF
>  
> +#define L2CAP_DEFAULT_MAX_EXT_WINDOW	0x3FFF
> +

and remove MAX from this one.

>  #define L2CAP_CONN_TIMEOUT	(40000) /* 40 seconds */
>  #define L2CAP_INFO_TIMEOUT	(4000)  /*  4 seconds */
>  
> @@ -240,6 +242,7 @@ struct l2cap_conf_opt {
>  #define L2CAP_CONF_RFC		0x04
>  #define L2CAP_CONF_FCS		0x05
>  #define L2CAP_CONF_EFS		0x06
> +#define L2CAP_CONF_EWS		0x07
>  
>  #define L2CAP_CONF_MAX_SIZE	22
>  
> @@ -357,7 +360,7 @@ struct l2cap_chan {
>  
>  	__u8		fcs;
>  
> -	__u8		tx_win;
> +	__u16		tx_win;
>  	__u8		max_tx;
>  	__u16		retrans_timeout;
>  	__u16		monitor_timeout;
> @@ -381,7 +384,7 @@ struct l2cap_chan {
>  	struct sk_buff	*sdu;
>  	struct sk_buff	*sdu_last_frag;
>  
> -	__u8		remote_tx_win;
> +	__u16		remote_tx_win;
>  	__u8		remote_max_tx;
>  	__u16		remote_mps;
>  
> @@ -488,6 +491,7 @@ enum {
>  	CONF_STATE2_DEVICE,
>  	CONF_LOCAL_PEND,
>  	CONF_REMOTE_PEND,
> +	CONF_EWS_RECV,
>  };
>  
>  #define L2CAP_CONF_MAX_CONF_REQ 2
> @@ -508,6 +512,7 @@ enum {
>  /* Definitions for flags in l2cap_chan */
>  enum {
>  	FLAG_EFS_ENABLE,
> +	FLAG_EXT_CTRL,
>  };
>  
>  #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 7aad856..69e974a 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1906,6 +1906,22 @@ static inline bool __l2cap_efs_supported(struct l2cap_chan *chan)
>  	return enable_hs && chan->conn->feat_mask & L2CAP_FEAT_EXT_FLOW;
>  }
>  
> +static inline bool __l2cap_ews_supported(struct l2cap_chan *chan)
> +{
> +	return enable_hs && chan->conn->feat_mask & L2CAP_FEAT_EXT_WINDOW;
> +}
> +
> +static inline void l2cap_txwin_setup(struct l2cap_chan *chan)
> +{
> +	if (chan->tx_win > L2CAP_DEFAULT_MAX_TX_WINDOW &&
> +						__l2cap_ews_supported(chan))
> +		/* use extended control field */
> +		set_bit(FLAG_EXT_CTRL, &chan->flags);
> +	else
> +		chan->tx_win = min_t(u16, chan->tx_win,
> +						L2CAP_DEFAULT_MAX_TX_WINDOW);
> +}
> +
>  static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
>  {
>  	struct l2cap_conf_req *req = data;
> @@ -1957,7 +1973,6 @@ done:
>  
>  	case L2CAP_MODE_ERTM:
>  		rfc.mode            = L2CAP_MODE_ERTM;
> -		rfc.txwin_size      = chan->tx_win;
>  		rfc.max_transmit    = chan->max_tx;
>  		rfc.retrans_timeout = 0;
>  		rfc.monitor_timeout = 0;
> @@ -1965,6 +1980,11 @@ done:
>  		if (L2CAP_DEFAULT_MAX_PDU_SIZE > chan->conn->mtu - 10)
>  			rfc.max_pdu_size = cpu_to_le16(chan->conn->mtu - 10);
>  
> +		l2cap_txwin_setup(chan);
> +
> +		rfc.txwin_size = min_t(u16, chan->tx_win,
> +						L2CAP_DEFAULT_MAX_TX_WINDOW);

rfc.txwin_size is exactly chan->tx_win.


Also I would like to see a patch cleaning up the names we give to the tx
window. Some places is tx_win, others txwin_size or even txwin.

> +
>  		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
>  							(unsigned long) &rfc);
>  
> @@ -1996,6 +2016,10 @@ done:
>  			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, chan->fcs);
>  		}
>  
> +		if (__l2cap_ews_supported(chan) &&
> +				test_bit(FLAG_EXT_CTRL, &chan->flags))

if EXT_CTRL is true there is no need to to check for __l2cap_ews_supported().
It is true as well.

> +			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EWS, 2,
> +					chan->tx_win);
>  		break;
>  
>  	case L2CAP_MODE_STREAMING:
> @@ -2033,7 +2057,10 @@ done:
>  			chan->fcs = L2CAP_FCS_NONE;
>  			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, chan->fcs);
>  		}
> -
> +		
> +		if (__l2cap_ews_supported(chan) &&
> +				test_bit(FLAG_EXT_CTRL, &chan->flags))
> +			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EWS, 2, 0);

same here.

>  		break;
>  	}
>  
> @@ -2093,6 +2120,12 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
>  				memcpy(&efs, (void *) val, olen);
>  			break;
>  
> +		case L2CAP_CONF_EWS:
> +			set_bit(FLAG_EXT_CTRL, &chan->flags);
> +			chan->remote_tx_win = val;
> +			set_bit(CONF_EWS_RECV, &chan->conf_state);
> +			break;
> +
>  		default:
>  			if (hint)
>  				break;
> @@ -2183,7 +2216,11 @@ done:
>  			break;
>  
>  		case L2CAP_MODE_ERTM:
> -			chan->remote_tx_win = rfc.txwin_size;
> +			if (!test_bit(CONF_EWS_RECV, &chan->conf_state))
> +				chan->remote_tx_win = rfc.txwin_size;
> +			else
> +				rfc.txwin_size = L2CAP_DEFAULT_MAX_TX_WINDOW;
> +

This seems better:
			if (test_bit(CONF_EWS_RECV)
				rfc.txwin_size = L2CAP_DEFAULT_MAX_TX_WINDOW

			chan->remote_tx_win = rfc.txwin_size;

Actually why does this code exist? Why do you want to set tx_win to
L2CAP_DEFAULT_MAX_TX_WINDOW when EWS is received.


>  			chan->remote_max_tx = rfc.max_transmit;
>  
>  			if (le16_to_cpu(rfc.max_pdu_size) > chan->conn->mtu - 10)
> @@ -2304,6 +2341,13 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
>  			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS,
>  					sizeof(efs), (unsigned long) &efs);
>  			break;
> +
> +		case L2CAP_CONF_EWS:
> +			chan->tx_win = val < L2CAP_DEFAULT_MAX_EXT_WINDOW ?
> +				val : L2CAP_DEFAULT_MAX_EXT_WINDOW;

This should be <=, but the end result is the same.

	Gustavo
