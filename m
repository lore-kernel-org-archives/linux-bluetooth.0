Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v5] tools: Add initial code for btmon-logger
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180405093127.6179-1-szymon.janc@codecoup.pl>
Date: Wed, 18 Apr 2018 09:30:28 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A4CEA44D-B5F3-49CA-BCEB-B2598D8764E1@holtmann.org>
References: <20180405093127.6179-1-szymon.janc@codecoup.pl>
To: Szymon Janc <szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> This is intended for use for automated logging or unatrended systems.
> It doesn't contain any packet decoding functionality which results
> in much smaller binary.
> ---
> .gitignore                    |   2 +
> Makefile.tools                |  16 ++
> android/bluetoothd-snoop.c    |   2 +-
> bootstrap-configure           |   1 +
> configure.ac                  |   4 +
> monitor/control.c             |   2 +-
> src/shared/btsnoop.c          |  75 ++++++++-
> src/shared/btsnoop.h          |   3 +-
> tools/btmon-logger.c          | 366 ++++++++++++++++++++++++++++++++++++++++++
> tools/btmon-logger.service.in |  14 ++
> 10 files changed, 480 insertions(+), 5 deletions(-)
> create mode 100644 tools/btmon-logger.c
> create mode 100644 tools/btmon-logger.service.in
> 
> diff --git a/.gitignore b/.gitignore
> index 47808059b..2c5cf0f83 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -118,6 +118,8 @@ tools/btconfig
> tools/btmgmt
> tools/btsnoop
> tools/btpclient
> +tools/btmon-logger
> +tools/btmon-logger.service

I would actually use bluetooth-logger.service here. It is bluetooth.service and bluetooth-logger.service which makes this a bit more consistent.

