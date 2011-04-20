Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Cleanup: remove unused structure
Date: Wed, 20 Apr 2011 10:17:22 -0300
Message-Id: <1303305443-24135-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index dbc2c93..5ee6d7f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1320,11 +1320,6 @@ static DBusMessage *adapter_stop_discovery(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
-struct remote_device_list_t {
-	GSList *list;
-	time_t time;
-};
-
 static DBusMessage *get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
-- 
1.7.5.rc1

