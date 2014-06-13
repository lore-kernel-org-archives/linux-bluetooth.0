Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix wrong check
Date: Fri, 13 Jun 2014 16:44:55 +0200
Message-ID: <7464350.jhI9E2pFpN@uw000953>
In-Reply-To: <1402569654-27092-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402569654-27092-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thursday 12 of June 2014 13:40:54 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/gatt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index cc3746c..8da77d0 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -4133,8 +4133,8 @@ static void fill_gatt_response_by_handle(uint16_t handle, uint16_t offset,
>  
>  	entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
>  							UINT_TO_PTR(handle));
> -	if (entry) {
> -		DBG("No pending response found! Bogus android response?");
> +	if (!entry) {
> +		error("No pending response found! Bogus android response?");
>  		return;
>  	}

I've already pushed similar fix from Marcin. But please rebase and send
DBG to error change.

-- 
Best regards, 
Szymon Janc
