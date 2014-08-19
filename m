Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update PAN PICS and tests results
Date: Tue, 19 Aug 2014 19:32:32 +0200
Message-ID: <8761123.h3VrdQbOa7@leonov>
In-Reply-To: <1408364473-1182-1-git-send-email-szymon.janc@tieto.com>
References: <1408364473-1182-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 18 of August 2014 14:21:13 Szymon Janc wrote:
> Specification Errata #3558 makes LLMNR support optional as LLMNR Draft
> was never adopted by IETF. AOSP doesn't support LLMNR.
> ---
>  android/pics-pan.txt | 3 ++-
>  android/pts-pan.txt  | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/android/pics-pan.txt b/android/pics-pan.txt
> index b59bef7..20b91c7 100644
> --- a/android/pics-pan.txt
> +++ b/android/pics-pan.txt
> @@ -124,7 +124,8 @@ TSPC_PAN_4_2	True (*)	PANU: Support IPv4 (C.1)
>  TSPC_PAN_4_3	False		PANU: Support ping client for IPv4 (O)
>  TSPC_PAN_4_4	False		PANU: Support DHCP client for  IPv4 (O)
>  TSPC_PAN_4_5	False		PANU: Support DNS/LLMNR Resolver for IPv4 (O)
> -TSPC_PAN_4_5a	True		PANU: Support LLMNR Sender for IPv4 (C.2)
> +TSPC_PAN_4_5a	False (*)	PANU: Support LLMNR Sender for IPv4 (C.2)
> +				Reference: SE #3558, TSE #4382, TCW #448
>  TSPC_PAN_4_5b	False		PANU: Support LLMNR Responder for IPv4 (O)
>  TSPC_PAN_4_6	False		PANU: Support HTTP Client for IPv4 (O)
>  TSPC_PAN_4_7	False		PANU: Support WAP Client for IPv4 (O)
> diff --git a/android/pts-pan.txt b/android/pts-pan.txt
> index 5e3248c..0af186c 100644
> --- a/android/pts-pan.txt
> +++ b/android/pts-pan.txt
> @@ -56,7 +56,7 @@ TC_PANU_Ipv4_Autonet_BV_01_I		PASS	After DHCP 
request fail
> send From IUT: send address request
>  						dhcpd -r 169.254.x.x bt-pan
>  TC_PANU_Ipv6_Autonet_BV_02_I		N/A
> -TC_PANU_IP_LLMNR_BV_01_I		INC	PTS TSE errata #5871
> +TC_PANU_IP_LLMNR_BV_01_I		N/A	SE #3558, TSE #4382, TCW #448
>  TC_PANU_IP_LLMNR_BV_02_I		N/A
>  TC_PANU_IP_DHCP_BV_03_I			N/A
>  TC_PANU_IP_DNS_BV_01_I			N/A

Pushed.

-- 
BR
Szymon Janc
