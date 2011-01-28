Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] hcitool: automatic flush timeout support
Date: Fri, 28 Jan 2011 15:39:02 +0200
Message-Id: <1296221942-28499-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

---
 lib/hci.c       |   54 ++++++++++++++++++++++++++++++++++
 lib/hci.h       |   19 ++++++++++++
 lib/hci_lib.h   |    2 +
 tools/hcitool.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 161 insertions(+), 0 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index 048fda4..533512e 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -2569,6 +2569,60 @@ int hci_read_rssi(int dd, uint16_t handle, int8_t *rssi, int to)
 	return 0;
 }
 
+int hci_read_flush_timeout(int dd, uint16_t handle, uint16_t *timeout, int to)
+{
+	read_flush_timeout_rp rp;
+	struct hci_request rq;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf    = OGF_HOST_CTL;
+	rq.ocf    = OCF_READ_AUTOMATIC_FLUSH_TIMEOUT;
+	rq.cparam = &handle;
+	rq.clen   = READ_FLUSH_TIMEOUT_CP_SIZE;
+	rq.rparam = &rp;
+	rq.rlen   = READ_FLUSH_TIMEOUT_RP_SIZE;
+
+	if (hci_send_req(dd, &rq, to) < 0)
+		return -1;
+
+	if (rp.status) {
+		errno = EIO;
+		return -1;
+	}
+
+	*timeout = rp.flush_timeout;
+	return 0;
+}
+
+int hci_write_flush_timeout(int dd, uint16_t handle, uint16_t timeout, int to)
+{
+	write_flush_timeout_cp cp;
+	write_flush_timeout_rp rp;
+	struct hci_request rq;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = handle;
+	cp.flush_timeout = timeout;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf    = OGF_HOST_CTL;
+	rq.ocf    = OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT;
+	rq.cparam = &cp;
+	rq.clen   = WRITE_FLUSH_TIMEOUT_CP_SIZE;
+	rq.rparam = &rp;
+	rq.rlen   = WRITE_FLUSH_TIMEOUT_RP_SIZE;
+
+	if (hci_send_req(dd, &rq, to) < 0)
+		return -1;
+
+	if (rp.status) {
+		errno = EIO;
+		return -1;
+	}
+
+	return 0;
+}
+
 int hci_read_afh_map(int dd, uint16_t handle, uint8_t *mode, uint8_t *map,
 			int to)
 {
diff --git a/lib/hci.h b/lib/hci.h
index 9b5388b..72cf7e3 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -906,8 +906,27 @@ typedef struct {
 #define WRITE_VOICE_SETTING_CP_SIZE 2
 
 #define OCF_READ_AUTOMATIC_FLUSH_TIMEOUT	0x0027
+typedef struct {
+	uint8_t		status;
+	uint16_t	handle;
+	uint16_t	flush_timeout;
+} __attribute__ ((packed)) read_flush_timeout_rp;
+#define READ_FLUSH_TIMEOUT_RP_SIZE 5
+
+#define READ_FLUSH_TIMEOUT_CP_SIZE 2
 
 #define OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT	0x0028
+typedef struct {
+	uint16_t	handle;
+	uint16_t	flush_timeout;
+} __attribute__ ((packed)) write_flush_timeout_cp;
+#define WRITE_FLUSH_TIMEOUT_CP_SIZE 4
+
+typedef struct {
+	uint8_t		status;
+	uint16_t	handle;
+} __attribute__ ((packed)) write_flush_timeout_rp;
+#define WRITE_FLUSH_TIMEOUT_RP_SIZE 3
 
 #define OCF_READ_NUM_BROADCAST_RETRANS	0x0029
 
diff --git a/lib/hci_lib.h b/lib/hci_lib.h
index b63a2a4..d56dfc2 100644
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -114,6 +114,8 @@ int hci_read_link_quality(int dd, uint16_t handle, uint8_t *link_quality, int to
 int hci_read_rssi(int dd, uint16_t handle, int8_t *rssi, int to);
 int hci_read_afh_map(int dd, uint16_t handle, uint8_t *mode, uint8_t *map, int to);
 int hci_read_clock(int dd, uint16_t handle, uint8_t which, uint32_t *clock, uint16_t *accuracy, int to);
+int hci_read_flush_timeout(int dd, uint16_t handle, uint16_t *timeout, int to);
+int hci_write_flush_timeout(int dd, uint16_t handle, uint16_t timeout, int to);
 
 int hci_le_set_scan_enable(int dev_id, uint8_t enable, uint8_t filter_dup);
 int hci_le_set_scan_parameters(int dev_id, uint8_t type, uint16_t interval,
diff --git a/tools/hcitool.c b/tools/hcitool.c
index d50adaf..580f867 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2517,6 +2517,91 @@ static void cmd_ledc(int dev_id, int argc, char **argv)
 	hci_close_dev(dd);
 }
 
+/* Flush timer */
+
+static struct option flush_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ 0, 0, 0, 0 }
+};
+
+static const char *flush_help =
+	"Usage:\n"
+	"\tflush <bdaddr> [timeout in slots]\n";
+
+static void cmd_flush(int dev_id, int argc, char **argv)
+{
+	struct hci_conn_info_req *cr;
+	bdaddr_t bdaddr;
+	int opt, dd;
+	uint16_t flush_timeout;
+
+	for_each_opt(opt, flush_options, NULL) {
+		switch (opt) {
+			default:
+				printf("%s", flush_help);
+				return;
+		}
+	}
+	helper_arg(1, 2, &argc, &argv, flush_help);
+
+	str2ba(argv[0], &bdaddr);
+
+	if (dev_id < 0) {
+		dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
+		if (dev_id < 0) {
+			fprintf(stderr, "Not connected.\n");
+			exit(1);
+		}
+	}
+
+	dd = hci_open_dev(dev_id);
+	if (dd < 0) {
+		perror("HCI device open failed");
+		exit(1);
+	}
+
+	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
+	if (!cr) {
+		perror("Can't allocate memory");
+		exit(1);
+	}
+
+	bacpy(&cr->bdaddr, &bdaddr);
+	cr->type = ACL_LINK;
+	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
+		perror("Get connection info failed");
+		exit(1);
+	}
+
+	if (argc == 1) {
+		if (hci_read_flush_timeout(dd, htobs(cr->conn_info->handle),
+					&flush_timeout, 1000) < 0) {
+			perror("Read automatic flush timeout failed");
+			exit(1);
+		}
+
+		flush_timeout = btohs(flush_timeout);
+
+		if (flush_timeout)
+			printf("Automatic flush timeout: %u slots (%.2f ms)\n",
+				flush_timeout, (float) flush_timeout * 0.625);
+		else
+			printf("Automatic flush timeout never expires\n");
+	} else {
+		flush_timeout = strtol(argv[1], NULL, 10);
+
+		if (hci_write_flush_timeout(dd, htobs(cr->conn_info->handle),
+					htobs(flush_timeout), 1000) < 0) {
+			perror("Write automatic flush timeout failed");
+			exit(1);
+		}
+	}
+
+	free(cr);
+
+	hci_close_dev(dd);
+}
+
 static struct {
 	char *cmd;
 	void (*func)(int dev_id, int argc, char **argv);
@@ -2546,6 +2631,7 @@ static struct {
 	{ "key",    cmd_key,    "Change connection link key"           },
 	{ "clkoff", cmd_clkoff, "Read clock offset"                    },
 	{ "clock",  cmd_clock,  "Read local or remote clock"           },
+	{ "flush",  cmd_flush,  "Set/display automatic flush timeout"  },
 	{ "lescan", cmd_lescan, "Start LE scan"                        },
 	{ "lecc",   cmd_lecc,   "Create a LE Connection",              },
 	{ "ledc",   cmd_ledc,   "Disconnect a LE Connection",          },
-- 
1.7.1

