Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Kumar Singh <arunkat@gmail.com>
Subject: [PATCH 1/5] hcitool: Add command to add a device to LE White List
Date: Mon, 28 Feb 2011 15:18:50 -0300
Message-Id: <1298917134-8229-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Arun Kumar Singh <arunkat@gmail.com>

---
 lib/hci.c       |   29 +++++++++++++++++++++++++++++
 lib/hci.h       |    6 ++++++
 lib/hci_lib.h   |    2 +-
 tools/hcitool.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 1 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index 688b0b4..fc710f4 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -1291,6 +1291,35 @@ int hci_disconnect(int dd, uint16_t handle, uint8_t reason, int to)
 	return 0;
 }
 
+int hci_le_add_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
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
diff --git a/lib/hci.h b/lib/hci.h
index 9b5388b..d2d4f77 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -75,6 +75,12 @@ enum {
 	HCI_RAW,
 };
 
+/* LE address type */
+enum {
+	LE_PUBLIC_ADDRESS = 0x00,
+	LE_RANDOM_ADDRESS = 0x01
+};
+
 /* HCI ioctl defines */
 #define HCIDEVUP	_IOW('H', 201, int)
 #define HCIDEVDOWN	_IOW('H', 202, int)
diff --git a/lib/hci_lib.h b/lib/hci_lib.h
index 5be8d50..fb2c7cb 100644
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -131,7 +131,7 @@ int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
 int hci_le_conn_update(int dd, uint16_t handle, uint16_t min_interval,
 			uint16_t max_interval, uint16_t latency,
 			uint16_t supervision_timeout, int to);
-
+int hci_le_add_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to);
 int hci_for_each_dev(int flag, int(*func)(int dd, int dev_id, long arg), long arg);
 int hci_get_route(bdaddr_t *bdaddr);
 
diff --git a/tools/hcitool.c b/tools/hcitool.c
index ebc8448..1184b6b 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2564,6 +2564,52 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 	hci_close_dev(dd);
 }
 
+static struct option lewladd_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ 0, 0, 0, 0 }
+};
+
+static const char *lewladd_help =
+	"Usage:\n"
+	"\tlewladd <bdaddr>\n";
+
+static void cmd_lewladd(int dev_id, int argc, char **argv)
+{
+	int err, opt, dd;
+	bdaddr_t bdaddr;
+
+	for_each_opt(opt, lewladd_options, NULL) {
+		switch (opt) {
+		default:
+			printf("%s", lewladd_help);
+			return;
+		}
+	}
+
+	helper_arg(1, 1, &argc, &argv, lewladd_help);
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
+	err = hci_le_add_white_list(dd, &bdaddr, LE_PUBLIC_ADDRESS, 1000);
+	hci_close_dev(dd);
+
+	if (err < 0) {
+		err = errno;
+		fprintf(stderr, "Can't add to white list: %s(%d)\n",
+							strerror(err), err);
+		exit(1);
+	}
+}
+
 static struct option ledc_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ 0, 0, 0, 0 }
@@ -2725,6 +2771,7 @@ static struct {
 	{ "clkoff", cmd_clkoff, "Read clock offset"                    },
 	{ "clock",  cmd_clock,  "Read local or remote clock"           },
 	{ "lescan", cmd_lescan, "Start LE scan"                        },
+	{ "lewladd", cmd_lewladd, "Add device to LE White List"        },
 	{ "lecc",   cmd_lecc,   "Create a LE Connection"               },
 	{ "ledc",   cmd_ledc,   "Disconnect a LE Connection"           },
 	{ "lecup",  cmd_lecup,  "LE Connection Update"                 },
-- 
1.7.4.1

