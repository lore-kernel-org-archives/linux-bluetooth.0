Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH] Fix status problem after pulling empty call history
Date: Thu,  4 Nov 2010 12:58:00 +0100
Message-Id: <1288871880-5857-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Problem with "OK" status after pulling phonebook for empty call history
(cch) is fixed by this patch. Previously "OK" status was received even
for empty (as it normally does for non-empty) call history and now
"Not Found" status is received in case when there is no call event.
---
 plugins/pbap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 3ea7d6b..a40563c 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -251,7 +251,7 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 
 	DBG("");
 
-	if (vcards < 0) {
+	if (vcards <= 0) {
 		obex_object_set_io_flags(pbap, G_IO_ERR, -ENOENT);
 		return;
 	}
-- 
1.6.3.3

