Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH BlueZ 7/7] monitor: Add option to show only mesh
 advertisements
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170718164627.20114-7-luiz.dentz@gmail.com>
Date: Tue, 18 Jul 2017 21:10:46 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <34016F68-631B-40AF-84D9-6DBDD285D3B7@holtmann.org>
References: <20170718164627.20114-1-luiz.dentz@gmail.com>
 <20170718164627.20114-7-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This adds -M/--mesh [nid] option to show only mesh advertisements which
> is very convenient when monitoring noisy environments.
> ---
> monitor/main.c   | 17 +++++++++++-
> monitor/packet.c | 80 ++++++++++++++++++++++++++++++++++++++++++++------------
> monitor/packet.h |  2 ++
> 3 files changed, 82 insertions(+), 17 deletions(-)
> 
> diff --git a/monitor/main.c b/monitor/main.c
> index b4e9a6a..fb7d5f5 100644
> --- a/monitor/main.c
> +++ b/monitor/main.c
> @@ -71,6 +71,7 @@ static void usage(void)
> 		"\t-S, --sco              Dump SCO traffic\n"
> 		"\t-A, --a2dp             Dump A2DP stream traffic\n"
> 		"\t-E, --ellisys [ip]     Send Ellisys HCI Injection\n"
> +		"\t-M, --mesh [nid]	  Dump Mesh traffic only\n"
> 		"\t-h, --help             Show help options\n");
> }
> 
> @@ -88,6 +89,7 @@ static const struct option main_options[] = {
> 	{ "sco",     no_argument,	NULL, 'S' },
> 	{ "a2dp",    no_argument,	NULL, 'A' },
> 	{ "ellisys", required_argument, NULL, 'E' },
> +	{ "mesh",    optional_argument, NULL, 'M' },
> 	{ "todo",    no_argument,       NULL, '#' },
> 	{ "version", no_argument,       NULL, 'v' },
> 	{ "help",    no_argument,       NULL, 'h' },
> @@ -104,6 +106,7 @@ int main(int argc, char *argv[])
> 	const char *tty = NULL;
> 	unsigned int tty_speed = B115200;
> 	unsigned short ellisys_port = 0;
> +	int mesh_nid = -1;
> 	const char *str;
> 	int exit_status;
> 	sigset_t mask;
> @@ -115,7 +118,7 @@ int main(int argc, char *argv[])
> 	for (;;) {
> 		int opt;
> 
> -		opt = getopt_long(argc, argv, "d:r:w:a:s:p:i:tTSAE:vh",
> +		opt = getopt_long(argc, argv, "d:r:w:a:s:p:i:tTSAE:M::vh",
> 						main_options, NULL);
> 		if (opt < 0)
> 			break;
> @@ -176,6 +179,18 @@ int main(int argc, char *argv[])
> 			ellisys_server = optarg;
> 			ellisys_port = 24352;
> 			break;
> +		case 'M':
> +			if (optarg) {
> +				mesh_nid = atoi(optarg);

you also need to support hex input here as well.

> +				if (mesh_nid < 0 || mesh_nid > 0x7f) {
> +					fprintf(stderr, "Invalid NID: %s\n",
> +								optarg);
> +					return EXIT_FAILURE;
> +				}
> +				packet_set_mesh_nid(mesh_nid);
> +			}
> +			filter_mask |= PACKET_FILTER_MESH_ONLY;
> +			break;
> 		case '#':
> 			packet_todo();
> 			lmp_todo();
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 678d7a7..c2ba66f 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -111,6 +111,7 @@ static unsigned long filter_mask = 0;
> static bool index_filter = false;
> static uint16_t index_number = 0;
> static uint16_t index_current = 0;
> +static int mesh_nid = -1;
> 
> #define UNKNOWN_MANUFACTURER 0xffff
> 
> @@ -268,6 +269,11 @@ void packet_select_index(uint16_t index)
> 	index_number = index;
> }
> 
> +void packet_set_mesh_nid(uint8_t nid)
> +{
> +	mesh_nid = nid;
> +}
> +
> #define print_space(x) printf("%*c", (x), ' ');
> 
> #define MAX_INDEX 16
> @@ -8850,6 +8856,25 @@ rssi:
> 	}
> }
> 
> +static bool le_adv_report_filter(uint8_t index, const void *data, uint8_t size)
> +{
> +	const struct bt_hci_evt_le_adv_report *evt = data;
> +
> +	if (!packet_has_filter(PACKET_FILTER_MESH_ONLY))
> +		return false;
> +
> +	switch (evt->data[1]) {
> +	case BT_EIR_MESH_DATA:
> +		if (mesh_nid > 0 && ((evt->data[2] & 0xfe) != mesh_nid))
> +			return true;

fall through comment is missing and also mesh_nid > 0 is wrong. Then using uint8_t mesh_nid would be fine. Which is actually what I think we should be doing anyway in the first place. This a cryptographic hash. Chances are super slim that we get 0x00 here.

> +	case BT_EIR_MESH_PROV:
> +	case BT_EIR_MESH_BEACON:
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> static void le_conn_update_complete_evt(uint8_t index, const void *data, uint8_t size)
> {
> 	const struct bt_hci_evt_le_conn_update_complete *evt = data;
> @@ -8998,6 +9023,7 @@ struct subevent_data {
> 	void (*func) (uint8_t index, const void *data, uint8_t size);
> 	uint8_t size;
> 	bool fixed;
> +	bool (*filter) (uint8_t index, const void *data, uint8_t size);
> };
> 
> static void print_subevent(const struct subevent_data *subevent_data,
> @@ -9039,7 +9065,8 @@ static const struct subevent_data le_meta_event_table[] = {
> 	{ 0x01, "LE Connection Complete",
> 				le_conn_complete_evt, 18, true },
> 	{ 0x02, "LE Advertising Report",
> -				le_adv_report_evt, 1, false },
> +				le_adv_report_evt, 1, false,
> +				le_adv_report_filter },
> 	{ 0x03, "LE Connection Update Complete",
> 				le_conn_update_complete_evt, 9, true },
> 	{ 0x04, "LE Read Remote Used Features",
> @@ -9072,29 +9099,45 @@ static const struct subevent_data le_meta_event_table[] = {
> 	{ }
> };
> 
> -static void le_meta_event_evt(uint8_t index, const void *data, uint8_t size)
> +static const struct subevent_data *le_meta_event_find(uint8_t subevent)
> {
> -	uint8_t subevent = *((const uint8_t *) data);
> -	struct subevent_data unknown;
> -	const struct subevent_data *subevent_data = &unknown;
> 	int i;
> 
> -	unknown.subevent = subevent;
> -	unknown.str = "Unknown";
> -	unknown.func = NULL;
> -	unknown.size = 0;
> -	unknown.fixed = true;
> -
> 	for (i = 0; le_meta_event_table[i].str; i++) {
> -		if (le_meta_event_table[i].subevent == subevent) {
> -			subevent_data = &le_meta_event_table[i];
> -			break;
> -		}
> +		if (le_meta_event_table[i].subevent == subevent)
> +			return &le_meta_event_table[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static void le_meta_event_evt(uint8_t index, const void *data, uint8_t size)
> +{
> +	uint8_t subevent = *((const uint8_t *) data);
> +	const struct subevent_data *subevent_data;
> +
> +	subevent_data = le_meta_event_find(subevent);
> +	if (!subevent_data) {
> +		print_indent(6, COLOR_HCI_EVENT_UNKNOWN, "", "", COLOR_OFF,
> +						" (0x%2.2x)", subevent);
> +		return;
> 	}
> 
> 	print_subevent(subevent_data, index, data + 1, size - 1);
> }
> 
> +static bool le_meta_event_filter(uint8_t index, const void *data, uint8_t size)
> +{
> +	uint8_t subevent = *((const uint8_t *) data);
> +	const struct subevent_data *subevent_data;
> +
> +	subevent_data = le_meta_event_find(subevent);
> +	if (!subevent_data || !subevent_data->filter)
> +		return false;
> +
> +	return subevent_data->filter(index, data + 1, size - 1);
> +}
> +
> static void vendor_evt(uint8_t index, const void *data, uint8_t size)
> {
> 	uint8_t subevent = *((const uint8_t *) data);
> @@ -9135,6 +9178,7 @@ struct event_data {
> 	void (*func) (uint8_t index, const void *data, uint8_t size);
> 	uint8_t size;
> 	bool fixed;
> +	bool (*filter) (uint8_t index, const void *data, uint8_t size);
> };
> 
> static const struct event_data event_table[] = {
> @@ -9241,7 +9285,8 @@ static const struct event_data event_table[] = {
> 	{ 0x3d, "Remote Host Supported Features",
> 				remote_host_features_notify_evt, 14, true },
> 	{ 0x3e, "LE Meta Event",
> -				le_meta_event_evt, 1, false },
> +				le_meta_event_evt, 1, false,
> +				le_meta_event_filter },

I really do not like this. Lets not add another function to these tables. Figure something else out. And frankly, I rather have a btmon --mesh command that focus purely on mesh advertising bearer. If not, then just leave all packets unfiltered.

Also we could just figure out on how to use BPF on the monitoring socket. Doing this outside the kernel seems pointless.

Regards

Marcel

