Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH Bluez v2 2/2] tools/btmgmt: Use set_index() for --index
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <77a36423-486e-7c95-6f86-3f10a0af0fc0@jp.fujitsu.com>
Message-ID: <bf57367d-6d26-6ea8-eb45-9dc373b91c23@jp.fujitsu.com>
Date: Fri, 17 Nov 2017 16:22:31 +0900
MIME-Version: 1.0
In-Reply-To: <77a36423-486e-7c95-6f86-3f10a0af0fc0@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The command select can also set the specified index even if prefix hci
includes uppercase characters.
---
Changes in v2:
- s/get_index()/mgmt_index/

 tools/btmgmt.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index e218a87ff..3911ba268 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -93,7 +93,7 @@ static void set_index(char *arg)
 	if (!arg || !strcmp(arg, "none") || !strcmp(arg, "any") ||
 						!strcmp(arg, "all"))
 		mgmt_index = MGMT_INDEX_NONE;
-	else if (!strncmp(arg, "hci", 3))
+	else if(strlen(arg) > 3 && !strncasecmp(arg, "hci", 3))
 		mgmt_index = atoi(&arg[3]);
 	else
 		mgmt_index = atoi(arg);
@@ -4810,18 +4810,13 @@ static void mgmt_debug(const char *str, void *user_data)
 int main(int argc, char *argv[])
 {
 	struct io *input;
-	uint16_t index = MGMT_INDEX_NONE;
 	int status, opt;
 
 	while ((opt = getopt_long(argc, argv, "+hi:",
 						main_options, NULL)) != -1) {
 		switch (opt) {
 		case 'i':
-			if (strlen(optarg) > 3 &&
-					strncasecmp(optarg, "hci", 3) == 0)
-				index = atoi(optarg + 3);
-			else
-				index = atoi(optarg);
+			set_index(optarg);
 			break;
 		case 'h':
 		default:
@@ -4855,10 +4850,10 @@ int main(int argc, char *argv[])
 			return EXIT_FAILURE;
 		}
 
-		c->func(mgmt, index, argc, argv);
+		c->func(mgmt, mgmt_index, argc, argv);
 	}
 
-	register_mgmt_callbacks(mgmt, index);
+	register_mgmt_callbacks(mgmt, mgmt_index);
 
 	/* Interactive mode */
 	if (!argc)
@@ -4874,12 +4869,10 @@ int main(int argc, char *argv[])
 		rl_erase_empty_line = 1;
 		rl_callback_handler_install(NULL, rl_handler);
 
-		update_prompt(index);
+		update_prompt(mgmt_index);
 		rl_redisplay();
 	}
 
-	mgmt_index = index;
-
 	status = mainloop_run();
 
 	if (input) {
-- 
2.14.1

