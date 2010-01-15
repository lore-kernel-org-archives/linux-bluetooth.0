Return-Path: <cyrus@holtmann.org>
From: Zhu Yanhai <yanhai.zhu@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Zhu Yanhai <yanhai.zhu@linux.intel.com>
Subject: [PATCH] Pick up the first modem found by oFono
Date: Fri, 15 Jan 2010 15:51:49 +0800
Message-Id: <1263541909-19739-1-git-send-email-yanhai.zhu@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

During the initial phase, for now we just pick up the first modem
detected by oFono, and skip over the others. If there are no modems
found, just exit silently.

Signed-off-by: Zhu Yanhai <yanhai.zhu@linux.intel.com>
---
 audio/telephony-ofono.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 2778cfc..9b99dc5 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -571,18 +571,23 @@ static void list_modem_reply(DBusPendingCall *call, void *user_data)
 	dbus_message_iter_next(&iter_property);
 	dbus_message_iter_recurse(&iter_property, &iter_arrary);
 	dbus_message_iter_recurse(&iter_arrary, &sub);
-	while (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_INVALID) {
 
-		dbus_message_iter_get_basic(&sub, &modem_obj_path_local);
-		modem_obj_path = g_strdup(modem_obj_path_local);
-		debug("modem_obj_path is %p, %s\n", modem_obj_path,
-						modem_obj_path);
-		dbus_message_iter_next(&sub);
+	if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_OBJECT_PATH) {
+		debug("No modem found.");
+		goto done;
 	}
 
-	ret = get_registration_and_signal_status();
-	if (ret < 0)
-		error("get_registration_and_signal_status() failed(%d)", ret);
+	dbus_message_iter_get_basic(&sub, &modem_obj_path_local);
+	if (modem_obj_path_local != NULL) {
+		modem_obj_path = g_strdup(modem_obj_path_local);
+		debug("modem_obj_path is %s", modem_obj_path);
+		ret = get_registration_and_signal_status();
+		if (ret < 0)
+			error("get_registration_and_signal_status() failed(%d)",
+				   ret);
+	} else
+		error("Fail to retrieve modem's object path.");
+
 done:
 	dbus_message_unref(reply);
 }
-- 
1.6.2.2

