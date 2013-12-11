Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Dec 2013 14:02:20 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/tester: Fix closing invalid fd
Message-ID: <20131211120218.GE18372@aemeltch-MOBL1>
References: <1386762298-31678-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386762298-31678-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Dec 11, 2013 at 01:44:58PM +0200, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> This fixes possible closing invalid fd in a case socket() fails
> ---
>  android/android-tester.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/android/android-tester.c b/android/android-tester.c
> index 09c76c9..12d7613 100644
> --- a/android/android-tester.c
> +++ b/android/android-tester.c
> @@ -357,8 +357,10 @@ static void emulator(int pipe, int hci_index)
>  	ssize_t len;
>  
>  	fd = socket(PF_LOCAL, SOCK_DGRAM | SOCK_CLOEXEC, 0);
> -	if (fd < 0)
> -		goto failed;
> +	if (fd < 0) {
> +		close(pipe)

sorry did not check this missing ;, just apply patches from marcin

Best regards 
Andrei Emeltchenko 

> +		return;
> +	}
>  
>  	tv.tv_sec = WAIT_FOR_SIGNAL_TIME;
>  	tv.tv_usec = 0;
> @@ -374,7 +376,6 @@ static void emulator(int pipe, int hci_index)
>  	}
>  
>  	len = write(pipe, EMULATOR_SIGNAL, sizeof(EMULATOR_SIGNAL));
> -
>  	if (len != sizeof(EMULATOR_SIGNAL))
>  		goto failed;
>  
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
