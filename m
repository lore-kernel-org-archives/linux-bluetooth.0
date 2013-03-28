Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 03/16] attrib: Change command->sent type from gboolean
Date: Thu, 28 Mar 2013 11:39:07 -0400
Message-Id: <1364485160-22720-4-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no reason to command->sent be gboolean.
---
 attrib/gattrib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 88bfc97..bd8e380 100644
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
@@ -335,7 +335,7 @@ static gboolean can_write_data(GIOChannel *io, GIOCondition cond,
 		return TRUE;
 	}
 
-	cmd->sent = TRUE;
+	cmd->sent = true;
 
 	if (attrib->timeout_watch == 0)
 		attrib->timeout_watch = g_timeout_add_seconds(GATT_TIMEOUT,
-- 
1.8.2

