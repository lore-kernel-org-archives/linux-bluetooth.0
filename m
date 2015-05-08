Return-Path: <cyrus@holtmann.org>
Message-ID: <1431103613.2871.17.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] tools/btsnoop: Add split option
From: Chan-yeol Park <chanyeol.park@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: chanyeol.park@samsung.com
Date: Sat, 09 May 2015 01:46:53 +0900
In-Reply-To: <1429868955-7765-1-git-send-email-chanyeol.park@samsung.com>
References: <1429868955-7765-1-git-send-email-chanyeol.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel

As you guided, I made split option in tools/btsnoop.c

Personally I would like to replace our hcidump with btmon.
but I expect it would take time that Front line viewer implement
BTSNOOP_TYPE_MONITOR.

Thanks
Chanyeol

On Fri, 2015-04-24 at 18:49 +0900, chanyeol.park@gmail.com wrote:
> From: Chan-yeol Park <chanyeol.park@samsung.com>
> 
> Current btmon's btsnoop data link type is BTSNOOP_TYPE_MONITOR:2001.
> but some of btsnoop viewer could not handle it because they just
> support BTSNOOP_TYPE_HCI(1001).
> 
> So they need split option to analyze the btsnoop file captured by
> btmon.
> ---
>  tools/btsnoop.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 98 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/btsnoop.c b/tools/btsnoop.c
> index 3eb8082..0ea4c65 100644
> --- a/tools/btsnoop.c
> +++ b/tools/btsnoop.c
> @@ -34,6 +34,8 @@
>  #include <stdint.h>
>  #include <stdbool.h>
>  #include <string.h>
> +#include <time.h>
> +#include <sys/time.h>
>  #include <getopt.h>
>  #include <endian.h>
>  #include <arpa/inet.h>
> @@ -272,6 +274,86 @@ close_input:
>  		close(input_fd[i]);
>  }
>  
> +#define BT_SNOOP_TYPE_HCI_PREFIX "btsnoop_type_hci"
> +
> +static void command_split(const char *input)
> +{
> +	unsigned char buf[BTSNOOP_MAX_PACKET_SIZE];
> +	uint16_t pktlen,opcode;
> +	uint32_t type;
> +	struct timeval tv;
> +	uint16_t index, max_index = 0;
> +	char write_file_name[255];
> +	struct btsnoop *btsnoop_read_file = NULL;
> +	struct btsnoop *btsnoop_write_file[16];
> +	time_t t;
> +	struct tm tm;
> +	unsigned long num_packets = 0;
> +
> +	btsnoop_read_file = btsnoop_open(input, BTSNOOP_FLAG_PKLG_SUPPORT);
> +	if (!btsnoop_read_file)
> +		return;
> +
> +	type = btsnoop_get_type(btsnoop_read_file);
> +	if (type != BTSNOOP_TYPE_MONITOR) {
> +		fprintf(stderr, "unsupported link data type %u\n", type);
> +		btsnoop_unref(btsnoop_read_file);
> +		return;
> +	}
> +
> +next_packet:
> +	if (!btsnoop_read_hci(btsnoop_read_file, &tv, &index, &opcode, buf,
> +								&pktlen))
> +		goto close_files;
> +
> +	if (opcode == 0xffff)
> +		goto next_packet;
> +
> +	switch (opcode) {
> +	case BTSNOOP_OPCODE_NEW_INDEX:
> +		t = tv.tv_sec;
> +		localtime_r(&t, &tm);
> +
> +		if (max_index < index)
> +			max_index = index;
> +
> +		sprintf(write_file_name, "%s%d_%02d:%02d:%02d.%06lu.log",
> +			BT_SNOOP_TYPE_HCI_PREFIX, index, tm.tm_hour, tm.tm_min,
> +			tm.tm_sec, tv.tv_usec);
> +
> +		printf("New Index %d would be saved in %s\n", index,
> +							write_file_name);
> +
> +		btsnoop_write_file[index] = btsnoop_create(write_file_name,
> +							BTSNOOP_TYPE_HCI);
> +		if (!btsnoop_write_file[index])
> +			goto close_files;
> +
> +		break;
> +	case BTSNOOP_OPCODE_DEL_INDEX:
> +		printf("Del Index %d\n", index);
> +
> +		btsnoop_unref(btsnoop_write_file[index]);
> +		btsnoop_write_file[index] = NULL;
> +		break;
> +	default:
> +		btsnoop_write_hci(btsnoop_write_file[index], &tv, index,
> +							opcode, buf, pktlen);
> +	}
> +	num_packets++;
> +
> +	goto next_packet;
> +
> +close_files:
> +	for (index = 0; index < max_index; index++)
> +		btsnoop_unref(btsnoop_write_file[index]);
> +
> +	btsnoop_unref(btsnoop_read_file);
> +
> +	printf("BT Snoop data link transfer is completed for %lu packets\n",
> +								num_packets);
> +}
> +
>  static void command_extract_eir(const char *input)
>  {
>  	struct btsnoop_pkt pkt;
> @@ -518,6 +600,7 @@ static void usage(void)
>  	printf("commands:\n"
>  		"\t-m, --merge <output>   Merge multiple btsnoop files\n"
>  		"\t-e, --extract <input>  Extract data from btsnoop file\n"
> +		"\t-s, --split <input>    Split btmon file into legacy btsnoop file(s)\n"
>  		"\t-h, --help             Show help options\n");
>  }
>  
> @@ -525,12 +608,13 @@ static const struct option main_options[] = {
>  	{ "merge",   required_argument, NULL, 'm' },
>  	{ "extract", required_argument, NULL, 'e' },
>  	{ "type",    required_argument, NULL, 't' },
> +	{ "split",   required_argument, NULL, 's' },
>  	{ "version", no_argument,       NULL, 'v' },
>  	{ "help",    no_argument,       NULL, 'h' },
>  	{ }
>  };
>  
> -enum { INVALID, MERGE, EXTRACT };
> +enum { INVALID, MERGE, EXTRACT, SPLIT };
>  
>  int main(int argc, char *argv[])
>  {
> @@ -542,7 +626,7 @@ int main(int argc, char *argv[])
>  	for (;;) {
>  		int opt;
>  
> -		opt = getopt_long(argc, argv, "m:e:t:vh", main_options, NULL);
> +		opt = getopt_long(argc, argv, "m:e:s:t:vh", main_options, NULL);
>  		if (opt < 0)
>  			break;
>  
> @@ -555,6 +639,9 @@ int main(int argc, char *argv[])
>  			command = EXTRACT;
>  			input_path = optarg;
>  			break;
> +		case 's':
> +			command = SPLIT;
> +			input_path = optarg;
>  		case 't':
>  			type = optarg;
>  			break;
> @@ -600,6 +687,15 @@ int main(int argc, char *argv[])
>  			fprintf(stderr, "extract type not supported\n");
>  		break;
>  
> +	case SPLIT:
> +		if (argc - optind > 0) {
> +			fprintf(stderr, "extra arguments not allowed\n");
> +			return EXIT_FAILURE;
> +		}
> +
> +		command_split(input_path);
> +		break;
> +
>  	default:
>  		usage();
>  		return EXIT_FAILURE;


