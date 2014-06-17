Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 04/17] android/gatt: Change DBG() to error()
Date: Tue, 17 Jun 2014 23:22:20 +0200
Message-ID: <2359678.CjEdacx2Jc@athlon>
In-Reply-To: <1402905472-17643-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1402905472-17643-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Monday 16 June 2014 10:57:39 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/gatt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index a19fe5c..eb977d5 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -4275,7 +4275,7 @@ static void fill_gatt_response_by_handle(uint16_t
> handle, uint16_t offset, entry = queue_find(dev->pending_requests,
> match_dev_request_by_handle, UINT_TO_PTR(handle));
>  	if (!entry) {
> -		DBG("No pending response found! Bogus android response?");
> +		error("No pending response found! Bogus android response?");

Please prefix error message with "gatt:"

>  		return;
>  	}

-- 
Szymon K. Janc
szymon.janc@gmail.com
