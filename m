Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Aug 2014 10:56:41 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/3] monitor: Add save to file SCO audio
Message-ID: <20140805075640.GB26104@aemeltch-MOBL1>
References: <1406643504-29232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406643504-29232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Tue, Jul 29, 2014 at 05:18:22PM +0300, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Add new option which makes possible to save audio SCO trace to file. The
> file can be played with sox using command line:
> btmon -a <cap> -S<audio-file>
> $ play -c 1 -t s16 -r 8000 <audio-file>
> ---
>  monitor/analyze.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>  monitor/analyze.h |  2 ++
>  monitor/main.c    | 17 ++++++++++++++---
>  monitor/packet.h  |  1 +
>  4 files changed, 59 insertions(+), 5 deletions(-)
> 
> diff --git a/monitor/analyze.c b/monitor/analyze.c
> index 5288cf3..7aa98b0 100644
> --- a/monitor/analyze.c
> +++ b/monitor/analyze.c
> @@ -28,15 +28,22 @@
>  
>  #include <stdio.h>
>  #include <string.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <sys/stat.h>
>  
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
>  #include "src/shared/btsnoop.h"
>  #include "monitor/bt.h"
> +#include "monitor/packet.h"
>  #include "analyze.h"
>  
>  #define MAX_PACKET_SIZE		(1486 + 4)
>  
> +static int sco_fd = -1;
> +static unsigned long filter_mask = 0;
> +
>  struct hci_dev {
>  	uint16_t index;
>  	uint8_t type;
> @@ -237,12 +244,22 @@ static void acl_pkt(struct timeval *tv, uint16_t index,
>  	dev->num_acl++;
>  }
>  
> -static void sco_pkt(struct timeval *tv, uint16_t index,
> +void analyze_set_filter(unsigned long filter)
> +{
> +	filter_mask = filter;
> +}
> +
> +static void sco_pkt(struct timeval *tv, uint16_t index, bool in,
>  					const void *data, uint16_t size)
>  {
>  	const struct bt_hci_sco_hdr *hdr = data;
>  	struct hci_dev *dev;
>  
> +	if (size < sizeof(*hdr)) {
> +		fprintf(stderr, "Malformed SCO packet of size %u", size);
> +		return;
> +	}
> +
>  	data += sizeof(*hdr);
>  	size -= sizeof(*hdr);
>  
> @@ -251,6 +268,15 @@ static void sco_pkt(struct timeval *tv, uint16_t index,
>  		return;
>  
>  	dev->num_sco++;
> +
> +	if (size != 48) {
> +		fprintf(stderr, "Drop malformed packet of size %u\n", size);
> +		return;
> +	}
> +
> +	if ((filter_mask & PACKET_FILTER_SAVE_SCO_DATA) && in)
> +		if (write(sco_fd, data, size) < 0)
> +			return;
>  }
>  
>  void analyze_trace(const char *path)
> @@ -308,8 +334,10 @@ void analyze_trace(const char *path)
>  			acl_pkt(&tv, index, buf, pktlen);
>  			break;
>  		case BTSNOOP_OPCODE_SCO_TX_PKT:
> +			sco_pkt(&tv, index, false, buf, pktlen);
> +			break;
>  		case BTSNOOP_OPCODE_SCO_RX_PKT:
> -			sco_pkt(&tv, index, buf, pktlen);
> +			sco_pkt(&tv, index, true, buf, pktlen);
>  			break;
>  		}
>  
> @@ -321,5 +349,17 @@ void analyze_trace(const char *path)
>  	queue_destroy(dev_list, dev_destroy);
>  
>  done:
> +	if (sco_fd >= 0)
> +		close(sco_fd);
>  	btsnoop_unref(btsnoop_file);
>  }
> +
> +bool open_sco_dump(const char *path)
> +{
> +	sco_fd = open(path, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC,
> +					S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
> +	if (sco_fd < 0)
> +		return false;
> +
> +	return true;
> +}
> diff --git a/monitor/analyze.h b/monitor/analyze.h
> index c643d35..50bbf07 100644
> --- a/monitor/analyze.h
> +++ b/monitor/analyze.h
> @@ -23,3 +23,5 @@
>   */
>  
>  void analyze_trace(const char *path);
> +void analyze_set_filter(unsigned long filter);
> +bool open_sco_dump(const char *path);
> diff --git a/monitor/main.c b/monitor/main.c
> index f0922eb..ac34262 100644
> --- a/monitor/main.c
> +++ b/monitor/main.c
> @@ -76,7 +76,7 @@ static const struct option main_options[] = {
>  	{ "index",   required_argument, NULL, 'i' },
>  	{ "time",    no_argument,       NULL, 't' },
>  	{ "date",    no_argument,       NULL, 'T' },
> -	{ "sco",     no_argument,	NULL, 'S' },
> +	{ "sco",     optional_argument,	NULL, 'S' },
>  	{ "ellisys", required_argument, NULL, 'E' },
>  	{ "todo",    no_argument,       NULL, '#' },
>  	{ "version", no_argument,       NULL, 'v' },
> @@ -91,6 +91,7 @@ int main(int argc, char *argv[])
>  	const char *writer_path = NULL;
>  	const char *analyze_path = NULL;
>  	const char *ellisys_server = NULL;
> +	const char *sco_path = NULL;
>  	unsigned short ellisys_port = 0;
>  	const char *str;
>  	int exit_status;
> @@ -103,7 +104,7 @@ int main(int argc, char *argv[])
>  	for (;;) {
>  		int opt;
>  
> -		opt = getopt_long(argc, argv, "r:w:a:s:i:tTSE:vh",
> +		opt = getopt_long(argc, argv, "r:w:a:s:i:tTS::E:vh",
>  						main_options, NULL);
>  		if (opt < 0)
>  			break;
> @@ -142,7 +143,11 @@ int main(int argc, char *argv[])
>  			filter_mask |= PACKET_FILTER_SHOW_DATE;
>  			break;
>  		case 'S':
> -			filter_mask |= PACKET_FILTER_SHOW_SCO_DATA;
> +			if (optarg) {
> +				filter_mask |= PACKET_FILTER_SAVE_SCO_DATA;
> +				sco_path = optarg;
> +			} else
> +				filter_mask |= PACKET_FILTER_SHOW_SCO_DATA;
>  			break;
>  		case 'E':
>  			ellisys_server = optarg;
> @@ -184,6 +189,12 @@ int main(int argc, char *argv[])
>  	keys_setup();
>  
>  	packet_set_filter(filter_mask);
> +	analyze_set_filter(filter_mask);
> +
> +	if (sco_path && !open_sco_dump(sco_path)) {
> +		printf("Failed to open '%s'\n", sco_path);
> +		return EXIT_FAILURE;
> +	}
>  
>  	if (analyze_path) {
>  		analyze_trace(analyze_path);
> diff --git a/monitor/packet.h b/monitor/packet.h
> index c39816b..d75b3ba 100644
> --- a/monitor/packet.h
> +++ b/monitor/packet.h
> @@ -32,6 +32,7 @@
>  #define PACKET_FILTER_SHOW_TIME_OFFSET	(1 << 3)
>  #define PACKET_FILTER_SHOW_ACL_DATA	(1 << 4)
>  #define PACKET_FILTER_SHOW_SCO_DATA	(1 << 5)
> +#define PACKET_FILTER_SAVE_SCO_DATA	(1 << 6)
>  
>  void packet_set_filter(unsigned long filter);
>  void packet_add_filter(unsigned long filter);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
