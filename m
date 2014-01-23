Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/9] android/ipc-tester: Add cases for SOCK msg size
Date: Fri, 24 Jan 2014 00:25:56 +0100
Message-ID: <2121587.74RTNtnecv@athlon>
In-Reply-To: <1390379124-16426-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1390379124-16426-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wednesday 22 January 2014 09:25:16 Jakub Tyszkowski wrote:
> Add cases testing message size verification for SOCK opcodes.
> ---
>  android/ipc-tester.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/android/ipc-tester.c b/android/ipc-tester.c
> index ed0dd10..088c324 100644
> --- a/android/ipc-tester.c
> +++ b/android/ipc-tester.c
> @@ -864,5 +864,23 @@ int main(int argc, char *argv[])
>  			sizeof(struct hal_cmd_le_test_mode), -1,
>  			HAL_SERVICE_ID_BLUETOOTH);
> 
> +	/* check for valid data size for SOCK */
> +	test_datasize_valid("SOCK Listen+", HAL_SERVICE_ID_SOCK,
> +			HAL_OP_SOCK_LISTEN,
> +			sizeof(struct hal_cmd_sock_listen), 1,
> +			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_SOCK);
> +	test_datasize_valid("SOCK Listen-", HAL_SERVICE_ID_SOCK,
> +			HAL_OP_SOCK_LISTEN,
> +			sizeof(struct hal_cmd_sock_listen), -1,
> +			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_SOCK);
> +	test_datasize_valid("SOCK Connect+", HAL_SERVICE_ID_SOCK,
> +			HAL_OP_SOCK_CONNECT,
> +			sizeof(struct hal_cmd_sock_connect), 1,
> +			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_SOCK);
> +	test_datasize_valid("SOCK Connect-", HAL_SERVICE_ID_SOCK,
> +			HAL_OP_SOCK_CONNECT,
> +			sizeof(struct hal_cmd_sock_connect), -1,
> +			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_SOCK);
> +
>  	return tester_run();
>  }

All patches in this set have been applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
