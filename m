Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ v2 05/16] attrib: Change match_event return type from gboolean
Date: Wed, 10 Apr 2013 15:16:50 -0400
Message-Id: <1365621421-1422-6-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1365621421-1422-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
 <1365621421-1422-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no reason to use gboolean as return type of match_event.
---
 attrib/gattrib.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 9fda74f..636e09d 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -365,28 +365,28 @@ static void wake_up_sender(struct _GAttrib *attrib)
 				can_write_data, attrib, destroy_sender);
 }
 
-static gboolean match_event(struct event *evt, const uint8_t *pdu, gsize len)
+static bool match_event(struct event *evt, const uint8_t *pdu, gsize len)
 {
 	guint16 handle;
 
 	if (evt->expected == GATTRIB_ALL_EVENTS)
-		return TRUE;
+		return true;
 
 	if (!is_response(pdu[0]) && evt->expected == GATTRIB_ALL_REQS)
-		return TRUE;
+		return true;
 
 	if (evt->expected == pdu[0] && evt->handle == GATTRIB_ALL_HANDLES)
-		return TRUE;
+		return true;
 
 	if (len < 3)
-		return FALSE;
+		return false;
 
 	handle = att_get_u16(&pdu[1]);
 
 	if (evt->expected == pdu[0] && evt->handle == handle)
-		return TRUE;
+		return true;
 
-	return FALSE;
+	return false;
 }
 
 static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
-- 
1.8.2

