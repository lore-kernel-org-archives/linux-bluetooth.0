Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Jul 2015 00:29:01 -0700 (PDT)
From: Szymon Janc <szymon.janc@tieto.com>
To: Atul Rai <a.rai@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, sachin.dev@samsung.com
Subject: Re: [PATCH v3] android/client: Fix memory leak while using realloc()
Message-ID: <32687193.BbdPDPfzcv@leonov>
In-Reply-To: <1438057250-17977-1-git-send-email-a.rai@samsung.com>
References: <1438057250-17977-1-git-send-email-a.rai@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Atul,

On Tuesday 28 of July 2015 09:50:50 Atul Rai wrote:
> While reallocating space to store additional "remote device set" using
> realloc, if realloc() fails, the original block is left untouched but
> reference to that block is lost as NULL is assigned to remote_devices.
> The original block needs to be freed before return.
> ---
>  android/client/if-bt.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/android/client/if-bt.c b/android/client/if-bt.c
> index 4723024..c9acf6c 100644
> --- a/android/client/if-bt.c
> +++ b/android/client/if-bt.c
> @@ -118,10 +118,19 @@ void add_remote_device(const bt_bdaddr_t *addr)
> 
>  	/* Realloc space if needed */
>  	if (remote_devices_cnt >= remote_devices_capacity) {
> +		bt_bdaddr_t *tmp;
> +
>  		remote_devices_capacity *= 2;
> +		/*
> +		 * Save reference to previously allocated memory block so that
> +		 * it can be freed in case realloc fails.
> +		 */
> +		tmp = remote_devices;
> +
>  		remote_devices = realloc(remote_devices, sizeof(bt_bdaddr_t) *
>  						remote_devices_capacity);
>  		if (remote_devices == NULL) {
> +			free(tmp);
>  			remote_devices_capacity = 0;
>  			remote_devices_cnt = 0;
>  			return;

Applied, thanks.

-- 
BR
Szymon Janc
