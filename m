Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 8/8] gattrib: Protect GAttrib when there is a pending write
Date: Wed, 21 Mar 2012 13:00:55 -0400
Message-Id: <1332349255-15764-9-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

---
 attrib/gattrib.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 8a1e97b..c3a70b9 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -293,14 +293,18 @@ static void destroy_sender(gpointer data)
 	struct _GAttrib *attrib = data;
 
 	attrib->write_watch = 0;
+	g_attrib_unref(attrib);
 }
 
 static void wake_up_sender(struct _GAttrib *attrib)
 {
-	if (attrib->write_watch == 0)
-		attrib->write_watch = g_io_add_watch_full(attrib->io,
-			G_PRIORITY_DEFAULT, G_IO_OUT, can_write_data,
-			attrib, destroy_sender);
+	if (attrib->write_watch != 0)
+		return;
+
+	attrib = g_attrib_ref(attrib);
+	attrib->write_watch = g_io_add_watch_full(attrib->io,
+				G_PRIORITY_DEFAULT, G_IO_OUT,
+				can_write_data, attrib, destroy_sender);
 }
 
 static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
-- 
1.7.5.4

