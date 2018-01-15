Return-Path: <szymon.janc@codecoup.pl>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] tools: Add initial code for btmon-logger
Date: Mon, 15 Jan 2018 12:55:37 +0100
Message-ID: <3417178.fibeJ9uDTt@ix>
In-Reply-To: <A75F2019-6A6A-4331-B66B-CEE6359E8CA4@holtmann.org>
References: <20180112142546.31424-1-szymon.janc@codecoup.pl> <A75F2019-6A6A-4331-B66B-CEE6359E8CA4@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Friday, 12 January 2018 16:37:01 CET Marcel Holtmann wrote:
> Hi Szymon,
>=20
> > This is intended for use for automted logging or unatrended systems.
> > It doesn't contain any packet decoding functionality which results
> > in much smaller binary.
> > ---
> > .gitignore           |   1 +
> > Makefile.tools       |   6 +
> > tools/btmon-logger.c | 359
> > +++++++++++++++++++++++++++++++++++++++++++++++++++ 3 files changed, 366
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
> > index 651ff00ca..1accfb4f0 100644
> > --- a/Makefile.tools
> > +++ b/Makefile.tools
> > @@ -62,6 +62,12 @@ monitor_btmon_SOURCES =3D monitor/main.c monitor/bt.=
h \
> >=20
> > 				monitor/tty.h
> >=20
> > monitor_btmon_LDADD =3D lib/libbluetooth-internal.la \
> >=20
> > 				src/libshared-mainloop.la @UDEV_LIBS@
> >=20
> > +
> > +
>=20
> one empty line.
>=20
> > +noinst_PROGRAMS +=3D tools/btmon-logger
> > +
> > +tools_btmon_logger_SOURCES =3D tools/btmon-logger.c
> > +tools_btmon_logger_LDADD =3D src/libshared-mainloop.la
> > endif
> >=20
> > if TESTING
> > diff --git a/tools/btmon-logger.c b/tools/btmon-logger.c
> > new file mode 100644
> > index 000000000..fe5f101b4
> > --- /dev/null
> > +++ b/tools/btmon-logger.c
> > @@ -0,0 +1,359 @@
> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2017  Codecoup
>=20
> Lets assume that some of the code is copied from existing btmon sources a=
nd
> so lets keep Intel copyright in place as well :)
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
> > +#include "lib/mgmt.h=E2=80=9D
>=20
> the mgmt.h should not be needed.

This is needed for struct mgmt_hdr definition.

