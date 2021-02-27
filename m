Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FF2C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Feb 2021 20:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC18B64E34
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Feb 2021 20:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhB0UXp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 27 Feb 2021 15:23:45 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:39286 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhB0UXl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 27 Feb 2021 15:23:41 -0500
Received: from marcel-macbook.holtmann.net (p4ff9fb90.dip0.t-ipconnect.de [79.249.251.144])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1A9D6CED0A;
        Sat, 27 Feb 2021 21:30:02 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH BlueZ v3] monitor: Add option to set fallback width
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210226205232.6844-1-sonnysasaka@chromium.org>
Date:   Sat, 27 Feb 2021 21:22:28 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Daniel Winkler <danielwinkler@google.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <728662E2-D299-4753-AC81-99D321ABB7A7@holtmann.org>
References: <20210226205232.6844-1-sonnysasaka@chromium.org>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

> Sometimes we want to be able to pipe the output of btmon to a
> non-terminal device. The current fallback width is usually not long
> enough so this patch adds an option to specify the column width. This is
> especially needed for text logs from bluetoothd.
> 
> Reviewed-by: Daniel Winkler <danielwinkler@google.com>
> 
> ---
> monitor/control.c |  4 ++--
> monitor/control.h |  2 +-
> monitor/display.c |  8 ++++++--
> monitor/display.h |  2 +-
> monitor/main.c    | 10 ++++++++--
> 5 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/monitor/control.c b/monitor/control.c
> index d1ba97d37..2fab87320 100644
> --- a/monitor/control.c
> +++ b/monitor/control.c
> @@ -1474,7 +1474,7 @@ bool control_writer(const char *path)
> 	return !!btsnoop_file;
> }
> 
> -void control_reader(const char *path, bool pager)
> +void control_reader(const char *path, bool pager, int num_columns)
> {
> 	unsigned char buf[BTSNOOP_MAX_PACKET_SIZE];
> 	uint16_t pktlen;
> @@ -1500,7 +1500,7 @@ void control_reader(const char *path, bool pager)
> 	}
> 
> 	if (pager)
> -		open_pager();
> +		open_pager(num_columns);
> 
> 	switch (format) {
> 	case BTSNOOP_FORMAT_HCI:
> diff --git a/monitor/control.h b/monitor/control.h
> index 29616c4f1..b96c542fc 100644
> --- a/monitor/control.h
> +++ b/monitor/control.h
> @@ -12,7 +12,7 @@
> #include <stdint.h>
> 
> bool control_writer(const char *path);
> -void control_reader(const char *path, bool pager);
> +void control_reader(const char *path, bool pager, int num_columns);
> void control_server(const char *path);
> int control_tty(const char *path, unsigned int speed);
> int control_rtt(char *jlink, char *rtt);
> diff --git a/monitor/display.c b/monitor/display.c
> index b11b71d5d..08db18147 100644
> --- a/monitor/display.c
> +++ b/monitor/display.c
> @@ -28,6 +28,7 @@
> #include "display.h"
> 
> static pid_t pager_pid = 0;
> +static int n_columns = FALLBACK_TERMINAL_WIDTH;

hmmm. Wouldn’t be default_num_columns better a bit better here and more descriptive what the variable does?

> 
> bool use_color(void)
> {
> @@ -48,7 +49,8 @@ int num_columns(void)
> 
> 		if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) < 0 ||
> 								ws.ws_col == 0)
> -			cached_num_columns = FALLBACK_TERMINAL_WIDTH;
> +			cached_num_columns = n_columns > 0 ?
> +				n_columns : FALLBACK_TERMINAL_WIDTH;

Just set cached_num_columns = default_num_columns.

> 		else
> 			cached_num_columns = ws.ws_col;
> 	}
> @@ -81,12 +83,14 @@ static void wait_for_terminate(pid_t pid)
> 	}
> }
> 
> -void open_pager(void)
> +void open_pager(int columns)
> {
> 	const char *pager;
> 	pid_t parent_pid;
> 	int fd[2];
> 
> +	n_columns = columns;
> +
> 	if (pager_pid > 0)
> 		return;
> 
> diff --git a/monitor/display.h b/monitor/display.h
> index f3a614b81..97aac8f7a 100644
> --- a/monitor/display.h
> +++ b/monitor/display.h
> @@ -75,5 +75,5 @@ static inline uint64_t print_bitfield(int indent, uint64_t val,
> 
> int num_columns(void);
> 
> -void open_pager(void);
> +void open_pager(int);

I know that this is fine, but don’t do that. Include the parameter name please.

> void close_pager(void);
> diff --git a/monitor/main.c b/monitor/main.c
> index 0f5eb4a3b..23a16660f 100644
> --- a/monitor/main.c
> +++ b/monitor/main.c
> @@ -67,6 +67,7 @@ static void usage(void)
> 		"\t                       Read data from RTT\n"
> 		"\t-R  --rtt [<address>],[<area>],[<name>]\n"
> 		"\t                       RTT control block parameters\n"
> +		"\t-C, --column [width]   Output width if not a terminal\n"
> 		"\t-h, --help             Show help options\n");
> }
> 
> @@ -90,6 +91,7 @@ static const struct option main_options[] = {
> 	{ "no-pager",  no_argument,       NULL, 'P' },
> 	{ "jlink",     required_argument, NULL, 'J' },
> 	{ "rtt",       required_argument, NULL, 'R' },
> +	{ "column",    required_argument, NULL, 'C' },

Not plural “columns” here?

> 	{ "todo",      no_argument,       NULL, '#' },
> 	{ "version",   no_argument,       NULL, 'v' },
> 	{ "help",      no_argument,       NULL, 'h' },
> @@ -110,6 +112,7 @@ int main(int argc, char *argv[])
> 	const char *str;
> 	char *jlink = NULL;
> 	char *rtt = NULL;
> +	int num_columns = 0;
> 	int exit_status;
> 
> 	mainloop_init();
> @@ -121,7 +124,7 @@ int main(int argc, char *argv[])
> 		struct sockaddr_un addr;
> 
> 		opt = getopt_long(argc, argv,
> -					"r:w:a:s:p:i:d:B:V:MNtTSAE:PJ:R:vh",
> +					"r:w:a:s:p:i:d:B:V:MNtTSAE:PJ:R:C:vh",
> 					main_options, NULL);
> 		if (opt < 0)
> 			break;
> @@ -205,6 +208,9 @@ int main(int argc, char *argv[])
> 		case 'R':
> 			rtt = optarg;
> 			break;
> +		case 'C':
> +			num_columns = atoi(optarg);
> +			break;

I would have set here default_num_columns global variable.

> 		case '#':
> 			packet_todo();
> 			lmp_todo();
> @@ -245,7 +251,7 @@ int main(int argc, char *argv[])
> 		if (ellisys_server)
> 			ellisys_enable(ellisys_server, ellisys_port);
> 
> -		control_reader(reader_path, use_pager);
> +		control_reader(reader_path, use_pager, num_columns);
> 		return EXIT_SUCCESS;
> 	}

Regards

Marcel

