Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 3/4] android/snoop: Add support for TCP clients
Date: Fri, 30 May 2014 18:15:55 +0200
Message-ID: <1401466556-9040-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401466556-9040-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401466556-9040-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support to write snoop file to client connected via
TCP. Default listen port is 4330 which is used by Bluedroid for similar
purpose.
---
 android/bluetoothd-snoop.c | 123 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/android/bluetoothd-snoop.c b/android/bluetoothd-snoop.c
index 57f97f4..25b9c97 100644
--- a/android/bluetoothd-snoop.c
+++ b/android/bluetoothd-snoop.c
@@ -32,6 +32,9 @@
 #if defined(ANDROID)
 #include <sys/capability.h>
 #endif
+#include <sys/un.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
@@ -41,12 +44,15 @@
 #include "src/shared/btsnoop.h"
 
 #define DEFAULT_SNOOP_FILE "/sdcard/btsnoop_hci.log"
+#define DEFAULT_TCP_PORT 4330
 
 #define MAX_PACKET_SIZE (1486 + 4)
 
 static struct btsnoop *snoop = NULL;
+static struct btsnoop *tcp_snoop = NULL;
 static uint8_t monitor_buf[MAX_PACKET_SIZE];
 static int monitor_fd = -1;
+static int server_fd = -1;
 
 static void signal_callback(int signum, void *user_data)
 {
@@ -137,8 +143,10 @@ static void data_callback(int fd, uint32_t events, void *user_data)
 			continue;
 
 		flags = get_flags_from_opcode(opcode);
-		if (flags != 0xff)
+		if (flags != 0xff) {
 			btsnoop_write(snoop, tv, flags, monitor_buf, pktlen);
+			btsnoop_write(tcp_snoop, tv, flags, monitor_buf, pktlen);
+		}
 	}
 }
 
@@ -215,6 +223,115 @@ static void set_capabilities(void)
 #endif
 }
 
+static void tcp_callback(int fd, uint32_t events, void *user_data)
+{
+	if (events & (EPOLLERR | EPOLLHUP | EPOLLRDHUP)) {
+		mainloop_remove_fd(fd);
+
+		free(tcp_snoop);
+		tcp_snoop = NULL;
+
+		printf("TCP client disconnected\n");
+	}
+}
+
+static void accept_tcp(int fd, uint32_t events, void *user_data)
+{
+	struct sockaddr_un addr;
+	socklen_t len;
+	int nfd;
+
+	memset(&addr, 0, sizeof(addr));
+	len = sizeof(addr);
+
+	if (events & (EPOLLERR | EPOLLHUP)) {
+		mainloop_remove_fd(server_fd);
+		return;
+	}
+
+	nfd = accept(server_fd, (struct sockaddr *) &addr, &len);
+	if (nfd < 0) {
+		perror("Failed to accept incoming connection\n");
+		return;
+	}
+
+	/* We only support one client connected */
+	if (tcp_snoop) {
+		fprintf(stderr, "TCP client already connected\n");
+		close(nfd);
+		return;
+	}
+
+	if (mainloop_add_fd(nfd, EPOLLIN | EPOLLRDHUP, tcp_callback,
+							NULL, NULL) < 0) {
+		fprintf(stderr, "Failed to setup watch on client\n");
+		close(nfd);
+		return;
+	}
+
+	tcp_snoop = btsnoop_create_fd(nfd, BTSNOOP_TYPE_HCI);
+	if (!tcp_snoop) {
+		fprintf(stderr, "Failed to create snoop\n");
+		close(nfd);
+		return;
+	}
+
+	printf("TCP client connected\n");
+}
+
+static int open_tcp(void)
+{
+	struct sockaddr_in addr;
+	int fd, opt = 1;
+
+	fd = socket(PF_INET, SOCK_STREAM, 0);
+	if (fd < 0) {
+		perror("Failed to open server socket\n");
+		return -1;
+	}
+
+	setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family = AF_INET;
+	addr.sin_addr.s_addr = INADDR_ANY;
+	addr.sin_addr.s_addr = inet_addr("127.0.0.1");
+	addr.sin_port = htons(DEFAULT_TCP_PORT);
+
+	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		perror("Failed to bind server socket\n");
+		close(fd);
+		return -1;
+	}
+
+	if (listen(fd, 5) < 0) {
+		perror("Failed to listen server socket\n");
+		close(fd);
+		return -1;
+	}
+
+	if (mainloop_add_fd(fd, EPOLLIN, accept_tcp, NULL, NULL) < 0) {
+		fprintf(stderr, "Failed to setup watch on server socket\n");
+		close(fd);
+		return -1;
+	}
+
+	server_fd = fd;
+
+	printf("TCP server ready\n");
+
+	return 0;
+}
+
+static void close_tcp(void)
+{
+	close(server_fd);
+
+	mainloop_remove_fd(server_fd);
+
+	server_fd = -1;
+}
+
 int main(int argc, char *argv[])
 {
 	const char *path;
@@ -243,8 +360,12 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
+	open_tcp();
+
 	mainloop_run();
 
+	close_tcp();
+
 	close_monitor();
 
 	return EXIT_SUCCESS;
-- 
1.9.3