> peripheral/btsensor
> monitor/btmon
> emulator/btvirt
> diff --git a/Makefile.tools b/Makefile.tools
> index f7ab77de1..71d0d2f69 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -66,6 +66,22 @@ monitor_btmon_LDADD = lib/libbluetooth-internal.la \
> 				src/libshared-mainloop.la @UDEV_LIBS@
> endif
> 
> +if LOGGER
> +libexec_PROGRAMS += tools/btmon-logger
> +
> +tools_btmon_logger_SOURCES = tools/btmon-logger.c lib/monitor.h
> +tools_btmon_logger_LDADD = src/libshared-mainloop.la
> +tools_btmon_logger_DEPENDENCIES = src/libshared-mainloop.la \
> +					tools/btmon-logger.service
> +
> +if SYSTEMD
> +systemdsystemunit_DATA += tools/btmon-logger.service
> +endif
> +endif
> +
> +CLEANFILES += tools/btmon-logger.service
> +EXTRA_DIST += tools/btmon-logger.service.in
> +
> if TESTING
> noinst_PROGRAMS += emulator/btvirt emulator/b1ee emulator/hfp \
> 					peripheral/btsensor tools/3dsp \
> diff --git a/android/bluetoothd-snoop.c b/android/bluetoothd-snoop.c
> index 4b096632a..8d9a2d087 100644
> --- a/android/bluetoothd-snoop.c
> +++ b/android/bluetoothd-snoop.c
> @@ -148,7 +148,7 @@ static int open_monitor(const char *path)
> 	struct sockaddr_hci addr;
> 	int opt = 1;
> 
> -	snoop = btsnoop_create(path, BTSNOOP_FORMAT_HCI);
> +	snoop = btsnoop_create(path, 0, 0, BTSNOOP_FORMAT_HCI);
> 	if (!snoop)
> 		return -1;
> 
> diff --git a/bootstrap-configure b/bootstrap-configure
> index 658eef296..b14b4553b 100755
> --- a/bootstrap-configure
> +++ b/bootstrap-configure
> @@ -24,4 +24,5 @@ fi
> 		--enable-sixaxis \
> 		--enable-midi \
> 		--enable-mesh \
> +		--enable-logger \
> 		--disable-datafiles $*
> diff --git a/configure.ac b/configure.ac
> index db46d6f07..5132131f2 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -327,6 +327,10 @@ AC_ARG_ENABLE(sixaxis, AC_HELP_STRING([--enable-sixaxis],
> AM_CONDITIONAL(SIXAXIS, test "${enable_sixaxis}" = "yes" &&
> 					 test "${enable_udev}" != "no")
> 
> +AC_ARG_ENABLE(logger, AC_HELP_STRING([--enable-logger],
> +		[enable HCI logger service]), [enable_logger=${enableval}])
> +AM_CONDITIONAL(LOGGER, test "${enable_logger}" = "yes")
> +
> if (test "${prefix}" = "NONE"); then
> 	dnl no prefix and no localstatedir, so default to /var
> 	if (test "$localstatedir" = '${prefix}/var'); then
> diff --git a/monitor/control.c b/monitor/control.c
> index 1cd79ca5d..6330fff96 100644
> --- a/monitor/control.c
> +++ b/monitor/control.c
> @@ -1373,7 +1373,7 @@ int control_tty(const char *path, unsigned int speed)
> 
> bool control_writer(const char *path)
> {
> -	btsnoop_file = btsnoop_create(path, BTSNOOP_FORMAT_MONITOR);
> +	btsnoop_file = btsnoop_create(path, 0, 0, BTSNOOP_FORMAT_MONITOR);
> 
> 	return !!btsnoop_file;
> }
> diff --git a/src/shared/btsnoop.c b/src/shared/btsnoop.c
> index e20d1b382..a3803e184 100644
> --- a/src/shared/btsnoop.c
> +++ b/src/shared/btsnoop.c
> @@ -30,6 +30,8 @@
> #include <unistd.h>
> #include <stdlib.h>
> #include <string.h>
> +#include <stdio.h>
> +#include <limits.h>
> #include <arpa/inet.h>
> #include <sys/stat.h>
> 
> @@ -73,6 +75,11 @@ struct btsnoop {
> 	bool aborted;
> 	bool pklg_format;
> 	bool pklg_v2;
> +	const char *path;
> +	size_t max_size;
> +	size_t cur_size;
> +	unsigned int max_count;
> +	unsigned int cur_count;
> };
> 
> struct btsnoop *btsnoop_open(const char *path, unsigned long flags)
> @@ -131,17 +138,31 @@ failed:
> 	return NULL;
> }
> 
> -struct btsnoop *btsnoop_create(const char *path, uint32_t format)
> +struct btsnoop *btsnoop_create(const char *path, size_t max_size,
> +					unsigned int max_count, uint32_t format)
> {
> 	struct btsnoop *btsnoop;
> 	struct btsnoop_hdr hdr;
> +	const char *real_path;
> +	char tmp[PATH_MAX];
> 	ssize_t written;
> 
> +	if (!max_size && max_count)
> +		return NULL;
> +
> 	btsnoop = calloc(1, sizeof(*btsnoop));
> 	if (!btsnoop)
> 		return NULL;
> 
> -	btsnoop->fd = open(path, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC,
> +	/* If max file size is specified, always add counter to file path */
> +	if (max_size) {
> +		snprintf(tmp, PATH_MAX, "%s.0", path);
> +		real_path = tmp;
> +	} else {
> +		real_path = path;
> +	}
> +
> +	btsnoop->fd = open(real_path, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC,
> 					S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
> 	if (btsnoop->fd < 0) {
> 		free(btsnoop);
> @@ -150,6 +171,9 @@ struct btsnoop *btsnoop_create(const char *path, uint32_t format)
> 
> 	btsnoop->format = format;
> 	btsnoop->index = 0xffff;
> +	btsnoop->path = path;
> +	btsnoop->max_count = max_count;
> +	btsnoop->max_size = max_size;
> 
> 	memcpy(hdr.id, btsnoop_id, sizeof(btsnoop_id));
> 	hdr.version = htobe32(btsnoop_version);
> @@ -162,6 +186,8 @@ struct btsnoop *btsnoop_create(const char *path, uint32_t format)
> 		return NULL;
> 	}
> 
> +	btsnoop->cur_size = BTSNOOP_HDR_SIZE;
> +
> 	return btsnoop_ref(btsnoop);
> }
> 
> @@ -197,6 +223,42 @@ uint32_t btsnoop_get_format(struct btsnoop *btsnoop)
> 	return btsnoop->format;
> }
> 
> +static bool btsnoop_rotate(struct btsnoop *btsnoop)
> +{
> +	struct btsnoop_hdr hdr;
> +	char path[PATH_MAX];
> +	ssize_t written;
> +
> +	close(btsnoop->fd);
> +
> +	/* Check if max number of log files has been reached */
> +	if (btsnoop->max_count && btsnoop->cur_count >= btsnoop->max_count) {
> +		snprintf(path, PATH_MAX, "%s.%u", btsnoop->path,
> +				btsnoop->cur_count - btsnoop->max_count);
> +		unlink(path);
> +	}
> +
> +	snprintf(path, PATH_MAX,"%s.%u", btsnoop->path, btsnoop->cur_count);
> +	btsnoop->cur_count++;
> +
> +	btsnoop->fd = open(path, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC,
> +					S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
> +	if (btsnoop->fd < 0)
> +		return false;
> +
> +	memcpy(hdr.id, btsnoop_id, sizeof(btsnoop_id));
> +	hdr.version = htobe32(btsnoop_version);
> +	hdr.type = htobe32(btsnoop->format);
> +
> +	written = write(btsnoop->fd, &hdr, BTSNOOP_HDR_SIZE);
> +	if (written < 0)
> +		return false;
> +
> +	btsnoop->cur_size = BTSNOOP_HDR_SIZE;
> +
> +	return true;
> +}
> +
> bool btsnoop_write(struct btsnoop *btsnoop, struct timeval *tv,
> 			uint32_t flags, uint32_t drops, const void *data,
> 			uint16_t size)
> @@ -208,6 +270,11 @@ bool btsnoop_write(struct btsnoop *btsnoop, struct timeval *tv,
> 	if (!btsnoop || !tv)
> 		return false;
> 
> +	if (btsnoop->max_size && btsnoop->max_size <=
> +			btsnoop->cur_size + size + BTSNOOP_PKT_SIZE)
> +		if (!btsnoop_rotate(btsnoop))
> +			return false;
> +
> 	ts = (tv->tv_sec - 946684800ll) * 1000000ll + tv->tv_usec;
> 
> 	pkt.size  = htobe32(size);
> @@ -220,12 +287,16 @@ bool btsnoop_write(struct btsnoop *btsnoop, struct timeval *tv,
> 	if (written < 0)
> 		return false;
> 
> +	btsnoop->cur_size += BTSNOOP_PKT_SIZE;
> +
> 	if (data && size > 0) {
> 		written = write(btsnoop->fd, data, size);
> 		if (written < 0)
> 			return false;
> 	}
> 
> +	btsnoop->cur_size += size;
> +
> 	return true;
> }
> 
> diff --git a/src/shared/btsnoop.h b/src/shared/btsnoop.h
> index 3df8998a3..3043d33e2 100644
> --- a/src/shared/btsnoop.h
> +++ b/src/shared/btsnoop.h
> @@ -99,7 +99,8 @@ struct btsnoop_opcode_user_logging {
> struct btsnoop;
> 
> struct btsnoop *btsnoop_open(const char *path, unsigned long flags);
> -struct btsnoop *btsnoop_create(const char *path, uint32_t format);
> +struct btsnoop *btsnoop_create(const char *path, size_t max_size,
> +				unsigned int max_count, uint32_t format);
> 
> struct btsnoop *btsnoop_ref(struct btsnoop *btsnoop);
> void btsnoop_unref(struct btsnoop *btsnoop);
> diff --git a/tools/btmon-logger.c b/tools/btmon-logger.c
> new file mode 100644
> index 000000000..0dd2b3a09
> --- /dev/null
> +++ b/tools/btmon-logger.c
> @@ -0,0 +1,366 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2017-2018  Codecoup
> + *  Copyright (C) 2011-2014  Intel Corporation
> + *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
> + *
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <limits.h>
> +#include <string.h>
> +#include <time.h>
> +#include <getopt.h>
> +#include <unistd.h>
> +#include <sys/socket.h>
> +#include <sys/stat.h>
> +#include <libgen.h>
> +#include <errno.h>
> +
> +#include <linux/capability.h>
> +
> +#include "lib/bluetooth.h"
> +#include "lib/hci.h"
> +
> +#include "src/shared/util.h"
> +#include "src/shared/mainloop.h"
> +#include "src/shared/btsnoop.h”

Extra empty line here.

> +#define MONITOR_INDEX_NONE 0xffff
> +
> +struct monitor_hdr {
> +	uint16_t opcode;
> +	uint16_t index;
> +	uint16_t len;
> +} __attribute__ ((packed));
> +
> +static struct btsnoop *btsnoop_file = NULL;
> +
> +static void data_callback(int fd, uint32_t events, void *user_data)
> +{
> +	uint8_t buf[BTSNOOP_MAX_PACKET_SIZE];
> +	unsigned char control[64];
> +	struct monitor_hdr hdr;
> +	struct msghdr msg;
> +	struct iovec iov[2];
> +
> +	if (events & (EPOLLERR | EPOLLHUP)) {
> +		mainloop_remove_fd(fd);
> +		return;
> +	}
> +
> +	iov[0].iov_base = &hdr;
> +	iov[0].iov_len = sizeof(hdr);
> +	iov[1].iov_base = buf;
> +	iov[1].iov_len = sizeof(buf);
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.msg_iov = iov;
> +	msg.msg_iovlen = 2;
> +	msg.msg_control = control;
> +	msg.msg_controllen = sizeof(control);
> +
> +	while (1) {
> +		struct cmsghdr *cmsg;
> +		struct timeval *tv = NULL;
> +		struct timeval ctv;
> +		uint16_t opcode, index, pktlen;
> +		ssize_t len;
> +
> +		len = recvmsg(fd, &msg, MSG_DONTWAIT);
> +		if (len < 0)
> +			break;
> +
> +		if (len < (ssize_t) sizeof(hdr))
> +			break;
> +
> +		for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL;
> +					cmsg = CMSG_NXTHDR(&msg, cmsg)) {
> +			if (cmsg->cmsg_level != SOL_SOCKET)
> +				continue;
> +
> +			if (cmsg->cmsg_type == SCM_TIMESTAMP) {
> +				memcpy(&ctv, CMSG_DATA(cmsg), sizeof(ctv));
> +				tv = &ctv;
> +			}
> +		}
> +
> +		opcode = le16_to_cpu(hdr.opcode);
> +		index  = le16_to_cpu(hdr.index);
> +		pktlen = le16_to_cpu(hdr.len);
> +
> +		btsnoop_write_hci(btsnoop_file, tv, index, opcode, 0, buf,
> +									pktlen);
> +	}
> +}
> +
> +static bool open_monitor_channel(void)
> +{
> +	struct sockaddr_hci addr;
> +	int fd, opt = 1;
> +
> +	fd = socket(AF_BLUETOOTH, SOCK_RAW | SOCK_CLOEXEC, BTPROTO_HCI);
> +	if (fd < 0) {
> +		perror("Failed to open monitor channel");
> +		return false;
> +	}
> +
> +	memset(&addr, 0, sizeof(addr));
> +	addr.hci_family = AF_BLUETOOTH;
> +	addr.hci_dev = HCI_DEV_NONE;
> +	addr.hci_channel = HCI_CHANNEL_MONITOR;
> +
> +	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> +		perror("Failed to bind monitor channel");
> +		close(fd);
> +		return false;
> +	}
> +
> +	if (setsockopt(fd, SOL_SOCKET, SO_TIMESTAMP, &opt, sizeof(opt)) < 0) {
> +		perror("Failed to enable timestamps");
> +		close(fd);
> +		return false;
> +	}
> +
> +	if (setsockopt(fd, SOL_SOCKET, SO_PASSCRED, &opt, sizeof(opt)) < 0) {
> +		perror("Failed to enable credentials");
> +		close(fd);
> +		return false;
> +	}
> +
> +	mainloop_add_fd(fd, EPOLLIN, data_callback, NULL, NULL);
> +
> +	return true;
> +}
> +
> +static void signal_callback(int signum, void *user_data)
> +{
> +	switch (signum) {
> +	case SIGINT:
> +	case SIGTERM:
> +		mainloop_quit();
> +		break;
> +	}
> +}
> +
> +extern int capget(struct __user_cap_header_struct *header,
> +					struct __user_cap_data_struct *data);
> +extern int capset(struct __user_cap_header_struct *header,
> +				const struct __user_cap_data_struct *data);
> +
> +static void drop_capabilities(void)
> +{
> +	struct __user_cap_header_struct header;
> +	struct __user_cap_data_struct cap;
> +	unsigned int mask;
> +	int err;
> +
> +	header.version = _LINUX_CAPABILITY_VERSION_3;
> +	header.pid = 0;
> +
> +	err = capget(&header, &cap);
> +	if (err) {
> +		perror("Unable to get current capabilities");
> +		return;
> +	}
> +
> +	/* not needed anymore since mgmt socket is already open */
> +	mask = ~CAP_TO_MASK(CAP_NET_RAW);
> +
> +	cap.effective &= mask;
> +	cap.permitted &= mask;
> +	cap.inheritable &= mask;
> +
> +	err = capset(&header, &cap);
> +	if (err)
> +		perror("Failed to set capabilities");
> +}
> +
> +static void usage(void)
> +{
> +	printf("btmon-logger - Bluetooth monitor\n"
> +		"Usage:\n");
> +	printf("\tbtmon-logger [options]\n");
> +	printf("options:\n"
> +		"\t-b, --basename <path>  Save traces in specified path\n”

I would add a -p, --parents options here to create parent directories as needed. I think for security purposes this should be optional and only used from the service file. When run from command line, it should actually fail if the directory does not exist.

> +		"\t-l, --limit <limit>    Limit traces file size (rotate)\n"
> +		"\t-c, --count <count>    Limit number of rotated files\n"
> +		"\t-v, --version          Show version\n"
> +		"\t-h, --help             Show help options\n");
> +}
> +
> +static const struct option main_options[] = {
> +	{ "basename",	required_argument,	NULL, 'b' },
> +	{ "limit",	required_argument,	NULL, 'l' },
> +	{ "count",	required_argument,	NULL, 'c' },
> +	{ "version",	no_argument,		NULL, 'v' },
> +	{ "help",	no_argument,		NULL, 'h' },
> +	{ }
> +};
> +
> +static int create_dir(const char *filename)
> +{
> +	char *dirc;
> +	char *dir;
> +	char *p;
> +	int err = 0;
> +
> +	/* get base directory */
> +	dirc = strdup(filename);
> +	dir = dirname(dirc);
> +
> +	p = dir;
> +
> +	/* preserve leading / if present */
> +	if (*p == '/')
> +		p++;
> +
> +	/* create any intermediate directories */
> +	p = strchrnul(p, '/');
> +	while (*p) {
> +		/* cut directory path */
> +		*p = '\0';
> +
> +		if (mkdir(dir, 0700) < 0 && errno != EEXIST) {
> +			err = errno;
> +			goto done;
> +		}
> +
> +		/* restore directory path */
> +		*p = '/';
> +		p = strchrnul(p + 1, '/');
> +	}
> +
> +	/* create leaf directory */
> +	if (mkdir(dir, 0700) < 0 && errno != EEXIST)
> +		err = errno;
> +
> +done:
> +	free(dirc);
> +
> +	if (err)
> +		printf("Failed to create intermediate directories for %s\n",
> +								filename);
> +
> +	return err;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	const char *path = "hci.log";
> +	unsigned long max_count = 0;
> +	size_t size_limit = 0;
> +	int exit_status;
> +	sigset_t mask;
> +	char *endptr;
> +
> +	mainloop_init();
> +
> +	while (true) {
> +		int opt;
> +
> +		opt = getopt_long(argc, argv, "b:l:c:vh", main_options,
> +									NULL);
> +		if (opt < 0)
> +			break;
> +
> +		switch (opt) {
> +		case 'b':
> +			path = optarg;
> +			if (strlen(path) > PATH_MAX) {
> +				fprintf(stderr, "Too long path\n");
> +				return EXIT_FAILURE;
> +			}
> +			break;
> +		case 'l':
> +			size_limit = strtoul(optarg, &endptr, 10);
> +
> +			if (size_limit == ULONG_MAX) {
> +				fprintf(stderr, "Invalid limit\n");
> +				return EXIT_FAILURE;
> +			}
> +
> +			if (*endptr != '\0') {
> +				if (*endptr == 'K' || *endptr == 'k') {
> +					size_limit *= 1024;
> +				} else if (*endptr == 'M' || *endptr == 'm') {
> +					size_limit *= 1024 * 1024;
> +				} else {
> +					fprintf(stderr, "Invalid limit\n");
> +					return EXIT_FAILURE;
> +				}
> +			}
> +
> +			/* limit this to reasonable size */
> +			if (size_limit < 4096) {
> +				fprintf(stderr, "Too small limit value\n");
> +				return EXIT_FAILURE;
> +			}
> +			break;
> +		case 'c':
> +			max_count = strtoul(optarg, &endptr, 10);
> +			break;
> +		case 'v':
> +			printf("%s\n", VERSION);
> +			return EXIT_SUCCESS;
> +		case 'h':
> +			usage();
> +			return EXIT_SUCCESS;
> +		default:
> +			return EXIT_FAILURE;
> +		}
> +	}
> +
> +	if (argc - optind > 0) {
> +		fprintf(stderr, "Invalid command line parameters\n");
> +		return EXIT_FAILURE;
> +	}
> +
> +	if (!open_monitor_channel())
> +		return EXIT_FAILURE;
> +
> +	if (create_dir(path) < 0)
> +		return EXIT_FAILURE;
> +
> +	btsnoop_file = btsnoop_create(path, size_limit, max_count,
> +							BTSNOOP_FORMAT_MONITOR);
> +	if (!btsnoop_file)
> +		return EXIT_FAILURE;
> +
> +	drop_capabilities();
> +
> +	sigemptyset(&mask);
> +	sigaddset(&mask, SIGINT);
> +	sigaddset(&mask, SIGTERM);
> +
> +	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
> +
> +	printf("Bluetooth monitor logger ver %s\n", VERSION);
> +
> +	exit_status = mainloop_run();
> +
> +	btsnoop_unref(btsnoop_file);
> +
> +	return exit_status;
> +}
> diff --git a/tools/btmon-logger.service.in b/tools/btmon-logger.service.in
> new file mode 100644
> index 000000000..f4a0b3d5f
> --- /dev/null
> +++ b/tools/btmon-logger.service.in
> @@ -0,0 +1,14 @@
> +[Unit]
> +Description=Bluetooth monitor logger
> +ConditionPathIsDirectory=/sys/class/bluetooth
> +
> +[Service]
> +Type=simple
> +ExecStart=/usr/libexec/bluetooth/btmon-logger -b /var/log/bluetooth/hci.log
> +CapabilityBoundingSet=CAP_NET_RAW
> +LimitNPROC=1
> +ProtectHome=true
> +ProtectSystem=full

So what about PrivateTmp, PrivateDevice and PrivateNetwork?

> +
> +[Install]
> +WantedBy=bluetooth.target

One thing do be doing is utilize src/systemd.c and enable sd_notify support. I mean if you are doing a printf to be included in the Journal, then also get the sd_notify done right so that you can use proper STATUS and READY notifications.

Eventually you can add watchdog support as well, but then please do it smart and only schedule timeout events when there is no IO, every IO should automatically restart the watchdog timer. So that the daemon is as idle as possible.

Regards

Marcel

