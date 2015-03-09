Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Lukasz Rymanowski' <lukasz.rymanowski@tieto.com>,
	linux-bluetooth@vger.kernel.org
References: <1425660538-25884-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1425660538-25884-8-git-send-email-lukasz.rymanowski@tieto.com>
In-reply-to: <1425660538-25884-8-git-send-email-lukasz.rymanowski@tieto.com>
Subject: RE: [PATCH v3 7/7] tools/btgatt-client: Add prepare and execute write
Date: Mon, 09 Mar 2015 12:34:16 +0530
Message-id: <000b01d05a37$464a7410$d2df5c30$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Lukasz Rymanowski
> Sent: Friday, March 06, 2015 10:19 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Lukasz Rymanowski
> Subject: [PATCH v3 7/7] tools/btgatt-client: Add prepare and execute write
> 
> ---
>  tools/btgatt-client.c | 204
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 204 insertions(+)
> 
> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c index
> e2e0d15..6a0eae8 100644
> --- a/tools/btgatt-client.c
> +++ b/tools/btgatt-client.c
> @@ -67,6 +67,8 @@ struct client {
>  	struct bt_att *att;
>  	struct gatt_db *db;
>  	struct bt_gatt_client *gatt;
> +
> +	unsigned int reliable_session_id;
>  };
> 
>  static void print_prompt(void)
> @@ -884,6 +886,204 @@ static void cmd_write_long_value(struct client *cli,
> char *cmd_str)
>  	free(value);
>  }
> 
> +static void write_prepare_usage(void)
> +{
> +	printf("Usage: write-prepare [options] <value_handle> <offset> "
> +				"<value>\n"
> +				"Options:\n"
> +				"\t-s, --session-id\tSession id\n"
> +				"e.g.:\n"
> +				"\twrite-prepare -s 1 0x0001 00 01 00\n"); }
> +
> +static struct option write_prepare_options[] = {
> +	{ "session-id",		1, 0, 's' },
> +	{ }
> +};
> +
> +static void cmd_write_prepare(struct client *cli, char *cmd_str) {
> +	int opt, i;
> +	char *argvbuf[516];
> +	char **argv = argvbuf;
> +	int argc = 0;
> +	unsigned int id = 0;
> +	uint16_t handle;
> +	uint16_t offset;
> +	char *endptr = NULL;
> +	unsigned int length;
> +	uint8_t *value = NULL;
> +
> +	if (!bt_gatt_client_is_ready(cli->gatt)) {
> +		printf("GATT client not initialized\n");
> +		return;
> +	}
> +
> +	if (!parse_args(cmd_str, 514, argv + 1, &argc)) {
> +		printf("Too many arguments\n");
> +		write_value_usage();
> +		return;
> +	}
> +
> +	/* Add command name for getopt_long */
> +	argc++;
> +	argv[0] = "write-prepare";
> +
> +	optind = 0;
> +	while ((opt = getopt_long(argc, argv , "s:", write_prepare_options,
> +								NULL)) !=
-1) {
> +		switch (opt) {
> +		case 's':
> +			if (!optarg) {
> +				write_prepare_usage();
> +				return;
> +			}
> +
> +			id = atoi(optarg);
> +
> +			break;
> +		default:
> +			write_prepare_usage();
> +			return;
> +		}
> +	}
> +
> +	argc -= optind;
> +	argv += optind;
> +
> +	if (argc < 3) {
> +		write_prepare_usage();
> +		return;
> +	}
> +
> +	if (cli->reliable_session_id != id) {
> +		printf("Session id != Ongoing session id (%u!=%u)\n", id,
> +						cli->reliable_session_id);
> +		return;
> +	}
> +
> +	handle = strtol(argv[0], &endptr, 0);
> +	if (!endptr || *endptr != '\0' || !handle) {
> +		printf("Invalid handle: %s\n", argv[0]);
> +		return;
> +	}
> +
> +	endptr = NULL;
> +	offset = strtol(argv[1], &endptr, 0);
> +	if (!endptr || *endptr != '\0' || errno == ERANGE) {
> +		printf("Invalid offset: %s\n", argv[1]);
> +		return;
> +	}
> +
> +	/*
> +	 * First two arguments are handle and offset. What remains is the
> value
> +	 * length
> +	 */
> +	length = argc - 2;
> +
> +	if (length == 0)
> +		goto done;
> +
> +	if (length > UINT16_MAX) {
> +		printf("Write value too long\n");
> +		return;
> +	}
> +
> +	value = malloc(length);
> +	if (!value) {
> +		printf("Failed to allocate memory for value\n");
> +		return;
> +	}
> +
> +	for (i = 2; i < argc; i++) {
> +		if (strlen(argv[i]) != 2) {
> +			printf("Invalid value byte: %s\n", argv[i]);
> +			free(value);
> +			return;
> +		}
> +
> +		value[i-2] = strtol(argv[i], &endptr, 0);
> +		if (endptr == argv[i] || *endptr != '\0' || errno == ERANGE)
{
> +			printf("Invalid value byte: %s\n", argv[i]);
> +			free(value);
> +			return;
> +		}
> +	}
> +
> +done:
> +	cli->reliable_session_id =
> +			bt_gatt_client_prepare_write(cli->gatt, id,
> +							handle, offset,
> +							value, length,
> +							write_long_cb, NULL,
> +							NULL);
> +	if (!cli->reliable_session_id)
> +		printf("Failed to proceed prepare write\n");
> +	else
> +		printf("Prepare write success.\n"
> +				"Session id: %d to be used on next write\n",
> +						cli->reliable_session_id);
> +
> +	free(value);
> +}
> +
> +static void write_execute_usage(void)
> +{
> +	printf("Usage: write-execute <session_id> <execute>\n"
> +				"e.g.:\n"
> +				"\twrite-execute 1 0\n");
> +}
> +
> +static void cmd_write_execute(struct client *cli, char *cmd_str) {
> +	char *argvbuf[516];
> +	char **argv = argvbuf;
> +	int argc = 0;
> +	char *endptr = NULL;
> +	unsigned int session_id;
> +	bool execute;
> +
> +	if (!bt_gatt_client_is_ready(cli->gatt)) {
> +		printf("GATT client not initialized\n");
> +		return;
> +	}
> +
> +	if (!parse_args(cmd_str, 514, argv, &argc)) {
> +		printf("Too many arguments\n");
> +		write_value_usage();
> +		return;
> +	}
> +
> +	if (argc < 2) {
> +		write_execute_usage();
> +		return;
> +	}
> +
> +	session_id = strtol(argv[0], &endptr, 0);
> +	if (!endptr || *endptr != '\0') {
> +		printf("Invalid session id: %s\n", argv[0]);
> +		return;
> +	}
> +
> +	if (session_id != cli->reliable_session_id) {
> +		printf("Invalid session id: %u != %u\n", session_id,
> +						cli->reliable_session_id);
> +		return;
> +	}
> +

I applied this patch set internally and tested the prepare write and execute
functionality using PTS tool.
Listed below are few fixes which I am able to figure out.

I think '!!' here is not required, unless there is some specific reason.

> +	execute = !!strtol(argv[1], &endptr, 0);
> +	if (!endptr || *endptr != '\0') {
> +		printf("Invalid execute: %s\n", argv[1]);
> +		return;
> +	}
> +

The function defined in src/shared/gatt-client.h.

unsigned int bt_gatt_client_write_execute(struct bt_gatt_client *client,
                                        bool execute,
                                        unsigned int id,
                                        bt_gatt_client_callback_t callback,
                                        void *user_data,
                                        bt_gatt_client_destroy_func_t
destroy);

Function parameters are not matching.
Other than these, it is passing all reliable write Test Cases.

> +	if (!bt_gatt_client_write_execute(cli->gatt, session_id, execute,
> +							write_cb, NULL,
> NULL))
> +		printf("Failed to proceed write execute\n");
> +
> +	cli->reliable_session_id = 0;
> +}
> +
>  static void register_notify_usage(void)  {
>  	printf("Usage: register-notify <chrc value handle>\n"); @@ -1130,6
> +1330,10 @@ static struct {
>  			"\tWrite a characteristic or descriptor value" },
>  	{ "write-long-value", cmd_write_long_value,
>  			"Write long characteristic or descriptor value" },
> +	{ "write-prepare", cmd_write_prepare,
> +			"\tWrite prepare characteristic or descriptor value"
},
> +	{ "write-execute", cmd_write_execute,
> +			"\tExecute already prepared write" },
>  	{ "register-notify", cmd_register_notify,
>  			"\tSubscribe to not/ind from a characteristic" },
>  	{ "unregister-notify", cmd_unregister_notify,
> --
> 1.8.4
> 

Regards,
Gowtham Anandha Babu

> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

