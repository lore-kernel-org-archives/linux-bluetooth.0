Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Kumar Singh <arunkat@gmail.com>
Subject: [PATCH 4/5] hcitool: Add command to read size of LE White List
Date: Mon, 28 Feb 2011 15:18:53 -0300
Message-Id: <1298917134-8229-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298917134-8229-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298917134-8229-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Arun Kumar Singh <arunkat@gmail.com>

---
 lib/hci.c       |   27 +++++++++++++++++++++++++++
 lib/hci_lib.h   |    1 +
 tools/hcitool.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index 0e1518c..9184e09 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -1349,6 +1349,33 @@ int hci_le_rm_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
 	return 0;
 }
 
+int hci_le_read_white_list_size(int dd, uint8_t *size, int to)
+{
+	struct hci_request rq;
+	le_read_white_list_size_rp rp;
+
+	memset(&rp, 0, sizeof(rp));
+	memset(&rq, 0, sizeof(rq));
+
+	rq.ogf = OGF_LE_CTL;
+	rq.ocf = OCF_LE_READ_WHITE_LIST_SIZE;
+	rq.rparam = &rp;
+	rq.rlen = LE_READ_WHITE_LIST_SIZE_RP_SIZE;
+
+	if (hci_send_req(dd, &rq, to) < 0)
+		return -1;
+
+	if (rp.status) {
+		errno = EIO;
+		return -1;
+	}
+
+	if (size)
+		*size = rp.size;
+
+	return 0;
+}
+
 int hci_read_local_name(int dd, int len, char *name, int to)
 {
 	read_local_name_rp rp;
diff --git a/lib/hci_lib.h b/lib/hci_lib.h
index e894e8e..ce1bb6c 100644
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -133,6 +133,7 @@ int hci_le_conn_update(int dd, uint16_t handle, uint16_t min_interval,
 			uint16_t supervision_timeout, int to);
 int hci_le_add_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to);
 int hci_le_rm_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to);
+int hci_le_read_white_list_size(int dd, uint8_t *size, int to);
 int hci_for_each_dev(int flag, int(*func)(int dd, int dev_id, long arg), long arg);
 int hci_get_route(bdaddr_t *bdaddr);
 
diff --git a/tools/hcitool.c b/tools/hcitool.c
index bf0f25d..427edc2 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2656,6 +2656,52 @@ static void cmd_lewlrm(int dev_id, int argc, char **argv)
 	}
 }
 
+static struct option lewlsz_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ 0, 0, 0, 0 }
+};
+
+static const char *lewlsz_help =
+	"Usage:\n"
+	"\tlewlsz\n";
+
+static void cmd_lewlsz(int dev_id, int argc, char **argv)
+{
+	int err, dd, opt;
+	uint8_t size;
+
+	for_each_opt(opt, lewlsz_options, NULL) {
+		switch (opt) {
+		default:
+			printf("%s", lewlsz_help);
+			return;
+		}
+	}
+
+	helper_arg(0, 0, &argc, &argv, lewlsz_help);
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
+	err = hci_le_read_white_list_size(dd, &size, 1000);
+	hci_close_dev(dd);
+
+	if (err < 0) {
+		err = errno;
+		fprintf(stderr, "Can't read white list size: %s(%d)\n",
+							strerror(err), err);
+		exit(1);
+	}
+
+	printf("White list size: %d\n", size);
+}
+
 static struct option ledc_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ 0, 0, 0, 0 }
@@ -2819,6 +2865,7 @@ static struct {
 	{ "lescan",   cmd_lescan,  "Start LE scan"                        },
 	{ "lewladd",  cmd_lewladd, "Add device to LE White List"          },
 	{ "lewlrm",   cmd_lewlrm,  "Remove device from LE White List"     },
+	{ "lewlsz",   cmd_lewlsz,  "Read size of LE White List"           },
 	{ "lecc",     cmd_lecc,    "Create a LE Connection"               },
 	{ "ledc",     cmd_ledc,    "Disconnect a LE Connection"           },
 	{ "lecup",    cmd_lecup,   "LE Connection Update"                 },
-- 
1.7.4.1

