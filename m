Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix transport mask for service start
Date: Tue, 25 Nov 2014 15:12:39 +0100
Message-ID: <1558916.8nS4HBavjS@leonov>
In-Reply-To: <1416582939-8123-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1416582939-8123-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Friday 21 of November 2014 16:15:39 Jakub Tyszkowski wrote:
> With Android 5 transport enum was changed to bit mask. With this change
> we use bit masks in daemon and for Kitkat we map enum to bit mask in
> hal.
> ---
>  android/gatt.c     | 18 ++++++++----------
>  android/hal-gatt.c | 32 +++++++++++++++++++++++++++++++-
>  android/hal-msg.h  |  5 ++---
>  3 files changed, 41 insertions(+), 14 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index ea5cead..092473c 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -5263,30 +5263,28 @@ static void handle_server_start_service(const void
> *buf, uint16_t len) struct gatt_db_attribute *attrib;
>  	uint8_t status;
> 
> -	DBG("");
> +	DBG("transport 0x%02x", cmd->transport);
> 
>  	memset(&ev, 0, sizeof(ev));
> 
> +	if (cmd->transport == 0) {
> +		status = HAL_STATUS_FAILED;
> +		goto failed;
> +	}
> +
>  	server = find_app_by_id(cmd->server_if);
>  	if (!server) {
>  		status = HAL_STATUS_FAILED;
>  		goto failed;
>  	}
> 
> -	switch (cmd->transport) {
> -	case GATT_SERVER_TRANSPORT_BREDR:
> -	case GATT_SERVER_TRANSPORT_LE_BREDR:
> +	if (cmd->transport & GATT_SERVER_TRANSPORT_BREDR_BIT) {
>  		if (!add_service_sdp_record(cmd->service_handle)) {
>  			status = HAL_STATUS_FAILED;
>  			goto failed;
>  		}
> -		break;
> -	case GATT_SERVER_TRANSPORT_LE:
> -		break;
> -	default:
> -		status = HAL_STATUS_FAILED;
> -		goto failed;
>  	}
> +	/* TODO: Handle BREDR only */
> 
>  	attrib = gatt_db_get_attribute(gatt_db, cmd->service_handle);
>  	if (!attrib) {
> diff --git a/android/hal-gatt.c b/android/hal-gatt.c
> index ac4f367..ee6eb3a 100644
> --- a/android/hal-gatt.c
> +++ b/android/hal-gatt.c
> @@ -1812,7 +1812,7 @@ static bt_status_t add_descriptor(int server_if, int
> service_handle, sizeof(cmd), &cmd, NULL, NULL, NULL);
>  }
> 
> -static bt_status_t start_service(int server_if, int service_handle,
> +static bt_status_t start_service_real(int server_if, int service_handle,
>  								int transport)
>  {
>  	struct hal_cmd_gatt_server_start_service cmd;
> @@ -1829,6 +1829,36 @@ static bt_status_t start_service(int server_if, int
> service_handle, sizeof(cmd), &cmd, NULL, NULL, NULL);
>  }
> 
> +#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
> +static bt_status_t start_service(int server_if, int service_handle,
> +								int transport)
> +{
> +	return start_service_real(server_if, service_handle, transport);
> +}
> +#else
> +static bt_status_t start_service(int server_if, int service_handle,
> +								int transport)
> +{
> +	int transport_mask = 0;
> +
> +	/* Android 5 changes transport enum to bit mask. */
> +	switch (transport) {
> +	case 0:
> +		transport_mask = GATT_SERVER_TRANSPORT_LE_BIT;
> +		break;
> +	case 1:
> +		transport_mask = GATT_SERVER_TRANSPORT_BREDR_BIT
> +		break;
> +	case 2:
> +		transport_mask = GATT_SERVER_TRANSPORT_LE_BIT |
> +						GATT_SERVER_TRANSPORT_BREDR_BIT;
> +		break;
> +	}
> +
> +	return start_service_real(server_if, service_handle, transport_mask);
> +}
> +#endif
> +
>  static bt_status_t stop_service(int server_if, int service_handle)
>  {
>  	struct hal_cmd_gatt_server_stop_service cmd;
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index 5396404..1cc4434 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -984,9 +984,8 @@ struct hal_cmd_gatt_server_add_descriptor {
>  	int32_t permissions;
>  } __attribute__((packed));
> 
> -#define GATT_SERVER_TRANSPORT_LE		0x00
> -#define GATT_SERVER_TRANSPORT_BREDR		0x01
> -#define GATT_SERVER_TRANSPORT_LE_BREDR		0x02
> +#define GATT_SERVER_TRANSPORT_LE_BIT		0x01
> +#define GATT_SERVER_TRANSPORT_BREDR_BIT		0x02
> 
>  #define HAL_OP_GATT_SERVER_START_SERVICE	0x1f
>  struct hal_cmd_gatt_server_start_service {


Patch applied, thanks.

Note that I had to update tester myself. Please keep that in mind for future 
submissions.

-- 
BR
Szymon Janc
