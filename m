Return-Path: <cyrus@holtmann.org>
Message-ID: <1429852906.2609.13.camel@gmail.com>
Subject: Re: [BlueZ RFC 2/3] monitor: Add btsnoop data link type option
From: Chanyeol Park <chanyeol.park@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	linux-bluetooth@vger.kernel.org, chanyeol.park@samsung.com
Date: Fri, 24 Apr 2015 14:21:46 +0900
In-Reply-To: <2AC37407-D18A-4A49-ACE9-A6FD1B70FF67@holtmann.org>
References: <1429775365-17215-1-git-send-email-chanyeol.park@samsung.com>
	 <1429775365-17215-2-git-send-email-chanyeol.park@samsung.com>
	 <4816983.5v9O5K046c@leonov>
	 <2AC37407-D18A-4A49-ACE9-A6FD1B70FF67@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, 2015-04-23 at 09:53 -0700, Marcel Holtmann wrote:
> Hi Szymon,
> 
> >> Current btmon's btsnoop data link type is BTSNOOP_TYPE_MONITOR(2001)
> >> statically. but some of btsnoop viewer just support BTSNOOP_TYPE_HCI(1001,
> >> so they could not use btmon's btsnoop. If this option is set, they could
> >> parse btsnoop. ---
> >> monitor/control.c | 4 ++--
> >> monitor/control.h | 2 +-
> >> monitor/main.c    | 9 ++++++++-
> >> 3 files changed, 11 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/monitor/control.c b/monitor/control.c
> >> index 00e4bc0..72204bf 100644
> >> --- a/monitor/control.c
> >> +++ b/monitor/control.c
> >> @@ -1124,9 +1124,9 @@ void control_server(const char *path)
> >> 	server_fd = fd;
> >> }
> >> 
> >> -bool control_writer(const char *path)
> >> +bool control_writer(const char *path, uint32_t type)
> >> {
> >> -	btsnoop_file = btsnoop_create(path, BTSNOOP_TYPE_MONITOR);
> >> +	btsnoop_file = btsnoop_create(path, type);
> >> 
> >> 	return !!btsnoop_file;
> >> }
> >> diff --git a/monitor/control.h b/monitor/control.h
> >> index 267d71b..680e6b6 100644
> >> --- a/monitor/control.h
> >> +++ b/monitor/control.h
> >> @@ -24,7 +24,7 @@
> >> 
> >> #include <stdint.h>
> >> 
> >> -bool control_writer(const char *path);
> >> +bool control_writer(const char *path, uint32_t type);
> >> void control_reader(const char *path);
> >> void control_server(const char *path);
> >> int control_tracing(void);
> >> diff --git a/monitor/main.c b/monitor/main.c
> >> index 6e7d4b3..66d7ad1 100644
> >> --- a/monitor/main.c
> >> +++ b/monitor/main.c
> >> @@ -33,6 +33,7 @@
> >> #include <getopt.h>
> >> 
> >> #include "src/shared/mainloop.h"
> >> +#include "src/shared/btsnoop.h"
> >> 
> >> #include "packet.h"
> >> #include "lmp.h"
> >> @@ -66,6 +67,7 @@ static void usage(void)
> >> 		"\t-t, --time             Show time instead of time offset\n"
> >> 		"\t-T, --date             Show time and date information\n"
> >> 		"\t-S, --sco              Dump SCO traffic\n"
> >> +		"\t-H, --hci              Use BTSNOOP_TYPE_HCI\n"
> >> 		"\t-E, --ellisys [ip]     Send Ellisys HCI Injection\n"
> >> 		"\t-h, --help             Show help options\n");
> >> }
> >> @@ -80,6 +82,7 @@ static const struct option main_options[] = {
> >> 	{ "time",    no_argument,       NULL, 't' },
> >> 	{ "date",    no_argument,       NULL, 'T' },
> >> 	{ "sco",     no_argument,	NULL, 'S' },
> >> +	{ "hci",     no_argument,	NULL, 'H' },
> >> 	{ "ellisys", required_argument, NULL, 'E' },
> >> 	{ "todo",    no_argument,       NULL, '#' },
> >> 	{ "version", no_argument,       NULL, 'v' },
> >> @@ -98,6 +101,7 @@ int main(int argc, char *argv[])
> >> 	const char *str;
> >> 	int exit_status;
> >> 	sigset_t mask;
> >> +	uint32_t type = BTSNOOP_TYPE_MONITOR;
> >> 
> >> 	mainloop_init();
> >> 
> >> @@ -151,6 +155,9 @@ int main(int argc, char *argv[])
> >> 		case 'S':
> >> 			filter_mask |= PACKET_FILTER_SHOW_SCO_DATA;
> >> 			break;
> >> +		case 'H':
> >> +			type = BTSNOOP_TYPE_HCI;
> >> +			break;
> >> 		case 'E':
> >> 			ellisys_server = optarg;
> >> 			ellisys_port = 24352;
> >> @@ -210,7 +217,7 @@ int main(int argc, char *argv[])
> >> 		return EXIT_SUCCESS;
> >> 	}
> >> 
> >> -	if (writer_path && !control_writer(writer_path)) {
> >> +	if (writer_path && !control_writer(writer_path, type)) {
> >> 		printf("Failed to open '%s'\n", writer_path);
> >> 		return EXIT_FAILURE;
> >> 	}
> > 
> > This option should be tightly coupled with --index option since legacy format 
> > cannot store index id.
> 
> I do not like this. btmon should always write the new format. Otherwise you are missing the index added and removed extra meta data.
> 
> Regards
> 
> Marcel
> 
Thanks for your opinion. I am not clear which tool(btmon, hcidump,
android hcidump in bluez) is the best option to capture Bluetooth
packets in real products.

As you know tizen uses hcidump. but it seems that development of hcidump
is stopped. So I would like to use btmon instead of hcidump if possible.

Currently our popular Bluetooth analyzer, front line viewer could not
open btmon packet. Is btmon way standard? I could not find it.

If we use your proposal well, I think the index added and removed extra
meta data could be written in hcidump file name, for example
foo_leagacy_hci0_12:34:56.log only when user wants.

Regards
Chanyeol

