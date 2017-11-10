Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH Bluez 1/2] tools/btmgmt: Introduce {get, set}_index()
Message-ID: <2249773c-05a0-935d-b592-afa28764314d@jp.fujitsu.com>
Date: Fri, 10 Nov 2017 18:51:34 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btmgmt.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 552f74411..5b472bff0 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -88,6 +88,22 @@ static int pending_index = 0;
 
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
+static uint16_t get_index(void)
+{
+	return mgmt_index;
+}
+
 static void update_prompt(uint16_t index)
 {
 	char str[32];
@@ -4535,19 +4551,13 @@ static void cmd_select(struct mgmt *mgmt, uint16_t index,
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
 
-	register_mgmt_callbacks(mgmt, mgmt_index);
+	register_mgmt_callbacks(mgmt, get_index());
 
-	print("Selected index %u", mgmt_index);
+	print("Selected index %u", get_index());
 
-	update_prompt(mgmt_index);
+	update_prompt(get_index());
 }
 
 static struct cmd_info interactive_cmd[] = {
@@ -4695,7 +4705,7 @@ static void rl_handler(char *input)
 		c = find_cmd(cmd, interactive_cmd, NELEM(interactive_cmd));
 
 	if (c && c->func) {
-		c->func(mgmt, mgmt_index, argc, argv);
+		c->func(mgmt, get_index(), argc, argv);
 		goto free_we;
 	}
 
-- 
2.14.1

