Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix for read request
Date: Fri, 16 May 2014 14:36:34 +0200
Message-ID: <43760990.aZUY7d9jVI@uw000953>
In-Reply-To: <1400237252-3968-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400237252-3968-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Friday 16 of May 2014 12:47:32 Lukasz Rymanowski wrote:
> If there is no attribute in database we should return immediately.
> ---
>  android/gatt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 9bbcc48..9d90f3a 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -3656,8 +3656,10 @@ static void read_requested_attributes(void *data, void *user_data)
>  						resp_data->offset,
>  						process_data->opcode,
>  						&process_data->device->bdaddr,
> -						&value, &value_len))
> +						&value, &value_len)) {
>  		resp_data->length = READ_FAILED;
> +		return;
> +	}
>  
>  	/* We have value here already if no callback will be called */
>  	if (value_len >= 0) {
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
