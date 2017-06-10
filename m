Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] monitor/avdtp: Correct bit mask for TSEP
Date: Sat, 10 Jun 2017 21:21:19 +0200
Message-ID: <2027586.XSW9BB2509@ix>
In-Reply-To: <20170607083944.9188-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20170607083944.9188-1-grzegorz.kolodziejczyk@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Wednesday, 7 June 2017 10:39:44 CEST Grzegorz Kolodziejczyk wrote:
> According to AVDP specification 1.3 (8.6.2 Stream End Point Discovery
> Response), TSEP bit is on 3rd position of 3rd frame byte.
> ---
>  monitor/avdtp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/monitor/avdtp.c b/monitor/avdtp.c
> index 006daf3..f5ef4c0 100644
> --- a/monitor/avdtp.c
> +++ b/monitor/avdtp.c
> @@ -368,7 +368,7 @@ static bool avdtp_discover(struct avdtp_frame
> *avdtp_frame) print_field("%*cMedia Type: %s (0x%02x)", 2, ' ',
>  					mediatype2str(info >> 4), info >> 4);
>  			print_field("%*cSEP Type: %s (0x%02x)", 2, ' ',
> -						info & 0x04 ? "SNK" : "SRC",
> +						info & 0x08 ? "SNK" : "SRC",
>  						(info >> 3) & 0x01);
>  			print_field("%*cIn use: %s", 2, ' ',
>  						seid & 0x02 ? "Yes" : "No");


Applied, thanks.

-- 
pozdrawiam
Szymon Janc