>=20
> > +
> > +#include "src/shared/util.h"
> > +#include "src/shared/mainloop.h"
> > +#include "src/shared/btsnoop.h"
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
> > +static int mgmt_index =3D -1;
>=20
> Initially I would leave this out. Limiting on index seems rather pointles=
s.
>=20
> > +
> > +static int monitor_sk =3D -1;
>=20
> I am certain that can move into main() actually.
>=20
> > +static struct btsnoop *btsnoop_file =3D NULL;
> > +
> > +static bool create_btsnoop(void)
> > +{
> > +	static char real_path[FILENAME_MAX];
> > +
> > +	if (suffix_date) {
> > +		struct timeval tv;
> > +		struct tm tm;
> > +
> > +		memset(&tv, 0, sizeof(tv));
> > +
> > +		gettimeofday(&tv, NULL);
> > +		localtime_r(&tv.tv_sec, &tm);
> > +
> > +		snprintf(real_path, FILENAME_MAX,
> > +				"%s/%s_%04d-%02d-%02d_%02d:%02d:%02d.btsnoop",
> > +				path, prefix, tm.tm_year + 1900, tm.tm_mon + 1,
> > +				tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);
> > +
> > +	} else {
> > +		static unsigned int cnt =3D 0;
> > +
> > +		snprintf(real_path, sizeof(real_path), "%s/%s_%u.btsnoop",
> > +							path, prefix, cnt++);
> > +	}
> > +
> > +	btsnoop_file =3D btsnoop_create(real_path, BTSNOOP_FORMAT_MONITOR);
> > +	if(!btsnoop_file) {
> > +		fprintf(stderr, "Failed to create btsnoop file, exiting.\n");
> > +		return false;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +static void rotate_btsnoop(uint16_t pktlen)
> > +{
> > +	write_size +=3D BTSNOOP_PKT_SIZE + pktlen;
> > +
> > +	if (write_size <=3D write_limit)
> > +		return;
> > +
> > +	write_size =3D BTSNOOP_HDR_SIZE + BTSNOOP_PKT_SIZE + pktlen;
> > +
> > +	btsnoop_unref(btsnoop_file);
> > +
> > +	if (!create_btsnoop())
> > +		mainloop_quit();
> > +}
> > +
> > +static void data_callback(int fd, uint32_t events, void *user_data)
> > +{
> > +	uint8_t buf[BTSNOOP_MAX_PACKET_SIZE];
> > +	unsigned char control[64];
> > +	struct mgmt_hdr hdr;
> > +	struct msghdr msg;
> > +	struct iovec iov[2];
> > +
> > +	if (events & (EPOLLERR | EPOLLHUP)) {
> > +		mainloop_remove_fd(monitor_sk);
> > +		return;
> > +	}
> > +
> > +	iov[0].iov_base =3D &hdr;
> > +	iov[0].iov_len =3D MGMT_HDR_SIZE;
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
> > +		len =3D recvmsg(monitor_sk, &msg, MSG_DONTWAIT);
> > +		if (len < 0)
> > +			break;
> > +
> > +		if (len < MGMT_HDR_SIZE)
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
> > +		if (mgmt_index >=3D 0 && mgmt_index !=3D index)
> > +			continue;
> > +
> > +		if (write_limit)
> > +			rotate_btsnoop(pktlen);
> > +
> > +		btsnoop_write_hci(btsnoop_file, tv, index, opcode, 0, buf,
> > +									pktlen);
> > +	}
> > +}
> > +
> > +static int open_socket(uint16_t channel)
> > +{
> > +	struct sockaddr_hci addr;
> > +	int fd, opt =3D 1;
> > +
> > +	fd =3D socket(AF_BLUETOOTH, SOCK_RAW | SOCK_CLOEXEC, BTPROTO_HCI);
> > +	if (fd < 0) {
> > +		perror("Failed to open channel");
> > +		return -1;
> > +	}
> > +
> > +	memset(&addr, 0, sizeof(addr));
> > +	addr.hci_family =3D AF_BLUETOOTH;
> > +	addr.hci_dev =3D HCI_DEV_NONE;
> > +	addr.hci_channel =3D channel;
> > +
> > +	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> > +		perror("Failed to bind channel");
> > +		close(fd);
> > +		return -1;
> > +	}
> > +
> > +	if (setsockopt(fd, SOL_SOCKET, SO_TIMESTAMP, &opt, sizeof(opt)) < 0) {
> > +		perror("Failed to enable timestamps");
> > +		close(fd);
> > +		return -1;
> > +	}
> > +
> > +	if (setsockopt(fd, SOL_SOCKET, SO_PASSCRED, &opt, sizeof(opt)) < 0) {
> > +		perror("Failed to enable credentials");
> > +		close(fd);
> > +		return -1;
> > +	}
> > +
> > +	return fd;
> > +}
> > +
> > +static bool open_monitor_channel(void)
> > +{
> > +	monitor_sk =3D open_socket(HCI_CHANNEL_MONITOR);
> > +	if (monitor_sk < 0)
> > +		return false;
> > +
> > +	mainloop_add_fd(monitor_sk, EPOLLIN, data_callback, NULL, NULL);
> > +
> > +	return true;
> > +}
>=20
> Combine open monitor and open socket into one since you will only support
> CHANNEL_MONITOR anyway.
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
> > +		"\t-p, --path <path>      Save traces in specified path\n"
> > +		"\t-P, --prefix <name>    Prefix filenames (defaults: \"hci\"\n"
> > +		"\t-d, --date             Suffix filenames with date\n"
> > +		"\t-l, --limit <limit>    Limit btsnoop file size (rotate)\n"
> > +		"\t-i, --index <num>      Log only specified controller\n"
> > +		"\t-v, --version          Show version\n"
> > +		"\t-h, --help             Show help options\n");
> > +}
> > +
> > +static const struct option main_options[] =3D {
> > +	{ "path",	required_argument,	NULL, 'p' },
> > +	{ "prefix",	required_argument,	NULL, 'P' },
> > +	{ "date",	no_argument,		NULL, 'd' },
> > +	{ "limit",	required_argument,	NULL, 'l' },
> > +	{ "index",	required_argument,	NULL, 'i' },
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
> > +
> > +	mainloop_init();
> > +
> > +	while (true) {
> > +		int opt;
> > +
> > +		opt =3D getopt_long(argc, argv, "p:P:dl:iLvh", main_options,
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
> > +		case 'i':
> > +			mgmt_index =3D atoi(optarg);
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
