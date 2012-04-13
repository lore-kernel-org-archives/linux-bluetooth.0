Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/2] sdp-client: Add ability to clear cached session
Date: Fri, 13 Apr 2012 11:34:18 +0200
Message-ID: <1334309659-2046-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be usefull for disconnecting SDP L2CAP channel before cached
session timeout fires.
---
 src/sdp-client.c |   21 ++++++++++++++++++++-
 src/sdp-client.h |    1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/src/sdp-client.c b/src/sdp-client.c
index f119313..55e59c2 100644
--- a/src/sdp-client.c
+++ b/src/sdp-client.c
@@ -61,7 +61,7 @@ static gboolean cached_session_expired(gpointer user_data)
 	return FALSE;
 }
 
-static sdp_session_t *get_sdp_session(const bdaddr_t *src, const bdaddr_t *dst)
+static sdp_session_t *get_cached_sdp_session(const bdaddr_t *src, const bdaddr_t *dst)
 {
 	GSList *l;
 
@@ -82,6 +82,17 @@ static sdp_session_t *get_sdp_session(const bdaddr_t *src, const bdaddr_t *dst)
 		return session;
 	}
 
+	return NULL;
+}
+
+static sdp_session_t *get_sdp_session(const bdaddr_t *src, const bdaddr_t *dst)
+{
+	sdp_session_t *session;
+
+	session = get_cached_sdp_session(src, dst);
+	if (session)
+		return session;
+
 	return sdp_connect(src, dst, SDP_NON_BLOCKING);
 }
 
@@ -367,3 +378,11 @@ int bt_cancel_discovery(const bdaddr_t *src, const bdaddr_t *dst)
 	return 0;
 }
 
+void bt_clear_cached_session(const bdaddr_t *src, const bdaddr_t *dst)
+{
+	sdp_session_t *session;
+
+	session = get_cached_sdp_session(src, dst);
+	if (session)
+		sdp_close(session);
+}
diff --git a/src/sdp-client.h b/src/sdp-client.h
index 13d9121..9191594 100644
--- a/src/sdp-client.h
+++ b/src/sdp-client.h
@@ -28,3 +28,4 @@ int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
 			uuid_t *uuid, bt_callback_t cb, void *user_data,
 			bt_destroy_t destroy);
 int bt_cancel_discovery(const bdaddr_t *src, const bdaddr_t *dst);
+void bt_clear_cached_session(const bdaddr_t *src, const bdaddr_t *dst);
-- 
on behalf of ST-Ericsson

