Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] android/gatt: Initial support for write test command
Date: Thu, 29 May 2014 16:22:13 +0200
Message-ID: <2828749.7sly4NCZqI@uw000953>
In-Reply-To: <1401368704-4265-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401368704-4265-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thursday 29 of May 2014 15:04:59 Jakub Tyszkowski wrote:
> This is handled mostly the same way as read so we can use the same
> function for sending att requests.
> 
> As test command parameters are of type uint16_t, we cannot write longer
> values. We can figure out the ways to overcome this limitation if it
> turns out that it's really needed (i.e. some PTS test cases cannot be
> passed).
> ---
>  android/gatt.c    | 19 +++++++++++++------
>  android/hal-msg.h |  1 +
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 9b51ab1..5919377 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -3442,9 +3442,10 @@ failed:
>  				HAL_OP_GATT_CLIENT_SET_ADV_DATA, status);
>  }
>  
> -static uint8_t handle_test_command_read(bdaddr_t *bdaddr, bt_uuid_t *uuid,
> -					uint16_t read_type, uint16_t u2,
> -					uint16_t u3, uint16_t u4, uint16_t u5)
> +static uint8_t handle_test_command_read_write(bdaddr_t *bdaddr, bt_uuid_t *uuid,
> +						uint16_t op, uint16_t u2,
> +						uint16_t u3, uint16_t u4,
> +						uint16_t u5)
>  {
>  	guint16 length = 0;
>  	struct gatt_device *dev;
> @@ -3459,7 +3460,7 @@ static uint8_t handle_test_command_read(bdaddr_t *bdaddr, bt_uuid_t *uuid,
>  	if (!pdu)
>  		return HAL_STATUS_FAILED;
>  
> -	switch (read_type) {
> +	switch (op) {
>  	case ATT_OP_READ_REQ:
>  		length = enc_read_req(u2, pdu, mtu);
>  		break;
> @@ -3473,8 +3474,13 @@ static uint8_t handle_test_command_read(bdaddr_t *bdaddr, bt_uuid_t *uuid,
>  		length = enc_read_by_grp_req(u2, u3, uuid, pdu, mtu);
>  		break;
>  	case ATT_OP_READ_MULTI_REQ:
> +		return HAL_STATUS_UNSUPPORTED;
> +	case ATT_OP_WRITE_REQ:
> +	case ATT_OP_WRITE_CMD:
> +	case ATT_OP_PREP_WRITE_REQ:
> +	case ATT_OP_EXEC_WRITE_REQ:
>  	default:
> -		error("gatt: Unknown read type");
> +		error("gatt: Unknown operation type");
>  
>  		return HAL_STATUS_UNSUPPORTED;
>  	}
> @@ -3532,7 +3538,8 @@ static void handle_client_test_command(const void *buf, uint16_t len)
>  		status = HAL_STATUS_FAILED;
>  		break;
>  	case GATT_CLIENT_TEST_CMD_READ:
> -		status = handle_test_command_read(&bdaddr, &uuid, cmd->u1,
> +	case GATT_CLIENT_TEST_CMD_WRITE:
> +		status = handle_test_command_read_write(&bdaddr, &uuid, cmd->u1,
>  							cmd->u2, cmd->u3,
>  							cmd->u4, cmd->u5);
>  		break;
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index ae15499..5da62f3 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -752,6 +752,7 @@ struct hal_cmd_gatt_client_set_adv_data {
>  #define GATT_CLIENT_TEST_CMD_DISCONNECT		0x03
>  #define GATT_CLIENT_TEST_CMD_DISCOVER		0x04
>  #define GATT_CLIENT_TEST_CMD_READ		0xe0
> +#define GATT_CLIENT_TEST_CMD_WRITE		0xe1
>  #define GATT_CLIENT_TEST_CMD_PAIRING_CONFIG	0xf0
>  
>  #define HAL_OP_GATT_CLIENT_TEST_COMMAND		0x16
> 

All patches applied. Thanks.

-- 
Best regards, 
Szymon Janc
