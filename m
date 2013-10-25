Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Oct 2013 12:36:17 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 06/15] android/hal: Add support for sending create bond
 command
Message-ID: <20131025093616.GC6113@aemeltch-MOBL1>
References: <1382691378-31940-1-git-send-email-szymon.janc@tieto.com>
 <1382691378-31940-6-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382691378-31940-6-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Oct 25, 2013 at 10:56:09AM +0200, Szymon Janc wrote:
> This allows HAL to start bonding.
> ---
>  android/hal-bluetooth.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
> index b81f8dd..6f7ef45 100644
> --- a/android/hal-bluetooth.c
> +++ b/android/hal-bluetooth.c
> @@ -275,15 +275,17 @@ static int cancel_discovery(void)
>  
>  static int create_bond(const bt_bdaddr_t *bd_addr)
>  {
> +	struct hal_cmd_create_bond cmd;
> +
>  	DBG("");
>  
>  	if (!interface_ready())
>  		return BT_STATUS_NOT_READY;
>  
> -	if (!bd_addr)
> -		return BT_STATUS_PARM_INVALID;

I think we can leave check here

Best regards 
Andrei Emeltchenko 

> +	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
>  
> -	return BT_STATUS_UNSUPPORTED;
> +	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CREATE_BOND,
> +					sizeof(cmd), &cmd, 0, NULL, NULL);
>  }
>  
>  static int cancel_bond(const bt_bdaddr_t *bd_addr)
> -- 
> 1.8.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
