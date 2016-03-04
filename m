Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Patrik Flykt <patrik.flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] btmgmt: Implement Remove Network Management API command
Date: Fri,  4 Mar 2016 13:41:50 +0200
Message-Id: <1457091710-21751-4-git-send-email-patrik.flykt@linux.intel.com>
In-Reply-To: <1457091710-21751-1-git-send-email-patrik.flykt@linux.intel.com>
References: <1457091710-21751-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Send MGMT_OP_REMOVE_NETWORK Management API command to disconnect a
connection to a remote 6LowPAN device. Wait for the command to
complete before printing out a result.

Also listen for MGMT_EV_NETWORK_REMOVED events that indicate
disconnection of other connections not requested by us.
---
 lib/mgmt.h     | 16 ++++++++++
 tools/btmgmt.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 8a9178e..43475e7 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -550,6 +550,15 @@ struct mgmt_rp_add_network {
 	int ifindex;
 } __packed;
 
+#define MGMT_OP_REMOVE_NETWORK		0x0044
+#define MGMT_REMOVE_NETWORK_SIZE	7
+struct mgmt_cp_remove_network {
+	struct mgmt_addr_info dst;
+} __packed;
+struct mgmt_rp_remove_network {
+        struct mgmt_addr_info dst;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -768,6 +777,11 @@ struct mgmt_ev_network_added {
 	int ifindex;
 } __packed;
 
+#define MGMT_EV_NETWORK_REMOVED		0x0026
+struct mgmt_ev_network_removed {
+	struct mgmt_addr_info dst;
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
@@ -837,6 +851,7 @@ static const char *mgmt_op[] = {
 	"Start Limited Discovery",
 	"Get Networks",
 	"Add Network",
+	"Remove Network",
 };
 
 static const char *mgmt_ev[] = {
@@ -878,6 +893,7 @@ static const char *mgmt_ev[] = {
 	"Advertising Added",
 	"Advertising Removed",
 	"Network Added",
+	"Network Removed",
 };
 
 static const char *mgmt_status[] = {
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 7bd0943..4b842fb 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1126,6 +1126,22 @@ static void network_added(uint16_t index, uint16_t len,
 			addr, typestr(ev->dst.type), index, ev->ifindex);
 }
 
+static void network_removed(uint16_t index, uint16_t len,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_network_removed *ev = param;
+	char addr[18];
+
+	if (len < sizeof(*ev)) {
+		error("Too few parameters returned (%u bytes)", len);
+		return;
+	}
+
+	ba2str(&ev->dst.bdaddr, addr);
+	print("Network Removed %s (%s) hci%d", addr, typestr(ev->dst.type),
+			index);
+}
+
 static void version_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
@@ -4446,6 +4462,82 @@ static void cmd_add_network(struct mgmt *mgmt, uint16_t index,
 	}
 }
 
+static void remove_network_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	const struct mgmt_rp_remove_network *rp = param;
+	char addr[18];
+
+	if (len == 0 && status != 0) {
+		error("Remove Network failed, status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+		return noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (len < sizeof(*rp)) {
+		error("Unexpected Remove Network len %u", len);
+		return noninteractive_quit(EXIT_FAILURE);
+	}
+
+	ba2str(&rp->dst.bdaddr, addr);
+
+	if (status)
+		error("Remove Network %s (%s) failed with status 0x%02x (%s)",
+			addr, typestr(rp->dst.type),
+			status, mgmt_errstr(status));
+	else
+		print("Remove Network %s (%s)", addr,
+			typestr(rp->dst.type));
+
+	noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_remove_network(struct mgmt *mgmt, uint16_t index,
+			int argc, char **argv)
+{
+	struct mgmt_cp_remove_network cp;
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
+			network_usage(argv[0]);
+			return noninteractive_quit(EXIT_SUCCESS);
+		default:
+			network_usage(argv[0]);
+			return noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+	optind = 0;
+
+	if (argc < 1) {
+		network_usage(argv[0]);
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
+	if (mgmt_send(mgmt, MGMT_OP_REMOVE_NETWORK, index, sizeof(cp), &cp,
+				remove_network_rsp, NULL, NULL) == 0) {
+		error("Unable to send Remove Network cmd");
+		return noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 struct cmd_info {
 	char *cmd;
 	void (*func)(struct mgmt *mgmt, uint16_t index, int argc, char **argv);
@@ -4516,6 +4608,8 @@ static struct cmd_info all_cmd[] = {
 	{ "clr-adv",	cmd_clr_adv,	"Clear advertising instances"	},
 	{ "get-networks", cmd_get_networks, "Get 6LowPAN networks"      },
 	{ "add-network", cmd_add_network, "Add a 6LowPAN network"       },
+	{ "remove-network", cmd_remove_network,
+	                                "Remove a 6LowPAN network"      },
 };
 
 static void cmd_quit(struct mgmt *mgmt, uint16_t index,
@@ -4578,6 +4672,8 @@ static void register_mgmt_callbacks(struct mgmt *mgmt, uint16_t index)
 					advertising_removed, NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_NETWORK_ADDED, index, network_added,
 					NULL, NULL);
+	mgmt_register(mgmt, MGMT_EV_NETWORK_REMOVED, index, network_removed,
+					NULL, NULL);
 }
 
 static void cmd_select(struct mgmt *mgmt, uint16_t index,
-- 
2.1.4

