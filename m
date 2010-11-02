Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Cleanup set_mode code
Date: Tue,  2 Nov 2010 16:44:16 +0200
Message-Id: <1288709056-7551-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Now that MODE_LIMITED was removed there is no need to compare string mode
to determine if scan mode will change or not.
---
 src/adapter.c |   21 +++++----------------
 1 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 32c74d1..e12d9e5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -603,22 +603,11 @@ done:
 
 	DBG("%s", modestr);
 
-	if (msg != NULL) {
-		/* Limited to Discoverable and vice-versa doesn't cause any
-		   change to scan mode */
-		if (g_str_equal(modestr, mode2str(adapter->mode)) == TRUE) {
-			DBusMessage *reply;
-
-			reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-
-			g_dbus_send_message(connection, reply);
-		} else
-			/* Wait for mode change to reply */
-			adapter->pending_mode = create_session(adapter,
-								connection,
-								msg, new_mode,
-								NULL);
-	} else
+	if (msg != NULL)
+		/* Wait for mode change to reply */
+		adapter->pending_mode = create_session(adapter, connection,
+							msg, new_mode, NULL);
+	else
 		/* Nothing to reply just write the new mode */
 		adapter->mode = new_mode;
 
-- 
1.7.1

