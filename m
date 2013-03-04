Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH 2/3] attrib: Fix use after free of attrib
Date: Mon, 04 Mar 2013 18:44:31 +0530
Message-id: <1362402872-13080-2-git-send-email-jaganath.k@samsung.com>
In-reply-to: <1362402872-13080-1-git-send-email-jaganath.k@samsung.com>
References: <1362402872-13080-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If attrib is freed in cmd->func(), then it will be used if either
request or response queue has some data to send.

This patch moves calling wake_up_sender() which increases the ref
count of attrib so that it wont get freed in cmd->func().
---
 attrib/gattrib.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index d648b82..0090027 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -450,6 +450,9 @@ done:
 	norequests = g_queue_is_empty(attrib->requests);
 	noresponses = g_queue_is_empty(attrib->responses);
 
+	if (!norequests || !noresponses)
+		wake_up_sender(attrib);
+
 	if (cmd) {
 		if (cmd->func)
 			cmd->func(status, buf, len, cmd->user_data);
@@ -457,9 +460,6 @@ done:
 		command_destroy(cmd);
 	}
 
-	if (!norequests || !noresponses)
-		wake_up_sender(attrib);
-
 	return TRUE;
 }
 
-- 
1.7.9.5

