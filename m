Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/4] tools: Add conn-info to btmgmt
Date: Fri, 16 May 2014 17:19:12 +0200
Message-ID: <1400253554-31574-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1400253554-31574-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400253554-31574-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>

---
 tools/btmgmt.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 48d42a3..0618de1 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -2137,6 +2137,94 @@ static void cmd_debug_keys(struct mgmt *mgmt, uint16_t index,
 	cmd_setting(mgmt, index, MGMT_OP_SET_DEBUG_KEYS, argc, argv);
 }
 
+static void conn_info_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	const struct mgmt_rp_get_conn_info *rp = param;	char addr[18];
+
+	if (len == 0 && status != 0) {
+		fprintf(stderr, "Get Conn Info failed, status 0x%02x (%s)\n",
+						status, mgmt_errstr(status));
+		goto done;
+	}
+
+	if (len < sizeof(*rp)) {
+		fprintf(stderr, "Unexpected Get Conn Info len %u\n", len);
+		goto done;
+	}
+
+	ba2str(&rp->addr.bdaddr, addr);
+
+	if (status != 0) {
+		fprintf(stderr, "Get Conn Info for %s (%s) failed. status 0x%02x (%s)\n",
+						addr, typestr(rp->addr.type),
+						status, mgmt_errstr(status));
+		goto done;
+	}
+
+	printf("Connection Information for %s (%s)\n",
+						addr, typestr(rp->addr.type));
+	printf("\tRSSI %d\n\tTX power %d\n\tmaximum TX power %d\n",
+				rp->rssi, rp->tx_power, rp->max_tx_power);
+
+done:
+	mainloop_quit();
+}
+
+static void conn_info_usage(void)
+{
+	printf("Usage: btmgmt conn-info [-t type] <remote address>\n");
+}
+
+static struct option conn_info_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ "type",	1, 0, 't' },
+	{ 0, 0, 0, 0 }
+};
+
+static void cmd_conn_info(struct mgmt *mgmt, uint16_t index,
+						int argc, char **argv)
+{
+	struct mgmt_cp_get_conn_info cp;
+	uint8_t type = BDADDR_BREDR;
+	int opt;
+
+	while ((opt = getopt_long(argc, argv, "+t:h", conn_info_options,
+								NULL)) != -1) {
+		switch (opt) {
+		case 't':
+			type = strtol(optarg, NULL, 0);
+			break;
+		case 'h':
+		default:
+			conn_info_usage();
+			exit(EXIT_SUCCESS);
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+	optind = 0;
+
+	if (argc < 1) {
+		conn_info_usage();
+		exit(EXIT_FAILURE);
+	}
+
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	memset(&cp, 0, sizeof(cp));
+	str2ba(argv[0], &cp.addr.bdaddr);
+	cp.addr.type = type;
+
+	if (mgmt_send(mgmt, MGMT_OP_GET_CONN_INFO, index, sizeof(cp), &cp,
+					conn_info_rsp, NULL, NULL) == 0) {
+		fprintf(stderr, "Unable to send get_conn_info cmd\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
 static struct {
 	char *cmd;
 	void (*func)(struct mgmt *mgmt, uint16_t index, int argc, char **argv);
@@ -2179,6 +2267,7 @@ static struct {
 	{ "did",	cmd_did,	"Set Device ID"			},
 	{ "static-addr",cmd_static_addr,"Set static address"		},
 	{ "debug-keys",	cmd_debug_keys,	"Toogle debug keys"		},
+	{ "conn-info",	cmd_conn_info,	"Get connection information"	},
 	{ }
 };
 
-- 
1.9.3

