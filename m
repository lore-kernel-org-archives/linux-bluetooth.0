Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 05/17] android/gatt: Fix wrong initial value
Date: Tue, 17 Jun 2014 23:21:16 +0200
Message-ID: <3045098.LyDRGR9gjU@athlon>
In-Reply-To: <1402905472-17643-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1402905472-17643-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Monday 16 June 2014 10:57:40 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Initialize value_len to -1 since otherwise check value_len >= 0 does not
> make sense.
> ---
>  android/gatt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index eb977d5..c5cb58f 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -4288,7 +4288,7 @@ static void read_requested_attributes(void *data, void
> *user_data) struct request_processing_data *process_data = user_data;
>  	uint32_t permissions;
>  	uint8_t *value, error;
> -	int value_len = 0;
> +	int value_len = -1;
> 
>  	if (!gatt_db_get_attribute_permissions(gatt_db, resp_data->handle,
>  								&permissions)) {

This is not correct. value_len == -1 means that callback was called from 
gatt_db_read() and response will be filled later.

-- 
Szymon K. Janc
szymon.janc@gmail.com
