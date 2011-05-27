Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH] Fix invalid read and possible memory leaks
Date: Fri, 27 May 2011 14:26:24 +0300
Message-Id: <1306495584-9518-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed incorrect update of transport->owners GSlist in media_transport_free.
Removal of list entries within 'for' loop leads to invalid read of memory
(l = l->next) and memory leaks.
---
 audio/transport.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index aa3308d..4047d80 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -805,14 +805,21 @@ static GDBusSignalTable transport_signals[] = {
 	{ }
 };
 
+static void media_transport_remove_helper(gpointer data, gpointer user_data)
+{
+	struct media_transport *transport = user_data;
+	struct media_owner *owner = data;
+
+	media_transport_remove(transport, owner);
+}
+
+
 static void media_transport_free(void *data)
 {
 	struct media_transport *transport = data;
-	GSList *l;
-
-	for (l = transport->owners; l; l = l->next)
-		media_transport_remove(transport, l->data);
 
+	g_slist_foreach(transport->owners, media_transport_remove_helper,
+								transport);
 	g_slist_free(transport->owners);
 
 	if (transport->session)
-- 
1.7.4.1

