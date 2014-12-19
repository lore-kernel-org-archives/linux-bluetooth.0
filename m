Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix possible NULL dereference
Date: Fri, 19 Dec 2014 14:10:06 +0100
Message-ID: <1449847.FzcL4bpd4a@uw000953>
In-Reply-To: <1418992228-4070-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1418992228-4070-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Friday 19 of December 2014 14:30:28 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Fixes warnings:
> ...
> Pointer 'req' returned from call to function 'queue_peek_head'
> may be NULL and will be dereferenced
> ...
> ---
>  android/gatt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 6828f2f..2534836 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -5561,6 +5561,9 @@ static void handle_server_send_response(const void *buf, uint16_t len)
>  		 * gatt_db_attribute_write().
>  		 */
>  		req = queue_peek_head(conn->device->pending_requests);
> +		if (!req)
> +			goto done;
> +
>  		/* Cast status to uint8_t, due to (byte) cast in java layer. */
>  		req->error = err_to_att((uint8_t) cmd->status);
>  		req->state = REQUEST_DONE;
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
