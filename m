Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1470153463.21877.24.camel@hadess.net>
Subject: Re: [PATCH 2/2] doc/device-api.txt Information about D-Bus LastSeen
 property
From: Bastien Nocera <hadess@hadess.net>
To: andrey.zheregelya@dsr-company.com, linux-bluetooth@vger.kernel.org
Date: Tue, 02 Aug 2016 17:57:43 +0200
In-Reply-To: <20160802154059.24472-2-andrey.zheregelya@dsr-company.com>
References: <20160802154059.24472-1-andrey.zheregelya@dsr-company.com>
	 <20160802154059.24472-2-andrey.zheregelya@dsr-company.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2016-08-02 at 18:40 +0300, andrey.zheregelya@dsr-company.com
wrote:
> From: Andrey Zheregelya <andrey.zheregelya@dsr-company.com>
> 
> ---
>  doc/device-api.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index 087efb9..6387a0c 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -216,3 +216,11 @@ Properties	string Address [readonly]
>  
>  			Indicate whether or not service discovery
> has been
>  			resolved.
> +
> +    bool LastSeen [readonly, experimantal]
> +
> +      Unix time of last found device update. 
> +      Indicates if device is alive and reachable.

It's doesn't, really, until you apply heuristics to it. How do you plan
to use this?

> +      Adapter should be in discovery mode.
> +      Information about device's reachability is based
> +      on advertisement packets.
