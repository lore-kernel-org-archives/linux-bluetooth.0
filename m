Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/health: Make coding style consistent for array parameter
Date: Tue, 17 Jun 2014 21:26:51 +0200
Message-ID: <4907338.zOYmyKcdAo@athlon>
In-Reply-To: <1403012834-28933-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1403012834-28933-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tuesday 17 June 2014 15:47:14 Grzegorz Kolodziejczyk wrote:
> ---
>  android/health.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/android/health.c b/android/health.c
> index 58323d9..60c4c99 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -1093,8 +1093,7 @@ static int connect_mcl(struct health_channel *channel)
> search_cb, channel, NULL, 0);
>  }
> 
> -static struct health_device *create_device(uint16_t app_id,
> -						const uint8_t addr[])
> +static struct health_device *create_device(uint16_t app_id, const uint8_t
> *addr) {
>  	struct health_device *dev;

Applied. Thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
