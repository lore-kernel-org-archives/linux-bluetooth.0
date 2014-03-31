Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Fix NULL pointer dereference
Date: Mon, 31 Mar 2014 15:54:55 +0200
Message-ID: <6986568.6jbTlktqIB@uw000953>
In-Reply-To: <1396269913-23447-1-git-send-email-marcin.kraglak@tieto.com>
References: <1396269913-23447-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Monday 31 of March 2014 14:45:13 Marcin Kraglak wrote:
> If there is no adapter, hal_ipc in not initialized. Below is
> message from valgrind:
> 
> ==22501== Invalid read of size 4
> ==22501==    at 0x805B809: ipc_unregister (ipc.c:421)
> ==22501==    by 0x804AEAF: main (main.c:548)
> ==22501==  Address 0x4 is not stack'd, malloc'd or (recently) free'd
> ---
>  android/main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/android/main.c b/android/main.c
> index 828f81d..e229a6d 100644
> --- a/android/main.c
> +++ b/android/main.c
> @@ -541,8 +541,11 @@ int main(int argc, char *argv[])
>  	bt_bluetooth_cleanup();
>  	g_main_loop_unref(event_loop);
>  
> -	ipc_unregister(hal_ipc, HAL_SERVICE_ID_CORE);
> -	ipc_cleanup(hal_ipc);
> +	/* If no adapter was initialized, hal_ipc is NULL */
> +	if (hal_ipc) {
> +		ipc_unregister(hal_ipc, HAL_SERVICE_ID_CORE);
> +		ipc_cleanup(hal_ipc);
> +	}
>  
>  	info("Exit");

Applied, thanks.

-- 
Best regards, 
Szymon Janc
