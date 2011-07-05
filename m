Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] avrcp: remove unused dbus reply message
Date: Tue,  5 Jul 2011 17:24:46 -0300
Message-Id: <1309897486-20006-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix leak of dbus messages being created but not unreferenced after
method returns.
---
 audio/control.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index defbbc8..c3ef737 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -1045,13 +1045,8 @@ static DBusMessage *volume_up(DBusConnection *conn, DBusMessage *msg,
 {
 	struct audio_device *device = data;
 	struct control *control = device->control;
-	DBusMessage *reply;
 	int err;
 
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
 	if (control->state != AVCTP_STATE_CONNECTED)
 		return btd_error_not_connected(msg);
 
@@ -1070,13 +1065,8 @@ static DBusMessage *volume_down(DBusConnection *conn, DBusMessage *msg,
 {
 	struct audio_device *device = data;
 	struct control *control = device->control;
-	DBusMessage *reply;
 	int err;
 
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
 	if (control->state != AVCTP_STATE_CONNECTED)
 		return btd_error_not_connected(msg);
 
-- 
1.7.6

