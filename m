Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH BlueZ v1 1/2] attrib: Remove norequests and noresponses
 variables
Date: Mon, 01 Apr 2013 15:08:00 +0530
Message-id: <1364809081-1796-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Passing NULL is fine to g_queue_is_empty(), so removing these
variables makes the code more readable
---
 attrib/gattrib.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 01c19f9..f95f2fb 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -394,7 +394,6 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 	uint8_t buf[512], status;
 	gsize len;
 	GIOStatus iostat;
-	gboolean norequests, noresponses;
 
 	if (attrib->stale)
 		return FALSE;
@@ -447,11 +446,6 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 	status = 0;
 
 done:
-	norequests = attrib->requests == NULL ||
-			g_queue_is_empty(attrib->requests);
-	noresponses = attrib->responses == NULL ||
-			g_queue_is_empty(attrib->responses);
-
 	if (cmd) {
 		if (cmd->func)
 			cmd->func(status, buf, len, cmd->user_data);
@@ -459,7 +453,8 @@ done:
 		command_destroy(cmd);
 	}
 
-	if (!norequests || !noresponses)
+	if (!g_queue_is_empty(attrib->requests) ||
+					!g_queue_is_empty(attrib->responses))
 		wake_up_sender(attrib);
 
 	return TRUE;
-- 
1.7.9.5

