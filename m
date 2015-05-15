Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] gatt: Fix NULL pointer dereference
Date: Fri, 15 May 2015 17:17:01 +0300
Message-Id: <1431699421-21186-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Safely return in case of error.
---
 peripheral/gatt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/peripheral/gatt.c b/peripheral/gatt.c
index 8df62a6..6cf2b79 100644
--- a/peripheral/gatt.c
+++ b/peripheral/gatt.c
@@ -178,6 +178,7 @@ static void att_conn_callback(int fd, uint32_t events, void *user_data)
 	if (!conn) {
 		fprintf(stderr, "Failed to create GATT connection\n");
 		close(new_fd);
+		return;
 	}
 
 	if (!queue_push_tail(conn_list, conn)) {
-- 
2.1.4

