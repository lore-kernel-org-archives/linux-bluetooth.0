Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] tools/btmgmt: Add set-io-cap command
Date: Tue, 27 May 2014 17:17:45 +0200
Message-Id: <1401203866-8851-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed for testing e.g. PTS
---
 tools/btmgmt.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 0618de1..ca16d85 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -2225,6 +2225,49 @@ static void cmd_conn_info(struct mgmt *mgmt, uint16_t index,
 	}
 }
 
+static void set_io_cap_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	if (status != 0)
+		fprintf(stderr, "Could not set IO Capability with "
+						"status 0x%02x (%s)\n",
+						status, mgmt_errstr(status));
+	else
+		printf("IO Capabilities successfully set\n");
+
+	mainloop_quit();
+}
+
+static void set_io_cap_usage(void)
+{
+	printf("Usage: btmgmt [cap]\n");
+}
+
+static void cmd_set_io_cap(struct mgmt *mgmt, uint16_t index,
+						int argc, char **argv)
+{
+	struct mgmt_cp_set_io_capability cp;
+	uint8_t cap = 0x01;
+
+	if (argc < 2) {
+		set_io_cap_usage();
+		exit(EXIT_FAILURE);
+	}
+
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	cap = atoi(argv[1]);
+	memset(&cp, 0, sizeof(cp));
+	cp.io_capability = cap;
+
+	if (mgmt_send(mgmt, MGMT_OP_SET_IO_CAPABILITY, index, sizeof(cp), &cp,
+					set_io_cap_rsp, NULL, NULL) == 0) {
+		fprintf(stderr, "Unable to send set-io-cap cmd\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
 static struct {
 	char *cmd;
 	void (*func)(struct mgmt *mgmt, uint16_t index, int argc, char **argv);
@@ -2268,6 +2311,7 @@ static struct {
 	{ "static-addr",cmd_static_addr,"Set static address"		},
 	{ "debug-keys",	cmd_debug_keys,	"Toogle debug keys"		},
 	{ "conn-info",	cmd_conn_info,	"Get connection information"	},
+	{ "set-io-cap",	cmd_set_io_cap,	"Set IO Capability"		},
 	{ }
 };
 
-- 
1.8.4

