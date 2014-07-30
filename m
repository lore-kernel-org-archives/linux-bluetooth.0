Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] android/gatt: Split set_security() function
Date: Wed, 30 Jul 2014 12:37:09 +0200
Message-ID: <1499940.vN5kL8FkWq@uw000953>
In-Reply-To: <1406713130-3825-1-git-send-email-marcin.kraglak@tieto.com>
References: <1406713130-3825-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wednesday 30 of July 2014 11:38:46 Marcin Kraglak wrote:
> Split function to set_security() and set_auth_type(). Set_security()
> will be used in public API.
> ---
>  android/gatt.c | 51 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 22 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 2ddbf29..31558d0 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -2832,27 +2832,12 @@ static int get_sec_level(struct gatt_device *dev)
>  	return sec_level;
>  }
>  
> -static bool set_security(struct gatt_device *device, int auth_type)
> +static bool set_security(struct gatt_device *device, int req_sec_level)
>  {
> -	int req_sec_level, sec_level;
> +	int sec_level;
>  	GError *gerr = NULL;
>  	GIOChannel *io;
>  
> -	switch (auth_type) {
> -	case HAL_GATT_AUTHENTICATION_MITM:
> -		req_sec_level = BT_SECURITY_HIGH;
> -		break;
> -	case HAL_GATT_AUTHENTICATION_NO_MITM:
> -		req_sec_level = BT_SECURITY_MEDIUM;
> -		break;
> -	case HAL_GATT_AUTHENTICATION_NONE:
> -		req_sec_level = BT_SECURITY_LOW;
> -		break;
> -	default:
> -		error("gatt: Invalid auth_type value: %d", auth_type);
> -		return false;
> -	}
> -
>  	sec_level = get_sec_level(device);
>  	if (sec_level < 0)
>  		return false;
> @@ -2875,6 +2860,28 @@ static bool set_security(struct gatt_device *device, int auth_type)
>  	return true;
>  }
>  
> +static bool set_auth_type(struct gatt_device *device, int auth_type)
> +{
> +	int sec_level;
> +
> +	switch (auth_type) {
> +	case HAL_GATT_AUTHENTICATION_MITM:
> +		sec_level = BT_SECURITY_HIGH;
> +		break;
> +	case HAL_GATT_AUTHENTICATION_NO_MITM:
> +		sec_level = BT_SECURITY_MEDIUM;
> +		break;
> +	case HAL_GATT_AUTHENTICATION_NONE:
> +		sec_level = BT_SECURITY_LOW;
> +		break;
> +	default:
> +		error("gatt: Invalid auth_type value: %d", auth_type);
> +		return false;
> +	}
> +
> +	return set_security(device, sec_level);
> +}
> +
>  static void handle_client_read_characteristic(const void *buf, uint16_t len)
>  {
>  	const struct hal_cmd_gatt_client_read_characteristic *cmd = buf;
> @@ -2915,7 +2922,7 @@ static void handle_client_read_characteristic(const void *buf, uint16_t len)
>  		goto failed;
>  	}
>  
> -	if (!set_security(conn->device, cmd->auth_req)) {
> +	if (!set_auth_type(conn->device, cmd->auth_req)) {
>  		error("gatt: Failed to set security %d", cmd->auth_req);
>  		status = HAL_STATUS_FAILED;
>  		free(cb_data);
> @@ -3052,7 +3059,7 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
>  		}
>  	}
>  
> -	if (!set_security(conn->device, cmd->auth_req)) {
> +	if (!set_auth_type(conn->device, cmd->auth_req)) {
>  		error("gatt: Failed to set security %d", cmd->auth_req);
>  		status = HAL_STATUS_FAILED;
>  		goto failed;
> @@ -3267,7 +3274,7 @@ static void handle_client_read_descriptor(const void *buf, uint16_t len)
>  		goto failed;
>  	}
>  
> -	if (!set_security(conn->device, cmd->auth_req)) {
> +	if (!set_auth_type(conn->device, cmd->auth_req)) {
>  		error("gatt: Failed to set security %d", cmd->auth_req);
>  		status = HAL_STATUS_FAILED;
>  		free(cb_data);
> @@ -3399,7 +3406,7 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
>  		}
>  	}
>  
> -	if (!set_security(conn->device, cmd->auth_req)) {
> +	if (!set_auth_type(conn->device, cmd->auth_req)) {
>  		error("gatt: Failed to set security %d", cmd->auth_req);
>  		status = HAL_STATUS_FAILED;
>  		goto failed;
> @@ -3882,7 +3889,7 @@ static uint8_t test_increase_security(bdaddr_t *bdaddr, uint16_t u1)
>  	if (!device)
>  		return HAL_STATUS_FAILED;
>  
> -	if (!set_security(device, u1))
> +	if (!set_auth_type(device, u1))
>  		return HAL_STATUS_FAILED;
>  
>  	return HAL_STATUS_SUCCESS;
> 

All 5 patches applied. Thanks.

-- 
Best regards, 
Szymon Janc
