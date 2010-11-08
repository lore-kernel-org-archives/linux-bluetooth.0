Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/9] Add __btd_error_not_supported()
Date: Mon,  8 Nov 2010 04:29:41 -0200
Message-Id: <1289197787-16715-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1289197787-16715-3-git-send-email-padovan@profusion.mobi>
References: <1289197787-16715-1-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-2-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-3-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |    8 ++------
 src/device.c    |    4 +---
 src/error.c     |    7 +++++++
 src/error.h     |    1 +
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 76f46e9..e9f59fc 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -1020,9 +1020,7 @@ static DBusMessage *volume_up(DBusConnection *conn, DBusMessage *msg,
 					"Device not Connected");
 
 	if (!control->target)
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".NotSupported",
-					"AVRCP Target role not supported");
+		return __btd_error_not_supported(msg);
 
 	err = avctp_send_passthrough(control, VOL_UP_OP);
 	if (err < 0)
@@ -1050,9 +1048,7 @@ static DBusMessage *volume_down(DBusConnection *conn, DBusMessage *msg,
 					"Device not Connected");
 
 	if (!control->target)
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".NotSupported",
-					"AVRCP Target role not supported");
+		return __btd_error_not_supported(msg);
 
 	err = avctp_send_passthrough(control, VOL_DOWN_OP);
 	if (err < 0)
diff --git a/src/device.c b/src/device.c
index 6d110dc..3393634 100644
--- a/src/device.c
+++ b/src/device.c
@@ -540,9 +540,7 @@ static DBusMessage *set_blocked(DBusConnection *conn, DBusMessage *msg,
 	case 0:
 		return dbus_message_new_method_return(msg);
 	case EINVAL:
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".NotSupported",
-					"Kernel lacks blacklist support");
+		return __btd_error_not_supported(msg);
 	default:
 		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
 						"%s", strerror(-err));
diff --git a/src/error.c b/src/error.c
index e268163..4429903 100644
--- a/src/error.c
+++ b/src/error.c
@@ -62,3 +62,10 @@ DBusMessage *__btd_error_already_exists(DBusMessage *msg)
 				ERROR_INTERFACE ".AlreadyExists",
 				"Already Exists");
 }
+
+DBusMessage *__btd_error_not_supported(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE
+					".NotSupported",
+					"Operation is not supported");
+}
diff --git a/src/error.h b/src/error.h
index 284889f..7dbb8b3 100644
--- a/src/error.h
+++ b/src/error.h
@@ -32,3 +32,4 @@ DBusHandlerResult error_common_reply(DBusConnection *conn, DBusMessage *msg,
 
 DBusMessage *__btd_error_invalid_args(DBusMessage *msg);
 DBusMessage *__btd_error_already_exists(DBusMessage *msg);
+DBusMessage *__btd_error_not_supported(DBusMessage *msg);
-- 
1.7.3.1

