Return-Path: <cyrus@holtmann.org>
From: Arun Kumar SINGH <arunkr.singh@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 23 Feb 2011 08:07:11 +0100
Subject: [PATCH 1/4] HCI command to add device in LE White List
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA334C047D5A@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From fd4e7d6f3b9b33c7b75f7da5600c6fc0fb947b06 Mon Sep 17 00:00:00 2001
From: ArunKumarSingh <arunkr.singh@stericsson.com>
Date: Wed, 23 Feb 2011 11:24:58 +0530
Subject: [PATCH] Commands to add device to White-list

---
 lib/hci.c       |   29 +++++++++++++++++++++++++++++
 lib/hci.h       |    5 +++++
 lib/hci_lib.h   |    1 +
 tools/hcitool.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 lib/hci.c
 mode change 100644 => 100755 lib/hci.h
 mode change 100644 => 100755 lib/hci_lib.h
 mode change 100644 => 100755 tools/hcitool.c

diff --git a/lib/hci.c b/lib/hci.c
old mode 100644
new mode 100755
index 048fda4..a85f193
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -1291,6 +1291,35 @@ int hci_disconnect(int dd, uint16_t handle, uint8_t reason, int to)
 	return 0;
 }
 
+int hci_le_add_to_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type)
+{
+	struct hci_request rq;
+	le_add_device_to_white_list_cp cp;
+	uint8_t status;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.bdaddr_type = type;
+	bacpy(&cp.bdaddr, bdaddr);
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LE_CTL;
+	rq.ocf = OCF_LE_ADD_DEVICE_TO_WHITE_LIST;
+	rq.cparam = &cp;
+	rq.clen = LE_ADD_DEVICE_TO_WHITE_LIST_CP_SIZE;
+	rq.rparam = &status;
+	rq.rlen = 1;
+
+	if (hci_send_req(dd, &rq, 1000) < 0)
+		return -1;
+
+	if (status) {
+		errno = EIO;
+		return -1;
+	}
+
+	return 0;
+}
+
 int hci_read_local_name(int dd, int len, char *name, int to)
 {
 	read_local_name_rp rp;
diff --git a/lib/hci.h b/lib/hci.h
old mode 100644
new mode 100755
index 9b5388b..06d0b35
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -1523,6 +1523,11 @@ typedef struct {
 
 #define OCF_LE_CREATE_CONN_CANCEL		0x000E
 
+typedef enum {
+	LE_PUBLIC_DEVICE_ADDR = 0x00,
+	LE_RANDOM_DEVICE_ADDR =	0x01,
+}le_device_addr_type;
+
 #define OCF_LE_READ_WHITE_LIST_SIZE		0x000F
 typedef struct {
 	uint8_t		status;
diff --git a/lib/hci_lib.h b/lib/hci_lib.h
old mode 100644
new mode 100755
index b63a2a4..7127d70
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -127,6 +127,7 @@ int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
 		uint16_t latency, uint16_t supervision_timeout,
 		uint16_t min_ce_length, uint16_t max_ce_length,
 		uint16_t *handle, int to);
+int hci_le_add_to_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type);
 
 int hci_for_each_dev(int flag, int(*func)(int dd, int dev_id, long arg), long arg);
 int hci_get_route(bdaddr_t *bdaddr);
diff --git a/tools/hcitool.c b/tools/hcitool.c
old mode 100644
new mode 100755
index d7a82cc..b5109b8
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2487,6 +2487,52 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 	hci_close_dev(dd);
 }
 
+static struct option leaddwl_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ 0, 0, 0, 0 }
+};
+
+static const char *leaddwl_help =
+	"Usage:\n"
+	"\tleaddwl\n";
+
+static void cmd_leaddwl(int dev_id, int argc, char **argv)
+{
+	int err, opt, dd;
+	bdaddr_t bdaddr;
+	le_device_addr_type bdaddr_type;
+		
+	for_each_opt(opt, leaddwl_options, NULL) {
+		switch (opt) {
+		default:
+			printf("%s", leaddwl_help);
+			return;
+		}
+	}
+
+	helper_arg(1, 1, &argc, &argv, leaddwl_help);
+		
+	if (dev_id < 0)
+		dev_id = hci_get_route(NULL);
+
+	dd = hci_open_dev(dev_id);
+	if (dd < 0) {
+		perror("Could not open device");
+		exit(1);
+	}
+	
+	str2ba(argv[0], &bdaddr);
+	bdaddr_type = LE_PUBLIC_DEVICE_ADDR;
+	
+	err = hci_le_add_to_white_list(dd, &bdaddr, bdaddr_type);
+	hci_close_dev(dd);
+
+	if (err < 0) {
+		perror("Cant add to white list");
+		exit(1);
+	}
+}
+
 static struct option ledc_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ 0, 0, 0, 0 }
@@ -2563,6 +2609,7 @@ static struct {
 	{ "clkoff", cmd_clkoff, "Read clock offset"                    },
 	{ "clock",  cmd_clock,  "Read local or remote clock"           },
 	{ "lescan", cmd_lescan, "Start LE scan"                        },
+	{ "leaddwl", cmd_leaddwl, "Add this device to white list"	   },
 	{ "lecc",   cmd_lecc,   "Create a LE Connection",              },
 	{ "ledc",   cmd_ledc,   "Disconnect a LE Connection",          },
 	{ NULL, NULL, 0 }
-- 
1.7.0.4

