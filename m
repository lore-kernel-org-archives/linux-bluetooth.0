Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] tools/btgatt-client: Rename sec_level to security
Date: Tue, 28 Apr 2015 17:35:33 +0300
Message-Id: <1430231734-26699-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1430231734-26699-1-git-send-email-luiz.dentz@gmail.com>
References: <1430231734-26699-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/btgatt-client.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index a49e16a..fbc01db 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1195,15 +1195,15 @@ static void cmd_unregister_notify(struct client *cli, char *cmd_str)
 	printf("Unregistered notify handler with id: %u\n", id);
 }
 
-static void set_sec_level_usage(void)
+static void set_security_usage(void)
 {
-	printf("Usage: set_sec_level <level>\n"
+	printf("Usage: set_security <level>\n"
 		"level: 1-3\n"
 		"e.g.:\n"
 		"\tset-sec-level 2\n");
 }
 
-static void cmd_set_sec_level(struct client *cli, char *cmd_str)
+static void cmd_set_security(struct client *cli, char *cmd_str)
 {
 	char *argvbuf[1];
 	char **argv = argvbuf;
@@ -1218,12 +1218,12 @@ static void cmd_set_sec_level(struct client *cli, char *cmd_str)
 
 	if (!parse_args(cmd_str, 1, argv, &argc)) {
 		printf("Too many arguments\n");
-		set_sec_level_usage();
+		set_security_usage();
 		return;
 	}
 
 	if (argc < 1) {
-		set_sec_level_usage();
+		set_security_usage();
 		return;
 	}
 
@@ -1239,7 +1239,7 @@ static void cmd_set_sec_level(struct client *cli, char *cmd_str)
 		printf("Setting security level %d success\n", level);
 }
 
-static void cmd_get_sec_level(struct client *cli, char *cmd_str)
+static void cmd_get_security(struct client *cli, char *cmd_str)
 {
 	int level;
 
@@ -1342,9 +1342,9 @@ static struct {
 			"\tSubscribe to not/ind from a characteristic" },
 	{ "unregister-notify", cmd_unregister_notify,
 						"Unregister a not/ind session"},
-	{ "set-sec-level", cmd_set_sec_level,
+	{ "set-security", cmd_set_security,
 				"\tSet security level on le connection"},
-	{ "get-sec-level", cmd_get_sec_level,
+	{ "get-security", cmd_get_security,
 				"\tGet security level on le connection"},
 	{ "set-sign-key", cmd_set_sign_key,
 				"\tSet signing key for signed write command"},
-- 
2.1.0

