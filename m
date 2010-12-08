Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Revert use of new error function for Blocked
Date: Tue,  7 Dec 2010 23:02:06 -0200
Message-Id: <1291770126-2726-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The error message says a lot about what the user need to do, I'm reverting
this change and will fix in the next patch series about the DBus error
handling.
---
 src/device.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index cfe00c5..b9341a2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -532,7 +532,9 @@ static DBusMessage *set_blocked(DBusConnection *conn, DBusMessage *msg,
 	case 0:
 		return dbus_message_new_method_return(msg);
 	case EINVAL:
-		return btd_error_not_supported(msg);
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".NotSupported",
+					"Kernel lacks blacklist support");
 	default:
 		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
 						"%s", strerror(-err));
-- 
1.7.3.2

