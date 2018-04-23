Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ v2] emulator/b1ee: Enable to specify host and port
Message-ID: <d2e6c913-7438-930c-1005-ffe352b555e7@jp.fujitsu.com>
Date: Mon, 23 Apr 2018 18:00:37 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Removes the DEFAULT_SERVER macro because the default host seems to be
unofficial since 2017.
---
 emulator/b1ee.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 5 deletions(-)

diff --git a/emulator/b1ee.c b/emulator/b1ee.c
index 1fe46840f..1253a3dca 100644
--- a/emulator/b1ee.c
+++ b/emulator/b1ee.c
@@ -32,6 +32,8 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
+#include <getopt.h>
+#include <ctype.h>
 
 #include <netdb.h>
 #include <arpa/inet.h>
@@ -41,7 +43,6 @@
 
 #include "src/shared/mainloop.h"
 
-#define DEFAULT_SERVER		"b1ee.com"
 #define DEFAULT_HOST_PORT	"45550"		/* 0xb1ee */
 #define DEFAULT_SNIFFER_PORT	"45551"		/* 0xb1ef */
 
@@ -49,6 +50,43 @@ static int sniffer_fd;
 static int server_fd;
 static int vhci_fd;
 
+static void usage(void)
+{
+	printf("b1ee - Bluetooth device testing tool over internet\n"
+		"Usage:\n");
+	printf("\tb1ee [options] <host>\n");
+	printf("options:\n"
+		"\t-p, --port <port>          Specify the server port\n"
+		"\t-s, --sniffer-port <port>  Specify the sniffer port\n"
+		"\t-v, --version              Show version information\n"
+		"\t-h, --help                 Show help options\n");
+}
+
+static const struct option main_options[] = {
+	{ "port",		required_argument,	NULL, 'p' },
+	{ "sniffer-port",	required_argument,	NULL, 's' },
+	{ "version",		no_argument,		NULL, 'v' },
+	{ "help",		no_argument,		NULL, 'h' },
+	{ }
+};
+
+static char *set_port(char *str)
+{
+	char *c;
+
+	if (str == NULL || str[0] == '\0')
+		return NULL;
+
+	for (c = str; *c != '\0'; c++)
+		if (isdigit(*c) == 0)
+			return NULL;
+
+	if (atol(str) > 65535)
+		return NULL;
+
+	return strdup(str);
+}
+
 static void sniffer_read_callback(int fd, uint32_t events, void *user_data)
 {
 	static uint8_t buf[4096];
@@ -182,7 +220,7 @@ static int do_connect(const char *node, const char *service)
 	hints.ai_family = PF_UNSPEC;
 	hints.ai_socktype = SOCK_STREAM;
 
-	err = getaddrinfo(DEFAULT_SERVER, DEFAULT_HOST_PORT, &hints, &res);
+	err = getaddrinfo(node, service, &hints, &res);
 	if (err) {
 		perror(gai_strerror(err));
 		exit(1);
@@ -224,11 +262,53 @@ int main(int argc, char *argv[])
 {
 	const char sniff_cmd[] = { 0x01, 0x00,
 					0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+	char *server_port = NULL, *sniffer_port = NULL;
+	int ret = EXIT_FAILURE;
 	ssize_t written;
 	sigset_t mask;
 
-	server_fd = do_connect(DEFAULT_SERVER, DEFAULT_HOST_PORT);
-	sniffer_fd = do_connect(DEFAULT_SERVER, DEFAULT_SNIFFER_PORT);
+	for (;;) {
+		int opt;
+
+		opt = getopt_long(argc, argv, "s:p:vh", main_options, NULL);
+		if (opt < 0)
+			break;
+
+		switch (opt) {
+		case 'p':
+			server_port = set_port(optarg);
+			if (server_port == NULL)
+				goto usage;
+
+			break;
+		case 's':
+			sniffer_port = set_port(optarg);
+			if (sniffer_port == NULL)
+				goto usage;
+
+			break;
+		case 'v':
+			printf("%s\n", VERSION);
+			ret = EXIT_SUCCESS;
+			goto done;
+		case 'h':
+			ret = EXIT_SUCCESS;
+			goto usage;
+		default:
+			goto usage;
+		}
+	}
+
+	argc = argc - optind;
+	argv = argv + optind;
+	optind = 0;
+
+	if (argv[0] == NULL || argv[0][0] == '\0')
+		goto usage;
+
+	server_fd = do_connect(argv[0], server_port ? : DEFAULT_HOST_PORT);
+	sniffer_fd = do_connect(argv[0],
+				sniffer_port ? : DEFAULT_SNIFFER_PORT);
 
 	written = write(sniffer_fd, sniff_cmd, sizeof(sniff_cmd));
 	if (written < 0)
@@ -253,5 +333,15 @@ int main(int argc, char *argv[])
 	mainloop_add_fd(server_fd, EPOLLIN, server_read_callback, NULL, NULL);
 	mainloop_add_fd(vhci_fd, EPOLLIN, vhci_read_callback, NULL, NULL);
 
-	return mainloop_run();
+	ret = mainloop_run();
+
+	goto done;
+
+usage:
+	usage();
+done:
+	free(server_port);
+	free(sniffer_port);
+
+	return ret;
 }
-- 
2.14.1

