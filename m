Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/4] android/bluetooth: Start keep IRK for adapter
Date: Tue, 16 Dec 2014 22:36:02 +0100
Message-ID: <3420102.WxxDUE4Adk@athlon>
In-Reply-To: <1418238948-30800-2-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418238948-30800-1-git-send-email-lukasz.rymanowski@tieto.com> <1418238948-30800-2-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 10 December 2014 20:15:45 Lukasz Rymanowski wrote:
> ---
>  android/bluetooth.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 48ca231..e9c5be1 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -176,6 +176,8 @@ static struct {
> 
>  	char *name;
> 
> +	uint8_t irk[16];
> +
>  	uint8_t max_advert_instance;
>  	uint8_t rpa_offload_supported;
>  	uint8_t max_irk_list_size;
> @@ -196,6 +198,7 @@ static struct {
>  	.index = MGMT_INDEX_NONE,
>  	.dev_class = 0,
>  	.name = NULL,
> +	.irk = {0},
>  	.max_advert_instance = 0,
>  	.rpa_offload_supported = 0,
>  	.max_irk_list_size = 0,

I don't think we need to keep IRK in memory.

I'd just try to load it (if not present generate and store) and provide it to 
kernel.

-- 
Szymon K. Janc
szymon.janc@gmail.com
