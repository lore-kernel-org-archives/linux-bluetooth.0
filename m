Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 2/4] Fix the attrib server trying to handle responses
Date: Mon, 19 Sep 2011 10:20:00 -0300
Message-Id: <1316438402-9982-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1316438402-9982-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1316438402-9982-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

The attribute server should only try to handle ATT requests, responses
and events should be handled by the client.
---
 attrib/gattrib.c    |    4 +++-
 attrib/gattrib.h    |    1 +
 src/attrib-server.c |    2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 8c15e52..4d901f1 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -346,7 +346,9 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 		struct event *evt = l->data;
 
 		if (evt->expected == buf[0] ||
-					evt->expected == GATTRIB_ALL_EVENTS)
+				evt->expected == GATTRIB_ALL_EVENTS ||
+				(is_response(buf[0]) == FALSE &&
+						evt->expected == GATTRIB_ALL_REQS))
 			evt->func(buf, len, evt->user_data);
 	}
 
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 4c49879..47c0d60 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -29,6 +29,7 @@ extern "C" {
 #endif
 
 #define GATTRIB_ALL_EVENTS 0xFF
+#define GATTRIB_ALL_REQS 0xFE
 
 struct _GAttrib;
 typedef struct _GAttrib GAttrib;
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 6c40681..af9c291 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -947,7 +947,7 @@ int attrib_channel_attach(GAttrib *attrib, gboolean out)
 
 
 	channel->attrib = g_attrib_ref(attrib);
-	channel->id = g_attrib_register(channel->attrib, GATTRIB_ALL_EVENTS,
+	channel->id = g_attrib_register(channel->attrib, GATTRIB_ALL_REQS,
 					channel_handler, channel, NULL);
 
 	if (out == FALSE)
-- 
1.7.6.1

