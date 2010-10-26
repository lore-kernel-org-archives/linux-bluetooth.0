Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH] Fix cache is invalid on empty listing response
Date: Tue, 26 Oct 2010 11:33:48 +0300
Message-Id: <1288082028-10014-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix cache marked as invalid when no data available in response to get phone
book listing. This fixes obexd crash in 3-way calling scenario. Cache is
created when there is second incoming call. If the call is rejected and
retried again, valid empty cache is sent over obex stream that causes obexd
crash. With this fix, the stream is aborted in such scenario. A new attempt
to create cache is carried out on each new subsequent incoming call.
---
 plugins/pbap.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 11cb678..f7f3897 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -407,7 +407,11 @@ static void cache_ready_notify(void *user_data)
 			(const char *) pbap->params->searchval);
 
 	if (sorted == NULL) {
-		pbap->cache.valid = TRUE;
+		/* When no data available from tracker, cache marked as
+		 * invalid (new one will be tried to be created next time),
+		 * no such file or directory error is set, and obex stream
+		 * is aborted */
+		pbap->cache.valid = FALSE;
 		obex_object_set_io_flags(pbap, G_IO_ERR, -ENOENT);
 		return;
 	}
-- 
1.7.0.4

