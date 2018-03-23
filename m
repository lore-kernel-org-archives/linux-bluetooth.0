Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ] client: Fix stay on error handling in
 non-interactive
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <616a6ea1-2cc0-1361-008a-442d12f9d8fd@jp.fujitsu.com>
Message-ID: <3f5c769d-094a-3dca-0575-25bb7d977cee@jp.fujitsu.com>
Date: Fri, 23 Mar 2018 16:04:57 +0900
MIME-Version: 1.0
In-Reply-To: <616a6ea1-2cc0-1361-008a-442d12f9d8fd@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 03/19/2018 05:40 PM, ERAMOTO Masaya wrote:
> Returns the FAILURE status since there is no meaning of stay in
> non-interactive mode when executing some commands with an invalid
> argument or with no controller. Also returns with the SUCCESS status
> when getting a scan filtering value or disconnecting a non-default
> device.
> ---
>  client/advertising.c |  2 +-
>  client/main.c        | 63 ++++++++++++++++++++++++++--------------------------
>  2 files changed, 32 insertions(+), 33 deletions(-)
> 
> diff --git a/client/advertising.c b/client/advertising.c
> index 4517f8f86..152a22a56 100644
> --- a/client/advertising.c
> +++ b/client/advertising.c
> @@ -644,7 +644,7 @@ void ad_advertise_tx_power(DBusConnection *conn, dbus_bool_t *value)
>  	}
>  
>  	if (ad.tx_power == *value)
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  
>  	ad.tx_power = *value;
>  
> diff --git a/client/main.c b/client/main.c
> index a83010b48..b299ae166 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -840,7 +840,7 @@ static void cmd_show(int argc, char *argv[])
>  
>  	if (argc < 2 || !strlen(argv[1])) {
>  		if (check_default_ctrl() == FALSE)
> -			return;
> +			return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  
>  		proxy = default_ctrl->proxy;
>  	} else {
> @@ -848,7 +848,7 @@ static void cmd_show(int argc, char *argv[])
>  		if (!adapter) {
>  			bt_shell_printf("Controller %s not available\n",
>  								argv[1]);
> -			return;
> +			return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  		}
>  		proxy = adapter->proxy;
>  	}
> @@ -960,7 +960,7 @@ static void cmd_system_alias(int argc, char *argv[])
>  	char *name;
>  
>  	if (check_default_ctrl() == FALSE)
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  
>  	name = g_strdup(argv[1]);
>  
> @@ -977,7 +977,7 @@ static void cmd_reset_alias(int argc, char *argv[])
>  	char *name;
>  
>  	if (check_default_ctrl() == FALSE)
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  
>  	name = g_strdup("");
>  
> @@ -995,10 +995,10 @@ static void cmd_power(int argc, char *argv[])
>  	char *str;
>  
>  	if (!parse_argument(argc, argv, NULL, NULL, &powered, NULL))
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  
>  	if (check_default_ctrl() == FALSE)
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  
>  	str = g_strdup_printf("power %s", powered == TRUE ? "on" : "off");
>  
> @@ -1016,10 +1016,10 @@ static void cmd_pairable(int argc, char *argv[])
>  	char *str;
>  
>  	if (!parse_argument(argc, argv, NULL, NULL, &pairable, NULL))
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  
>  	if (check_default_ctrl() == FALSE)
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  
>  	str = g_strdup_printf("pairable %s", pairable == TRUE ? "on" : "off");
>  
> @@ -1039,10 +1039,10 @@ static void cmd_discoverable(int argc, char *argv[])
>  	char *str;
>  
>  	if (!parse_argument(argc, argv, NULL, NULL, &discoverable, NULL))
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  
>  	if (check_default_ctrl() == FALSE)
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  
>  	str = g_strdup_printf("discoverable %s",
>  				discoverable == TRUE ? "on" : "off");
> @@ -1202,10 +1202,10 @@ static void cmd_scan(int argc, char *argv[])
>  	const char *method;
>  
>  	if (!parse_argument(argc, argv, NULL, NULL, &enable, NULL))
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  
>  	if (check_default_ctrl() == FALSE)
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  
>  	if (enable == TRUE) {
>  		set_discovery_filter();
> @@ -1230,7 +1230,7 @@ static void cmd_scan_filter_uuids(int argc, char *argv[])
>  		for (uuid = filter.uuids; uuid && *uuid; uuid++)
>  			print_uuid(*uuid);
>  
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  	}
>  
>  	g_strfreev(filter.uuids);
> @@ -1257,7 +1257,7 @@ static void cmd_scan_filter_rssi(int argc, char *argv[])
>  	if (argc < 2 || !strlen(argv[1])) {
>  		if (filter.rssi != DISTANCE_VAL_INVALID)
>  			bt_shell_printf("RSSI: %d\n", filter.rssi);
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  	}
>  
>  	filter.pathloss = DISTANCE_VAL_INVALID;
> @@ -1272,7 +1272,7 @@ static void cmd_scan_filter_pathloss(int argc, char *argv[])
>  		if (filter.pathloss != DISTANCE_VAL_INVALID)
>  			bt_shell_printf("Pathloss: %d\n",
>  						filter.pathloss);
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  	}
>  
>  	filter.rssi = DISTANCE_VAL_INVALID;
> @@ -1287,7 +1287,7 @@ static void cmd_scan_filter_transport(int argc, char *argv[])
>  		if (filter.transport)
>  			bt_shell_printf("Transport: %s\n",
>  					filter.transport);
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  	}
>  
>  	g_free(filter.transport);
> @@ -1301,7 +1301,7 @@ static void cmd_scan_filter_duplicate_data(int argc, char *argv[])
>  	if (argc < 2 || !strlen(argv[1])) {
>  		bt_shell_printf("DuplicateData: %s\n",
>  				filter.duplicate ? "on" : "off");
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  	}
>  
>  	if (!strcmp(argv[1], "on"))
> @@ -1310,7 +1310,7 @@ static void cmd_scan_filter_duplicate_data(int argc, char *argv[])
>  		filter.duplicate = false;
>  	else {
>  		bt_shell_printf("Invalid option: %s\n", argv[1]);
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  	}
>  
>  	filter.set = false;
> @@ -1412,12 +1412,12 @@ static void cmd_scan_filter_clear(int argc, char *argv[])
>  		all = true;
>  
>  	if (!data_clear(filter_clear, all ? "all" : argv[1]))
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  
>  	filter.set = false;
>  
>  	if (check_default_ctrl() == FALSE)
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  
>  	set_discovery_filter();
>  }
> @@ -1667,7 +1667,7 @@ static void cmd_remove(int argc, char *argv[])
>  	GDBusProxy *proxy;
>  
>  	if (check_default_ctrl() == FALSE)
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  
>  	if (strcmp(argv[1], "*") == 0) {
>  		GList *list;
> @@ -1684,7 +1684,7 @@ static void cmd_remove(int argc, char *argv[])
>  	proxy = find_proxy_by_address(default_ctrl->devices, argv[1]);
>  	if (!proxy) {
>  		bt_shell_printf("Device %s not available\n", argv[1]);
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  	}
>  
>  	remove_device(proxy);
> @@ -1746,10 +1746,8 @@ static void disconn_reply(DBusMessage *message, void *user_data)
>  
>  	bt_shell_printf("Successful disconnected\n");
>  
> -	if (proxy != default_dev)
> -		return;
> -
> -	set_default_device(NULL, NULL);
> +	if (proxy == default_dev)
> +		set_default_device(NULL, NULL);
>  
>  	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
> @@ -1799,7 +1797,7 @@ static void cmd_set_alias(int argc, char *argv[])
>  
>  	if (!default_dev) {
>  		bt_shell_printf("No device connected\n");
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  	}
>  
>  	name = g_strdup(argv[1]);
> @@ -1820,7 +1818,7 @@ static void cmd_select_attribute(int argc, char *argv[])
>  
>  	if (!default_dev) {
>  		bt_shell_printf("No device connected\n");
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  	}
>  
>  	proxy = gatt_select_attribute(default_attr, argv[1]);
> @@ -1964,7 +1962,7 @@ static void cmd_notify(int argc, char *argv[])
>  	dbus_bool_t enable;
>  
>  	if (!parse_argument(argc, argv, NULL, NULL, &enable, NULL))
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  
>  	if (!default_attr) {
>  		bt_shell_printf("No attribute selected\n");
> @@ -2145,7 +2143,7 @@ static void cmd_advertise(int argc, char *argv[])
>  
>  	if (!parse_argument(argc, argv, ad_arguments, "type",
>  					&enable, &type))
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  
>  	if (!default_ctrl || !default_ctrl->ad_proxy) {
>  		bt_shell_printf("LEAdvertisingManager not found\n");
> @@ -2188,7 +2186,7 @@ static void cmd_advertise_tx_power(int argc, char *argv[])
>  	}
>  
>  	if (!parse_argument(argc, argv, NULL, NULL, &powered, NULL))
> -		return;
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  
>  	ad_advertise_tx_power(dbus_conn, &powered);
>  }
> @@ -2345,7 +2343,8 @@ static void cmd_ad_clear(int argc, char *argv[])
>  	if (argc < 2 || !strlen(argv[1]))
>  		all = true;
>  
> -	data_clear(ad_clear, all ? "all" : argv[1]);
> +	if(!data_clear(ad_clear, all ? "all" : argv[1]))
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  }
>  
>  static const struct bt_shell_menu advertise_menu = {
> 

Please help to have a review.


Regards,
Eramoto

