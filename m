Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android: Add simple rotation of snoop file
Date: Thu, 16 Jan 2014 09:02:43 +0100
Message-ID: <2219671.NIHpfoq1oi@uw000953>
In-Reply-To: <1389819699-12055-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389819699-12055-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wednesday 15 of January 2014 22:01:36 Andrzej Kaczmarek wrote:
> Already existing snoop file is renamed by adding ".old" suffix before
> new one is created. This is useful in case phone is restarted so logs
> are not overwritten and for this reason it's only applied in case
> default snoop file name is used.
> ---
>  android/bluetoothd-snoop.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/android/bluetoothd-snoop.c b/android/bluetoothd-snoop.c
> index 02f44e9..23e0bfd 100644
> --- a/android/bluetoothd-snoop.c
> +++ b/android/bluetoothd-snoop.c
> @@ -206,6 +206,9 @@ int main(int argc, char *argv[])
>  
>  	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
>  
> +	if (!strcmp(DEFAULT_SNOOP_FILE, path))
> +		rename(DEFAULT_SNOOP_FILE, DEFAULT_SNOOP_FILE ".old");
> +
>  	if (open_monitor(path) < 0) {
>  		printf("Failed to start bluetoothd_snoop\n");
>  		return EXIT_FAILURE;
> 

All patches in this set applied, thanks.
(after changing commits order to not break build in 1/4)

-- 
Best regards, 
Szymon Janc
