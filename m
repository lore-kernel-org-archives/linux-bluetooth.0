Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] monitor: Fix use of uninitialized variable
Date: Tue, 24 Nov 2015 20:57:49 +0100
Message-ID: <7546151.u5ofOufstg@ix>
In-Reply-To: <1448136544-18660-1-git-send-email-szymon.janc@codecoup.pl>
References: <1448136544-18660-1-git-send-email-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Saturday 21 November 2015 21:09:03 Szymon Janc wrote:
> subevent code was never set in vendor_evt() resulting in printing
> random stack data as subevent opcode in print_subevent().
> ---
>  monitor/packet.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 4c18cb2..70bd153 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -8471,6 +8471,7 @@ static void vendor_evt(const void *data, uint8_t size)
> vendor_data.str = vendor_str;
>  		} else
>  			vendor_data.str = vnd->str;
> +		vendor_data.subevent = subevent;
>  		vendor_data.func = vnd->evt_func;
>  		vendor_data.size = vnd->evt_size;
>  		vendor_data.fixed = vnd->evt_fixed;

Applied.

-- 
pozdrawiam
Szymon Janc
