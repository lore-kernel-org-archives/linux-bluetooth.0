Return-Path: <cyrus@holtmann.org>
From: Arun Kumar SINGH <arunkr.singh@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 23 Feb 2011 08:20:58 +0100
Subject: [PATCH 4/4] HCI command to clear LE White List
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA334C047D87@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 1142406b33f6f279ee6913e0327e922c93c32e16 Mon Sep 17 00:00:00 2001
From: ArunKumarSingh <arunkr.singh@stericsson.com>
Date: Wed, 23 Feb 2011 12:26:39 +0530
Subject: [PATCH] HCI command to clear LE White list


Signed-off-by: ArunKumarSingh <arunkr.singh@stericsson.com>
---
 lib/hci.c       |   22 ++++++++++++++++++++++
 lib/hci_lib.h   |    1 +
 tools/hcitool.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index 2f36448..43f596f 100755
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -1377,6 +1377,28 @@ int hci_le_read_white_list_size(int dd, int *size)
 	return 0;
 }
 
+int hci_le_clear_white_list(int dd)
+{
+	struct hci_request rq;
+	uint8_t status;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LE_CTL;
+	rq.ocf = OCF_LE_CLEAR_WHITE_LIST;
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
index d5f07f6..c86b0de 100755
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -130,6 +130,7 @@ int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
 int hci_le_add_to_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type);
 int hci_le_remove_from_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type);
 int hci_le_read_white_list_size(int dd, int *size);
+int hci_le_clear_white_list(int dd);
 
 int hci_for_each_dev(int flag, int(*func)(int dd, int dev_id, long arg), long arg);
 int hci_get_route(bdaddr_t *bdaddr);
diff --git a/tools/hcitool.c b/tools/hcitool.c
index fa65c4e..8ec4c20 100755
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2620,6 +2620,47 @@ static void cmd_lerdwlsz(int dev_id, int argc, char **argv)
 	}
 }
 
+static struct option leclrwl_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ 0, 0, 0, 0 }
+};
+
+static const char *leclrwl_help =
+	"Usage:\n"
+	"\tleclrwl\n";
+
+static void cmd_leclrwl(int dev_id, int argc, char **argv)
+{
+	int err, dd, opt;
+
+	for_each_opt(opt, leclrwl_options, NULL) {
+		switch (opt) {
+		default:
+			printf("%s", leclrwl_help);
+			return;
+		}
+	}
+
+	helper_arg(0, 0, &argc, &argv, leclrwl_help);
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
+	err = hci_le_clear_white_list(dd);
+	hci_close_dev(dd);
+
+	if (err < 0) {
+		perror("Cant clear white list");
+		exit(1);
+	}
+}
+
 static struct option ledc_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ 0, 0, 0, 0 }
@@ -2699,6 +2740,7 @@ static struct {
 	{ "leaddwl", cmd_leaddwl, "Add this device to white list"	   },
 	{ "lermwl", cmd_lermwl, "Remove this device from white list"   },
 	{ "lerdwlsz",  cmd_lerdwlsz,  "Read white list size"		   },
+	{ "leclrwl",   cmd_leclrwl,   "Clear white list"			   },
 	{ "lecc",   cmd_lecc,   "Create a LE Connection",              },
 	{ "ledc",   cmd_ledc,   "Disconnect a LE Connection",          },
 	{ NULL, NULL, 0 }
-- 
1.7.0.4

