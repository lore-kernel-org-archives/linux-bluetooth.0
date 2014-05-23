Return-Path: <cyrus@holtmann.org>
Date: Fri, 23 May 2014 14:46:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: Re: [RFC 01/11] doc: Update RSSI property description.
Message-ID: <20140523114623.GB29929@t440s.lan>
References: <1400543083-28811-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1400543083-28811-2-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400543083-28811-2-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Tue, May 20, 2014, Andrzej Kaczmarek wrote:
> RSSI property applies to either inquiry or advertising packets and this
> should be stated here especially that we plan to add connection RSSI
> property.
> ---
>  doc/device-api.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index 2d9fa3c..577ee60 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -192,4 +192,4 @@ Properties	string Address [readonly]
>  		int16 RSSI [readonly, optional]
>  
>  			Received Signal Strength Indicator of the remote
> -			device.
> +			device (inquiry or advertising).

I've applied this first patch from the set since it's trivial, but e.g.
for the second one I'd at least want an ack from Marcel before pushing.

Johan
