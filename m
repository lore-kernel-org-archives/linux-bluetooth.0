Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] btproxy: Fix double close
Date: Thu,  9 Jan 2014 11:01:22 +0200
Message-Id: <1389258082-10847-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

setup_streams() already makes close()
---
 tools/btproxy.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/btproxy.c b/tools/btproxy.c
index 1573587..f872326 100644
--- a/tools/btproxy.c
+++ b/tools/btproxy.c
@@ -411,11 +411,8 @@ static void server_callback(int fd, uint32_t events, void *user_data)
 
 	printf("New client connected\n");
 
-	if (!setup_streams(src_fd, src_type_rx, src_type_tx,  dst_fd)) {
-		close(dst_fd);
-		close(src_fd);
+	if (!setup_streams(src_fd, src_type_rx, src_type_tx,  dst_fd))
 		return;
-	}
 
 	client_active = true;
 }
-- 
1.8.3.2

