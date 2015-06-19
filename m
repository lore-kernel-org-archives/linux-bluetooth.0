Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] tools/btproxy: Add -o option
Date: Fri, 19 Jun 2015 12:33:44 +0200
Message-Id: <1434710024-1122-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This option allows to power off adapter before opening user channel.
---
 tools/btproxy.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/tools/btproxy.c b/tools/btproxy.c
index 43de037..962abe8 100644
--- a/tools/btproxy.c
+++ b/tools/btproxy.c
@@ -40,10 +40,13 @@
 #include <sys/stat.h>
 #include <sys/socket.h>
 #include <sys/un.h>
+#include <sys/ioctl.h>
 
 #include <netdb.h>
 #include <arpa/inet.h>
 
+#include "lib/bluetooth.h"
+#include "lib/hci.h"
 #include "src/shared/util.h"
 #include "src/shared/mainloop.h"
 #include "src/shared/ecc.h"
@@ -53,17 +56,13 @@
 #define HCI_AMP		0x01
 
 #define BTPROTO_HCI	1
-struct sockaddr_hci {
-	sa_family_t	hci_family;
-	unsigned short	hci_dev;
-	unsigned short  hci_channel;
-};
 #define HCI_CHANNEL_USER	1
 
 static uint16_t hci_index = 0;
 static bool client_active = false;
 static bool debug_enabled = false;
 static bool emulate_ecc = false;
+static bool power_off = false;
 
 static void hexdump_print(const char *str, void *user_data)
 {
@@ -515,11 +514,31 @@ static bool setup_proxy(int host_fd, bool host_shutdown,
 	return true;
 }
 
+static int power_off_controler(int index)
+{
+	int fd, ret;
+
+	fd = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	if (fd < 0)
+		return -1;
+
+	ret = ioctl(fd, HCIDEVDOWN, index);
+
+	close(fd);
+
+	return ret;
+}
+
 static int open_channel(uint16_t index)
 {
 	struct sockaddr_hci addr;
 	int fd;
 
+	if (power_off && power_off_controler(index) < 0) {
+		perror("Failed to power off controller");
+		return -1;
+	}
+
 	printf("Opening user channel for hci%u\n", hci_index);
 
 	fd = socket(PF_BLUETOOTH, SOCK_RAW | SOCK_CLOEXEC, BTPROTO_HCI);
@@ -732,6 +751,7 @@ static void usage(void)
 		"\t-i, --index <num>           Use specified controller\n"
 		"\t-a, --amp                   Create AMP controller\n"
 		"\t-e, --ecc                   Emulate ECC support\n"
+		"\t-o, --off                   Power off controller\n"
 		"\t-d, --debug                 Enable debugging output\n"
 		"\t-h, --help                  Show help options\n");
 }
@@ -745,6 +765,7 @@ static const struct option main_options[] = {
 	{ "index",    required_argument, NULL, 'i' },
 	{ "amp",      no_argument,       NULL, 'a' },
 	{ "ecc",      no_argument,       NULL, 'e' },
+	{ "off",      no_argument,       NULL, 'o' },
 	{ "debug",    no_argument,       NULL, 'd' },
 	{ "version",  no_argument,       NULL, 'v' },
 	{ "help",     no_argument,       NULL, 'h' },
@@ -765,7 +786,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "rc:l::u::p:i:aedvh",
+		opt = getopt_long(argc, argv, "rc:l::u::p:i:aedvho",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -809,6 +830,9 @@ int main(int argc, char *argv[])
 		case 'e':
 			emulate_ecc = true;
 			break;
+		case 'o':
+			power_off = true;
+			break;
 		case 'd':
 			debug_enabled = true;
 			break;
-- 
1.9.3

