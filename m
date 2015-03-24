Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 3/4] tools/btmgmt: Add the 'rm-adv' command
Date: Tue, 24 Mar 2015 11:35:10 -0700
Message-Id: <1427222111-15481-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1427222111-15481-1-git-send-email-armansito@chromium.org>
References: <1427222111-15481-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces the add 'rm-adv' command which allows user to
send the MGMT "Remove Advertising" command to the kernel.
---
 tools/btmgmt.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 06f9a82..06f32f3 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3818,6 +3818,58 @@ done:
 		noninteractive_quit(success ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
+static void rm_adv_rsp(uint8_t status, uint16_t len, const void *param,
+								void *user_data)
+{
+	const struct mgmt_rp_remove_advertising *rp = param;
+
+	if (status != 0) {
+		error("Remove Advertising failed with status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+		return noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (len != sizeof(*rp)) {
+		error("Invalid Remove Advertising response length (%u)", len);
+		return noninteractive_quit(EXIT_FAILURE);
+	}
+
+	print("Instance removed: %u", rp->instance);
+
+	return noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void rm_adv_usage(void)
+{
+	print("Usage: rm-adv <instance_id>");
+}
+
+static void cmd_rm_adv(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+{
+	struct mgmt_cp_remove_advertising cp;
+	uint8_t instance;
+
+	if (argc != 2) {
+		rm_adv_usage();
+		return noninteractive_quit(EXIT_FAILURE);
+	}
+
+	instance = strtol(argv[1], NULL, 0);
+
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	memset(&cp, 0, sizeof(cp));
+
+	cp.instance = instance;
+
+	if (!mgmt_send(mgmt, MGMT_OP_REMOVE_ADVERTISING, index, sizeof(cp), &cp,
+						rm_adv_rsp, NULL, NULL)) {
+		error("Unable to send \"Remove Advertising\" command");
+		return noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 struct cmd_info {
 	char *cmd;
 	void (*func)(struct mgmt *mgmt, uint16_t index, int argc, char **argv);
@@ -3882,6 +3934,7 @@ static struct cmd_info all_cmd[] = {
 	{ "le-oob",	cmd_le_oob,	"Local OOB data (LE)"		},
 	{ "advinfo",	cmd_advinfo,	"Show advertising features"	},
 	{ "add-adv",	cmd_add_adv,	"Add Advertising Data"		},
+	{ "rm-adv",	cmd_rm_adv,	"Remove Advertising Data"	},
 };
 
 static void cmd_quit(struct mgmt *mgmt, uint16_t index,
-- 
2.2.0.rc0.207.ga3a616c

