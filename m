Return-Path: <cyrus@holtmann.org>
From: Arun Kumar SINGH <arunkr.singh@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 23 Feb 2011 08:09:57 +0100
Subject: [PATCH 2/4] HCI command to remove device from LE White List
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA334C047D5E@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 2c5038477842b3b73eea161d9610b2bd4100f338 Mon Sep 17 00:00:00 2001
From: ArunKumarSingh <arunkr.singh@stericsson.com>
Date: Wed, 23 Feb 2011 12:03:36 +0530
Subject: [PATCH] Command to remove device from Whitelist


Signed-off-by: ArunKumarSingh <arunkr.singh@stericsson.com>
---
 lib/hci.c       |   29 +++++++++++++++++++++++++++++
 lib/hci_lib.h   |    1 +
 tools/hcitool.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index a85f193..1ae2dc6 100755
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -1320,6 +1320,35 @@ int hci_le_add_to_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type)
 	return 0;
 }
 
+int hci_le_remove_from_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type)
+{
+	struct hci_request rq;
+	le_remove_device_from_white_list_cp cp;
+	uint8_t status;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.bdaddr_type = type;
+	bacpy(&cp.bdaddr, bdaddr);
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LE_CTL;
+	rq.ocf = OCF_LE_REMOVE_DEVICE_FROM_WHITE_LIST;
+	rq.cparam = &cp;
+	rq.clen = LE_REMOVE_DEVICE_FROM_WHITE_LIST_CP_SIZE;
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
diff --git a/lib/hci_lib.h b/lib/hci_lib.h
index 7127d70..b42a91b 100755
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -128,6 +128,7 @@ int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
 		uint16_t min_ce_length, uint16_t max_ce_length,
 		uint16_t *handle, int to);
 int hci_le_add_to_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type);
+int hci_le_remove_from_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type);
 
 int hci_for_each_dev(int flag, int(*func)(int dd, int dev_id, long arg), long arg);
 int hci_get_route(bdaddr_t *bdaddr);
diff --git a/tools/hcitool.c b/tools/hcitool.c
index b5109b8..1118b07 100755
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2533,6 +2533,52 @@ static void cmd_leaddwl(int dev_id, int argc, char **argv)
 	}
 }
 
+static struct option lermwl_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ 0, 0, 0, 0 }
+};
+
+static const char *lermwl_help =
+	"Usage:\n"
+	"\tlermwl <bdaddr>\n";
+
+static void cmd_lermwl(int dev_id, int argc, char **argv)
+{
+	int err, opt, dd;
+	bdaddr_t bdaddr;
+	le_device_addr_type bdaddr_type;
+
+	for_each_opt(opt, lermwl_options, NULL) {
+		switch (opt) {
+		default:
+			printf("%s", lermwl_help);
+			return;
+		}
+	}
+
+	helper_arg(1, 1, &argc, &argv, lermwl_help);
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
+	err = hci_le_remove_from_white_list(dd, &bdaddr, bdaddr_type);
+	hci_close_dev(dd);
+
+	if (err < 0) {
+		perror("Cant remove from white list");
+		exit(1);
+	}
+}
+
 static struct option ledc_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ 0, 0, 0, 0 }
@@ -2610,6 +2656,7 @@ static struct {
 	{ "clock",  cmd_clock,  "Read local or remote clock"           },
 	{ "lescan", cmd_lescan, "Start LE scan"                        },
 	{ "leaddwl", cmd_leaddwl, "Add this device to white list"	   },
+	{ "lermwl", cmd_lermwl, "Remove this device from white list"   },
 	{ "lecc",   cmd_lecc,   "Create a LE Connection",              },
 	{ "ledc",   cmd_ledc,   "Disconnect a LE Connection",          },
 	{ NULL, NULL, 0 }
-- 
1.7.0.4

