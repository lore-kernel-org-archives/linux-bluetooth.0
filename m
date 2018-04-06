Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ] emulator/b1ee: Enable to specify connecting host
Message-ID: <e39b74fb-9418-7e23-7049-8f4a687a40e4@jp.fujitsu.com>
Date: Fri, 6 Apr 2018 17:45:40 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Because the default host seems to be unofficial since 2017, removes the
DEFAULT_SERVER macro.
---
 emulator/b1ee.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/emulator/b1ee.c b/emulator/b1ee.c
index 1fe46840f..42340f014 100644
--- a/emulator/b1ee.c
+++ b/emulator/b1ee.c
@@ -41,7 +41,6 @@
 
 #include "src/shared/mainloop.h"
 
-#define DEFAULT_SERVER		"b1ee.com"
 #define DEFAULT_HOST_PORT	"45550"		/* 0xb1ee */
 #define DEFAULT_SNIFFER_PORT	"45551"		/* 0xb1ef */
 
@@ -182,7 +181,7 @@ static int do_connect(const char *node, const char *service)
 	hints.ai_family = PF_UNSPEC;
 	hints.ai_socktype = SOCK_STREAM;
 
-	err = getaddrinfo(DEFAULT_SERVER, DEFAULT_HOST_PORT, &hints, &res);
+	err = getaddrinfo(node, DEFAULT_HOST_PORT, &hints, &res);
 	if (err) {
 		perror(gai_strerror(err));
 		exit(1);
@@ -227,8 +226,15 @@ int main(int argc, char *argv[])
 	ssize_t written;
 	sigset_t mask;
 
-	server_fd = do_connect(DEFAULT_SERVER, DEFAULT_HOST_PORT);
-	sniffer_fd = do_connect(DEFAULT_SERVER, DEFAULT_SNIFFER_PORT);
+	if (argc < 2) {
+		perror("b1ee - Bluetooth device testing tool over internet\n"
+			"Usage:\n"
+			"\tb1ee <host>\n");
+		return EXIT_FAILURE;
+	}
+
+	server_fd = do_connect(argv[1], DEFAULT_HOST_PORT);
+	sniffer_fd = do_connect(argv[1], DEFAULT_SNIFFER_PORT);
 
 	written = write(sniffer_fd, sniff_cmd, sizeof(sniff_cmd));
 	if (written < 0)
-- 
2.14.1

