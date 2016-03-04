Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Patrik Flykt <patrik.flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] btmgmt: Implement Add Network Management API command
Date: Fri,  4 Mar 2016 13:41:49 +0200
Message-Id: <1457091710-21751-3-git-send-email-patrik.flykt@linux.intel.com>
In-Reply-To: <1457091710-21751-1-git-send-email-patrik.flykt@linux.intel.com>
References: <1457091710-21751-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Send MGMT_OP_ADD_NETWORK Management API command to create a connection
to a remote 6LowPAN device and wait for the command to complete before
printing out a result.

Also listen for MGMT_EV_NETWORK_ADDED events that indicate creation of
other connections not requested by us.
---
 lib/mgmt.h     |  18 ++++++++++
 tools/btmgmt.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 9db853c..8a9178e 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -540,6 +540,16 @@ struct mgmt_rp_network {
 	uint32_t ifindex;
 } __packed;
 
+#define MGMT_OP_ADD_NETWORK		0x0043
+#define MGMT_ADD_NETWORK_SIZE		7
+struct mgmt_cp_add_network {
+	struct mgmt_addr_info dst;
+} __packed;
+struct mgmt_rp_add_network {
+	struct mgmt_addr_info dst;
+	int ifindex;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -752,6 +762,12 @@ struct mgmt_ev_advertising_removed {
 	uint8_t instance;
 } __packed;
 
+#define MGMT_EV_NETWORK_ADDED		0x0025
+struct mgmt_ev_network_added {
+	struct mgmt_addr_info dst;
+	int ifindex;
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
@@ -820,6 +836,7 @@ static const char *mgmt_op[] = {
 	"Get Advertising Size Information",		/* 0x0040 */
 	"Start Limited Discovery",
 	"Get Networks",
+	"Add Network",
 };
 
 static const char *mgmt_ev[] = {
@@ -860,6 +877,7 @@ static const char *mgmt_ev[] = {
 	"Local Out Of Band Extended Data Updated",
 	"Advertising Added",
 	"Advertising Removed",
+	"Network Added",
 };
 
 static const char *mgmt_status[] = {
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index fb6eec3..7bd0943 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1110,6 +1110,22 @@ static void advertising_removed(uint16_t index, uint16_t len,
 	print("hci%u advertising_removed: instance %u", index, ev->instance);
 }
 
+static void network_added(uint16_t index, uint16_t len,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_network_added *ev = param;
+	char addr[18];
+
+	if (len < sizeof(*ev)) {
+		error("Too few parameters returned (%u bytes)", len);
+		return;
+	}
+
+	ba2str(&ev->dst.bdaddr, addr);
+	print("Network Added %s (%s) hci%d interface %d",
+			addr, typestr(ev->dst.type), index, ev->ifindex);
+}
+
 static void version_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
@@ -4343,6 +4359,93 @@ static void cmd_get_networks(struct mgmt *mgmt, uint16_t index,
 	}
 }
 
+static void network_usage(const char *command)
+{
+	print("Usage: %s [-t type] <remote address>", command);
+}
+
+static struct option network_info_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ "type",	1, 0, 't' },
+	{ 0, 0, 0, 0 }
+};
+
+static void add_network_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	const struct mgmt_rp_add_network *rp = param;
+	char addr[18];
+
+	if (len == 0 && status != 0) {
+		error("Add Network failed, status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+		return noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (len < sizeof(*rp)) {
+		error("Unexpected Add Network len %u", len);
+		return noninteractive_quit(EXIT_FAILURE);
+	}
+
+	ba2str(&rp->dst.bdaddr, addr);
+
+	if (status)
+		error("Add Network %s (%s) failed with status 0x%02x (%s)",
+			addr, typestr(rp->dst.type),
+			status, mgmt_errstr(status));
+	else
+		print("Add Network %s (%s) interface %d", addr,
+			typestr(rp->dst.type), rp->ifindex);
+
+	noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_add_network(struct mgmt *mgmt, uint16_t index,
+			int argc, char **argv)
+{
+	struct mgmt_cp_add_network cp;
+	uint8_t type = BDADDR_LE_PUBLIC;
+	int opt;
+
+	optind = 0;
+	while ((opt = getopt_long(argc, argv, "+t:h", network_info_options,
+								NULL)) != -1) {
+		switch (opt) {
+		case 't':
+			type = strtol(optarg, NULL, 0);
+			break;
+		case 'h':
+			network_usage("add-network");
+			return noninteractive_quit(EXIT_SUCCESS);
+		default:
+			network_usage("add-network");
+			return noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+	optind = 0;
+
+	if (argc < 1) {
+		network_usage("add-network");
+		return noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	memset(&cp, 0, sizeof(cp));
+	str2ba(argv[0], &cp.dst.bdaddr);
+	cp.dst.type = type;
+
+	if (mgmt_send(mgmt, MGMT_OP_ADD_NETWORK, index, sizeof(cp), &cp,
+				add_network_rsp, NULL, NULL) == 0) {
+		error("Unable to send Add Network cmd");
+		return noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 struct cmd_info {
 	char *cmd;
 	void (*func)(struct mgmt *mgmt, uint16_t index, int argc, char **argv);
@@ -4412,6 +4515,7 @@ static struct cmd_info all_cmd[] = {
 	{ "rm-adv",	cmd_rm_adv,	"Remove advertising instance"	},
 	{ "clr-adv",	cmd_clr_adv,	"Clear advertising instances"	},
 	{ "get-networks", cmd_get_networks, "Get 6LowPAN networks"      },
+	{ "add-network", cmd_add_network, "Add a 6LowPAN network"       },
 };
 
 static void cmd_quit(struct mgmt *mgmt, uint16_t index,
@@ -4472,6 +4576,8 @@ static void register_mgmt_callbacks(struct mgmt *mgmt, uint16_t index)
 						advertising_added, NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_ADVERTISING_REMOVED, index,
 					advertising_removed, NULL, NULL);
+	mgmt_register(mgmt, MGMT_EV_NETWORK_ADDED, index, network_added,
+					NULL, NULL);
 }
 
 static void cmd_select(struct mgmt *mgmt, uint16_t index,
-- 
2.1.4

