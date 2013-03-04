Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH 3/3] attrib: Remove norequests and noresponses variables
Date: Mon, 04 Mar 2013 18:44:32 +0530
Message-id: <1362402872-13080-3-git-send-email-jaganath.k@samsung.com>
In-reply-to: <1362402872-13080-1-git-send-email-jaganath.k@samsung.com>
References: <1362402872-13080-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Using g_queue_is_empty() directly in if condition looks more
readable.
---
 attrib/gattrib.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 0090027..37581a3 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -394,7 +394,6 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 	uint8_t buf[512], status;
 	gsize len;
 	GIOStatus iostat;
-	gboolean norequests, noresponses;
 
 	if (attrib->stale)
 		return FALSE;
@@ -447,10 +446,8 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 	status = 0;
 
 done:
-	norequests = g_queue_is_empty(attrib->requests);
-	noresponses = g_queue_is_empty(attrib->responses);
-
-	if (!norequests || !noresponses)
+	if (!g_queue_is_empty(attrib->requests) ||
+					!g_queue_is_empty(attrib->responses))
 		wake_up_sender(attrib);
 
 	if (cmd) {
-- 
1.7.9.5

