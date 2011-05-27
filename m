Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH] Fix invalid read of memory in avdtp module
Date: Fri, 27 May 2011 14:59:17 +0200
Message-Id: <1306501157-13073-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed incorrect update of server->sessions GSlist in avdtp_exit.
Previosly it was leading to invalid read of memory (l = l->next)
(and possible memory leaks) since after invoking avdtp_unref in
connection_lost, l pointer was not valid anymore (previously assignment
l = l->next was used after invoking connection_lost in for loop).
---
 audio/avdtp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index e6407bb..3b2a9ae 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -3857,9 +3857,15 @@ void avdtp_exit(const bdaddr_t *src)
 	if (!server)
 		return;
 
-	for (l = server->sessions; l; l = l->next) {
+	l = server->sessions;
+	while (l) {
 		struct avdtp *session = l->data;
 
+		l = l->next;
+		/* value of l pointer should be updated before invoking
+		 * connection_lost since it internally uses avdtp_unref
+		 * which operates on server->session list as well
+		 */
 		connection_lost(session, -ECONNABORTED);
 	}
 
-- 
1.6.3.3

