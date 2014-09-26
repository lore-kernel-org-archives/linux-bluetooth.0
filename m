Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/handsfree-client: Verify variable length data received from IPC
Date: Fri, 26 Sep 2014 12:28:45 +0200
Message-ID: <9352746.HT4QSUUR0E@uw000953>
In-Reply-To: <1411725855-6531-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1411725855-6531-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Friday 26 of September 2014 12:04:15 Jakub Tyszkowski wrote:
> Dial uses variable length data, check if we received as much as was
> declared. This fixes two negative ipc-tester cases for hfp-client dial
> api call not passing.
> ---
>  android/handsfree-client.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/android/handsfree-client.c b/android/handsfree-client.c
> index be29952..773ef76 100644
> --- a/android/handsfree-client.c
> +++ b/android/handsfree-client.c
> @@ -97,6 +97,15 @@ static void handle_volume_control(const void *buf, uint16_t len)
>  
>  static void handle_dial(const void *buf, uint16_t len)
>  {
> +	const struct hal_cmd_hf_client_dial *cmd = buf;
> +
> +	if (len != sizeof(*cmd) + cmd->number_len) {
> +		error("Malformed number data, size (%u bytes), terminating",
> +									len);
> +		raise(SIGTERM);
> +		return;
> +	}
> +
>  	DBG("Not Implemented");
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
>  				HAL_OP_HF_CLIENT_DIAL, HAL_STATUS_UNSUPPORTED);
> 

Applied. Thanks.

-- 
Best regards, 
Szymon Janc
