Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] android/hal-bluetooth: Implement get_connection_state
Date: Mon, 24 Nov 2014 15:36:13 +0100
Message-ID: <3267989.RveeH67Vvp@uw000953>
In-Reply-To: <1416568603-3666-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416568603-3666-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Friday 21 of November 2014 12:16:38 Marcin Kraglak wrote:
> ---
>  android/bluetooth.c     | 24 ++++++++++++++++++++++++
>  android/hal-bluetooth.c | 19 +++++++++++++++++--
>  android/hal-msg.h       |  9 +++++++++
>  3 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index da549d7..947a83c 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -5134,6 +5134,27 @@ static void handle_le_test_mode_cmd(const void *buf, uint16_t len)
>  							HAL_STATUS_FAILED);
>  }
>  
> +static void handle_get_connection_state(const void *buf, uint16_t len)
> +{
> +	const struct hal_cmd_get_connection_state *cmd = buf;
> +	struct hal_rsp_get_connection_state rsp;
> +	char address[18];
> +	bdaddr_t bdaddr;
> +
> +	android2bdaddr(cmd->bdaddr, &bdaddr);
> +	ba2str(&bdaddr, address);
> +
> +	DBG("%s", address);
> +
> +	/* TODO */
> +
> +	rsp.connection_state = 0;
> +
> +	ipc_send_rsp_full(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
> +				HAL_OP_GET_CONNECTION_STATE, sizeof(rsp), &rsp,
> +				-1);
> +}
> +
>  static const struct ipc_handler cmd_handlers[] = {
>  	/* HAL_OP_ENABLE */
>  	{ handle_enable_cmd, false, 0 },
> @@ -5184,6 +5205,9 @@ static const struct ipc_handler cmd_handlers[] = {
>  					sizeof(struct hal_cmd_dut_mode_send) },
>  	/* HAL_OP_LE_TEST_MODE */
>  	{ handle_le_test_mode_cmd, true, sizeof(struct hal_cmd_le_test_mode) },
> +	/* HAL_OP_GET_CONNECTION_STATE */
> +	{ handle_get_connection_state, false,
> +				sizeof(struct hal_cmd_get_connection_state) },
>  };
>  
>  bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
> diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
> index 68811df..defaef1 100644
> --- a/android/hal-bluetooth.c
> +++ b/android/hal-bluetooth.c
> @@ -957,11 +957,26 @@ static int config_hci_snoop_log(uint8_t enable)
>  #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
>  static int get_connection_state(const bt_bdaddr_t *bd_addr)
>  {
> +	struct hal_cmd_get_connection_state cmd;
> +	struct hal_rsp_get_connection_state rsp;
> +	size_t rsp_len = sizeof(rsp);
> +	bt_status_t status;
> +
>  	DBG("bdaddr: %s", bdaddr2str(bd_addr));
>  
> -	/* TODO: implement */
> +	if (!interface_ready())
> +		return 0;
>  
> -	return BT_STATUS_UNSUPPORTED;
> +	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
> +
> +	status = hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_GET_CONNECTION_STATE, sizeof(cmd), &cmd,
> +			&rsp_len, &rsp, NULL);
> +
> +	if (status != BT_STATUS_SUCCESS)
> +		return 0;
> +
> +	return rsp.connection_state;
>  }
>  
>  static int set_os_callouts(bt_os_callouts_t *callouts)
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index ca512d4..6a5a81c 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -252,6 +252,15 @@ struct hal_cmd_le_test_mode {
>  	uint8_t  data[0];
>  } __attribute__((packed));
>  
> +#define HAL_OP_GET_CONNECTION_STATE	0x15
> +struct hal_cmd_get_connection_state {
> +	uint8_t  bdaddr[6];
> +} __attribute__((packed));
> +
> +struct hal_rsp_get_connection_state {
> +	int32_t connection_state;
> +} __attribute__((packed));
> +
>  /* Bluetooth Socket HAL api */
>  
>  #define HAL_SOCK_RFCOMM		0x01

Patches 1 and 3-6 are now applied (after fixing build issues on Android KK).
Thanks.

But please send follow-up patch that updates android/hal-ipc-api.txt.
 

-- 
Best regards, 
Szymon Janc
