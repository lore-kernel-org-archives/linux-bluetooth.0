Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH v2 10/11] client: Group discovery filter variables into a
 struct
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20171214120300.20018-1-luiz.dentz@gmail.com>
 <20171214120300.20018-10-luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <8c2174a8-cccd-0b8c-4579-b1298782c794@jp.fujitsu.com>
Date: Fri, 15 Dec 2017 11:07:34 +0900
MIME-Version: 1.0
In-Reply-To: <20171214120300.20018-10-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 12/14/2017 09:02 PM, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This should be easier to read and maintain.
> ---
>  client/main.c | 89 +++++++++++++++++++++++++++++++----------------------------
>  1 file changed, 47 insertions(+), 42 deletions(-)
> 
> diff --git a/client/main.c b/client/main.c
> index 04937bc4b..3fd2c96cc 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -1267,24 +1267,29 @@ static void set_discovery_filter_reply(DBusMessage *message, void *user_data)
>  	bt_shell_printf("SetDiscoveryFilter success\n");
>  }
>  
> -static gint filtered_scan_rssi = DISTANCE_VAL_INVALID;
> -static gint filtered_scan_pathloss = DISTANCE_VAL_INVALID;
> -static char **filtered_scan_uuids;
> -static size_t filtered_scan_uuids_len;
> -static char *filtered_scan_transport;
> -static bool filtered_scan_duplicate_data;
> +static struct disc_filter {
> +	int16_t rssi;
> +	int16_t pathloss;
> +	char **uuids;
> +	size_t uuids_len;
> +	char *transport;
> +	bool duplicate;
> +} filter = {
> +	.rssi = DISTANCE_VAL_INVALID,
> +	.pathloss = DISTANCE_VAL_INVALID,
> +};

It is better to use the set_discovery_filter_args struct since the filter
variable is copied to its struct variable when calling SetDiscoveryFilter.


