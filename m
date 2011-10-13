Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Oct 2011 17:15:09 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 4/6] Bluetooth: EFS: parse L2CAP config request
Message-ID: <20111013201509.GF20892@joana>
References: <1318511938-24311-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1318511938-24311-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318511938-24311-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-10-13 16:18:56 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Add parsing Extended Flow Specification option in L2CAP Config Request
> Based upon haijun.liu <haijun.liu@atheros.com> series of patches
> (sent Sun, 22 Aug 2010)
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   43 +++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 43 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index f5c4bbb..255dada 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -2115,6 +2115,8 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
>  	int type, hint, olen;
>  	unsigned long val;
>  	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
> +	struct l2cap_conf_efs efs;
> +	u8 remote_efs = 0;
>  	u16 mtu = L2CAP_DEFAULT_MTU;
>  	u16 result = L2CAP_CONF_SUCCESS;
>  	u16 size;
> @@ -2147,7 +2149,12 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
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
>  		case L2CAP_CONF_EWS:
> @@ -2182,6 +2189,9 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
>  			break;
>  		}
>  
> +		if (remote_efs && __l2cap_efs_supported(chan))
> +			set_bit(FLAG_EFS_ENABLE, &chan->flags);

This could be:

		if (remote_efs) {
			if (__l2cap_efs_supported()
				set_bit()
			else
				return -ECONNREFUSED;
		}

> +
>  		if (chan->mode != rfc.mode)
>  			return -ECONNREFUSED;
>  
> @@ -2200,6 +2210,26 @@ done:
>  					sizeof(rfc), (unsigned long) &rfc);
>  	}
>  
> +	/*
> +	   Add extended flow specification option check here.
> +	 */
> +	if (result == L2CAP_CONF_SUCCESS && remote_efs) {
> +		if (!test_bit(FLAG_EFS_ENABLE, &chan->flags))
> +			return -ECONNREFUSED;

Then you don't need to do this check here, and everything can be potentially 
be placed under the same if (L2CAP_CONF_SUCCESS).

	Gustavo
