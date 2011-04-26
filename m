Return-Path: <cyrus@holtmann.org>
From: wu.zheng@intel.com
To: linux-bluetooth@vger.kernel.org
Cc: "wu.zheng" <wu.zheng@intel.com>
Subject: [PATCH] Check session->msg at sync_getphonebook_callback() in file client/sync.c
Date: Tue, 26 Apr 2011 10:45:54 +0800
Message-Id: <1303785954-16905-1-git-send-email-wu.zheng@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: wu.zheng <wu.zheng@intel.com>

Otherwise,session->msg will be NULL and cause segmentation fault error.The reason is that the condition of transfer->fd>0 && session->msg is ok and session->msg will be set to NULL in the func of session_notify_progress when sync profile is used.

---
 client/sync.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/client/sync.c b/client/sync.c
index 3622a3d..28ace61 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -78,6 +78,9 @@ static void sync_getphonebook_callback(struct session_data *session,
 	DBusMessage *reply;
 	char *buf = NULL;
 
+	if (session->msg == NULL)
+		goto done;
+
 	reply = dbus_message_new_method_return(session->msg);
 
 	if (transfer->filled > 0)
@@ -91,6 +94,8 @@ static void sync_getphonebook_callback(struct session_data *session,
 	g_dbus_send_message(session->conn, reply);
 	dbus_message_unref(session->msg);
 	session->msg = NULL;
+done:
+	transfer_unregister(transfer); 
 }
 
 static DBusMessage *sync_getphonebook(DBusConnection *connection,
-- 
1.7.3.4

