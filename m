Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix wrong size argument
Date: Wed, 25 Jun 2014 17:18:13 +0200
Message-ID: <11700954.ZxLd8GBxpa@uw000953>
In-Reply-To: <1403174179-23272-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403174179-23272-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thursday 19 of June 2014 13:36:19 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Instead of sizeof of (uint8_t *) pass real length, though for that
> function it doesn't matter at this point.
> ---
>  android/gatt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 5007817..7ce57ca 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -5688,7 +5688,7 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
>  		 * registered for this indication, event will be send in
>  		 * handle_notification
>  		 */
> -		resp_length = enc_confirmation(opdu, sizeof(opdu));
> +		resp_length = enc_confirmation(opdu, length);
>  		status = 0;
>  		break;
>  	case ATT_OP_HANDLE_NOTIFY:
> 

Applied. Thanks.

-- 
Best regards, 
Szymon Janc