>  
>  static void cmd_set_scan_filter_commit(void)
>  {
>  	struct set_discovery_filter_args args;
>  
>  	args.uuids = NULL;
> -	args.pathloss = filtered_scan_pathloss;
> -	args.rssi = filtered_scan_rssi;
> -	args.transport = filtered_scan_transport;
> -	args.uuids = filtered_scan_uuids;
> -	args.uuids_len = filtered_scan_uuids_len;
> -	args.duplicate = filtered_scan_duplicate_data;
> +	args.pathloss = filter.pathloss;
> +	args.rssi = filter.rssi;
> +	args.transport = filter.transport;
> +	args.uuids = filter.uuids;
> +	args.uuids_len = filter.uuids_len;
> +	args.duplicate = filter.duplicate;
>  

It may be better to pass the filter variable directly to the method instead
to copying to the args variable.


Regards,
Eramoto

>  	if (check_default_ctrl() == FALSE)
>  		return;
> @@ -1302,26 +1307,26 @@ static void cmd_scan_filter_uuids(int argc, char *argv[])
>  	if (argc < 2 || !strlen(argv[1])) {
>  		char **uuid;
>  
> -		for (uuid = filtered_scan_uuids; uuid && *uuid; uuid++)
> +		for (uuid = filter.uuids; uuid && *uuid; uuid++)
>  			print_uuid(*uuid);
>  
>  		return;
>  	}
>  
> -	g_strfreev(filtered_scan_uuids);
> -	filtered_scan_uuids = NULL;
> -	filtered_scan_uuids_len = 0;
> +	g_strfreev(filter.uuids);
> +	filter.uuids = NULL;
> +	filter.uuids_len = 0;
>  
>  	if (!strcmp(argv[1], "all"))
>  		goto commit;
>  
> -	filtered_scan_uuids = g_strdupv(&argv[1]);
> -	if (!filtered_scan_uuids) {
> +	filter.uuids = g_strdupv(&argv[1]);
> +	if (!filter.uuids) {
>  		bt_shell_printf("Failed to parse input\n");
>  		return;
>  	}
>  
> -	filtered_scan_uuids_len = g_strv_length(filtered_scan_uuids);
> +	filter.uuids_len = g_strv_length(filter.uuids);
>  
>  commit:
>  	cmd_set_scan_filter_commit();
> @@ -1330,13 +1335,13 @@ commit:
>  static void cmd_scan_filter_rssi(int argc, char *argv[])
>  {
>  	if (argc < 2 || !strlen(argv[1])) {
> -		if (filtered_scan_rssi != DISTANCE_VAL_INVALID)
> -			bt_shell_printf("RSSI: %d\n", filtered_scan_rssi);
> +		if (filter.rssi != DISTANCE_VAL_INVALID)
> +			bt_shell_printf("RSSI: %d\n", filter.rssi);
>  		return;
>  	}
>  
> -	filtered_scan_pathloss = DISTANCE_VAL_INVALID;
> -	filtered_scan_rssi = atoi(argv[1]);
> +	filter.pathloss = DISTANCE_VAL_INVALID;
> +	filter.rssi = atoi(argv[1]);
>  
>  	cmd_set_scan_filter_commit();
>  }
> @@ -1344,14 +1349,14 @@ static void cmd_scan_filter_rssi(int argc, char *argv[])
>  static void cmd_scan_filter_pathloss(int argc, char *argv[])
>  {
>  	if (argc < 2 || !strlen(argv[1])) {
> -		if (filtered_scan_pathloss != DISTANCE_VAL_INVALID)
> +		if (filter.pathloss != DISTANCE_VAL_INVALID)
>  			bt_shell_printf("Pathloss: %d\n",
> -						filtered_scan_pathloss);
> +						filter.pathloss);
>  		return;
>  	}
>  
> -	filtered_scan_rssi = DISTANCE_VAL_INVALID;
> -	filtered_scan_pathloss = atoi(argv[1]);
> +	filter.rssi = DISTANCE_VAL_INVALID;
> +	filter.pathloss = atoi(argv[1]);
>  
>  	cmd_set_scan_filter_commit();
>  }
> @@ -1359,14 +1364,14 @@ static void cmd_scan_filter_pathloss(int argc, char *argv[])
>  static void cmd_scan_filter_transport(int argc, char *argv[])
>  {
>  	if (argc < 2 || !strlen(argv[1])) {
> -		if (filtered_scan_transport)
> +		if (filter.transport)
>  			bt_shell_printf("Transport: %s\n",
> -					filtered_scan_transport);
> +					filter.transport);
>  		return;
>  	}
>  
> -	g_free(filtered_scan_transport);
> -	filtered_scan_transport = g_strdup(argv[1]);
> +	g_free(filter.transport);
> +	filter.transport = g_strdup(argv[1]);
>  
>  	cmd_set_scan_filter_commit();
>  }
> @@ -1375,14 +1380,14 @@ static void cmd_scan_filter_duplicate_data(int argc, char *argv[])
>  {
>  	if (argc < 2 || !strlen(argv[1])) {
>  		bt_shell_printf("DuplicateData: %s\n",
> -				filtered_scan_duplicate_data ? "on" : "off");
> +				filter.duplicate ? "on" : "off");
>  		return;
>  	}
>  
>  	if (!strcmp(argv[1], "on"))
> -		filtered_scan_duplicate_data = true;
> +		filter.duplicate = true;
>  	else if (!strcmp(argv[1], "off"))
> -		filtered_scan_duplicate_data = false;
> +		filter.duplicate = false;
>  	else {
>  		bt_shell_printf("Invalid option: %s\n", argv[1]);
>  		return;
> @@ -1407,14 +1412,14 @@ static void clear_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
>  static void cmd_scan_filter_clear(int argc, char *argv[])
>  {
>  	/* set default values for all options */
> -	filtered_scan_rssi = DISTANCE_VAL_INVALID;
> -	filtered_scan_pathloss = DISTANCE_VAL_INVALID;
> -	g_strfreev(filtered_scan_uuids);
> -	filtered_scan_uuids = NULL;
> -	filtered_scan_uuids_len = 0;
> -	g_free(filtered_scan_transport);
> -	filtered_scan_transport = NULL;
> -	filtered_scan_duplicate_data = false;
> +	filter.rssi = DISTANCE_VAL_INVALID;
> +	filter.pathloss = DISTANCE_VAL_INVALID;
> +	g_strfreev(filter.uuids);
> +	filter.uuids = NULL;
> +	filter.uuids_len = 0;
> +	g_free(filter.transport);
> +	filter.transport = NULL;
> +	filter.duplicate = false;
>  
>  	if (check_default_ctrl() == FALSE)
>  		return;
> 

