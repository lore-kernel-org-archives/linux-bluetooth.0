Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ v3 03/16] attrib: Change command->sent type from gboolean
Date: Wed, 17 Apr 2013 10:03:06 -0400
Message-Id: <1366207399-29536-4-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1366207399-29536-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1365621421-1422-1-git-send-email-jefferson.delfes@openbossa.org>
 <1366207399-29536-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no reason to command->sent be gboolean.
---
 attrib/gattrib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index f6881af..41e1ce4 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -66,7 +66,7 @@ struct command {
 	guint8 *pdu;
 	guint16 len;
 	guint8 expected;
-	gboolean sent;
+	bool sent;
 	GAttribResultFunc func;
 	gpointer user_data;
 	GDestroyNotify notify;
@@ -337,7 +337,7 @@ static gboolean can_write_data(GIOChannel *io, GIOCondition cond,
 		return TRUE;
 	}
 
-	cmd->sent = TRUE;
+	cmd->sent = true;
 
 	if (attrib->timeout_watch == 0)
 		attrib->timeout_watch = g_timeout_add_seconds(GATT_TIMEOUT,
-- 
1.8.2

