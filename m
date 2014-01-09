Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/haltest: Silence static analyzers
Date: Thu, 09 Jan 2014 18:06:19 +0100
Message-ID: <3390415.4blkkcRDgx@athlon>
In-Reply-To: <1389264320-7778-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1389259565-995-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1389264320-7778-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thursday 09 January 2014 12:45:20 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> This makes code more readable and silence static analyzers which think
> that pipe and fd are close two times.
> ---
>  android/android-tester.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/android-tester.c b/android/android-tester.c
> index a448ab5..c14cc19 100644
> --- a/android/android-tester.c
> +++ b/android/android-tester.c
> @@ -445,7 +445,7 @@ static void emulator(int pipe, int hci_index)
> 
>  	close(pipe);
>  	close(fd);
> -	bluetoothd_start(hci_index);
> +	return bluetoothd_start(hci_index);
> 
>  failed:
>  	close(pipe);

Applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
