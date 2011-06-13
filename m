Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH v2 2/4] Fix invalid write to memory issue in media module
Date: Mon, 13 Jun 2011 12:50:15 +0200
Message-Id: <1307962215-15497-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Under some circumstances (such as terminating bluetoothd during music is
streamed) endpoint object may be destroyed (memory for endpoint object is
internally freed, directly by "media_endpoint_remove") after invoking
"media_transport_destroy" (in "media_endpoint_clear_configuration") to
destroy transport object (memory for transport object is directly freed by
"media_transport_free"). It leads to invalid write issue (reported by
valgrind) after assignment "endpoint->transport = NULL", since "endpoint"
is "alias" pointer to endpoint object which is already out of date
(memory for endpoint object has been already freed).

This patch prevents from this issue by ensuring that assignment
"endpoint->transport = NULL" would be executed when endpoint object
certainly exists.
---
 audio/media.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 0eb712a..bbb77cf 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -643,6 +643,7 @@ void media_endpoint_clear_configuration(struct media_endpoint *endpoint)
 	DBusConnection *conn;
 	DBusMessage *msg;
 	const char *path;
+	struct media_transport *transport = endpoint->transport;
 
 	if (endpoint->transport == NULL)
 		return;
@@ -665,8 +666,8 @@ void media_endpoint_clear_configuration(struct media_endpoint *endpoint)
 							DBUS_TYPE_INVALID);
 	g_dbus_send_message(conn, msg);
 done:
-	media_transport_destroy(endpoint->transport);
 	endpoint->transport = NULL;
+	media_transport_destroy(transport);
 }
 
 void media_endpoint_release(struct media_endpoint *endpoint)
-- 
1.6.3.3

