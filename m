Return-Path: <cyrus@holtmann.org>
From: Anchit Narang <anchit.n@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com
Subject: [PATCH] tools/rctest: Closed File to fix memory leak
Date: Thu, 30 Jul 2015 12:20:03 +0530
Message-id: <1438239003-30647-1-git-send-email-anchit.n@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Closed the file  before returning from do_send function.
---
 tools/rctest.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/rctest.c b/tools/rctest.c
index bdc1eb5..a289368 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -559,6 +559,7 @@ static void do_send(int sk)
 		}
 		len = read(fd, buf, data_size);
 		send(sk, buf, len, 0);
+		close(fd);
 		return;
 	} else {
 		for (i = 6; i < data_size; i++)
-- 
1.7.9.5

