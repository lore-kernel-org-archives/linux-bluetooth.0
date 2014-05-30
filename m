Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 4/4] tools/hcidump: Add support to read snoop via ADB
Date: Fri, 30 May 2014 18:15:56 +0200
Message-ID: <1401466556-9040-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401466556-9040-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401466556-9040-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reading from ADB requires bluetoothd-snoop service to be running on
target device (i.e. HCI logging needs to be turned on in case of KitKat
devices).

Without optional argument, "-d" or "--read-adb" will connect to default
device and use default port (4330). Optional argument can be in form:
<serialno>:<port>

Any of <serialno> and <port> can be omitted and default value will be
used, i.e. --read-adb=ABCD will read from device with serial ABCD and
port 4330 while --read-adb=:1234 will read from default device and port
1234.
---
 tools/hcidump.c | 167 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 165 insertions(+), 2 deletions(-)

diff --git a/tools/hcidump.c b/tools/hcidump.c
index 37a9f00..3dff7d6 100644
--- a/tools/hcidump.c
+++ b/tools/hcidump.c
@@ -38,6 +38,7 @@
 #include <sys/types.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
+#include <arpa/inet.h>
 
 #include "parser/parser.h"
 #include "parser/sdp.h"
@@ -53,7 +54,8 @@ enum {
 	READ,
 	WRITE,
 	PPPDUMP,
-	AUDIO
+	AUDIO,
+	ADB,
 };
 
 /* Default options */
@@ -522,6 +524,153 @@ static int open_file(char *file, int mode, unsigned long flags)
 	return fd;
 }
 
