Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/hal-gatt: Fix missing check if interface is ready
Date: Tue, 27 May 2014 00:11:30 +0200
Message-ID: <2872925.oNVPNmXkhV@athlon>
In-Reply-To: <1401116627-28767-1-git-send-email-szymon.janc@tieto.com>
References: <1401116627-28767-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 26 May 2014 17:03:44 Szymon Janc wrote:
> ---
>  android/hal-gatt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/android/hal-gatt.c b/android/hal-gatt.c
> index 93dc066..6f0d2c5 100644
> --- a/android/hal-gatt.c
> +++ b/android/hal-gatt.c
> @@ -573,6 +573,9 @@ static bt_status_t register_client(bt_uuid_t *uuid)
>  {
>  	struct hal_cmd_gatt_client_register cmd;
> 
> +	if (!interface_ready())
> +		return BT_STATUS_NOT_READY;
> +
>  	memcpy(cmd.uuid, uuid, sizeof(*uuid));
> 
>  	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_REGISTER,

Patches 1-3 are now applied.

-- 
Szymon K. Janc
szymon.janc@gmail.com
