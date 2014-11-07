Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 7/7] android/handsfree-client: Handle disconnect command
Date: Fri, 07 Nov 2014 20:56:14 +0100
Message-ID: <1800542.EtE6XzkJ2e@leonov>
In-Reply-To: <1415186531-23288-8-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415186531-23288-1-git-send-email-lukasz.rymanowski@tieto.com> <1415186531-23288-8-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 05 of November 2014 12:22:11 Lukasz Rymanowski wrote:
> ---
>  android/handsfree-client.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/android/handsfree-client.c b/android/handsfree-client.c
> index d90cef0..751a9f1 100644
> --- a/android/handsfree-client.c
> +++ b/android/handsfree-client.c
> @@ -195,9 +195,32 @@ static struct device *get_device(const bdaddr_t *addr)
> 
>  static void handle_disconnect(const void *buf, uint16_t len)
>  {
> -	DBG("Not Implemented");
> +	const struct hal_cmd_hf_client_disconnect *cmd = buf;
> +	struct device *dev;
> +	uint32_t status;
> +	bdaddr_t bdaddr;
> +	char addr[18];
> +
> +	DBG("");
> +
> +	android2bdaddr(&cmd->bdaddr, &bdaddr);
> +
> +	ba2str(&bdaddr, addr);
> +	DBG("Disconnect %s", addr);
> +
> +	dev = get_device(&bdaddr);
> +	if (!dev) {
> +		status = HAL_STATUS_FAILED;
> +		goto done;
> +	}
> +
> +	status = hfp_hf_disconnect(dev->hf) ? HAL_STATUS_SUCCESS :
> +							HAL_STATUS_FAILED;

Shouldn't 'connecting' and 'disconnecting' state be handled here?

> +
> +done:
> +
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> -			HAL_OP_HF_CLIENT_DISCONNECT, HAL_STATUS_UNSUPPORTED);
> +			HAL_OP_HF_CLIENT_DISCONNECT, status);
>  }
> 
>  static void handle_connect_audio(const void *buf, uint16_t len)

-- 
BR
Szymon Janc
