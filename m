Return-Path: <cyrus@holtmann.org>
Message-ID: <532995D5.3030009@linux.intel.com>
Date: Wed, 19 Mar 2014 15:04:21 +0200
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH_v6] android/hal-health: Add HDP .register_application
 method
References: <1395151108-28229-1-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1395151108-28229-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


ping.

On 03/18/2014 03:58 PM, Ravi kumar Veeramally wrote:
> ---
> v6: Fixed Szymon's comment.
> v5: Fixed Johan's comment.
> v4: Added utility to copy null termiated strings to hal_string.
> ---
>   android/hal-health.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 83 insertions(+), 1 deletion(-)
>
> diff --git a/android/hal-health.c b/android/hal-health.c
> index e6fe65a..ac5977f 100644
> --- a/android/hal-health.c
> +++ b/android/hal-health.c
> @@ -28,6 +28,31 @@
>   
>   static const bthl_callbacks_t *cbacks = NULL;
>   
> +static bool string_to_hal(const char *str, struct hal_string *hstr,
> +								ssize_t *len)
> +{
> +	uint8_t str_len;
> +
> +	if (!hstr || !len)
> +		return false;
> +
> +	if (!str) {
> +		hstr->len = 0;
> +		return true;
> +	}
> +
> +	str_len = strlen(str) + 1;
> +
> +	if ((*len + str_len) > IPC_MTU)
> +		return false;
> +
> +	hstr->len = str_len;
> +	*len += hstr->len;
> +	memcpy(hstr->data, str, hstr->len);
> +
> +	return true;
> +}
> +
>   static bool interface_ready(void)
>   {
>   	return cbacks != NULL;
> @@ -38,6 +63,63 @@ static bool interface_ready(void)
>   static const struct hal_ipc_handler ev_handlers[] = {
>   };
>   
> +static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
> +{
> +	char buf[IPC_MTU];
> +	struct hal_cmd_health_reg_app *cmd = (void *) buf;
> +	struct hal_rsp_health_reg_app rsp;
> +	size_t len = sizeof(rsp);
> +	bt_status_t status;
> +	ssize_t cmd_len;
> +	uint8_t i;
> +
> +	DBG("");
> +
> +	if (!interface_ready())
> +		return BT_STATUS_NOT_READY;
> +
> +	if (!reg || !app_id)
> +		return BT_STATUS_PARM_INVALID;
> +
> +	cmd_len = sizeof(*cmd);
> +
> +	if (!string_to_hal(reg->application_name, &cmd->app_name, &cmd_len))
> +		return BT_STATUS_PARM_INVALID;
> +
> +	if (!string_to_hal(reg->provider_name, &cmd->provider_name, &cmd_len))
> +		return BT_STATUS_PARM_INVALID;
> +
> +	if (!string_to_hal(reg->srv_name, &cmd->service_name, &cmd_len))
> +		return BT_STATUS_PARM_INVALID;
> +
> +	if (!string_to_hal(reg->srv_desp, &cmd->service_descr, &cmd_len))
> +		return BT_STATUS_PARM_INVALID;
> +
> +	cmd->num_of_mdep = reg->number_of_mdeps;
> +
> +	for (i = 0; i < reg->number_of_mdeps; i++) {
> +		cmd_len += sizeof(cmd->mdep_cfg);
> +		if (cmd_len > IPC_MTU)
> +			return BT_STATUS_PARM_INVALID;
> +
> +		cmd->mdep_cfg[i].role = reg->mdep_cfg[i].mdep_role;
> +		cmd->mdep_cfg[i].data_type = reg->mdep_cfg[i].data_type;
> +		cmd->mdep_cfg[i].channel_type = reg->mdep_cfg[i].channel_type;
> +
> +		if (!string_to_hal(reg->mdep_cfg[i].mdep_description,
> +					&cmd->mdep_cfg[i].descr, &cmd_len))
> +			return BT_STATUS_PARM_INVALID;
> +	}
> +
> +	status = hal_ipc_cmd(HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_REG_APP,
> +						cmd_len, cmd, &len, &rsp, NULL);
> +
> +	if (status == HAL_STATUS_SUCCESS)
> +		*app_id = rsp.app_id;
> +
> +	return status;
> +}
> +
>   static bt_status_t unregister_application(int app_id)
>   {
>   	struct hal_cmd_health_unreg_app cmd;
> @@ -149,7 +231,7 @@ static void cleanup(void)
>   static bthl_interface_t health_if = {
>   	.size = sizeof(health_if),
>   	.init = init,
> -	.register_application = NULL,
> +	.register_application = register_application,
>   	.unregister_application = unregister_application,
>   	.connect_channel = connect_channel,
>   	.destroy_channel = destroy_channel,

