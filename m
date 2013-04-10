Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ v2 16/16] attrib: Change command->pdu pointer type from guint8
Date: Wed, 10 Apr 2013 15:17:01 -0400
Message-Id: <1365621421-1422-17-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1365621421-1422-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
 <1365621421-1422-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change pointer type of command->pdu for a standard type.
---
 attrib/gattrib.c | 4 ++--
 attrib/gattrib.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index e9b5a15..b00a8d2 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -63,7 +63,7 @@ struct _GAttrib {
 struct command {
 	unsigned int id;
 	uint8_t opcode;
-	guint8 *pdu;
+	uint8_t *pdu;
 	guint16 len;
 	uint8_t expected;
 	bool sent;
@@ -502,7 +502,7 @@ GAttrib *g_attrib_new(GIOChannel *io)
 	return g_attrib_ref(attrib);
 }
 
-unsigned int g_attrib_send(GAttrib *attrib, unsigned int id, const guint8 *pdu,
+unsigned int g_attrib_send(GAttrib *attrib, unsigned int id, const uint8_t *pdu,
 				guint16 len, GAttribResultFunc func,
 				gpointer user_data, GDestroyNotify notify)
 {
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 4404428..5f4477d 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -51,7 +51,7 @@ GIOChannel *g_attrib_get_channel(GAttrib *attrib);
 bool g_attrib_set_destroy_function(GAttrib *attrib, GDestroyNotify destroy,
 							gpointer user_data);
 
-unsigned int g_attrib_send(GAttrib *attrib, unsigned int id, const guint8 *pdu,
+unsigned int g_attrib_send(GAttrib *attrib, unsigned int id, const uint8_t *pdu,
 				guint16 len, GAttribResultFunc func,
 				gpointer user_data, GDestroyNotify notify);
 
-- 
1.8.2

