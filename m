Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH] Remove unnecessary jumps
Date: Thu, 26 May 2011 08:42:50 +0200
Message-Id: <1306392170-12483-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/irmc.c          |    4 ++--
 plugins/pbap.c          |    4 ++--
 plugins/syncevolution.c |    9 +++------
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/plugins/irmc.c b/plugins/irmc.c
index 2cf673c..fd233f7 100644
--- a/plugins/irmc.c
+++ b/plugins/irmc.c
@@ -510,7 +510,7 @@ static int irmc_init(void)
 	DBG("");
 	err = phonebook_init();
 	if (err < 0)
-		goto fail_pb_init;
+		return err;
 
 	err = obex_mime_type_driver_register(&irmc_driver);
 	if (err < 0)
@@ -526,7 +526,7 @@ fail_irmc_reg:
 	obex_mime_type_driver_unregister(&irmc_driver);
 fail_mime_irmc:
 	phonebook_exit();
-fail_pb_init:
+
 	return err;
 }
 
diff --git a/plugins/pbap.c b/plugins/pbap.c
index 61e7e42..c4df37f 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -1090,7 +1090,7 @@ static int pbap_init(void)
 
 	err = phonebook_init();
 	if (err < 0)
-		goto fail_pb_init;
+		return err;
 
 	err = obex_mime_type_driver_register(&mime_pull);
 	if (err < 0)
@@ -1118,7 +1118,7 @@ fail_mime_list:
 	obex_mime_type_driver_unregister(&mime_pull);
 fail_mime_pull:
 	phonebook_exit();
-fail_pb_init:
+
 	return err;
 }
 
diff --git a/plugins/syncevolution.c b/plugins/syncevolution.c
index a000b36..0575ab1 100644
--- a/plugins/syncevolution.c
+++ b/plugins/syncevolution.c
@@ -353,12 +353,12 @@ static ssize_t synce_read(void *object, void *buf, size_t count,
 
 	conn = obex_dbus_get_connection();
 	if (conn == NULL)
-		goto failed;
+		return -EPERM;
 
 	msg = dbus_message_new_method_call(SYNCE_BUS_NAME, SYNCE_PATH,
 				SYNCE_SERVER_INTERFACE, "Connect");
 	if (!msg)
-		goto failed;
+		return -EPERM;
 
 	dbus_message_iter_init_append(msg, &iter);
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
@@ -387,7 +387,7 @@ static ssize_t synce_read(void *object, void *buf, size_t count,
 	if (!dbus_connection_send_with_reply(conn, msg, &call, -1)) {
 		error("D-Bus call to %s failed.", SYNCE_SERVER_INTERFACE);
 		dbus_message_unref(msg);
-		goto failed;
+		return -EPERM;
 	}
 
 	dbus_pending_call_set_notify(call, connect_cb, context, NULL);
@@ -396,9 +396,6 @@ static ssize_t synce_read(void *object, void *buf, size_t count,
 	dbus_message_unref(msg);
 
 	return -EAGAIN;
-
-failed:
-	return -EPERM;
 }
 
 static ssize_t synce_write(void *object, const void *buf, size_t count)
-- 
1.7.4.1

