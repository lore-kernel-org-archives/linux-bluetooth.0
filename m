Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Oct 2013 16:21:40 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Add support for setting adapters name
Message-ID: <20131031142138.GM27517@aemeltch-MOBL1>
References: <1383228038-4306-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383228038-4306-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thu, Oct 31, 2013 at 03:00:38PM +0100, Grzegorz Kolodziejczyk wrote:
> ---
>  android/adapter.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  android/hal-msg.h |  2 ++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/android/adapter.c b/android/adapter.c
> index 15b65e5..5dadc2e 100644
> --- a/android/adapter.c
> +++ b/android/adapter.c
> @@ -129,6 +129,27 @@ static void scan_mode_changed(void)
>  	g_free(ev);
>  }
>  
> +static void adapter_name_changed(const uint8_t *name)
> +{
> +	struct hal_ev_adapter_props_changed *ev;
> +	uint8_t buf[sizeof(*ev) + sizeof(struct hal_property) +
> +							HAL_MAX_NAME_LENGTH];
> +
> +	memset(buf, 0, sizeof(buf));
> +	ev = (void *) buf;
> +
> +	ev->num_props = 1;
> +	ev->status = HAL_STATUS_SUCCESS;
> +	ev->props[0].type = HAL_PROP_ADAPTER_NAME;
> +	ev->props[0].len = HAL_MAX_NAME_LENGTH;

Do we need to pass always HAL_MAX_NAME_LENGTH ?

Best regards 
Andrei Emeltchenko 

> +	memcpy(ev->props->val, name, HAL_MAX_NAME_LENGTH);
> +
> +	DBG("Adapter name changed to: %s", ev->props->val);
> +
> +	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), ev, -1);
> +}
> +
>  static void settings_changed(uint32_t settings)
>  {
>  	uint32_t changed_mask;
> @@ -286,6 +307,37 @@ static bool set_mode(uint16_t opcode, uint8_t mode)
>  	return false;
>  }
>  
> +static void set_adapter_name_complete(uint8_t status, uint16_t length,
> +					const void *param, void *user_data)
> +{
> +	const struct mgmt_cp_set_local_name *rp = param;
> +
> +	if (status != MGMT_STATUS_SUCCESS) {
> +		error("Failed to set name: %s (0x%02x)",
> +						mgmt_errstr(status), status);
> +		return;
> +	}
> +
> +	adapter_name_changed(rp->name);
> +}
> +
> +static bool set_adapter_name(uint8_t *name, uint16_t len)
> +{
> +	struct mgmt_cp_set_local_name cp;
> +
> +	memset(&cp, 0, sizeof(cp));
> +	memcpy(cp.name, name, len);
> +
> +	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_LOCAL_NAME, adapter->index,
> +			sizeof(cp), &cp, set_adapter_name_complete, NULL,
> +								NULL) > 0)
> +		return true;
> +
> +	error("Failed to set name");
> +
> +	return false;
> +}
> +
>  static void read_info_complete(uint8_t status, uint16_t length, const void *param,
>  							void *user_data)
>  {
> @@ -472,6 +524,7 @@ static uint8_t set_property(void *buf, uint16_t len)
>  	case HAL_PROP_ADAPTER_SCAN_MODE:
>  		return set_scan_mode(cmd->val, cmd->len);
>  	case HAL_PROP_ADAPTER_NAME:
> +		return set_adapter_name(cmd->val, cmd->len);
>  	case HAL_PROP_ADAPTER_DISC_TIMEOUT:
>  	default:
>  		DBG("Unhandled property type 0x%x", cmd->type);
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index 80b47d6..506d10c 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -89,6 +89,8 @@ struct hal_cmd_get_adapter_prop {
>  	uint8_t type;
>  } __attribute__((packed));
>  
> +#define HAL_MAX_NAME_LENGTH		249
> +
>  #define HAL_PROP_ADAPTER_NAME			0x01
>  #define HAL_PROP_ADAPTER_ADDR			0x02
>  #define HAL_PROP_ADAPTER_UUIDS			0x03
> -- 
> 1.8.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
