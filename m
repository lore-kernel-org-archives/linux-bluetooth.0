Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/2] btproxy: Add support for creating pseudoterminal
Date: Thu, 26 Nov 2015 17:23:43 +0200
Message-Id: <1448551424-18448-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add new virtual Bluetooth serial controller on /dev/pts/X which allows
to test serial attach with btattach and hciattach.
---
 tools/btproxy.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/tools/btproxy.c b/tools/btproxy.c
index 43de037..6d78876 100644
--- a/tools/btproxy.c
+++ b/tools/btproxy.c
@@ -629,6 +629,41 @@ static int open_unix(const char *path)
 	return fd;
 }
 
+static int open_pty(void)
+{
+	int fd;
+	char *pts;
+
+	fd = open("/dev/ptmx", O_RDWR | O_NOCTTY);
+	if (fd < 0) {
+		perror("Failed to open pseudoterminal master");
+		return -1;
+	}
+
+	if (grantpt(fd) < 0) {
+		perror("Failed to grant access to slave pty");
+		close(fd);
+		return -1;
+	}
+
+	if (unlockpt(fd) < 0) {
+		perror("Failed to unlock slave pty");
+		close(fd);
+		return -1;
+	}
+
+	pts = ptsname(fd);
+	if (!pts) {
+		perror("Failed to get slave pty");
+		close(fd);
+		return -1;
+	}
+
+	printf("New pts created: %s\n", pts);
+
+	return fd;
+}
+
 static int open_tcp(const char *address, unsigned int port)
 {
 	struct sockaddr_in addr;
@@ -728,6 +763,7 @@ static void usage(void)
 		"\t-c, --connect <address>     Connect to server\n"
 		"\t-l, --listen [address]      Use TCP server\n"
 		"\t-u, --unix [path]           Use Unix server\n"
+		"\t-P, --pty                   Use PTY\n"
 		"\t-p, --port <port>           Use specified TCP port\n"
 		"\t-i, --index <num>           Use specified controller\n"
 		"\t-a, --amp                   Create AMP controller\n"
@@ -741,6 +777,7 @@ static const struct option main_options[] = {
 	{ "connect",  required_argument, NULL, 'c' },
 	{ "listen",   optional_argument, NULL, 'l' },
 	{ "unix",     optional_argument, NULL, 'u' },
+	{ "pty",      no_argument,       NULL, 'P' },
 	{ "port",     required_argument, NULL, 'p' },
 	{ "index",    required_argument, NULL, 'i' },
 	{ "amp",      no_argument,       NULL, 'a' },
@@ -758,6 +795,7 @@ int main(int argc, char *argv[])
 	const char *unix_path = NULL;
 	unsigned short tcp_port = 0xb1ee;	/* 45550 */
 	bool use_redirect = false;
+	bool use_pty = false;
 	uint8_t type = HCI_BREDR;
 	const char *str;
 	sigset_t mask;
@@ -765,7 +803,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "rc:l::u::p:i:aedvh",
+		opt = getopt_long(argc, argv, "rc:l::u::Pp:i:aedvh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -789,6 +827,9 @@ int main(int argc, char *argv[])
 			else
 				unix_path = "/tmp/bt-server-bredr";
 			break;
+		case 'P':
+			use_pty = true;
+			break;
 		case 'p':
 			tcp_port = atoi(optarg);
 			break;
@@ -828,12 +869,13 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	if (unix_path && (server_address || use_redirect)) {
+	if (unix_path && (server_address || use_redirect || use_pty)) {
 		fprintf(stderr, "Invalid to specify TCP and Unix servers\n");
 		return EXIT_FAILURE;
 	}
 
-	if (connect_address && (unix_path || server_address || use_redirect)) {
+	if (connect_address && (unix_path || server_address || use_redirect ||
+								use_pty)) {
 		fprintf(stderr, "Invalid to specify client and server mode\n");
 		return EXIT_FAILURE;
 	}
@@ -876,6 +918,26 @@ int main(int argc, char *argv[])
 			close(host_fd);
 			return EXIT_FAILURE;
 		}
+	} else if (use_pty) {
+		int master_fd, dev_fd;
+
+		printf("Opening pseudoterminal\n");
+
+		master_fd = open_pty();
+		if (master_fd < 0)
+			return EXIT_FAILURE;
+
+		dev_fd = open_channel(hci_index);
+		if (dev_fd < 0) {
+			close(master_fd);
+			return EXIT_FAILURE;
+		}
+
+		if (!setup_proxy(master_fd, false, dev_fd, true)) {
+			close(dev_fd);
+			close(master_fd);
+			return EXIT_FAILURE;
+		}
 	} else {
 		int server_fd;
 
-- 
2.5.0

