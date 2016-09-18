Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v2 4/5] tools/btmgmt: Add support for Set Appearance command
Date: Sun, 18 Sep 2016 12:34:40 +0200
Message-Id: <1474194881-10403-4-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1474194881-10403-1-git-send-email-szymon.janc@codecoup.pl>
References: <1474194881-10403-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btmgmt.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 0def4e1..3828c2a 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -4362,6 +4362,40 @@ static void cmd_clr_adv(struct mgmt *mgmt, uint16_t index, int argc, char **argv
 	cmd_rm_adv(mgmt, index, 2, rm_argv);
 }
 
+static void appearance_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	if (status != 0)
+		error("Could not set Appearance with status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+	else
+		print("Appearance successfully set");
+
+	noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_appearance(struct mgmt *mgmt, uint16_t index, int argc,
+								char **argv)
+{
+	struct mgmt_cp_set_appearance cp;
+
+	if (argc < 2) {
+		print("Usage: appearance <appearance>");
+		return noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	cp.appearance = cpu_to_le16(strtol(argv[1], NULL, 0));
+
+	if (mgmt_send(mgmt, MGMT_OP_SET_APPEARANCE, index, sizeof(cp), &cp,
+					appearance_rsp, NULL, NULL) == 0) {
+		error("Unable to send appearance cmd");
+		return noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 struct cmd_info {
 	char *cmd;
 	void (*func)(struct mgmt *mgmt, uint16_t index, int argc, char **argv);
@@ -4430,6 +4464,7 @@ static struct cmd_info all_cmd[] = {
 	{ "add-adv",	cmd_add_adv,	"Add advertising instance"	},
 	{ "rm-adv",	cmd_rm_adv,	"Remove advertising instance"	},
 	{ "clr-adv",	cmd_clr_adv,	"Clear advertising instances"	},
+	{ "appearance",	cmd_appearance,	"Set appearance"		},
 };
 
 static void cmd_quit(struct mgmt *mgmt, uint16_t index,
-- 
2.7.4

