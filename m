Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] avdtp: Remove not used pending_auth from struct avdtp
Date: Wed, 11 Sep 2013 15:52:12 +0200
Message-ID: <1378907534-6899-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/avdtp.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 818dbdd..61f55d6 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -41,7 +41,6 @@
 #include <bluetooth/sdp_lib.h>
 
 #include <glib.h>
-#include <dbus/dbus.h>
 #include <btio/btio.h>
 
 #include "log.h"
@@ -426,8 +425,6 @@ struct avdtp {
 
 	/* Attempt stream setup instead of disconnecting */
 	gboolean stream_setup;
-
-	DBusPendingCall *pending_auth;
 };
 
 static GSList *servers = NULL;
@@ -2325,12 +2322,8 @@ static struct avdtp *avdtp_get_internal(struct btd_device *device)
 		return NULL;
 
 	session = find_session(server->sessions, device);
-	if (session) {
-		if (session->pending_auth)
-			return NULL;
-		else
-			return session;
-	}
+	if (session)
+		return session;
 
 	session = g_new0(struct avdtp, 1);
 
-- 
1.8.4

