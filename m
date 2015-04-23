Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: chanyeol.park@gmail.com
Cc: linux-bluetooth@vger.kernel.org, chanyeol.park@samsung.com
Subject: Re: [BlueZ RFC 1/3] monitor: Add btsnoop data link transfer way
Date: Thu, 23 Apr 2015 13:25:55 +0200
Message-ID: <31085236.0AZ1lbYsZp@leonov>
In-Reply-To: <1429775365-17215-1-git-send-email-chanyeol.park@samsung.com>
References: <1429775365-17215-1-git-send-email-chanyeol.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol Park,

On Thursday 23 of April 2015 03:49:23 chanyeol.park@gmail.com wrote:
> From: Chan-yeol Park <chanyeol.park@samsung.com>
> 
> Current btmon's btsnoop data link type is BTSNOOP_TYPE_MONITOR:2001.
> but some of btsnoop viewer could not handle it because they just
> support BTSNOOP_TYPE_HCI(1001).
> 
> So they need transform way to analyze the btsnoop file captured by
> btmon.
> ---
>  monitor/control.c | 61
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++ monitor/control.h |
>  1 +
>  monitor/main.c    | 13 +++++++++++-
>  3 files changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/monitor/control.c b/monitor/control.c
> index e61a79d..00e4bc0 100644
> --- a/monitor/control.c
> +++ b/monitor/control.c
> @@ -1131,6 +1131,67 @@ bool control_writer(const char *path)
>  	return !!btsnoop_file;
>  }
> 
> +void transfer_btsnoop_data_link(const char *path, const char *writer_path)
> +{
> +	unsigned char buf[BTSNOOP_MAX_PACKET_SIZE];
> +	uint16_t pktlen;
> +	uint32_t type;
> +	struct timeval tv;
> +	struct btsnoop *btsnoop_write_file = NULL;
> +	unsigned long num_packets = 0;
> +
> +	btsnoop_file = btsnoop_open(path, BTSNOOP_FLAG_PKLG_SUPPORT);
> +	if (!btsnoop_file)
> +		return;
> +
> +	btsnoop_write_file = btsnoop_create(writer_path, BTSNOOP_TYPE_HCI);
> +	if (!btsnoop_write_file)
> +		return;
> +
> +	type = btsnoop_get_type(btsnoop_file);
> +
> +	switch (type) {
> +	case BTSNOOP_TYPE_HCI:
> +	case BTSNOOP_TYPE_UART:
> +	case BTSNOOP_TYPE_SIMULATOR:
> +		packet_del_filter(PACKET_FILTER_SHOW_INDEX);
> +		break;
> +
> +	case BTSNOOP_TYPE_MONITOR:
> +		packet_add_filter(PACKET_FILTER_SHOW_INDEX);
> +		break;
> +	}
> +
> +	switch (type) {
> +	case BTSNOOP_TYPE_HCI:
> +	case BTSNOOP_TYPE_UART:
> +	case BTSNOOP_TYPE_MONITOR:
> +		while (1) {
> +			uint16_t index, opcode;
> +
> +			if (!btsnoop_read_hci(btsnoop_file, &tv, &index,
> +							&opcode, buf, &pktlen))
> +				break;
> +
> +			if (opcode == 0xffff)
> +				continue;
> +
> +			btsnoop_write_hci(btsnoop_write_file, &tv, index,
> +							opcode, buf, pktlen);
> +			num_packets++;
> +		}
> +		break;
> +	}
> +
> +	btsnoop_unref(btsnoop_file);
> +	btsnoop_unref(btsnoop_write_file);
> +
> +	printf("BT Snoop data link transfer is completed for %lu packets\n",
> +								num_packets);
> +	printf("Output is saved in %s\n", writer_path);
> +}
> +
> +
>  void control_reader(const char *path)
>  {
>  	unsigned char buf[BTSNOOP_MAX_PACKET_SIZE];
> diff --git a/monitor/control.h b/monitor/control.h
> index 28f16db..267d71b 100644
> --- a/monitor/control.h
> +++ b/monitor/control.h
> @@ -28,5 +28,6 @@ bool control_writer(const char *path);
>  void control_reader(const char *path);
>  void control_server(const char *path);
>  int control_tracing(void);
> +void transfer_btsnoop_data_link(const char *path, const char *writer_path);
> 
>  void control_message(uint16_t opcode, const void *data, uint16_t size);
> diff --git a/monitor/main.c b/monitor/main.c
> index de48db5..6e7d4b3 100644
> --- a/monitor/main.c
> +++ b/monitor/main.c
> @@ -59,6 +59,7 @@ static void usage(void)
>  	printf("options:\n"
>  		"\t-r, --read <file>      Read traces in btsnoop format\n"
>  		"\t-w, --write <file>     Save traces in btsnoop format\n"
> +		"\t-f, --transfer <file>  Transfer btsnoop data link type\n"
>  		"\t-a, --analyze <file>   Analyze traces in btsnoop format\n"
>  		"\t-s, --server <socket>  Start monitor server socket\n"
>  		"\t-i, --index <num>      Show only specified controller\n"
> @@ -72,6 +73,7 @@ static void usage(void)
>  static const struct option main_options[] = {
>  	{ "read",    required_argument, NULL, 'r' },
>  	{ "write",   required_argument, NULL, 'w' },
> +	{ "transfer", required_argument, NULL, 'f' },
>  	{ "analyze", required_argument, NULL, 'a' },
>  	{ "server",  required_argument, NULL, 's' },
>  	{ "index",   required_argument, NULL, 'i' },
> @@ -104,7 +106,7 @@ int main(int argc, char *argv[])
>  	for (;;) {
>  		int opt;
> 
> -		opt = getopt_long(argc, argv, "r:w:a:s:i:tTSE:vh",
> +		opt = getopt_long(argc, argv, "r:w:f:a:s:i:tTSE:vh",
>  						main_options, NULL);
>  		if (opt < 0)
>  			break;
> @@ -116,6 +118,10 @@ int main(int argc, char *argv[])
>  		case 'w':
>  			writer_path = optarg;
>  			break;
> +		case 'f':
> +			reader_path = optarg;
> +			writer_path = "btsnoop_type_hci.log";
> +			break;
>  		case 'a':
>  			analyze_path = optarg;
>  			break;
> @@ -191,6 +197,11 @@ int main(int argc, char *argv[])
>  		return EXIT_SUCCESS;
>  	}
> 
> +	if (reader_path && writer_path) {
> +		transfer_btsnoop_data_link(reader_path, writer_path);
> +		return EXIT_SUCCESS;
> +	}
> +
>  	if (reader_path) {
>  		if (ellisys_server)
>  			ellisys_enable(ellisys_server, ellisys_port);

Those patches will make problems with multiple adapters.
So if you really want to put this into btmon --transfer option should create 1 
file per adapter eg. btmon --trasfer foo.btsnoop would result in multiple 
foo_legacy_hciX.btsnoop files (or whatever it would be called).


Personally I wouldn't put this into monitor but maybe provide additional 
option to btsnoop tool for splitting into legacy files.

-- 
BR
Szymon Janc
