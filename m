Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Add sec-level option to interactive gattool
Date: Wed, 23 Feb 2011 18:30:10 -0300
Message-Id: <1298496610-11705-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/interactive.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 05d94af..ec77f27 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -537,6 +537,50 @@ static void cmd_char_write_req(int argcp, char **argvp)
 	g_free(value);
 }
 
+static void cmd_sec_level(int argcp, char **argvp)
+{
+	GError *gerr = NULL;
+	BtIOSecLevel sec_level;
+
+	if (argcp < 2) {
+		printf("sec-level: %s\n", opt_sec_level);
+		return;
+	}
+
+	if (strcasecmp(argvp[1], "medium") == 0)
+		sec_level = BT_IO_SEC_MEDIUM;
+	else if (strcasecmp(argvp[1], "high") == 0)
+		sec_level = BT_IO_SEC_HIGH;
+	else if (strcasecmp(argvp[1], "low") == 0)
+		sec_level = BT_IO_SEC_LOW;
+	else {
+		printf("Allowed values: low | medium | high\n");
+		return;
+	}
+
+	g_free(opt_sec_level);
+	opt_sec_level = strdup(argvp[1]);
+
+	if (conn_state == STATE_CONNECTED) {
+		if (opt_psm) {
+			printf("It must be reconnected to this "
+				"change take effect\n");
+			return;
+		}
+
+		bt_io_set(iochannel, BT_IO_L2CAP, &gerr,
+				BT_IO_OPT_SEC_LEVEL, sec_level,
+				BT_IO_OPT_INVALID);
+
+		if (gerr) {
+			printf("Error: %s\n", gerr->message);
+			g_error_free(gerr);
+		}
+	}
+
+	return;
+}
+
 static struct {
 	const char *cmd;
 	void (*func)(int argcp, char **argvp);
@@ -563,6 +607,8 @@ static struct {
 		"Characteristics Value/Descriptor Read by UUID" },
 	{ "char-write-req",	cmd_char_write_req,	"<handle> <new value>",
 		"Characteristic Value Write (Write Request)" },
+	{ "sec-level",		cmd_sec_level,	"[low | medium | high]",
+		"Set security level. Default: low" },
 	{ NULL, NULL, NULL}
 };
 
-- 
1.7.1

