Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 3/3] obexd: Fix memory leak
Date: Fri,  1 Aug 2014 14:18:50 +0300
Message-Id: <1406891930-32361-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1406891930-32361-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <20140801103830.GC24358@t440s.P-661HNU-F1>
 <1406891930-32361-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes memory leak for message_listing_cb()
---
 obexd/client/map.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 0ef5e0f..47afc31 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1183,8 +1183,10 @@ static void message_listing_cb(struct obc_session *session,
 	}
 
 	reply = dbus_message_new_method_return(request->msg);
-	if (reply == NULL)
-		return;
+	if (reply == NULL) {
+		g_free(contents);
+		goto clean;
+	}
 
 	dbus_message_iter_init_append(reply, &iter);
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
@@ -1211,6 +1213,7 @@ static void message_listing_cb(struct obc_session *session,
 
 done:
 	g_dbus_send_message(conn, reply);
+clean:
 	pending_request_free(request);
 }
 
-- 
1.9.1

