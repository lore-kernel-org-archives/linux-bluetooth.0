Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 8/8] tools/btpclient: Add passkey confirm ev and passkey confirm rsp cmd
Date: Tue, 23 Jan 2018 15:03:28 +0100
Message-ID: <2235722.RxNYXpmJdV@ix>
In-Reply-To: <20180119164133.16767-8-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180119164133.16767-1-grzegorz.kolodziejczyk@codecoup.pl> <20180119164133.16767-8-grzegorz.kolodziejczyk@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Friday, 19 January 2018 17:41:33 CET Grzegorz Kolodziejczyk wrote:
> This patch adds passkey confirm command handler and passkey confirm
> event.
> ---
>  tools/btpclient.c | 94
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 94
> insertions(+)
> 
> diff --git a/tools/btpclient.c b/tools/btpclient.c
> index 55e5170a7..780c2a8db 100644
> --- a/tools/btpclient.c
> +++ b/tools/btpclient.c
> @@ -1703,11 +1703,43 @@ static struct l_dbus_message
> *ag_request_confirmation_call(struct l_dbus *dbus, struct l_dbus_message
> *message,
>  						void *user_data)
>  {
> +	struct btp_gap_passkey_confirm_ev ev;
> +	struct btp_device *device;
> +	struct btp_adapter *adapter;
>  	struct l_dbus_message *reply;
> +	const char *path, *str_addr, *str_addr_type;
> +	uint32_t passkey;
> 
>  	reply = l_dbus_message_new_method_return(message);
>  	l_dbus_message_set_arguments(reply, "");
> 
> +	l_dbus_message_get_arguments(message, "ou", &path, &passkey);
> +
> +	device = find_device_by_path(path);
> +
> +	if (!l_dbus_proxy_get_property(device->proxy, "Address", "s", &str_addr)
> +		|| !l_dbus_proxy_get_property(device->proxy, "AddressType", "s",
> +		&str_addr_type)) {
> +		l_info("Cannot get device properties");
> +
> +		return reply;
> +	}
> +
> +	ev.passkey = L_CPU_TO_LE32(passkey);
> +	ev.address_type = strcmp(str_addr_type, "public") ?
> +							BTP_GAP_ADDR_RANDOM :
> +							BTP_GAP_ADDR_PUBLIC;
> +	if (str2ba(str_addr, &ev.address) < 0) {
> +		l_info("Incorrect device address");
> +
> +		return reply;
> +	}
> +
> +	adapter = find_adapter_by_device(device);
> +
> +	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_PASSKEY_CONFIRM,
> +					adapter->index, sizeof(ev), &ev);
> +
>  	return reply;

So ag.pending request should be stored here. And reply here should be returned 
only in case of error.

>  }
> 
> @@ -2082,6 +2114,65 @@ failed:
>  	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
>  }
> 
> +static void passkey_confirm_rsp_reply(struct l_dbus_message *result,
> +								void *user_data)
> +{
> +	struct btp_adapter *adapter = user_data;
> +
> +	if (l_dbus_message_is_error(result)) {
> +		const char *name, *desc;
> +
> +		l_dbus_message_get_error(result, &name, &desc);
> +		l_error("Failed to confirm passkey (%s), %s", name, desc);
> +
> +		btp_send_error(btp, BTP_GAP_SERVICE, adapter->index,
> +								BTP_ERROR_FAIL);
> +		return;
> +	}
> +
> +	l_dbus_message_unref(ag.pending_req);
> +
> +	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_PASSKEY_CONFIRM_RSP,
> +						adapter->index, 0, NULL);
> +}
> +
> +static void btp_gap_confirm_entry_rsp(uint8_t index, const void *param,
> +					uint16_t length, void *user_data)
> +{
> +	const struct btp_gap_passkey_confirm_rsp_cp *cp = param;
> +	struct btp_adapter *adapter = find_adapter_by_index(index);
> +	struct l_dbus_message *reply;
> +	uint8_t status = BTP_ERROR_FAIL;
> +	bool prop;
> +
> +	if (!adapter) {
> +		status = BTP_ERROR_INVALID_INDEX;
> +		goto failed;
> +	}
> +
> +	/* Adapter needs to be powered to be able to confirm passkey */
> +	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
> +						!prop || !ag.pending_req)
> +		goto failed;
> +
> +	if (cp->match) {
> +		reply = l_dbus_message_new_method_return(ag.pending_req);
> +		l_dbus_message_set_arguments(reply, "");
> +	} else {
> +		reply = l_dbus_message_new_error(ag.pending_req,
> +						"org.bluez.Error.Rejected",
> +						"Passkey missmatch");
> +	}
> +
> +	l_dbus_send_with_reply(dbus, ag.pending_req, passkey_confirm_rsp_reply,
> +								adapter, NULL);
> +
> +	return;
> +
> +failed:
> +	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
> +}
> +
>  static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
>  {
>  	struct btp_device_found_ev ev;
> @@ -2215,6 +2306,9 @@ static void register_gap_service(void)
> 
>  	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_PASSKEY_ENTRY_RSP,
>  					btp_gap_passkey_entry_rsp, NULL, NULL);
> +
> +	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_PASSKEY_CONFIRM_RSP,
> +					btp_gap_confirm_entry_rsp, NULL, NULL);
>  }
> 
>  static void btp_core_read_commands(uint8_t index, const void *param,


-- 
pozdrawiam
Szymon Janc


