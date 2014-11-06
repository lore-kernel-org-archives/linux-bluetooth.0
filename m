Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/handsfree: Return default device for zero bdaddr
Date: Thu, 06 Nov 2014 11:41:10 +0100
Message-ID: <4917512.kiFJOhNPJF@uw000953>
In-Reply-To: <1415262430-12425-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415262430-12425-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thursday 06 of November 2014 10:27:10 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> For the old Android API use find_default_device() function.
> ---
>  android/handsfree.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/android/handsfree.c b/android/handsfree.c
> index 4d8dff4..98d1f56 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -290,6 +290,11 @@ static bool match_by_bdaddr(const void *data, const void *match_data)
>  
>  static struct hf_device *find_device(const bdaddr_t *bdaddr)
>  {
> +	uint8_t zero_addr[6] = { 0 };
> +
> +	if (!memcmp(bdaddr, zero_addr, sizeof(zero_addr)))
> +		return find_default_device();
> +
>  	return queue_find(devices, match_by_bdaddr, bdaddr);
>  }

Please use bacmp and BDADDR_ANY here.

-- 
Best regards, 
Szymon Janc
