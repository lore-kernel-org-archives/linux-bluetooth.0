Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/handsfree: Refactor handle_dial()
Date: Fri, 29 Aug 2014 15:58:51 +0200
Message-ID: <3335162.mhnMEypyip@uw000953>
In-Reply-To: <1409060601-14384-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1409060601-14384-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tuesday 26 of August 2014 16:43:21 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Call callback only once.
> ---
>  android/hal-handsfree.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
> index 0f5e1d7..986e745 100644
> --- a/android/hal-handsfree.c
> +++ b/android/hal-handsfree.c
> @@ -86,6 +86,7 @@ static void handle_dial(void *buf, uint16_t len, int fd)
>  {
>  	struct hal_ev_handsfree_dial *ev = buf;
>  	uint16_t num_len = ev->number_len;
> +	char *number = NULL;
>  
>  	if (len != sizeof(*ev) + num_len ||
>  			(num_len != 0 && ev->number[num_len - 1] != '\0')) {
> @@ -97,9 +98,9 @@ static void handle_dial(void *buf, uint16_t len, int fd)
>  		return;
>  
>  	if (ev->number_len)
> -		cbs->dial_call_cmd_cb((char *) ev->number);
> -	else
> -		cbs->dial_call_cmd_cb(NULL);
> +		number = (char *) ev->number;
> +
> +	cbs->dial_call_cmd_cb(number);
>  }
>  
>  static void handle_dtmf(void *buf, uint16_t len, int fd)

Patch applied. Thanks. 

-- 
Best regards, 
Szymon Janc
