Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 4/8] client: process transfer queue only if none active
Date: Tue, 21 Feb 2012 14:57:08 +0100
Message-Id: <1329832632-3681-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329832632-3681-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329832632-3681-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

session_process_queue should make sure there is no active operation, to
avoid starting a second one at the same time.
---
 client/session.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/client/session.c b/client/session.c
index e113d1f..7f387d4 100644
--- a/client/session.c
+++ b/client/session.c
@@ -732,6 +732,9 @@ static void session_process_queue(struct obc_session *session)
 {
 	struct pending_request *p;
 
+	if (session->p != NULL)
+		return;
+
 	if (session->queue == NULL || g_queue_is_empty(session->queue))
 		return;
 
-- 
1.7.6.5

