Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 24 Feb 2016 10:29:45 +0100
From: Chevallier Maxime <maxime.chevallier@openwide.fr>
To: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Subject: [PATCH v2] tools/btgatt-client : fix write-value byte parsing
Message-ID: <20160224092945.GA28224@vps217108.ovh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

write-value, write-long-value and write-prepare were parsing
bytes using strtol with base '0' and restraining wtring size to
be exactly 2, forbidding to write values over 99. The string length
is no more checked, we instead check that the parsed value is in the
correct range.
---
 tools/btgatt-client.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 0f6a1bd..2153bec 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -658,7 +658,7 @@ static void write_cb(bool success, uint8_t att_ecode, void *user_data)
 
 static void cmd_write_value(struct client *cli, char *cmd_str)
 {
-	int opt, i;
+	int opt, i, val;
 	char *argvbuf[516];
 	char **argv = argvbuf;
 	int argc = 1;
@@ -726,19 +726,14 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 		}
 
 		for (i = 1; i < argc; i++) {
-			if (strlen(argv[i]) != 2) {
-				printf("Invalid value byte: %s\n",
-								argv[i]);
-				goto done;
-			}
-
-			value[i-1] = strtol(argv[i], &endptr, 0);
+			val = strtol(argv[i], &endptr, 0);
 			if (endptr == argv[i] || *endptr != '\0'
-							|| errno == ERANGE) {
+				|| errno == ERANGE || val < 0 || val > 255) {
 				printf("Invalid value byte: %s\n",
 								argv[i]);
 				goto done;
 			}
+			value[i-1] = val;
 		}
 	}
 
@@ -793,7 +788,7 @@ static void write_long_cb(bool success, bool reliable_error, uint8_t att_ecode,
 
 static void cmd_write_long_value(struct client *cli, char *cmd_str)
 {
-	int opt, i;
+	int opt, i, val;
 	char *argvbuf[516];
 	char **argv = argvbuf;
 	int argc = 1;
@@ -865,21 +860,15 @@ static void cmd_write_long_value(struct client *cli, char *cmd_str)
 		}
 
 		for (i = 2; i < argc; i++) {
-			if (strlen(argv[i]) != 2) {
-				printf("Invalid value byte: %s\n",
-								argv[i]);
-				free(value);
-				return;
-			}
-
-			value[i-2] = strtol(argv[i], &endptr, 0);
+			val = strtol(argv[i], &endptr, 0);
 			if (endptr == argv[i] || *endptr != '\0'
-							|| errno == ERANGE) {
+				|| errno == ERANGE || val < 0 || val > 255) {
 				printf("Invalid value byte: %s\n",
 								argv[i]);
 				free(value);
 				return;
 			}
+			value[i-2] = val;
 		}
 	}
 
@@ -909,7 +898,7 @@ static struct option write_prepare_options[] = {
 
 static void cmd_write_prepare(struct client *cli, char *cmd_str)
 {
-	int opt, i;
+	int opt, i, val;
 	char *argvbuf[516];
 	char **argv = argvbuf;
 	int argc = 0;
@@ -1002,18 +991,14 @@ static void cmd_write_prepare(struct client *cli, char *cmd_str)
 	}
 
 	for (i = 2; i < argc; i++) {
-		if (strlen(argv[i]) != 2) {
-			printf("Invalid value byte: %s\n", argv[i]);
-			free(value);
-			return;
-		}
-
-		value[i-2] = strtol(argv[i], &endptr, 0);
-		if (endptr == argv[i] || *endptr != '\0' || errno == ERANGE) {
+		val = strtol(argv[i], &endptr, 0);
+		if (endptr == argv[i] || *endptr != '\0' || errno == ERANGE
+						|| val < 0 || val > 255) {
 			printf("Invalid value byte: %s\n", argv[i]);
 			free(value);
 			return;
 		}
+		value[i-2] = val;
 	}
 
 done:
-- 
2.1.4

