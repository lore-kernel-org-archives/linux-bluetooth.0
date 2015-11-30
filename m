Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] btproxy: Fix possible string overflow
Date: Mon, 30 Nov 2015 15:32:17 +0200
Message-Id: <1448890337-13444-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Follow common practice when copying to fixed size buffer.
---
 tools/btproxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btproxy.c b/tools/btproxy.c
index 1a3eb5e..ee4dadd 100644
--- a/tools/btproxy.c
+++ b/tools/btproxy.c
@@ -657,7 +657,7 @@ static int open_unix(const char *path)
 
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_UNIX;
-	strcpy(addr.sun_path, path);
+	strncpy(addr.sun_path, path, sizeof(addr.sun_path));
 
 	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		perror("Failed to bind Unix server socket");
-- 
2.5.0

