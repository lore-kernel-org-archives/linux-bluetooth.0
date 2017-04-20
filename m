Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH BlueZ 1/3] monitor: Add frame number support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170420123233.8747-1-luiz.dentz@gmail.com>
Date: Thu, 20 Apr 2017 14:57:18 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2CA3B728-9A43-4033-AC20-D03FC2154D56@holtmann.org>
References: <20170420123233.8747-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This adds -f/--frames options which can be used to show the frame
> number:
> 
>> HCI Event: Command Complete (0x0e) plen 4         	#86 [hci1] 13:00:02.639412
>      LE Set Scan Parameters (0x08|0x000b) ncmd 1
>        Status: Success (0x00)
> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2  #87 [hci1] 13:00:02.639663
>        Scanning: Enabled (0x01)
>        Filter duplicates: Enabled (0x01)
>> HCI Event: Command Complete (0x0e) plen 4             #88 [hci1] 13:00:02.640420
>      LE Set Scan Enable (0x08|0x000c) ncmd 2
>        Status: Success (0x00)
> ---
> monitor/main.c   |  7 ++++++-
> monitor/packet.c | 37 +++++++++++++++++++++++++++----------
> monitor/packet.h |  1 +
> 3 files changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/monitor/main.c b/monitor/main.c
> index f9bca22..e1a2375 100644
> --- a/monitor/main.c
> +++ b/monitor/main.c
> @@ -70,6 +70,7 @@ static void usage(void)
> 		"\t-T, --date             Show time and date information\n"
> 		"\t-S, --sco              Dump SCO traffic\n"
> 		"\t-E, --ellisys [ip]     Send Ellisys HCI Injection\n"
> +		"\t-f, --frames           Show frame counter\n"
> 		"\t-h, --help             Show help options\n");
> }

I would rather use -C / --counter as frame counter.

> @@ -86,6 +87,7 @@ static const struct option main_options[] = {
> 	{ "date",    no_argument,       NULL, 'T' },
> 	{ "sco",     no_argument,	NULL, 'S' },
> 	{ "ellisys", required_argument, NULL, 'E' },
> +	{ "frames",  no_argument,	NULL, 'f' },
> 	{ "todo",    no_argument,       NULL, '#' },
> 	{ "version", no_argument,       NULL, 'v' },
> 	{ "help",    no_argument,       NULL, 'h' },
> @@ -113,7 +115,7 @@ int main(int argc, char *argv[])
> 	for (;;) {
> 		int opt;
> 
> -		opt = getopt_long(argc, argv, "d:r:w:a:s:p:i:tTSE:vh",
> +		opt = getopt_long(argc, argv, "d:r:w:a:s:p:i:tfTSE:vh",
> 						main_options, NULL);
> 		if (opt < 0)
> 			break;
> @@ -171,6 +173,9 @@ int main(int argc, char *argv[])
> 			ellisys_server = optarg;
> 			ellisys_port = 24352;
> 			break;
> +		case 'f':
> +			filter_mask |= PACKET_FILTER_SHOW_FRAME;
> +			break;
> 		case '#':
> 			packet_todo();
> 			lmp_todo();
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 3c43356..e5f2a32 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -58,6 +58,7 @@
> #include "packet.h"
> 
> #define COLOR_CHANNEL_LABEL		COLOR_WHITE
> +#define COLOR_FRAME_LABEL		COLOR_WHITE
> #define COLOR_INDEX_LABEL		COLOR_WHITE
> #define COLOR_TIMESTAMP			COLOR_YELLOW
> 
> @@ -259,6 +260,18 @@ void packet_select_index(uint16_t index)
> 
> #define print_space(x) printf("%*c", (x), ' ');
> 
> +#define MAX_INDEX 16
> +
> +struct index_data {
> +	uint8_t  type;
> +	uint8_t  bdaddr[6];
> +	uint16_t manufacturer;
> +	size_t	frame;
> +};
> +
> +static struct index_data index_list[MAX_INDEX];
> +
> +

Too many empty lines here.

> static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
> 					uint16_t index, const char *channel,
> 					const char *color, const char *label,
> @@ -280,6 +293,20 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
> 			ts_pos += n;
> 			ts_len += n;
> 		}
> +	} else if (filter_mask & PACKET_FILTER_SHOW_FRAME &&
> +					(ident == '<' || ident == '>')) {

Lets not use the ident to choose here.

> +		if (use_color()) {
> +			n = sprintf(ts_str + ts_pos, "%s", COLOR_FRAME_LABEL);
> +			if (n > 0)
> +				ts_pos += n;
> +		}
> +
> +		n = sprintf(ts_str + ts_pos, " #%zu",
> +						++index_list[index].frame);

I would prefer if we add the frame number during input and not during display of the packet. That should be kept separate. Otherwise we create a mess like in hcidump.

> +		if (n > 0) {
> +			ts_pos += n;
> +			ts_len += n;
> +		}
> 	}
> 
> 	if ((filter_mask & PACKET_FILTER_SHOW_INDEX) &&
> @@ -3828,16 +3855,6 @@ static int addr2str(const uint8_t *addr, char *str)
> 			addr[5], addr[4], addr[3], addr[2], addr[1], addr[0]);
> }
> 
> -#define MAX_INDEX 16
> -
> -struct index_data {
> -	uint8_t  type;
> -	uint8_t  bdaddr[6];
> -	uint16_t manufacturer;
> -};
> -
> -static struct index_data index_list[MAX_INDEX];
> -
> void packet_monitor(struct timeval *tv, struct ucred *cred,
> 					uint16_t index, uint16_t opcode,
> 					const void *data, uint16_t size)
> diff --git a/monitor/packet.h b/monitor/packet.h
> index 354f4fe..2516ec1 100644
> --- a/monitor/packet.h
> +++ b/monitor/packet.h
> @@ -33,6 +33,7 @@
> #define PACKET_FILTER_SHOW_TIME_OFFSET	(1 << 3)
> #define PACKET_FILTER_SHOW_ACL_DATA	(1 << 4)
> #define PACKET_FILTER_SHOW_SCO_DATA	(1 << 5)
> +#define PACKET_FILTER_SHOW_FRAME	(1 << 6)

Call it FRAME_COUNTER or something similar. Just FRAME is misleading. Or we might just always show the frame counter anyway. It is not really in the way.

Regards

Marcel

