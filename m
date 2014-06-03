Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/4] tools/btmgmt: Add scan-params command
Date: Tue, 3 Jun 2014 12:13:33 +0200
Message-ID: <1401790416-30962-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btmgmt.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 0c42e17..2742dfc 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -2383,6 +2383,46 @@ static void cmd_set_io_cap(struct mgmt *mgmt, uint16_t index,
 	}
 }
 
+static void scan_params_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	if (status != 0)
+		fprintf(stderr, "Set scan parameters failed with status 0x%02x (%s)\n",
+						status, mgmt_errstr(status));
+	else
+		printf("Scan parameters successfully set\n");
+
+	mainloop_quit();
+}
+
+static void scan_params_usage(void)
+{
+	printf("Usage: btmgmt scan-params <interval> <window>\n");
+}
+
+static void cmd_scan_params(struct mgmt *mgmt, uint16_t index,
+							int argc, char **argv)
+{
+	struct mgmt_cp_set_scan_params cp;
+
+	if (argc < 3) {
+		scan_params_usage();
+		exit(EXIT_FAILURE);
+	}
+
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	cp.interval = strtol(argv[1], NULL, 0);
+	cp.window = strtol(argv[2], NULL, 0);
+
+	if (mgmt_send(mgmt, MGMT_OP_SET_SCAN_PARAMS, index, sizeof(cp), &cp,
+					scan_params_rsp, NULL, NULL) == 0) {
+		fprintf(stderr, "Unable to send set_scan_params cmd\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
 static struct {
 	char *cmd;
 	void (*func)(struct mgmt *mgmt, uint16_t index, int argc, char **argv);
@@ -2427,6 +2467,7 @@ static struct {
 	{ "debug-keys",	cmd_debug_keys,	"Toogle debug keys"		},
 	{ "conn-info",	cmd_conn_info,	"Get connection information"	},
 	{ "set-io-cap",	cmd_set_io_cap,	"Set IO Capability"		},
+	{ "scan-params",cmd_scan_params,"Set Scan Parameters"		},
 	{ }
 };
 
-- 
1.9.3

