Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd 5/9] client: process transfer queue only if none active
Date: Tue, 21 Feb 2012 09:46:19 +0100
Message-Id: <1329813983-26707-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329813983-26707-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329813983-26707-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

session_process_queue should make sure there is no active operation, to
avoid starting a second one at the same time.
---
 client/session.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/client/session.c b/client/session.c
index 160e015..eaabcf9 100644
--- a/client/session.c
+++ b/client/session.c
@@ -726,7 +726,8 @@ static void session_process_queue(struct obc_session *session)
 {
 	struct pending_request *p;
 
-	if (session->queue == NULL || g_queue_is_empty(session->queue))
+	if (session->queue == NULL || g_queue_is_empty(session->queue) ||
+							session->p != NULL)
 		return;
 
 	obc_session_ref(session);
-- 
1.7.6.5

