Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] Add support for cancelling a LE Scan with Control-C
Date: Thu,  6 Oct 2011 15:03:27 -0300
Message-Id: <1317924207-25529-1-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1317912132-6644-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1317912132-6644-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hcitool.c |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index 0dac2ae..4be0da0 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -38,6 +38,7 @@
 #include <sys/param.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
+#include <signal.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -55,6 +56,8 @@
 
 #define for_each_opt(opt, long, short) while ((opt=getopt_long(argc, argv, short ? short:"+", long, NULL)) != -1)
 
+static int signal_received;
+
 static void usage(void);
 
 static int dev_info(int s, int dev_id, long arg)
@@ -2346,12 +2349,18 @@ static int check_report_filter(uint8_t procedure, le_advertising_info *info)
 	return 0;
 }
 
+static void sigint_handler(int sig)
+{
+	signal_received = sig;
+}
+
 static int print_advertising_devices(int dd, uint8_t filter_type)
 {
 	unsigned char buf[HCI_MAX_EVENT_SIZE], *ptr;
 	struct hci_filter nf, of;
+	struct sigaction sa;
 	socklen_t olen;
-	int num, len;
+	int len;
 
 	olen = sizeof(of);
 	if (getsockopt(dd, SOL_HCI, HCI_FILTER, &of, &olen) < 0) {
@@ -2368,14 +2377,22 @@ static int print_advertising_devices(int dd, uint8_t filter_type)
 		return -1;
 	}
 
-	/* Wait for 10 report events */
-	num = 10;
-	while (num--) {
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_flags = SA_NOCLDSTOP;
+	sa.sa_handler = sigint_handler;
+	sigaction(SIGINT, &sa, NULL);
+
+	while (1) {
 		evt_le_meta_event *meta;
 		le_advertising_info *info;
 		char addr[18];
 
 		while ((len = read(dd, buf, sizeof(buf))) < 0) {
+			if (errno == EINTR && signal_received == SIGINT) {
+				len = 0;
+				goto done;
+			}
+
 			if (errno == EAGAIN || errno == EINTR)
 				continue;
 			goto done;
-- 
1.7.6.1

