Return-Path: <szymon.janc@codecoup.pl>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/3] tools: Add initial code for btmon-logger
Date: Mon, 05 Mar 2018 12:10:12 +0100
Message-ID: <6699189.7jNOSx0g8N@ix>
In-Reply-To: <BDF34253-B808-488A-A198-9B2A2E0A27B3@holtmann.org>
References: <20180219134608.14189-1-szymon.janc@codecoup.pl> <BDF34253-B808-488A-A198-9B2A2E0A27B3@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Monday, 26 February 2018 14:59:42 CET Marcel Holtmann wrote:
> Hi Szymon,
>=20
> > This is intended for use for automated logging or unatrended systems.
>=20
> unattended.
>=20
> > It doesn't contain any packet decoding functionality which results
> > in much smaller binary.
> > ---
> > .gitignore           |   1 +
> > Makefile.tools       |   5 +
> > tools/btmon-logger.c | 350
> > +++++++++++++++++++++++++++++++++++++++++++++++++++ 3 files changed, 356
> > insertions(+)
> > create mode 100644 tools/btmon-logger.c
> >=20
> > diff --git a/.gitignore b/.gitignore
> > index 47808059b..33ec66048 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -118,6 +118,7 @@ tools/btconfig
> > tools/btmgmt
> > tools/btsnoop
> > tools/btpclient
> > +tools/btmon-logger
> > peripheral/btsensor
> > monitor/btmon
> > emulator/btvirt
> > diff --git a/Makefile.tools b/Makefile.tools
> > index 71d083e71..ba4b9b7d7 100644
> > --- a/Makefile.tools
> > +++ b/Makefile.tools
> > @@ -62,6 +62,11 @@ monitor_btmon_SOURCES =3D monitor/main.c monitor/bt.=
h \
> >=20
> > 				monitor/tty.h
> >=20
> > monitor_btmon_LDADD =3D lib/libbluetooth-internal.la \
> >=20
> > 				src/libshared-mainloop.la @UDEV_LIBS@
> >=20
> > +
> > +noinst_PROGRAMS +=3D tools/btmon-logger
> > +
>=20
> We can keep it initially noinst here, but what is longer term plan. Give =
it
> its own configure switch or make it available when btmon is enabled. I
> think we need to treat this as a service and also provide a systemd unit
> file for it.
>=20
> If we do it via systemd unit files, then we can give the right path as
> current dir and take all the privileges and other path access away since
> nothing else is needed. Actually too bad that systemd can not start us wi=
th
> the monitor socket opened, because then we could run without any extra
> privileges. Anyhow, we should drop CAP_NET_RAW once we open the monitor
> socket.

I wasn't sure initially on how this will be handled but I'm fine with=20
configure switch (--btmon-service ?) and adding systemd service file.

