Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH 1/3] attrib: Remove redundant NULL check
Date: Mon, 04 Mar 2013 18:44:30 +0530
Message-id: <1362402872-13080-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_queue_is_empty() internally checks for NULL and return TRUE
in that case.
---
 attrib/gattrib.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 01c19f9..d648b82 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -447,10 +447,8 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 	status = 0;
 
 done:
-	norequests = attrib->requests == NULL ||
-			g_queue_is_empty(attrib->requests);
-	noresponses = attrib->responses == NULL ||
-			g_queue_is_empty(attrib->responses);
+	norequests = g_queue_is_empty(attrib->requests);
+	noresponses = g_queue_is_empty(attrib->responses);
 
 	if (cmd) {
 		if (cmd->func)
-- 
1.7.9.5

