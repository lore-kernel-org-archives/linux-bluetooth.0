Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ 1/2] tools/btmgmt: Add readline support to stop-find
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-ID: <5f2959f9-9888-1ac5-6991-106f12d651fe@jp.fujitsu.com>
Date: Fri, 6 Oct 2017 13:12:12 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

So can continue to run btmgmt even if using 'stop-find --help' in the 
interactive mode.
---
 tools/btmgmt.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index e454d86..0f21f48 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -2357,13 +2357,12 @@ static void stop_find_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
 	if (status != 0) {
-		fprintf(stderr,
-			"Stop Discovery failed: status 0x%02x (%s)\n",
+		error("Stop Discovery failed: status 0x%02x (%s)",
 						status, mgmt_errstr(status));
 		return noninteractive_quit(EXIT_SUCCESS);
 	}
 
-	printf("Discovery stopped\n");
+	print("Discovery stopped");
 	discovery = false;
 
 	noninteractive_quit(EXIT_SUCCESS);
@@ -2371,7 +2370,7 @@ static void stop_find_rsp(uint8_t status, uint16_t len, const void *param,
 
 static void stop_find_usage(void)
 {
-	printf("Usage: btmgmt stop-find [-l|-b]>\n");
+	print("Usage: btmgmt stop-find [-l|-b]");
 }
 
 static struct option stop_find_options[] = {
@@ -2406,7 +2405,7 @@ static void cmd_stop_find(struct mgmt *mgmt, uint16_t index, int argc,
 		default:
 			stop_find_usage();
 			optind = 0;
-			exit(EXIT_SUCCESS);
+			return noninteractive_quit(EXIT_SUCCESS);
 		}
 	}
 
@@ -2419,8 +2418,8 @@ static void cmd_stop_find(struct mgmt *mgmt, uint16_t index, int argc,
 
 	if (mgmt_send(mgmt, MGMT_OP_STOP_DISCOVERY, index, sizeof(cp), &cp,
 					     stop_find_rsp, NULL, NULL) == 0) {
-		fprintf(stderr, "Unable to send stop_discovery cmd\n");
-		exit(EXIT_FAILURE);
+		error("Unable to send stop_discovery cmd");
+		return noninteractive_quit(EXIT_FAILURE);
 	}
 }
 
-- 
2.7.4

