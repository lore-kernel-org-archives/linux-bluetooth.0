Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 05/16] attrib: Change match_event return type from gboolean
Date: Thu, 28 Mar 2013 11:39:09 -0400
Message-Id: <1364485160-22720-6-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no reason to use gboolean as return type of match_event.
---
 attrib/gattrib.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 9470457..c59d5f5 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -363,28 +363,28 @@ static void wake_up_sender(struct _GAttrib *attrib)
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