+static int send_adb(int fd, const char *cmd)
+{
+	char buf[128];
+	unsigned int len;
+	struct iovec iov[2];
+
+	len = strlen(cmd);
+	sprintf(buf, "%04X", len);
+
+	iov[0].iov_base = buf;
+	iov[0].iov_len = 4;
+	iov[1].iov_base = (void *) cmd;
+	iov[1].iov_len = len;
+
+	if (writev(fd, iov, 2) < 0)
+		return -1;
+
+	if (recv(fd, buf, sizeof(buf), 0) < 0)
+		return -1;
+
+	/* OKAY means we're fine */
+	if (!memcmp("OKAY", buf, 4))
+		return 0;
+
+	/*
+	 * failure comes in format FAIL<4hex><msg> where <4hex> is length of
+	 * <msg> written as hexadecimal string (4 chars)
+	 */
+	if (sscanf(buf, "FAIL%04X", &len) > 0) {
+		buf[8 + len] = '\0';
+		fprintf(stderr, "ADB: %s\n", &buf[8]);
+	} else {
+		fprintf(stderr, "ADB: unknown failure");
+	}
+
+	return -1;
+}
+
+static int connect_adb(const char *serial, int port)
+{
+	struct sockaddr_in addr;
+	char cmd[128];
+	int fd;
+
+	fd = socket(PF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	if (fd < 0) {
+		perror("Failed to open TCP client socket");
+		return -1;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family = AF_INET;
+	addr.sin_addr.s_addr = inet_addr("127.0.0.1");
+	addr.sin_port = htons(5037); /* default ADB port */
+
+	if (connect(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		perror("Failed to connect TCP client socket");
+		close(fd);
+		return -1;
+	}
+
+	/* first need to switch socket to adb daemon on device */
+	if (serial)
+		sprintf(cmd, "host:transport:%s", serial);
+	else
+		strcpy(cmd, "host:transport-any");
+	if (send_adb(fd, cmd) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	/* next need to switch socket to tcp socket */
+	sprintf(cmd, "tcp:%d", port ? port : 4330);
+	if (send_adb(fd, cmd) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
+static void parse_adb(const char *device, char **serial, int *port)
+{
+	const char *p;
+
+	*serial = NULL;
+	*port = 0;
+
+	if (!device)
+		return;
+
+	p = strrchr(device, ':');
+	if (!p) {
+		*serial = strdup(device);
+		return;
+	}
+
+	if (p - device)
+		*serial = strndup(device, p - device);
+	*port = atoi(&p[1]);
+}
+
+static int open_adb(const char *device)
+{
+	unsigned char buf[BTSNOOP_HDR_SIZE];
+	struct btsnoop_hdr *hdr = (struct btsnoop_hdr *) buf;
+	int fd, len;
+	char *serial;
+	int port;
+
+	parse_adb(device, &serial, &port);
+
+	fd = connect_adb(serial, port);
+	if (fd < 0)
+		return -1;
+
+	free(serial);
+
+	len = read(fd, buf, BTSNOOP_HDR_SIZE);
+	if (len != BTSNOOP_HDR_SIZE)
+		return -1;
+
+	if (memcmp(hdr->id, btsnoop_id, sizeof(btsnoop_id)))
+		return -1;
+
+	parser.flags |= DUMP_BTSNOOP;
+
+	btsnoop_version = be32toh(hdr->version);
+	btsnoop_type = be32toh(hdr->type);
+
+	printf("btsnoop version: %d datalink type: %d\n",
+						btsnoop_version, btsnoop_type);
+
+	if (btsnoop_version != 1) {
+		fprintf(stderr, "Unsupported BTSnoop version\n");
+		exit(1);
+	}
+
+	if (btsnoop_type != 1001 && btsnoop_type != 1002 &&
+					btsnoop_type != 2001) {
+		fprintf(stderr, "Unsupported BTSnoop datalink type\n");
+		exit(1);
+	}
+
+	return fd;
+}
+
 static int open_socket(int dev, unsigned long flags)
 {
 	struct sockaddr_hci addr;
@@ -624,6 +773,7 @@ static void usage(void)
 	"  -m, --manufacturer=compid  Default manufacturer\n"
 	"  -w, --save-dump=file       Save dump to a file\n"
 	"  -r, --read-dump=file       Read dump from a file\n"
+	"  -d, --read-adb=dev         Read dump via ADB\n"
 	"  -t, --ts                   Display time stamps\n"
 	"  -a, --ascii                Dump data in ascii\n"
 	"  -x, --hex                  Dump data in hex\n"
@@ -650,6 +800,7 @@ static struct option main_options[] = {
 	{ "manufacturer",	1, 0, 'm' },
 	{ "save-dump",		1, 0, 'w' },
 	{ "read-dump",		1, 0, 'r' },
+	{ "read-adb",		2, 0, 'd' },
 	{ "timestamp",		0, 0, 't' },
 	{ "ascii",		0, 0, 'a' },
 	{ "hex",		0, 0, 'x' },
@@ -679,7 +830,7 @@ int main(int argc, char *argv[])
 	uint16_t obex_port;
 
 	while ((opt = getopt_long(argc, argv,
-				"i:l:p:m:w:r:taxXRC:H:O:P:S:D:A:Yhv",
+				"i:l:p:m:w:r:d::taxXRC:H:O:P:S:D:A:Yhv",
 				main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'i':
@@ -711,6 +862,11 @@ int main(int argc, char *argv[])
 			dump_file = strdup(optarg);
 			break;
 
+		case 'd':
+			mode = ADB;
+			dump_file = optarg ? strdup(optarg) : NULL;
+			break;
+
 		case 't':
 			flags |= DUMP_TSTAMP;
 			break;
@@ -817,6 +973,13 @@ int main(int argc, char *argv[])
 		process_frames(device, open_socket(device, flags),
 				open_file(dump_file, mode, flags), flags);
 		break;
+
+	case ADB:
+		flags |= DUMP_VERBOSE;
+		init_parser(flags, filter, defpsm, defcompid,
+							pppdump_fd, audio_fd);
+		read_dump(open_adb(dump_file));
+		break;
 	}
 
 	return 0;
-- 
1.9.3

