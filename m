Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 1/2] Add support for cancelling a LE Scan with Control-C
Date: Thu,  6 Oct 2011 11:42:11 -0300
Message-Id: <1317912132-6644-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hcitool.c |   39 +++++++++++++++++++++++++++++++++++----
 1 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index 0dac2ae..988ebe3 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -38,6 +38,7 @@
 #include <sys/param.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
+#include <signal.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -55,6 +56,11 @@
 
 #define for_each_opt(opt, long, short) while ((opt=getopt_long(argc, argv, short ? short:"+", long, NULL)) != -1)
 
+static struct sighandler_data {
+	struct hci_filter of;
+	int fd;
+} signal_data;
+
 static void usage(void);
 
 static int dev_info(int s, int dev_id, long arg)
@@ -2346,12 +2352,30 @@ static int check_report_filter(uint8_t procedure, le_advertising_info *info)
 	return 0;
 }
 
+static void sigint_handler(int sig)
+{
+	int err;
+
+	setsockopt(signal_data.fd, SOL_HCI, HCI_FILTER, &signal_data.of, sizeof(signal_data.of));
+
+	err = hci_le_set_scan_enable(signal_data.fd, 0x00, 0x00, 1000);
+	if (err < 0) {
+		perror("Disable scan failed");
+		exit(1);
+	}
+
+	hci_close_dev(signal_data.fd);
+
+	exit(0);
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
@@ -2368,9 +2392,16 @@ static int print_advertising_devices(int dd, uint8_t filter_type)
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
+	memset(&signal_data, 0, sizeof(signal_data));
+	signal_data.fd = dd;
+	memcpy(&signal_data.of, &of, sizeof(signal_data.of));
+
+	while (1) {
 		evt_le_meta_event *meta;
 		le_advertising_info *info;
 		char addr[18];
-- 
1.7.6.1

