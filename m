Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 6/8] tools/btpclient: Add pair, unpair commands
Date: Tue, 23 Jan 2018 14:53:35 +0100
Message-ID: <1641665.1XMgaMqVk0@ix>
In-Reply-To: <20180119164133.16767-6-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180119164133.16767-1-grzegorz.kolodziejczyk@codecoup.pl> <20180119164133.16767-6-grzegorz.kolodziejczyk@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Friday, 19 January 2018 17:41:31 CET Grzegorz Kolodziejczyk wrote:
> This patch adds pair and unpair commands for btp client.
> ---
>  tools/btpclient.c | 124
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 124
> insertions(+)
> 
> diff --git a/tools/btpclient.c b/tools/btpclient.c
> index 53c0d4c05..9d44fba41 100644
> --- a/tools/btpclient.c
> +++ b/tools/btpclient.c
> @@ -304,6 +304,8 @@ static void btp_gap_read_commands(uint8_t index, const
> void *param, commands |= (1 << BTP_OP_GAP_CONNECT);
>  	commands |= (1 << BTP_OP_GAP_DISCONNECT);
>  	commands |= (1 << BTP_OP_GAP_SET_IO_CAPA);
> +	commands |= (1 << BTP_OP_GAP_PAIR);
> +	commands |= (1 << BTP_OP_GAP_UNPAIR);
> 
>  	commands = L_CPU_TO_LE16(commands);
> 
> @@ -1875,6 +1877,122 @@ failed:
>  	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
>  }
> 
> +static void pair_reply(struct l_dbus_proxy *proxy,
> +				struct l_dbus_message *result, void *user_data)
> +{
> +	uint8_t adapter_index = L_PTR_TO_UINT(user_data);
> +	struct btp_adapter *adapter = find_adapter_by_index(adapter_index);
> +
> +	if (!adapter)
> +		return;
> +
> +	if (l_dbus_message_is_error(result)) {
> +		const char *name, *desc;
> +
> +		l_dbus_message_get_error(result, &name, &desc);
> +		l_error("Failed to pair (%s), %s", name, desc);
> +
> +		return;
> +	}
> +}
> +
> +static void btp_gap_pair(uint8_t index, const void *param, uint16_t length,
> +								void *user_data)
> +{
> +	struct btp_adapter *adapter = find_adapter_by_index(index);
> +	const struct btp_gap_pair_cp *cp = param;
> +	uint8_t status = BTP_ERROR_FAIL;
> +	struct btp_device *device;
> +	bool prop;
> +
> +	if (!adapter) {
> +		status = BTP_ERROR_INVALID_INDEX;
> +		goto failed;
> +	}
> +
> +	/* Adapter needs to be powered to be able to pair */
> +	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
> +									!prop)
> +		goto failed;
> +
> +	device = find_device_by_address(adapter, &cp->address,
> +							cp->address_type);
> +
> +	if (!device)
> +		goto failed;
> +
> +	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_PAIR, adapter->index, 0,

Please comment here that on BTP this command is suppose to initiate pairing 
only and successful pairing result is reported via event later on.

> +									NULL);
> +
> +	l_dbus_proxy_method_call(device->proxy, "Pair", NULL, pair_reply,
> +					L_UINT_TO_PTR(adapter->index), NULL);
> +
> +	return;
> +
> +failed:
> +	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
> +}
> +
> +static void unpair_reply(struct l_dbus_proxy *proxy,
> +				struct l_dbus_message *result, void *user_data)
> +{
> +	uint8_t adapter_index = L_PTR_TO_UINT(user_data);
> +	struct btp_adapter *adapter = find_adapter_by_index(adapter_index);
> +
> +	if (!adapter) {
> +		btp_send_error(btp, BTP_GAP_SERVICE, BTP_INDEX_NON_CONTROLLER,
> +								BTP_ERROR_FAIL);
> +		return;
> +	}
> +
> +	if (l_dbus_message_is_error(result)) {
> +		const char *name, *desc;
> +
> +		l_dbus_message_get_error(result, &name, &desc);
> +		l_error("Failed to unpair (%s), %s", name, desc);
> +
> +		btp_send_error(btp, BTP_GAP_SERVICE, adapter_index,
> +								BTP_ERROR_FAIL);
> +		return;
> +	}
> +
> +	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_UNPAIR, adapter_index, 0, NULL);
> +}
> +
> +static void btp_gap_unpair(uint8_t index, const void *param, uint16_t
> length, +								void *user_data)
> +{
> +	struct btp_adapter *adapter = find_adapter_by_index(index);
> +	const struct btp_gap_pair_cp *cp = param;
> +	uint8_t status = BTP_ERROR_FAIL;
> +	struct btp_device *device;
> +	bool prop;
> +
> +	if (!adapter) {
> +		status = BTP_ERROR_INVALID_INDEX;
> +		goto failed;
> +	}
> +
> +	/* Adapter needs to be powered to be able to unpair */
> +	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
> +									!prop)
> +		goto failed;
> +
> +	device = find_device_by_address(adapter, &cp->address,
> +							cp->address_type);
> +
> +	if (!device)
> +		goto failed;
> +
> +	l_dbus_proxy_method_call(device->proxy, "Unpair", NULL, unpair_reply,
> +					L_UINT_TO_PTR(adapter->index), NULL);

There is no "Unpair" command in Device1 interface :)  Use RemoveDevice from 
Adapter1.

> +	return;
> +
> +failed:
> +	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
> +}
> +
>  static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
>  {
>  	struct btp_device_found_ev ev;
> @@ -1999,6 +2117,12 @@ static void register_gap_service(void)
> 
>  	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_IO_CAPA,
>  				btp_gap_set_io_capabilities, NULL, NULL);
> +
> +	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_PAIR, btp_gap_pair, NULL,
> +									NULL);
> +
> +	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_UNPAIR, btp_gap_unpair,
> +								NULL, NULL);
>  }
> 
>  static void btp_core_read_commands(uint8_t index, const void *param,


-- 
pozdrawiam
Szymon Janc


