Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] tools/btmgmt: Add command to set scan parameters
Date: Mon, 24 Feb 2014 19:32:27 -0300
Message-Id: <1393281147-14390-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btmgmt.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 9a5e971..dd90f34 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -2073,6 +2073,47 @@ static void cmd_debug_keys(struct mgmt *mgmt, uint16_t index,
 	cmd_setting(mgmt, index, MGMT_OP_SET_DEBUG_KEYS, argc, argv);
 }
 
+static void set_scan_params_usage(void)
+{
+	printf("Usage: btmgmt set-scan-params <window> <interval>");
+}
+
+static void set_scan_params_rsp(uint8_t status, uint16_t len, const void *param,
+								void *user_data)
+{
+	if (status != 0)
+		fprintf(stderr, "Set scan parameters failed "
+						"with status 0x%02x (%s)\n",
+						status, mgmt_errstr(status));
+	else
+		printf("Scan parameters successfully set\n");
+
+	mainloop_quit();
+}
+
+static void cmd_set_scan_params(struct mgmt *mgmt, uint16_t index, int argc,
+								char **argv)
+{
+	struct mgmt_cp_set_scan_params cp;
+
+	if (argc != 3) {
+		set_scan_params_usage();
+		exit(EXIT_FAILURE);
+	}
+
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	cp.window = strtol(argv[1], NULL, 16);
+	cp.interval = strtol(argv[2], NULL, 16);
+
+	if (mgmt_send(mgmt, MGMT_OP_SET_SCAN_PARAMS, index, sizeof(cp), &cp,
+					set_scan_params_rsp, NULL, NULL) == 0) {
+		fprintf(stderr, "Unable to send set_scan_params cmd\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
 static struct {
 	char *cmd;
 	void (*func)(struct mgmt *mgmt, uint16_t index, int argc, char **argv);
@@ -2115,6 +2156,7 @@ static struct {
 	{ "did",	cmd_did,	"Set Device ID"			},
 	{ "static-addr",cmd_static_addr,"Set static address"		},
 	{ "debug-keys",	cmd_debug_keys,	"Toogle debug keys"		},
+	{ "set-scan-params", cmd_set_scan_params, "Set scan parameters"	},
 	{ }
 };
 
-- 
1.8.5.4

