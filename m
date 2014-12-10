Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/socket: Add support for dynamic MAP record
Date: Wed, 10 Dec 2014 14:32:34 +0100
Message-ID: <2042341.U6dAk6S04b@leonov>
In-Reply-To: <1418057227-29987-1-git-send-email-szymon.janc@tieto.com>
References: <1418057227-29987-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 08 of December 2014 17:47:07 Szymon Janc wrote:
> Android 5.0 uses service name (sic!) for defining instance ID and
> supported message types. Name passed is in format of "XXYYname"
> where XX is hex coded instance and YY is hex coded message types
> mask.
> 
> This patch adds new mode for Socket HAL in which daemon tries to
> extract instance ID and message types from service name.
> ---
>  android/hal-bluetooth.c |  7 ++++++-
>  android/hal-msg.h       |  3 +++
>  android/socket.c        | 29 +++++++++++++++++++++++++++--
>  3 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
> index fac6b6f..f8e3e53 100644
> --- a/android/hal-bluetooth.c
> +++ b/android/hal-bluetooth.c
> @@ -539,9 +539,14 @@ static int init(bt_callbacks_t *callbacks)
>  	}
> 
>  	cmd.service_id = HAL_SERVICE_ID_SOCKET;
> -	cmd.mode = HAL_MODE_DEFAULT;
>  	cmd.max_clients = 1;
> 
> +#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
> +	cmd.mode = HAL_MODE_SOCKET_DYNAMIC_MAP;
> +#else
> +	cmd.mode = HAL_MODE_DEFAULT;
> +#endif
> +
>  	status = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
>  					sizeof(cmd), &cmd, NULL, NULL, NULL);
>  	if (status != BT_STATUS_SUCCESS) {
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index 33b53c5..81d5b2e 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -266,6 +266,9 @@ struct hal_rsp_get_connection_state {
> 
>  /* Bluetooth Socket HAL api */
> 
> +#define HAL_MODE_SOCKET_DEFAULT		HAL_MODE_DEFAULT
> +#define HAL_MODE_SOCKET_DYNAMIC_MAP	0x01
> +
>  #define HAL_SOCK_RFCOMM		0x01
>  #define HAL_SOCK_SCO		0x02
>  #define HAL_SOCK_L2CAP		0x03
> diff --git a/android/socket.c b/android/socket.c
> index 7200071..6e2fd9d 100644
> --- a/android/socket.c
> +++ b/android/socket.c
> @@ -90,6 +90,8 @@ static struct ipc *hal_ipc = NULL;
> 
>  static bdaddr_t adapter_addr;
> 
> +static uint8_t hal_mode = HAL_MODE_SOCKET_DEFAULT;
> +
>  static const uint8_t zero_uuid[16] = { 0 };
> 
>  /* Simple list of RFCOMM connected sockets */
> @@ -314,10 +316,31 @@ static sdp_record_t *create_mas_record(uint8_t chan,
> const char *svc_name) {
>  	sdp_list_t *seq;
>  	sdp_profile_desc_t profile[1];
> -	uint8_t minst = DEFAULT_MAS_INSTANCE;
> -	uint8_t mtype = DEFAULT_MAS_MSG_TYPE;
> +	uint8_t minst, mtype;
>  	sdp_record_t *record;
>  	uuid_t uuid;
> +	int cnt, ret;
> +
> +	switch (hal_mode) {
> +	case HAL_MODE_SOCKET_DYNAMIC_MAP:
> +		/*
> +		 * Service name for MAP is passed as XXYYname
> +		 * XX - instance
> +		 * YY - message type
> +		 */
> +		ret = sscanf(svc_name, "%02hhx%02hhx%n", &minst, &mtype, &cnt);
> +		if (ret != 2 || cnt != 4)
> +			return NULL;
> +
> +		svc_name += 4;
> +		break;
> +	case HAL_MODE_SOCKET_DEFAULT:
> +		minst = DEFAULT_MAS_INSTANCE;
> +		mtype = DEFAULT_MAS_MSG_TYPE;
> +		break;
> +	default:
> +		return NULL;
> +	}
> 
>  	sdp_uuid16_create(&uuid, MAP_MSE_SVCLASS_ID);
> 
> @@ -1148,6 +1171,8 @@ void bt_socket_register(struct ipc *ipc, const
> bdaddr_t *addr, uint8_t mode)
> 
>  	DBG("");
> 
> +	hal_mode = mode;
> +
>  	/*
>  	 * make sure channels assigned for profiles are reserved and not used
>  	 * for app services

Pushed.

-- 
BR
Szymon Janc
