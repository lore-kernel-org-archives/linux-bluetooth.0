Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Patrik Flykt <patrik.flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] btmgmt: Implement Get Networks Management API command
Date: Fri,  4 Mar 2016 13:41:48 +0200
Message-Id: <1457091710-21751-2-git-send-email-patrik.flykt@linux.intel.com>
In-Reply-To: <1457091710-21751-1-git-send-email-patrik.flykt@linux.intel.com>
References: <1457091710-21751-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Send MGMT_OP_GET_NETWORKS Management API command and print out the
connected networks, if any.
---
 lib/mgmt.h     | 11 +++++++++++
 tools/btmgmt.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index f6a976a..9db853c 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -530,6 +530,16 @@ struct mgmt_rp_get_adv_size_info {
 
 #define MGMT_OP_START_LIMITED_DISCOVERY	0x0041
 
+#define MGMT_OP_GET_NETWORKS		0x0042
+#define MGMT_GET_NETWORKS_SIZE		0
+struct mgmt_rp_get_networks {
+	uint16_t count;
+} __packed; /* followed by zero or more struct mgmt_rp_network */
+struct mgmt_rp_network {
+	struct mgmt_addr_info dst;
+	uint32_t ifindex;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -809,6 +819,7 @@ static const char *mgmt_op[] = {
 	"Remove Advertising",
 	"Get Advertising Size Information",		/* 0x0040 */
 	"Start Limited Discovery",
+	"Get Networks",
 };
 
 static const char *mgmt_ev[] = {
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 4c86dcb..fb6eec3 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -4290,6 +4290,59 @@ static void cmd_clr_adv(struct mgmt *mgmt, uint16_t index, int argc, char **argv
 	cmd_rm_adv(mgmt, index, 2, rm_argv);
 }
 
+static void get_networks_rsp(uint8_t status, uint16_t len,
+				const void *param, void *user_data)
+{
+	const struct mgmt_rp_get_networks *rp = param;
+	struct mgmt_rp_network *nw;
+	char addr[18];
+	int i;
+
+	if (len == 0 && status != 0) {
+		error("Get Networks failed, status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+		return noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (len < sizeof(*rp) || len != sizeof(*rp) +
+			rp->count * sizeof(*nw)) {
+		error("Unexpected Get Networks len %u", len);
+		return noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (status) {
+		error("Get Networks failed with status 0x%02x (%s)",
+			status, mgmt_errstr(status));
+	} else {
+		print("Get Networks %d items", rp->count);
+
+		nw = (struct mgmt_rp_network *)(rp + 1);
+		for (i = 0; i < rp->count; i++) {
+			ba2str(&nw->dst.bdaddr, addr);
+			print("%s (%s) interface %d", addr,
+				typestr(nw->dst.type), nw->ifindex);
+			nw++;
+		}
+	}
+
+	noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_get_networks(struct mgmt *mgmt, uint16_t index,
+				int argc, char **argv)
+{
+	if (argc > 1) {
+		print("Usage: %s", argv[0]);
+		return noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (mgmt_send(mgmt, MGMT_OP_GET_NETWORKS, index, 0, NULL,
+				get_networks_rsp, NULL, NULL) == 0) {
+		error("Unable to send Get Networks cmd");
+		return noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 struct cmd_info {
 	char *cmd;
 	void (*func)(struct mgmt *mgmt, uint16_t index, int argc, char **argv);
@@ -4358,6 +4411,7 @@ static struct cmd_info all_cmd[] = {
 	{ "add-adv",	cmd_add_adv,	"Add advertising instance"	},
 	{ "rm-adv",	cmd_rm_adv,	"Remove advertising instance"	},
 	{ "clr-adv",	cmd_clr_adv,	"Clear advertising instances"	},
+	{ "get-networks", cmd_get_networks, "Get 6LowPAN networks"      },
 };
 
 static void cmd_quit(struct mgmt *mgmt, uint16_t index,
-- 
2.1.4

