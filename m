Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH v2] Fix invalid read and possible memory leaks
Date: Fri, 27 May 2011 16:33:51 +0300
Message-Id: <1306503231-11664-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1306503231-11664-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1306503231-11664-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed incorrect update of transport->owners GSlist in media_transport_free.
Removal of list entries within 'for' loop leads to invalid read of memory
(l = l->next) and memory leaks.
---
 audio/transport.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index aa3308d..7c99207 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -808,10 +808,13 @@ static GDBusSignalTable transport_signals[] = {
 static void media_transport_free(void *data)
 {
 	struct media_transport *transport = data;
-	GSList *l;
+	GSList *l = transport->owners;
 
-	for (l = transport->owners; l; l = l->next)
-		media_transport_remove(transport, l->data);
+	while (l) {
+		struct media_owner *owner = l->data;
+		l = l->next;
+		media_transport_remove(transport, owner);
+	}
 
 	g_slist_free(transport->owners);
 
-- 
1.7.4.1

