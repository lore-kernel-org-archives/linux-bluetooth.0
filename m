Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] obex: Fix checking incorrect error code
Date: Tue,  3 Dec 2013 18:04:54 +0200
Message-Id: <1386086694-22682-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

chdir return -1 if error and 0 in success. Checking for > 0 is pointless.
---
 tools/obex-server-tool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/obex-server-tool.c b/tools/obex-server-tool.c
index e37c56f..86c2271 100644
--- a/tools/obex-server-tool.c
+++ b/tools/obex-server-tool.c
@@ -427,7 +427,7 @@ int main(int argc, char *argv[])
 		exit(EXIT_FAILURE);
 	}
 
-	if (option_root && chdir(option_root) > 0) {
+	if (option_root && chdir(option_root) < 0) {
 		perror("chdir:");
 		exit(EXIT_FAILURE);
 	}
-- 
1.8.3.2

