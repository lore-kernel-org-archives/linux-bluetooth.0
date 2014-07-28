Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 Jul 2014 16:57:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 02/11] android/core: Remove unneeded assignment
Message-ID: <20140728135750.GA17010@t440s.P-661HNU-F1>
References: <1405587306-20020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1406551609-17546-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1406551609-17546-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406551609-17546-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Jul 28, 2014, Andrei Emeltchenko wrote:
> ---
>  android/bluetooth.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index a2ab445..5b72a36 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -291,7 +291,6 @@ static void load_adapter_config(void)
>  	if (gerr) {
>  		adapter.discoverable_timeout = DEFAULT_DISCOVERABLE_TIMEOUT;
>  		g_error_free(gerr);
> -		gerr = NULL;
>  	}
>  
>  	g_key_file_free(key_file);

I don't think patches like this are a good idea since they make the code
more prone to bugs in the future. In this case if the function was ever
extended and gerr reused one would need to remember to "fix" the old
code so that it's re-initialized to NULL.

Johan
