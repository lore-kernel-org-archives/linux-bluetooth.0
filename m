Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH Bluez v2 1/2] tools/btmgmt: Introduce set_index()
Message-ID: <77a36423-486e-7c95-6f86-3f10a0af0fc0@jp.fujitsu.com>
Date: Fri, 17 Nov 2017 16:20:00 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
Changes in v2:
- remove get_index()
- s/get_index()/mgmt_index/

 tools/btmgmt.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 552f74411..e218a87ff 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -88,6 +88,17 @@ static int pending_index = 0;
 
 #define PROMPT_ON	COLOR_BLUE "[mgmt]" COLOR_OFF "# "
 
+static void set_index(char *arg)
+{
+	if (!arg || !strcmp(arg, "none") || !strcmp(arg, "any") ||
+						!strcmp(arg, "all"))
+		mgmt_index = MGMT_INDEX_NONE;
+	else if (!strncmp(arg, "hci", 3))
+		mgmt_index = atoi(&arg[3]);
+	else
+		mgmt_index = atoi(arg);
+}
+
 static void update_prompt(uint16_t index)
 {
 	char str[32];
@@ -4535,13 +4546,7 @@ static void cmd_select(struct mgmt *mgmt, uint16_t index,
 	mgmt_cancel_all(mgmt);
 	mgmt_unregister_all(mgmt);
 
-	if (!strcmp(argv[1], "none") || !strcmp(argv[1], "any") ||
-						!strcmp(argv[1], "all"))
-		mgmt_index = MGMT_INDEX_NONE;
-	else if (!strncmp(argv[1], "hci", 3))
-		mgmt_index = atoi(&argv[1][3]);
-	else
-		mgmt_index = atoi(argv[1]);
+	set_index(argv[1]);
 
 	register_mgmt_callbacks(mgmt, mgmt_index);
 
-- 
2.14.1

