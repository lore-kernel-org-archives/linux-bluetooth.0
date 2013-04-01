Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH BlueZ v1 2/2] attrib: Fix use after free of attrib
Date: Mon, 01 Apr 2013 15:08:01 +0530
Message-id: <1364809081-1796-2-git-send-email-jaganath.k@samsung.com>
In-reply-to: <1364809081-1796-1-git-send-email-jaganath.k@samsung.com>
References: <1364809081-1796-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If attrib is freed in cmd->func(), then it will be used if either
request or response queue has some data to send.

This patch moves calling wake_up_sender() which increases the ref
count of attrib so that it wont get freed in cmd->func().
---
 attrib/gattrib.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index f95f2fb..37581a3 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -446,6 +446,10 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 	status = 0;
 
 done:
+	if (!g_queue_is_empty(attrib->requests) ||
+					!g_queue_is_empty(attrib->responses))
+		wake_up_sender(attrib);
+
 	if (cmd) {
 		if (cmd->func)
 			cmd->func(status, buf, len, cmd->user_data);
@@ -453,10 +457,6 @@ done:
 		command_destroy(cmd);
 	}
 
-	if (!g_queue_is_empty(attrib->requests) ||
-					!g_queue_is_empty(attrib->responses))
-		wake_up_sender(attrib);
-
 	return TRUE;
 }
 
-- 
1.7.9.5

