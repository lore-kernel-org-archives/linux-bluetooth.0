Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/hal-bluetooth: Use fixed size buffers for commands
Date: Fri, 21 Feb 2014 11:44:47 +0100
Message-ID: <2279290.TUm28LXNik@uw000953>
In-Reply-To: <1392842978-29373-1-git-send-email-szymon.janc@gmail.com>
References: <1392842978-29373-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 19 of February 2014 21:49:37 Szymon Janc wrote:
> This make code follow same conventions for all commands.
> ---
>  android/hal-bluetooth.c | 44 +++++++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
> index 65432a8..a01229a 100644
> --- a/android/hal-bluetooth.c
> +++ b/android/hal-bluetooth.c
> @@ -525,8 +525,9 @@ static int get_adapter_property(bt_property_type_t type)
>  
>  static int set_adapter_property(const bt_property_t *property)
>  {
> -	char buf[sizeof(struct hal_cmd_set_adapter_prop) + property->len];
> +	char buf[BLUEZ_HAL_MTU];
>  	struct hal_cmd_set_adapter_prop *cmd = (void *) buf;
> +	size_t len;
>  
>  	DBG("prop: %s", btproperty2str(property));
>  
> @@ -535,8 +536,10 @@ static int set_adapter_property(const bt_property_t *property)
>  
>  	adapter_prop_from_hal(property, &cmd->type, &cmd->len, cmd->val);
>  
> +	len = sizeof(*cmd) + cmd->len;
> +
>  	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_SET_ADAPTER_PROP,
> -				sizeof(*cmd) + cmd->len, cmd, 0, NULL, NULL);
> +						len, cmd, 0, NULL, NULL);
>  }
>  
>  static int get_remote_device_properties(bt_bdaddr_t *remote_addr)
> @@ -579,8 +582,9 @@ static int get_remote_device_property(bt_bdaddr_t *remote_addr,
>  static int set_remote_device_property(bt_bdaddr_t *remote_addr,
>  						const bt_property_t *property)
>  {
> -	struct hal_cmd_set_remote_device_prop *cmd;
> -	uint8_t buf[sizeof(*cmd) + property->len];
> +	char buf[BLUEZ_HAL_MTU];
> +	struct hal_cmd_set_remote_device_prop *cmd = (void *) buf;
> +	size_t len;
>  
>  	DBG("bdaddr: %s prop: %s", bdaddr2str(remote_addr),
>  				bt_property_type_t2str(property->type));
> @@ -588,8 +592,6 @@ static int set_remote_device_property(bt_bdaddr_t *remote_addr,
>  	if (!interface_ready())
>  		return BT_STATUS_NOT_READY;
>  
> -	cmd = (void *) buf;
> -
>  	memcpy(cmd->bdaddr, remote_addr, sizeof(cmd->bdaddr));
>  
>  	/* type match IPC type */
> @@ -597,9 +599,11 @@ static int set_remote_device_property(bt_bdaddr_t *remote_addr,
>  	cmd->len = property->len;
>  	memcpy(cmd->val, property->val, property->len);
>  
> +	len = sizeof(*cmd) + cmd->len;
> +
>  	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH,
>  					HAL_OP_SET_REMOTE_DEVICE_PROP,
> -					sizeof(buf), cmd, 0, NULL, NULL);
> +					len, cmd, 0, NULL, NULL);
>  }
>  
>  static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
> @@ -786,40 +790,46 @@ static int dut_mode_configure(uint8_t enable)
>  					sizeof(cmd), &cmd, 0, NULL, NULL);
>  }
>  
> -static int dut_mode_send(uint16_t opcode, uint8_t *buf, uint8_t len)
> +static int dut_mode_send(uint16_t opcode, uint8_t *buf, uint8_t buf_len)
>  {
> -	uint8_t cmd_buf[sizeof(struct hal_cmd_dut_mode_send) + len];
> +	char cmd_buf[BLUEZ_HAL_MTU];
>  	struct hal_cmd_dut_mode_send *cmd = (void *) cmd_buf;
> +	size_t len;
>  
> -	DBG("opcode %u len %u", opcode, len);
> +	DBG("opcode %u len %u", opcode, buf_len);
>  
>  	if (!interface_ready())
>  		return BT_STATUS_NOT_READY;
>  
>  	cmd->opcode = opcode;
> -	cmd->len = len;
> +	cmd->len = buf_len;
>  	memcpy(cmd->data, buf, cmd->len);
>  
> +	len = sizeof(*cmd) + cmd->len;
> +
>  	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DUT_MODE_SEND,
> -					sizeof(cmd_buf), cmd, 0, NULL, NULL);
> +						len, cmd, 0, NULL, NULL);
>  }
>  
> -static int le_test_mode(uint16_t opcode, uint8_t *buf, uint8_t len)
> +static int le_test_mode(uint16_t opcode, uint8_t *buf, uint8_t buf_len)
>  {
> -	uint8_t cmd_buf[sizeof(struct hal_cmd_le_test_mode) + len];
> +	char cmd_buf[BLUEZ_HAL_MTU];
>  	struct hal_cmd_le_test_mode *cmd = (void *) cmd_buf;
> +	size_t len;
>  
> -	DBG("opcode %u len %u", opcode, len);
> +	DBG("opcode %u len %u", opcode, buf_len);
>  
>  	if (!interface_ready())
>  		return BT_STATUS_NOT_READY;
>  
>  	cmd->opcode = opcode;
> -	cmd->len = len;
> +	cmd->len = buf_len;
>  	memcpy(cmd->data, buf, cmd->len);
>  
> +	len = sizeof(*cmd) + cmd->len;
> +
>  	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_LE_TEST_MODE,
> -					sizeof(cmd_buf), cmd, 0, NULL, NULL);
> +						len, cmd, 0, NULL, NULL);
>  }
>  
>  static int config_hci_snoop_log(uint8_t enable)
> 

Both patches are now upstream.

-- 
Best regards, 
Szymon Janc
