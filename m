Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Kumar Singh <arunkat@gmail.com>
Subject: [PATCH 5/5] hcitool: Add command to clear LE White List
Date: Mon, 28 Feb 2011 15:18:54 -0300
Message-Id: <1298917134-8229-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298917134-8229-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298917134-8229-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Arun Kumar Singh <arunkat@gmail.com>

---
 lib/hci.c       |   22 ++++++++++++++++++++++
 lib/hci_lib.h   |    1 +
 tools/hcitool.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index 9184e09..02fc0cf 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -1376,6 +1376,28 @@ int hci_le_read_white_list_size(int dd, uint8_t *size, int to)
 	return 0;
 }
 
+int hci_le_clear_white_list(int dd, int to)
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
+	if (hci_send_req(dd, &rq, to) < 0)
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
index ce1bb6c..de3e636 100644
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -134,6 +134,7 @@ int hci_le_conn_update(int dd, uint16_t handle, uint16_t min_interval,
 int hci_le_add_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to);
 int hci_le_rm_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to);
 int hci_le_read_white_list_size(int dd, uint8_t *size, int to);
+int hci_le_clear_white_list(int dd, int to);
 int hci_for_each_dev(int flag, int(*func)(int dd, int dev_id, long arg), long arg);
 int hci_get_route(bdaddr_t *bdaddr);
 
diff --git a/tools/hcitool.c b/tools/hcitool.c
index 427edc2..e79d76b 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2702,6 +2702,49 @@ static void cmd_lewlsz(int dev_id, int argc, char **argv)
 	printf("White list size: %d\n", size);
 }
 
+static struct option lewlclr_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ 0, 0, 0, 0 }
+};
+
+static const char *lewlclr_help =
+	"Usage:\n"
+	"\tlewlclr\n";
+
+static void cmd_lewlclr(int dev_id, int argc, char **argv)
+{
+	int err, dd, opt;
+
+	for_each_opt(opt, lewlclr_options, NULL) {
+		switch (opt) {
+		default:
+			printf("%s", lewlclr_help);
+			return;
+		}
+	}
+
+	helper_arg(0, 0, &argc, &argv, lewlclr_help);
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
+	err = hci_le_clear_white_list(dd, 1000);
+	hci_close_dev(dd);
+
+	if (err < 0) {
+		err = errno;
+		fprintf(stderr, "Can't clear white list: %s(%d)\n",
+							strerror(err), err);
+		exit(1);
+	}
+}
+
 static struct option ledc_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ 0, 0, 0, 0 }
@@ -2866,6 +2909,7 @@ static struct {
 	{ "lewladd",  cmd_lewladd, "Add device to LE White List"          },
 	{ "lewlrm",   cmd_lewlrm,  "Remove device from LE White List"     },
 	{ "lewlsz",   cmd_lewlsz,  "Read size of LE White List"           },
+	{ "lewlclr",  cmd_lewlclr, "Clear LE White list"                  },
 	{ "lecc",     cmd_lecc,    "Create a LE Connection"               },
 	{ "ledc",     cmd_ledc,    "Disconnect a LE Connection"           },
 	{ "lecup",    cmd_lecup,   "LE Connection Update"                 },
-- 
1.7.4.1

