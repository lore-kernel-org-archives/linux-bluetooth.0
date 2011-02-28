Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Kumar Singh <arunkat@gmail.com>
Subject: [PATCH 3/5] hcitool: Add command to remove a device from LE white list
Date: Mon, 28 Feb 2011 15:18:52 -0300
Message-Id: <1298917134-8229-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298917134-8229-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298917134-8229-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Arun Kumar Singh <arunkat@gmail.com>

---
 lib/hci.c       |   29 +++++++++++++++++++++++++++++
 lib/hci_lib.h   |    1 +
 tools/hcitool.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index fc710f4..0e1518c 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -1320,6 +1320,35 @@ int hci_le_add_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
 	return 0;
 }
 
+int hci_le_rm_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
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
index fb2c7cb..e894e8e 100644
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -132,6 +132,7 @@ int hci_le_conn_update(int dd, uint16_t handle, uint16_t min_interval,
 			uint16_t max_interval, uint16_t latency,
 			uint16_t supervision_timeout, int to);
 int hci_le_add_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to);
+int hci_le_rm_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to);
 int hci_for_each_dev(int flag, int(*func)(int dd, int dev_id, long arg), long arg);
 int hci_get_route(bdaddr_t *bdaddr);
 
diff --git a/tools/hcitool.c b/tools/hcitool.c
index 8945156..bf0f25d 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2610,6 +2610,52 @@ static void cmd_lewladd(int dev_id, int argc, char **argv)
 	}
 }
 
+static struct option lewlrm_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ 0, 0, 0, 0 }
+};
+
+static const char *lewlrm_help =
+	"Usage:\n"
+	"\tlewlrm <bdaddr>\n";
+
+static void cmd_lewlrm(int dev_id, int argc, char **argv)
+{
+	int err, opt, dd;
+	bdaddr_t bdaddr;
+
+	for_each_opt(opt, lewlrm_options, NULL) {
+		switch (opt) {
+		default:
+			printf("%s", lewlrm_help);
+			return;
+		}
+	}
+
+	helper_arg(1, 1, &argc, &argv, lewlrm_help);
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
+
+	err = hci_le_rm_white_list(dd, &bdaddr, LE_PUBLIC_ADDRESS, 1000);
+	hci_close_dev(dd);
+
+	if (err < 0) {
+		err = errno;
+		fprintf(stderr, "Can't remove from white list: %s(%d)\n",
+							strerror(err), err);
+		exit(1);
+	}
+}
+
 static struct option ledc_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ 0, 0, 0, 0 }
@@ -2772,6 +2818,7 @@ static struct {
 	{ "clock",    cmd_clock,   "Read local or remote clock"           },
 	{ "lescan",   cmd_lescan,  "Start LE scan"                        },
 	{ "lewladd",  cmd_lewladd, "Add device to LE White List"          },
+	{ "lewlrm",   cmd_lewlrm,  "Remove device from LE White List"     },
 	{ "lecc",     cmd_lecc,    "Create a LE Connection"               },
 	{ "ledc",     cmd_ledc,    "Disconnect a LE Connection"           },
 	{ "lecup",    cmd_lecup,   "LE Connection Update"                 },
-- 
1.7.4.1

