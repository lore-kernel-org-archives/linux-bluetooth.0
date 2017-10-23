Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 6/8] tools/btmgmt: Refactor for functions to parse
 setting
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <2c74601a-9a6f-6dd3-5bf4-a1988ae21dc3@jp.fujitsu.com>
Message-ID: <4f2edbe5-5d93-90bc-b724-4b0ee78966da@jp.fujitsu.com>
Date: Mon, 23 Oct 2017 17:28:07 +0900
MIME-Version: 1.0
In-Reply-To: <2c74601a-9a6f-6dd3-5bf4-a1988ae21dc3@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btmgmt.c | 45 +++++++++++++++++----------------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 1bc97aa..ee2cb18 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1787,22 +1787,29 @@ done:
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void cmd_setting(struct mgmt *mgmt, uint16_t index, uint16_t op,
-							int argc, char **argv)
+static bool parse_setting(int argc, char **argv, uint8_t *val)
 {
-	uint8_t val;
-
 	if (argc < 2) {
 		print("Specify \"on\" or \"off\"");
-		return noninteractive_quit(EXIT_FAILURE);
+		return false;
 	}
 
 	if (strcasecmp(argv[1], "on") == 0 || strcasecmp(argv[1], "yes") == 0)
-		val = 1;
+		*val = 1;
 	else if (strcasecmp(argv[1], "off") == 0)
-		val = 0;
+		*val = 0;
 	else
-		val = atoi(argv[1]);
+		*val = atoi(argv[1]);
+	return true;
+}
+
+static void cmd_setting(struct mgmt *mgmt, uint16_t index, uint16_t op,
+							int argc, char **argv)
+{
+	uint8_t val;
+
+	if (parse_setting(argc, argv, &val) == false)
+		return noninteractive_quit(EXIT_FAILURE);
 
 	if (index == MGMT_INDEX_NONE)
 		index = 0;
@@ -1935,17 +1942,8 @@ static void cmd_privacy(struct mgmt *mgmt, uint16_t index, int argc,
 {
 	struct mgmt_cp_set_privacy cp;
 
-	if (argc < 2) {
-		print("Specify \"on\" or \"off\"");
+	if (parse_setting(argc, argv, &cp.privacy) == false)
 		return noninteractive_quit(EXIT_FAILURE);
-	}
-
-	if (strcasecmp(argv[1], "on") == 0 || strcasecmp(argv[1], "yes") == 0)
-		cp.privacy = 0x01;
-	else if (strcasecmp(argv[1], "off") == 0)
-		cp.privacy = 0x00;
-	else
-		cp.privacy = atoi(argv[1]);
 
 	if (index == MGMT_INDEX_NONE)
 		index = 0;
@@ -3351,17 +3349,8 @@ static void cmd_ext_config(struct mgmt *mgmt, uint16_t index,
 {
 	struct mgmt_cp_set_external_config cp;
 
-	if (argc < 2) {
-		print("Specify \"on\" or \"off\"");
+	if (parse_setting(argc, argv, &cp.config) == false)
 		return noninteractive_quit(EXIT_FAILURE);
-	}
-
-	if (strcasecmp(argv[1], "on") == 0 || strcasecmp(argv[1], "yes") == 0)
-		cp.config = 0x01;
-	else if (strcasecmp(argv[1], "off") == 0)
-		cp.config = 0x00;
-	else
-		cp.config = atoi(argv[1]);
 
 	if (index == MGMT_INDEX_NONE)
 		index = 0;
-- 
2.7.4

