Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v1] tools/btmgmt: Introduce stop-find command
Date: Wed, 11 Mar 2015 20:25:49 -0700
Message-Id: <1426130749-7053-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds stop-find command that stops discovery started by
find, or find-service command.
---
 tools/btmgmt.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 8eff56b..e8f76bb 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1897,6 +1897,84 @@ static void cmd_find(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	}
 }
 
+static void stop_find_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	if (status != 0) {
+		fprintf(stderr,
+			"Stop Discovery failed: status 0x%02x (%s)\n",
+						status, mgmt_errstr(status));
+		mainloop_quit();
+		return;
+	}
+
+	printf("Discovery stopped\n");
+	discovery = false;
+
+	noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void stop_find_usage(void)
+{
+	printf("Usage: btmgmt stop-find [-l|-b]>\n");
+}
+
+static struct option stop_find_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ "le-only",	1, 0, 'l' },
+	{ "bredr-only",	1, 0, 'b' },
+	{ 0, 0, 0, 0 }
+};
+
+static void cmd_stop_find(struct mgmt *mgmt, uint16_t index, int argc,
+			  char **argv)
+{
+	struct mgmt_cp_stop_discovery cp;
+	uint8_t type;
+	int opt;
+
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	type = 0;
+	type |= (1 << BDADDR_BREDR);
+	type |= (1 << BDADDR_LE_PUBLIC);
+	type |= (1 << BDADDR_LE_RANDOM);
+
+	while ((opt = getopt_long(argc, argv, "+lbh", stop_find_options,
+								NULL)) != -1) {
+		switch (opt) {
+		case 'l':
+			type &= ~(1 << BDADDR_BREDR);
+			type |= (1 << BDADDR_LE_PUBLIC);
+			type |= (1 << BDADDR_LE_RANDOM);
+			break;
+		case 'b':
+			type |= (1 << BDADDR_BREDR);
+			type &= ~(1 << BDADDR_LE_PUBLIC);
+			type &= ~(1 << BDADDR_LE_RANDOM);
+			break;
+		case 'h':
+		default:
+			stop_find_usage();
+			exit(EXIT_SUCCESS);
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+	optind = 0;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.type = type;
+
+	if (mgmt_send(mgmt, MGMT_OP_STOP_DISCOVERY, index, sizeof(cp), &cp,
+					     stop_find_rsp, NULL, NULL) == 0) {
+		fprintf(stderr, "Unable to send stop_discovery cmd\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
 static void name_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
@@ -3268,6 +3346,7 @@ static struct cmd_info all_cmd[] = {
 	{ "con",	cmd_con,	"List connections"		},
 	{ "find",	cmd_find,	"Discover nearby devices"	},
 	{ "find-service", cmd_find_service, "Discover nearby service"	},
+	{ "stop-find",	cmd_stop_find,	"Stop discovery"		},
 	{ "name",	cmd_name,	"Set local name"		},
 	{ "pair",	cmd_pair,	"Pair with a remote device"	},
 	{ "cancelpair",	cmd_cancel_pair,"Cancel pairing"		},
-- 
2.2.0.rc0.207.ga3a616c

