Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Dec 2013 10:46:09 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] android/bluetooth: Add support for DUT mode
 configure command
Message-ID: <20131223084607.GA19604@aemeltch-MOBL1>
References: <1387564210-6102-1-git-send-email-szymon.janc@tieto.com>
 <1387564210-6102-2-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387564210-6102-2-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Dec 20, 2013 at 07:30:08PM +0100, Szymon Janc wrote:
> This allows to enable and disable DUT mode.

Hi Szymon, could you add some more info about the mode?

Best regards 
Andrei Emeltchenko 

> ---
>  android/bluetooth.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 2e75864..59f0810 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -50,6 +50,8 @@
>  #include "utils.h"
>  #include "bluetooth.h"
>  
> +#define DUT_MODE_FILE "/sys/kernel/debug/bluetooth/hci%u/dut_mode"
> +
>  #define DEVICE_ID_SOURCE	0x0002	/* USB */
>  #define DEVICE_ID_VENDOR	0x1d6b	/* Linux Foundation */
>  #define DEVICE_ID_PRODUCT	0x0247	/* BlueZ for Android */
> @@ -2872,13 +2874,34 @@ failed:
>  static void handle_dut_mode_conf_cmd(const void *buf, uint16_t len)
>  {
>  	const struct hal_cmd_dut_mode_conf *cmd = buf;
> +	char path[FILENAME_MAX];
> +	uint8_t status;
> +	int fd, ret;
>  
>  	DBG("enable %u", cmd->enable);
>  
> -	/* TODO */
> +	snprintf(path, sizeof(path), DUT_MODE_FILE, adapter.index);
>  
> -	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DUT_MODE_CONF,
> -							HAL_STATUS_FAILED);
> +	fd = open(path, O_WRONLY);
> +	if (fd < 0) {
> +		status = HAL_STATUS_FAILED;
> +		goto failed;
> +	}
> +
> +	if (cmd->enable)
> +		ret = write(fd, "1", sizeof("1"));
> +	else
> +		ret = write(fd, "0", sizeof("0"));
> +
> +	if (ret < 0)
> +		status = HAL_STATUS_FAILED;
> +	else
> +		status = HAL_STATUS_SUCCESS;
> +
> +	close(fd);
> +
> +failed:
> +	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DUT_MODE_CONF, status);
>  }
>  
>  static void handle_dut_mode_send_cmd(const void *buf, uint16_t len)
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
