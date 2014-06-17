Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Add test command for sign write
Date: Tue, 17 Jun 2014 11:23:38 +0200
Message-ID: <2727661.I924SVBVzA@uw000953>
In-Reply-To: <1402955976-31684-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1402955976-31684-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Monday 16 of June 2014 23:59:36 Lukasz Rymanowski wrote:
> This is needed for some PTS test cases.
> ---
>  android/gatt.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index a19fe5c..943704a 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -3674,6 +3674,11 @@ static uint8_t test_read_write(bdaddr_t *bdaddr, bt_uuid_t *uuid, uint16_t op,
>  	case ATT_OP_EXEC_WRITE_REQ:
>  		length = enc_exec_write_req(u2, pdu, mtu);
>  		break;
> +	case ATT_OP_SIGNED_WRITE_CMD:
> +		if (signed_write_cmd(dev, u2, (uint8_t *) &u3, sizeof(u3)))
> +			return HAL_STATUS_SUCCESS;
> +		else
> +			return HAL_STATUS_FAILED;
>  	default:
>  		error("gatt: Unknown operation type");
>  
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
