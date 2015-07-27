Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Atul Rai <a.rai@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, sachin.dev@samsung.com
Subject: Re: [PATCH v2] android/client: Fix memory leak while using realloc()
Date: Mon, 27 Jul 2015 21:18:25 +0200
Message-ID: <2255750.trinXVBJIG@leonov>
In-Reply-To: <1437970480-2619-1-git-send-email-a.rai@samsung.com>
References: <1437970480-2619-1-git-send-email-a.rai@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Atul,

On Monday 27 of July 2015 09:44:40 Atul Rai wrote:
> While reallocating space to store additional "remote device set" using
> realloc, if realloc() fails, the original block is left untouched but
> reference to that block is lost as NULL is assigned to remote_devices.
> The original block needs to be freed before return.
> ---
>  android/client/if-bt.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/android/client/if-bt.c b/android/client/if-bt.c
> index 4723024..34611b9 100644
> --- a/android/client/if-bt.c
> +++ b/android/client/if-bt.c
> @@ -119,9 +119,18 @@ void add_remote_device(const bt_bdaddr_t *addr)
>  	/* Realloc space if needed */
>  	if (remote_devices_cnt >= remote_devices_capacity) {
>  		remote_devices_capacity *= 2;
> +		bt_bdaddr_t *tmp;
> +
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


This doesn't compile cleanly:

  CC       android/client/android_haltest-if-hf-client.o
android/client/if-bt.c: In function ‘add_remote_device’:
android/client/if-bt.c:122:3: error: ISO C90 forbids mixed declarations and 
code [-Werror=declaration-after-statement]
   bt_bdaddr_t *tmp;
   ^
cc1: all warnings being treated as errors
Makefile:6171: recipe for target 'android/client/android_haltest-if-bt.o' 
failed

You can use ./boostrap-configure;make for testing patches as this enables 
extra compiler flags.

-- 
BR
Szymon Janc
