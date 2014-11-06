Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] android/handsfree: Return default device for zero bdaddr
Date: Thu, 06 Nov 2014 13:57:19 +0100
Message-ID: <2839608.s73lST7E4d@uw000953>
In-Reply-To: <1415277958-26589-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <4917512.kiFJOhNPJF@uw000953> <1415277958-26589-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thursday 06 of November 2014 14:45:58 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> For the old Android API use find_default_device() function.
> ---
>  android/handsfree.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/android/handsfree.c b/android/handsfree.c
> index b410f5d..33fcbdd 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -290,6 +290,9 @@ static bool match_by_bdaddr(const void *data, const void *match_data)
>  
>  static struct hf_device *find_device(const bdaddr_t *bdaddr)
>  {
> +	if (!bacmp(bdaddr, BDADDR_ANY))
> +		return find_default_device();
> +
>  	return queue_find(devices, match_by_bdaddr, bdaddr);
>  }
>  

Applied, thanks. 

-- 
Best regards, 
Szymon Janc
