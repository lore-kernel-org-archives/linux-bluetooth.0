Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 11 Oct 2017 22:21:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Steve Brown <sbrown@cortland.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: mesh: Correct segmentation logic
Message-ID: <20171011192133.GA26896@x1c.home>
References: <20171011190624.2093-1-sbrown@cortland.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171011190624.2093-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Wed, Oct 11, 2017, Steve Brown wrote:
> The decision whether to segment or not didn't consider the size of the MIC
> 
> diff --git a/mesh/net.c b/mesh/net.c
> index 2d75c4f7d..96e82fe1c 100644
> --- a/mesh/net.c
> +++ b/mesh/net.c
> @@ -2098,7 +2098,7 @@ bool net_access_layer_send(uint8_t ttl, uint16_t src, uint32_t dst,
>  	if (!result)
>  		return false;
>  
> -	segN = SEG_MAX(len);
> +	segN = SEG_MAX(len + sizeof(uint32_t));
>  
>  	/* Only one ACK required SAR message per destination at a time */
>  	if (segN && IS_UNICAST(dst)) {

Applied, thanks.

Johan
