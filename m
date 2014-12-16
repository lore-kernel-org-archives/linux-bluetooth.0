Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Gu Chaojie <chao.jie.gu@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 3/3] tools/btgatt-client:Add signed write with CSRK option
Date: Tue, 16 Dec 2014 13:43:35 +0100
Message-ID: <1710475.Mo0BTicFZQ@uw000953>
In-Reply-To: <1415351073-4362-4-git-send-email-chao.jie.gu@intel.com>
References: <1415351073-4362-1-git-send-email-chao.jie.gu@intel.com> <1415351073-4362-4-git-send-email-chao.jie.gu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gu Chaojie,

On Friday 07 of November 2014 17:04:33 Gu Chaojie wrote:
> ---
>  tools/btgatt-client.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
> index 7a1204f..f175cf2 100644
> --- a/tools/btgatt-client.c
> +++ b/tools/btgatt-client.c
> @@ -505,12 +505,14 @@ static void write_value_usage(void)
>  	printf("Usage: write-value [options] <value_handle> <value>\n"
>  		"Options:\n"
>  		"\t-w, --without-response\tWrite without response\n"
> +		"\t-s, --signed-write\tsigned write command\n"

Keep same capitalization style.

>  		"e.g.:\n"
>  		"\twrite-value 0x0001 00 01 00\n");
>  }
>  
>  static struct option write_value_options[] = {
>  	{ "without-response",	0, 0, 'w' },
> +	{ "signed-write",	0, 0, 's' },
>  	{ }
>  };
>  
> @@ -534,6 +536,7 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
>  	int length;
>  	uint8_t *value = NULL;
>  	bool without_response = false;
> +	bool signed_write = false;
>  
>  	if (!bt_gatt_client_is_ready(cli->gatt)) {
>  		printf("GATT client not initialized\n");
> @@ -548,12 +551,15 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
>  
>  	optind = 0;
>  	argv[0] = "write-value";
> -	while ((opt = getopt_long(argc, argv, "+w", write_value_options,
> +	while ((opt = getopt_long(argc, argv, "+ws", write_value_options,
>  								NULL)) != -1) {
>  		switch (opt) {
>  		case 'w':
>  			without_response = true;
>  			break;
> +		case 's':
> +			signed_write = true;
> +			break;
>  		default:
>  			write_value_usage();
>  			return;
> @@ -607,7 +613,7 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
>  
>  	if (without_response) {
>  		if (!bt_gatt_client_write_without_response(cli->gatt, handle,
> -							false, value, length)) {
> +						signed_write, value, length)) {
>  			printf("Failed to initiate write without response "
>  								"procedure\n");
>  			goto done;
> @@ -858,6 +864,63 @@ static void cmd_unregister_notify(struct client *cli, char *cmd_str)
>  	printf("Unregistered notify handler with id: %u\n", id);
>  }
>  
> +static bool convert_csrk_key(char *optarg, uint8_t csrk[16])
> +{
> +	int i;
> +	char value[2];
> +
> +	if (strlen(optarg) != 32) {
> +		printf("csrk length is invalid\n");
> +		return false;
> +	} else {
> +		for (i = 0; i < 16; i++) {
> +			strncpy(value, optarg + (i * 2), 2);
> +			csrk[i] = strtol(value, NULL, 16);
> +		}
> +	}

Else is not needed since you return in if.

> +
> +	return true;
> +}
> +
> +static void set_csrk_usage(void)
> +{
> +	printf("Usage: set-csrk [options]\nOptions:\n"
> +		"\t -c, --csrk <csrk>\tCSRK\n"
> +		"e.g.:\n"
> +		"\tset-csrk -c D8515948451FEA320DC05A2E88308188\n");
> +}
> +
> +static void cmd_set_csrk(struct client *cli, char *cmd_str)
> +{
> +	char *argv[3];
> +	int argc = 0;
> +	uint8_t csrk[16];
> +
> +	memset(csrk, 0, 16);

This memset is not really needed.

> +
> +	if (!bt_gatt_client_is_ready(cli->gatt)) {
> +		printf("GATT client not initialized\n");
> +		return;
> +	}
> +
> +	if (!parse_args(cmd_str, 2, argv, &argc)) {
> +		set_csrk_usage();
> +		return;
> +	}
> +
> +	if (argc != 2) {
> +		set_csrk_usage();
> +		return;
> +	}
> +
> +	if (!strcmp(argv[0], "-c") || !strcmp(argv[0], "--csrk")) {

csrk[] could be local to this scope.

> +		if (convert_csrk_key(argv[1], csrk))
> +			bt_gatt_client_set_local_csrk(cli->gatt, 0, csrk);
> +
> +	} else
> +		set_csrk_usage();

Braces should be present on both if-else if one of then needs it.
Please refer to doc/coding-style.txt.

> +}
> +
>  static void cmd_help(struct client *cli, char *cmd_str);
>  
>  typedef void (*command_func_t)(struct client *cli, char *cmd_str);
> @@ -881,6 +944,8 @@ static struct {
>  			"\tSubscribe to not/ind from a characteristic" },
>  	{ "unregister-notify", cmd_unregister_notify,
>  						"Unregister a not/ind session"},
> +	{ "set-csrk", cmd_set_csrk,
> +			"\tSet CSRK for signed write command"},
>  	{ }
>  };
>  
> 

-- 
Best regards, 
Szymon Janc
