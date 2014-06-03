Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/4] tools/btmgmt: Rename set-io-cap to io-cap
Date: Tue, 3 Jun 2014 12:13:34 +0200
Message-ID: <1401790416-30962-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401790416-30962-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401790416-30962-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Every other 'set-something' command is just called 'something', so
let's keep this consistent.
---
 tools/btmgmt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 2742dfc..412856d 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -2340,7 +2340,7 @@ static void cmd_conn_info(struct mgmt *mgmt, uint16_t index,
 	}
 }
 
-static void set_io_cap_rsp(uint8_t status, uint16_t len, const void *param,
+static void io_cap_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
 	if (status != 0)
@@ -2353,19 +2353,19 @@ static void set_io_cap_rsp(uint8_t status, uint16_t len, const void *param,
 	mainloop_quit();
 }
 
-static void set_io_cap_usage(void)
+static void io_cap_usage(void)
 {
 	printf("Usage: btmgmt [cap]\n");
 }
 
-static void cmd_set_io_cap(struct mgmt *mgmt, uint16_t index,
+static void cmd_io_cap(struct mgmt *mgmt, uint16_t index,
 						int argc, char **argv)
 {
 	struct mgmt_cp_set_io_capability cp;
 	uint8_t cap;
 
 	if (argc < 2) {
-		set_io_cap_usage();
+		io_cap_usage();
 		exit(EXIT_FAILURE);
 	}
 
@@ -2377,7 +2377,7 @@ static void cmd_set_io_cap(struct mgmt *mgmt, uint16_t index,
 	cp.io_capability = cap;
 
 	if (mgmt_send(mgmt, MGMT_OP_SET_IO_CAPABILITY, index, sizeof(cp), &cp,
-					set_io_cap_rsp, NULL, NULL) == 0) {
+					io_cap_rsp, NULL, NULL) == 0) {
 		fprintf(stderr, "Unable to send set-io-cap cmd\n");
 		exit(EXIT_FAILURE);
 	}
@@ -2466,7 +2466,7 @@ static struct {
 	{ "static-addr",cmd_static_addr,"Set static address"		},
 	{ "debug-keys",	cmd_debug_keys,	"Toogle debug keys"		},
 	{ "conn-info",	cmd_conn_info,	"Get connection information"	},
-	{ "set-io-cap",	cmd_set_io_cap,	"Set IO Capability"		},
+	{ "io-cap",	cmd_io_cap,	"Set IO Capability"		},
 	{ "scan-params",cmd_scan_params,"Set Scan Parameters"		},
 	{ }
 };
-- 
1.9.3

