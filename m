Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Nov 2013 10:24:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 2/4] android: Add stub of get_remote_services command
Message-ID: <20131104082407.GA31497@x220.p-661hnu-f1>
References: <1383552410-2220-1-git-send-email-marcin.kraglak@tieto.com>
 <1383552410-2220-2-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383552410-2220-2-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Mon, Nov 04, 2013, Marcin Kraglak wrote:
> diff --git a/android/adapter.c b/android/adapter.c
> index 6f2a061..af62b11 100644
> --- a/android/adapter.c
> +++ b/android/adapter.c
> @@ -1459,6 +1459,11 @@ static uint8_t ssp_reply(void *buf, uint16_t len)
>  	return status;
>  }
>  
> +static uint8_t get_remote_services(void *buf, uint16_t len)
> +{
> +	return HAL_STATUS_UNSUPPORTED;
> +}
> +
>  void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
>  								uint16_t len)
>  {
> @@ -1563,6 +1568,11 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
>  			goto error;
>  
>  		break;
> +	case HAL_OP_GET_REMOTE_SERVICES:
> +		status = get_remote_services(buf, len);
> +		if (status != HAL_STATUS_SUCCESS)
> +			goto error;
> +		break;
>  	default:
>  		DBG("Unhandled command, opcode 0x%x", opcode);
>  		goto error;

The first two patches have been applied. I still need to do a more
thorough review of the other two before applying, and right this moment
I didn't have time for that.

Johan
