Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 7/7] tools/btmgmt: Add the 'clr-adv' command
Date: Tue, 24 Mar 2015 20:05:54 -0700
Message-Id: <1427252754-27889-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1427252754-27889-1-git-send-email-armansito@chromium.org>
References: <1427252754-27889-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces the 'clr-adv' command which allows users to remove
all registered advertising instances.
---
 tools/btmgmt.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 54dd0f2..f64327b 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3955,6 +3955,14 @@ static void cmd_rm_adv(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	}
 }
 
+static void cmd_clr_adv(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+{
+	char *all_instances = "0";
+	char *rm_argv[] = { "rm-adv", all_instances, NULL };
+
+	cmd_rm_adv(mgmt, index, 2, rm_argv);
+}
+
 struct cmd_info {
 	char *cmd;
 	void (*func)(struct mgmt *mgmt, uint16_t index, int argc, char **argv);
@@ -4018,8 +4026,9 @@ static struct cmd_info all_cmd[] = {
 	{ "bredr-oob",	cmd_bredr_oob,	"Local OOB data (BR/EDR)"	},
 	{ "le-oob",	cmd_le_oob,	"Local OOB data (LE)"		},
 	{ "advinfo",	cmd_advinfo,	"Show advertising features"	},
-	{ "add-adv",	cmd_add_adv,	"Add Advertising Data"		},
-	{ "rm-adv",	cmd_rm_adv,	"Remove Advertising Data"	},
+	{ "add-adv",	cmd_add_adv,	"Add advertising instance"	},
+	{ "rm-adv",	cmd_rm_adv,	"Remove advertising instance"	},
+	{ "clr-adv",	cmd_clr_adv,	"Clear advertising instances"	},
 };
 
 static void cmd_quit(struct mgmt *mgmt, uint16_t index,
-- 
2.2.0.rc0.207.ga3a616c

