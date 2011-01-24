Return-Path: <cyrus@holtmann.org>
From: Sumit Kumar BAJPAI <sumitkumar.bajpai@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 24 Jan 2011 10:59:01 +0100
Subject: [PATCH 3/4] HCI command to read size of LE White List
Message-ID: <4765B7BC10CB4C488A56C73E15D6FBA31DA570022B@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/hci.c       |   28 ++++++++++++++++++++++++++++
 lib/hci_lib.h   |    1 +
 tools/hcitool.c |   41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index 11b47b3..ec8d48e 100755
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -1349,6 +1349,34 @@ int hci_le_remove_from_white_list(int dd, const bdaddr_t* bdaddr, uint8_t type)
 	return 0;
 }
 
+int hci_le_read_white_list_size(int dd, int* size)
+{
+	struct hci_request rq;
+	le_read_white_list_size_rp rp;
+
+	memset(&rp, 0, sizeof(rp));
+	rp.size=0;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LE_CTL;
+	rq.ocf = OCF_LE_READ_WHITE_LIST_SIZE;
+	rq.rparam = &rp;
+	rq.rlen = LE_READ_WHITE_LIST_SIZE_RP_SIZE;
+
+	if (hci_send_req(dd, &rq, 1000) < 0)
+		return -1;
+	
+	if (rp.status) {
+		errno = EIO;
+		return -1;
+	}
+
+	if(size)
+		*size=rp.size;
+
+	return 0;
+}
+
 int hci_read_local_name(int dd, int len, char *name, int to)
 {
 	read_local_name_rp rp;
diff --git a/lib/hci_lib.h b/lib/hci_lib.h
index e64a431..f0325b2 100755
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -129,6 +129,7 @@ int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
 		uint16_t *handle, int to);
 int hci_le_add_to_white_list(int dd, const bdaddr_t* bdaddr, uint8_t type);
 int hci_le_remove_from_white_list(int dd, const bdaddr_t* bdaddr, uint8_t type);
+int hci_le_read_white_list_size(int dd, int* size);
 
 int hci_for_each_dev(int flag, int(*func)(int dd, int dev_id, long arg), long arg);
 int hci_get_route(bdaddr_t *bdaddr);
diff --git a/tools/hcitool.c b/tools/hcitool.c
index 038d05e..e80c7a3 100755
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2563,6 +2563,46 @@ static void cmd_lermwl(int dev_id, int argc, char **argv)
 	}
 }
 
+static struct option lerdwlsz_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ 0, 0, 0, 0 }
+};
+
+static const char *lerdwlsz_help =
+	"Usage:\n"
+	"\tlerdwlsz\n";
+
+static void cmd_lerdwlsz(int dev_id, int argc, char **argv)
+{
+	int err, dd, opt, size;
+	
+	for_each_opt(opt, lerdwlsz_options, NULL) {
+		switch (opt) {
+		default:
+			printf("%s", lerdwlsz_help);
+			return;
+		}
+	}
+	helper_arg(0, 0, &argc, &argv, lermwl_help);
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
+	err = hci_le_read_white_list_size(dd, &size);
+	hci_close_dev(dd);
+
+	if (err < 0) {
+		perror("Cant read white list size");
+		exit(1);
+	} 
+}
+
 static struct option ledc_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ 0, 0, 0, 0 }
@@ -2641,6 +2681,7 @@ static struct {
 	{ "lescan", cmd_lescan, "Start LE scan"                        },
 	{ "leaddwl", cmd_leaddwl, "Add this device to white list"	   },
 	{ "lermwl", cmd_lermwl, "Remove this device from white list"   },
+	{ "lerdwlsz",  cmd_lerdwlsz,  "Read white list size"		   },
 	{ "lecc",   cmd_lecc,   "Create a LE Connection",              },
 	{ "ledc",   cmd_ledc,   "Disconnect a LE Connection",          },
 	{ NULL, NULL, 0 }
-- 
1.6.5
