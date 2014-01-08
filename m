Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v3 3/4] android/pan: Implement PAN enable HAL api at daemon side
Date: Wed, 08 Jan 2014 10:24:56 +0100
Message-ID: <7986762.b1HJLuCvE7@uw000953>
In-Reply-To: <1389097880-14783-4-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389097880-14783-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1389097880-14783-4-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

> ---
>  android/pan.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/android/pan.c b/android/pan.c
> index 0eef284..0e12245 100644
> --- a/android/pan.c
> +++ b/android/pan.c
> @@ -585,18 +585,38 @@ static void bt_pan_enable(const void *buf, uint16_t len)
>  {
>  	const struct hal_cmd_pan_enable *cmd = buf;
>  	uint8_t status;
> +	int err;
> +
> +	DBG("");
> +
> +	if (local_role == cmd->local_role) {
> +		status = HAL_STATUS_SUCCESS;
> +		goto reply;
> +	}
> +
> +	/* destroy existing server */
> +	destroy_nap_device();
>  
>  	switch (cmd->local_role) {
>  	case HAL_PAN_ROLE_PANU:
> -	case HAL_PAN_ROLE_NAP:
> -		DBG("Not Implemented");
> -		status  = HAL_STATUS_FAILED;
> -		break;
> -	default:
>  		status = HAL_STATUS_UNSUPPORTED;
> -		break;
> +		goto reply;
> +	case HAL_PAN_ROLE_NONE:
> +		status = HAL_STATUS_SUCCESS;
> +		goto reply;
> +	}

Why do you remove default here? Daemon should verify parameter correctness.

> +
> +	local_role = cmd->local_role;
> +	err = register_nap_server();
> +	if (err < 0) {
> +		status = HAL_STATUS_FAILED;
> +		destroy_nap_device();
> +		goto reply;
>  	}
>  
> +	status = HAL_STATUS_SUCCESS;
> +
> +reply:
>  	ipc_send_rsp(HAL_SERVICE_ID_PAN, HAL_OP_PAN_ENABLE, status);
>  }
>  
> 

-- 
BR
Szymon Janc


