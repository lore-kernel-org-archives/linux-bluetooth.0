Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Gix, Brian" <brian.gix@intel.com>
To: Steve Brown <sbrown@cortland.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "Hedberg, Johan" <johan.hedberg@intel.com>
Subject: RE: [PATCH] Bluetooth: mesh: Correct segmentation logic
Date: Wed, 11 Oct 2017 19:10:06 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4373E1E3EC6@ORSMSX103.amr.corp.intel.com>
References: <20171011190624.2093-1-sbrown@cortland.com>
In-Reply-To: <20171011190624.2093-1-sbrown@cortland.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz, Marcel, Johan:

This is a legitimate and important fix.  Please apply ASAP.

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Steve Brown
> Sent: Wednesday, October 11, 2017 12:06 PM
> To: linux-bluetooth@vger.kernel.org
> Subject: [PATCH] Bluetooth: mesh: Correct segmentation logic
> 
> The decision whether to segment or not didn't consider the size of the MIC
> 
> diff --git a/mesh/net.c b/mesh/net.c
> index 2d75c4f7d..96e82fe1c 100644
> --- a/mesh/net.c
> +++ b/mesh/net.c
> @@ -2098,7 +2098,7 @@ bool net_access_layer_send(uint8_t ttl, uint16_t
> src, uint32_t dst,
>  	if (!result)
>  		return false;
> 
> -	segN = SEG_MAX(len);
> +	segN = SEG_MAX(len + sizeof(uint32_t));
> 
>  	/* Only one ACK required SAR message per destination at a time */
>  	if (segN && IS_UNICAST(dst)) {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
