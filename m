Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] tools/gatt: Fix accessing NULL cmd
Date: Fri,  5 Sep 2014 17:00:54 +0300
Message-Id: <1409925654-17136-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 tools/btgatt-client.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 3fd492b..d1395b2 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -758,6 +758,9 @@ static void prompt_read_cb(int fd, uint32_t events, void *user_data)
 		if (*cmd != '\0')
 			break;
 
+	if (!cmd)
+		goto failed;
+
 	for (i = 0; command[i].cmd; i++) {
 		if (strcmp(command[i].cmd, cmd) == 0)
 			break;
@@ -768,6 +771,7 @@ static void prompt_read_cb(int fd, uint32_t events, void *user_data)
 	else
 		fprintf(stderr, "Unknown command: %s\n", line);
 
+failed:
 	print_prompt();
 
 	free(line);
-- 
1.9.1

