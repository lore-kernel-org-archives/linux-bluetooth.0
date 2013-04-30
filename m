Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 14:36:19 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 04/13] Bluetooth: Fix LE vs BR/EDR selection when
 connecting
Message-ID: <20130430173619.GA19710@samus>
References: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
 <1367253345-12482-5-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367253345-12482-5-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 19:35 Mon 29 Apr, Johan Hedberg wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The choice between LE and BR/EDR should be made on the destination
> address type instead of the destination CID. This is particularly
> important when in the future more than one CID will be allowed for LE.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index d5e4404..95d46cd 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1792,7 +1792,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
>  
>  	auth_type = l2cap_get_auth_type(chan);
>  
> -	if (chan->dcid == L2CAP_CID_ATT)
> +	if (bdaddr_type_is_le(dst_type))

Wouldn't this break applications that rely on the CID for making a LE 
connection?

>  		hcon = hci_connect(hdev, LE_LINK, dst, dst_type,
>  				   chan->sec_level, auth_type);
>  	else
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
