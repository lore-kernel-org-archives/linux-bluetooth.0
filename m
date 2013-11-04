Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Nov 2013 12:08:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix incorrect result type in set_adapter_name
Message-ID: <20131104100851.GA2752@x220.p-661hnu-f1>
References: <1383557498-7971-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383557498-7971-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Mon, Nov 04, 2013, Marcin Kraglak wrote:
> diff --git a/android/adapter.c b/android/adapter.c
> index af62b11..38dec9d 100644
> --- a/android/adapter.c
> +++ b/android/adapter.c
> @@ -880,7 +880,7 @@ static void set_adapter_name_complete(uint8_t status, uint16_t length,
>  	adapter_name_changed(rp->name);
>  }
>  
> -static bool set_adapter_name(uint8_t *name, uint16_t len)
> +static uint8_t set_adapter_name(uint8_t *name, uint16_t len)
>  {
>  	struct mgmt_cp_set_local_name cp;
>  
> @@ -890,11 +890,11 @@ static bool set_adapter_name(uint8_t *name, uint16_t len)
>  	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_LOCAL_NAME, adapter->index,
>  			sizeof(cp), &cp, set_adapter_name_complete, NULL,
>  								NULL) > 0)
> -		return true;
> +		return HAL_STATUS_SUCCESS;
>  
>  	error("Failed to set name");
>  
> -	return false;
> +	return HAL_STATUS_FAILED;
>  }
>  
>  static void read_info_complete(uint8_t status, uint16_t length, const void *param,

Applied. Thanks.

Johan
