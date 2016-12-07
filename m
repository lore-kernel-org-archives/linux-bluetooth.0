Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Loic Poulain <loic.poulain@gmail.com>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
        Loic Poulain <loic.poulain@gmail.com>
Subject: [PATCH] shared/mainloop: Fix timeout data memleak
Date: Wed,  7 Dec 2016 14:44:23 +0100
Message-Id: <1481118263-4518-1-git-send-email-loic.poulain@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Valgrind reports "timeout_data" as definitely lost.
Fix this issue in timeout_destroy function.
---
 src/shared/mainloop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/mainloop.c b/src/shared/mainloop.c
index eacb6a4..09c46a7 100644
--- a/src/shared/mainloop.c
+++ b/src/shared/mainloop.c
@@ -283,6 +283,8 @@ static void timeout_destroy(void *user_data)
 
 	if (data->destroy)
 		data->destroy(data->user_data);
+
+	free(data);
 }
 
 static void timeout_callback(int fd, uint32_t events, void *user_data)
-- 
1.9.1

