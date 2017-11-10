Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH Bluez 2/2] tools/btmgmt: Use {get, set}_index() for --index
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <2249773c-05a0-935d-b592-afa28764314d@jp.fujitsu.com>
Message-ID: <e579c607-5bab-af99-7e8f-8cf309284f91@jp.fujitsu.com>
Date: Fri, 10 Nov 2017 18:51:59 +0900
MIME-Version: 1.0
In-Reply-To: <2249773c-05a0-935d-b592-afa28764314d@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The command select can also set the specified index even if prefix hci
includes uppercase characters.
---
 tools/btmgmt.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 5b472bff0..452ccd40b 100644
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
@@ -4815,18 +4815,13 @@ static void mgmt_debug(const char *str, void *user_data)
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
@@ -4860,10 +4855,10 @@ int main(int argc, char *argv[])
 			return EXIT_FAILURE;
 		}
 
-		c->func(mgmt, index, argc, argv);
+		c->func(mgmt, get_index(), argc, argv);
 	}
 
-	register_mgmt_callbacks(mgmt, index);
+	register_mgmt_callbacks(mgmt, get_index());
 
 	/* Interactive mode */
 	if (!argc)
@@ -4879,12 +4874,10 @@ int main(int argc, char *argv[])
 		rl_erase_empty_line = 1;
 		rl_callback_handler_install(NULL, rl_handler);
 
-		update_prompt(index);
+		update_prompt(get_index());
 		rl_redisplay();
 	}
 
-	mgmt_index = index;
-
 	status = mainloop_run();
 
 	if (input) {
-- 
2.14.1