> > +tools_btmon_logger_SOURCES =3D tools/btmon-logger.c lib/monitor.h
> > +tools_btmon_logger_LDADD =3D src/libshared-mainloop.la
> > endif
> >=20
> > if TESTING
> > diff --git a/tools/btmon-logger.c b/tools/btmon-logger.c
> > new file mode 100644
> > index 000000000..9787e6b03
> > --- /dev/null
> > +++ b/tools/btmon-logger.c
> > @@ -0,0 +1,350 @@
> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2017-2018  Codecoup
> > + *  Copyright (C) 2011-2014  Intel Corporation
> > + *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
> > + *
> > + *
> > + *  This program is free software; you can redistribute it and/or modi=
fy
> > + *  it under the terms of the GNU General Public License as published =
by
> > + *  the Free Software Foundation; either version 2 of the License, or
> > + *  (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public License
> > + *  along with this program; if not, write to the Free Software
> > + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1=
301
> >  USA + *
> > + */
> > +
> > +#ifdef HAVE_CONFIG_H
> > +#include <config.h>
> > +#endif
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <limits.h>
> > +#include <string.h>
> > +#include <time.h>
> > +#include <getopt.h>
> > +#include <unistd.h>
> > +#include <sys/socket.h>
> > +
> > +#include "lib/bluetooth.h"
> > +#include "lib/hci.h"
> > +
> > +#include "src/shared/util.h"
> > +#include "src/shared/mainloop.h"
> > +#include "src/shared/btsnoop.h"
> > +
> > +#define MONITOR_INDEX_NONE 0xffff
> > +
> > +struct monitor_hdr {
> > +	uint16_t opcode;
> > +	uint16_t index;
> > +	uint16_t len;
> > +} __attribute__ ((packed));
> > +
> > +struct btsnoop_hdr {
> > +	uint8_t		id[8];		/* Identification Pattern */
> > +	uint32_t	version;	/* Version Number =3D 1 */
> > +	uint32_t	type;		/* Datalink Type */
> > +} __attribute__ ((packed));
> > +#define BTSNOOP_HDR_SIZE (sizeof(struct btsnoop_hdr))
> > +
> > +struct btsnoop_pkt {
> > +	uint32_t	size;		/* Original Length */
> > +	uint32_t	len;		/* Included Length */
> > +	uint32_t	flags;		/* Packet Flags */
> > +	uint32_t	drops;		/* Cumulative Drops */
> > +	uint64_t	ts;		/* Timestamp microseconds */
> > +	uint8_t		data[0];	/* Packet Data */
> > +} __attribute__ ((packed));
> > +#define BTSNOOP_PKT_SIZE (sizeof(struct btsnoop_pkt))
> > +
> > +static const char *path =3D ".";
> > +static const char *prefix =3D "hci";
> > +static bool suffix_date =3D false;
> > +static size_t write_limit =3D 0;
> > +static size_t write_size =3D 0;
> > +
> > +static struct btsnoop *btsnoop_file =3D NULL;
> > +
> > +static bool create_btsnoop(void)
> > +{
> > +	static char real_path[FILENAME_MAX];
> > +	struct timeval tv;
> > +
> > +	gettimeofday(&tv, NULL);
> > +
> > +	if (suffix_date) {
> > +		struct tm tm;
> > +
> > +		localtime_r(&tv.tv_sec, &tm);
> > +
> > +		snprintf(real_path, FILENAME_MAX,
> > +				"%s/%s_%04d-%02d-%02d_%02d:%02d:%02d.btsnoop",
> > +				path, prefix, tm.tm_year + 1900, tm.tm_mon + 1,
> > +				tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);
> > +	} else {
> > +		static unsigned int cnt =3D 0;
> > +
> > +		snprintf(real_path, sizeof(real_path), "%s/%s_%u.btsnoop",
> > +							path, prefix, cnt++);
> > +	}
> > +
> > +	btsnoop_file =3D btsnoop_create(real_path, BTSNOOP_FORMAT_MONITOR);
> > +	if(!btsnoop_file)
>=20
> Missing space.
>=20
> > +		return false;
> > +
> > +	write_size =3D BTSNOOP_HDR_SIZE;
> > +
> > +	return true;
> > +}
>=20
> And I have the feeling that it would be best to put that code all in
> src/shared/btsnoop.c so that we have a more generic rotate function and
> don=E2=80=99t have to play tricks with the struct btsnoop pointer.

OK. I'll see on how this works out.

> > +
> > +static void rotate_btsnoop(uint16_t pktlen)
> > +{
> > +	write_size +=3D BTSNOOP_PKT_SIZE + pktlen;
> > +
> > +	if (write_size <=3D write_limit)
> > +		return;
> > +
> > +	btsnoop_unref(btsnoop_file);
> > +
> > +	if (!create_btsnoop()) {
> > +		fprintf(stderr, "Failed to create btsnoop file, exiting.\n");
> > +		mainloop_quit();
> > +		return;
> > +	}
> > +
> > +	write_size +=3D BTSNOOP_PKT_SIZE + pktlen;
> > +}
> > +
> > +static void data_callback(int fd, uint32_t events, void *user_data)
> > +{
> > +	uint8_t buf[BTSNOOP_MAX_PACKET_SIZE];
> > +	unsigned char control[64];
> > +	struct monitor_hdr hdr;
> > +	struct msghdr msg;
> > +	struct iovec iov[2];
> > +
> > +	if (events & (EPOLLERR | EPOLLHUP)) {
> > +		mainloop_remove_fd(fd);
> > +		return;
> > +	}
> > +
> > +	iov[0].iov_base =3D &hdr;
> > +	iov[0].iov_len =3D sizeof(hdr);
> > +	iov[1].iov_base =3D buf;
> > +	iov[1].iov_len =3D sizeof(buf);
> > +
> > +	memset(&msg, 0, sizeof(msg));
> > +	msg.msg_iov =3D iov;
> > +	msg.msg_iovlen =3D 2;
> > +	msg.msg_control =3D control;
> > +	msg.msg_controllen =3D sizeof(control);
> > +
> > +	while (1) {
> > +		struct cmsghdr *cmsg;
> > +		struct timeval *tv =3D NULL;
> > +		struct timeval ctv;
> > +		uint16_t opcode, index, pktlen;
> > +		ssize_t len;
> > +
> > +		len =3D recvmsg(fd, &msg, MSG_DONTWAIT);
> > +		if (len < 0)
> > +			break;
> > +
> > +		if (len < (ssize_t) sizeof(hdr))
> > +			break;
> > +
> > +		for (cmsg =3D CMSG_FIRSTHDR(&msg); cmsg !=3D NULL;
> > +					cmsg =3D CMSG_NXTHDR(&msg, cmsg)) {
> > +			if (cmsg->cmsg_level !=3D SOL_SOCKET)
> > +				continue;
> > +
> > +			if (cmsg->cmsg_type =3D=3D SCM_TIMESTAMP) {
> > +				memcpy(&ctv, CMSG_DATA(cmsg), sizeof(ctv));
> > +				tv =3D &ctv;
> > +			}
> > +		}
> > +
> > +		opcode =3D le16_to_cpu(hdr.opcode);
> > +		index  =3D le16_to_cpu(hdr.index);
> > +		pktlen =3D le16_to_cpu(hdr.len);
> > +
> > +		if (write_limit)
> > +			rotate_btsnoop(pktlen);
>=20
> Sounds rather pointless to do a check here for write_limit and then check
> everything else in the function. Which is still wrongly named since it is=
 a
> maybe_rotate_btsnoop what is actually happening. Fold it all into one pla=
ce
> and name it accordingly.
> > +
> > +		btsnoop_write_hci(btsnoop_file, tv, index, opcode, 0, buf,
> > +									pktlen);
> > +	}
> > +}
> > +
> > +static bool open_monitor_channel(void)
> > +{
> > +	struct sockaddr_hci addr;
> > +	int fd, opt =3D 1;
> > +
> > +	fd =3D socket(AF_BLUETOOTH, SOCK_RAW | SOCK_CLOEXEC, BTPROTO_HCI);
> > +	if (fd < 0) {
> > +		perror("Failed to open monitor channel");
> > +		return false;
> > +	}
> > +
> > +	memset(&addr, 0, sizeof(addr));
> > +	addr.hci_family =3D AF_BLUETOOTH;
> > +	addr.hci_dev =3D HCI_DEV_NONE;
> > +	addr.hci_channel =3D HCI_CHANNEL_MONITOR;
> > +
> > +	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> > +		perror("Failed to bind monitor channel");
> > +		close(fd);
> > +		return false;
> > +	}
> > +
> > +	if (setsockopt(fd, SOL_SOCKET, SO_TIMESTAMP, &opt, sizeof(opt)) < 0) {
> > +		perror("Failed to enable timestamps");
> > +		close(fd);
> > +		return false;
> > +	}
> > +
> > +	if (setsockopt(fd, SOL_SOCKET, SO_PASSCRED, &opt, sizeof(opt)) < 0) {
> > +		perror("Failed to enable credentials");
> > +		close(fd);
> > +		return false;
> > +	}
> > +
> > +	mainloop_add_fd(fd, EPOLLIN, data_callback, NULL, NULL);
> > +
> > +	return true;
> > +}
> > +
> > +static void signal_callback(int signum, void *user_data)
> > +{
> > +	switch (signum) {
> > +	case SIGINT:
> > +	case SIGTERM:
> > +		mainloop_quit();
> > +		break;
> > +	}
> > +}
> > +
> > +static void usage(void)
> > +{
> > +	printf("btmon-logger - Bluetooth monitor\n"
> > +		"Usage:\n");
> > +	printf("\tbtmon-logger [options]\n");
> > +	printf("options:\n"
> > +		"\t-p, --path <path>      Save traces in specified path\n=E2=80=9D
>=20
> Should be current path if nothing is provided.

OK.

>=20
> > +		"\t-P, --prefix <name>    Prefix filenames (defaults: \"hci\"\n=E2=
=80=9D
>=20
> that part is generally called basename. And default basename should be
> hci.log actually.
> > +		"\t-d, --date             Suffix filenames with date\n=E2=80=9D
>=20
> As discussed, I do not like the idea of a data suffix at all. That seems =
all
> pointless to be for no gain. You are trying to make something human
> readable which is clearly not. If people want to extra ranges from a set =
of
> log traces, then btmon (or btsnoop utility) can gain that functionality.
> However here, I prefer that we do a simple path/basename.1 style.
>=20
> Also path/basename will be the current file and all other numeration will=
 be
> increased and thus files moved along. Same as what logrotate and others a=
re
> actually doing. I kind dislike breaking with known way how others are
> handled.

So it should be initialy=20
path/basename.log

and then goes to
path/basename.log -> path/basename.log.1

and then
path/basename.log -> path/basename.log.1
path/basename.log.1 -> path/basename.log.2

?

> > +		"\t-l, --limit <limit>    Limit btsnoop file size (rotate)\n=E2=80=9D
>=20
> We also need a directory size limit after which the oldest files will be
> deleted. This can be as simple as n * limit.
> > +		"\t-v, --version          Show version\n"
> > +		"\t-h, --help             Show help options\n");
> > +}
> > +
> > +static const struct option main_options[] =3D {
> > +	{ "path",	required_argument,	NULL, 'p' },
> > +	{ "prefix",	required_argument,	NULL, 'P' },
> > +	{ "date",	no_argument,		NULL, 'd' },
> > +	{ "limit",	required_argument,	NULL, 'l' },
> > +	{ "version",	no_argument,		NULL, 'v' },
> > +	{ "help",	no_argument,		NULL, 'h' },
> > +	{ }
> > +};
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	sigset_t mask;
> > +	char *endptr;
> > +	int ret;
>=20
> I am using exit_status for these kind of main() return values.
>=20
> > +
> > +	mainloop_init();
> > +
> > +	while (true) {
> > +		int opt;
> > +
> > +		opt =3D getopt_long(argc, argv, "p:P:dl:Lvh", main_options,
> > +									NULL);
> > +		if (opt < 0)
> > +			break;
> > +
> > +		switch (opt) {
> > +		case 'p':
> > +			path =3D optarg;
> > +			if (strlen(path) > PATH_MAX) {
> > +				fprintf(stderr, "Too long path\n");
> > +				return EXIT_FAILURE;
> > +			}
> > +			break;
> > +		case 'P':
> > +			prefix =3D optarg;
> > +			break;
> > +		case 'd':
> > +			suffix_date =3D true;
> > +			break;
> > +		case 'l':
> > +			write_limit =3D strtoul(optarg, &endptr, 10);
> > +
> > +			if (write_limit =3D=3D ULONG_MAX) {
> > +				fprintf(stderr, "Invalid limit\n");
> > +				return EXIT_FAILURE;
> > +			}
> > +
> > +			if (*endptr !=3D '\0') {
> > +				if (*endptr =3D=3D 'K' || *endptr =3D=3D 'k') {
> > +					write_limit *=3D 1024;
> > +				} else if (*endptr =3D=3D 'M' || *endptr =3D=3D 'm') {
> > +					write_limit *=3D 1024 * 1024;
> > +				} else {
> > +					fprintf(stderr, "Invalid limit\n");
> > +					return EXIT_FAILURE;
> > +				}
> > +			}
> > +
> > +			/* limit this to reasonable size */
> > +			if (write_limit < 4096) {
> > +				fprintf(stderr, "Too small limit value\n");
> > +				return EXIT_FAILURE;
> > +			}
> > +			break;
> > +		case 'v':
> > +			printf("%s\n", VERSION);
> > +			return EXIT_SUCCESS;
> > +		case 'h':
> > +			usage();
> > +			return EXIT_SUCCESS;
> > +		default:
> > +			return EXIT_FAILURE;
> > +		}
> > +	}
> > +
> > +	if (argc - optind > 0) {
> > +		fprintf(stderr, "Invalid command line parameters\n");
> > +		return EXIT_FAILURE;
> > +	}
> > +
> > +	if (!open_monitor_channel() || !create_btsnoop())
> > +		return EXIT_FAILURE;
>=20
> Can we please clean up properly.
>=20
> > +
> > +	sigemptyset(&mask);
> > +	sigaddset(&mask, SIGINT);
> > +	sigaddset(&mask, SIGTERM);
> > +
> > +	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
> > +
> > +	printf("Bluetooth monitor ver %s\n", VERSION);
> > +
> > +	ret =3D mainloop_run();
> > +
> > +	btsnoop_unref(btsnoop_file);
> > +
> > +	return ret;
> > +}
>=20
> Regards
>=20
> Marcel


=2D-=20
pozdrawiam
Szymon Janc
