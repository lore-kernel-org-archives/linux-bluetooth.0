Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/10] Add btd_error_failed()
Date: Mon, 13 Dec 2010 19:33:00 -0200
Message-Id: <1292275987-13799-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1292275987-13799-3-git-send-email-padovan@profusion.mobi>
References: <1292275987-13799-1-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-2-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-3-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a special error type. It has a more general meaning and allows you
to add a string to the error.
---
 src/error.c |    6 ++++++
 src/error.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/src/error.c b/src/error.c
index 013de96..3a78628 100644
--- a/src/error.c
+++ b/src/error.c
@@ -114,3 +114,9 @@ DBusMessage *btd_error_no_such_adapter(DBusMessage *msg)
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".NoSuchAdapter",
 					"No such adapter");
 }
+
+DBusMessage *btd_error_failed(DBusMessage *msg, const char *str)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE
+					".Failed", "%s", str);
+}
diff --git a/src/error.h b/src/error.h
index a4e32fe..faaef0a 100644
--- a/src/error.h
+++ b/src/error.h
@@ -41,3 +41,4 @@ DBusMessage *btd_error_in_progress(DBusMessage *msg);
 DBusMessage *btd_error_does_not_exist(DBusMessage *msg);
 DBusMessage *btd_error_not_authorized(DBusMessage *msg);
 DBusMessage *btd_error_no_such_adapter(DBusMessage *msg);
+DBusMessage *btd_error_failed(DBusMessage *msg, const char *str);
-- 
1.7.3.2

