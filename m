Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Jun 2014 17:05:11 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/mcap: Fix possible uninitialized use
Message-ID: <20140626140509.GC11076@aemeltch-MOBL1>
References: <1403790332-27829-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403790332-27829-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jun 26, 2014 at 04:45:32PM +0300, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> In case of maximum number of retries has reached, base_time may be used
> uninitialized. Fixes following warnings:

Please discard this, I will rework the patch.

> 
> ...
> external/bluetooth/bluez/android/mcap-lib.c: In function
> 'sync_send_indication.part.35':
> external/bluetooth/bluez/android/mcap-lib.c:2366:20: warning:
> 'base_time.tv_sec' may be used uninitialized in this function
> [-Wuninitialized]
> external/bluetooth/bluez/android/mcap-lib.c:2693:18: note:
> 'base_time.tv_sec' was declared here
> external/bluetooth/bluez/android/mcap-lib.c:2366:46: warning:
> 'base_time.tv_nsec' may be used uninitialized in this function
> [-Wuninitialized]
> external/bluetooth/bluez/android/mcap-lib.c:2693:18: note:
> 'base_time.tv_nsec' was declared here
> external/bluetooth/bluez/android/mcap-lib.c: In function
> 'sync_send_indication':
> external/bluetooth/bluez/android/mcap-lib.c:2366:20: warning:
> 'base_time.tv_sec' may be used uninitialized in this function
> [-Wuninitialized]
> external/bluetooth/bluez/android/mcap-lib.c:2693:18: note:
> 'base_time.tv_sec' was declared here
> external/bluetooth/bluez/android/mcap-lib.c:2366:46: warning:
> 'base_time.tv_nsec' may be used uninitialized in this function
> [-Wuninitialized]
> external/bluetooth/bluez/android/mcap-lib.c:2693:18: note:
> 'base_time.tv_nsec' was declared here
> ...
> ---
>  android/mcap-lib.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/android/mcap-lib.c b/android/mcap-lib.c
> index 256abe1..dd688d9 100644
> --- a/android/mcap-lib.c
> +++ b/android/mcap-lib.c
> @@ -2663,12 +2663,12 @@ static gboolean get_all_clocks(struct mcap_mcl *mcl, uint32_t *btclock,
>  		if (clock_gettime(CLK, &t0) < 0)
>  			return FALSE;
>  
> -		if (!read_btclock(mcl, btclock, &btres))
> -			continue;
> -
>  		if (clock_gettime(CLK, base_time) < 0)
>  			return FALSE;
>  
> +		if (!read_btclock(mcl, btclock, &btres))
> +			continue;
> +
>  		/*
>  		 * Tries to detect preemption between clock_gettime
>  		 * and read_btclock by measuring transaction time
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
