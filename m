Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Oct 2013 23:16:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] android: Add initial code for hidhost virtual unplug
Message-ID: <20131022201611.GA18814@x220.p-661hnu-f1>
References: <1382467793-4709-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382467793-4709-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Oct 22, 2013, Ravi kumar Veeramally wrote:
> @@ -87,7 +89,13 @@ static bt_status_t hh_virtual_unplug(bt_bdaddr_t *bd_addr)
>  	if (!bd_addr)
>  		return BT_STATUS_PARM_INVALID;
>  
> -	return BT_STATUS_UNSUPPORTED;
> +	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
> +
> +	if (hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_MSG_OP_BT_HID_VP,
> +			sizeof(cmd), &cmd, 0, NULL, NULL) < 0)
> +		return BT_STATUS_FAIL;
> +
> +	return BT_STATUS_SUCCESS;
>  }

It seems you haven't quite paid attention to what happened in the
upstream tree today. Take a look at commit 039369d809dedcdfd3c09fb

Basically you should be able to simply do "return hal_ipc_cmd(...);"
in most cases now.

Johan
