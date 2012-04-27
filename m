Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH obexd v0 4/6] client: Use new session callback style in modules
Date: Fri, 27 Apr 2012 12:33:38 +0200
Message-Id: <1335522820-11826-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1335522820-11826-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1335522820-11826-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The session API now provides the transfer object in the callback, so
the modules can directly access the transfer object.
---
 client/ftp.c     |    3 ++-
 client/manager.c |    3 ++-
 client/map.c     |    3 ++-
 client/pbap.c    |   11 ++++++-----
 client/sync.c    |    3 ++-
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index baeeb2d..d7800b0 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -33,6 +33,7 @@
 #include "log.h"
 
 #include "session.h"
+#include "transfer.h"
 #include "driver.h"
 #include "ftp.h"
 
@@ -203,7 +204,7 @@ static void list_folder_callback(struct obc_session *session,
 
 	reply = dbus_message_new_method_return(msg);
 
-	if (obc_session_get_contents(session, &contents, &size) < 0)
+	if (obc_transfer_get_contents(transfer, &contents, &size) < 0)
 		goto done;
 
 	dbus_message_iter_init_append(reply, &iter);
diff --git a/client/manager.c b/client/manager.c
index 2eb944e..783367b 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -36,6 +36,7 @@
 
 #include "log.h"
 #include "session.h"
+#include "transfer.h"
 #include "manager.h"
 #include "bluetooth.h"
 #include "opp.h"
@@ -465,7 +466,7 @@ static void capabilities_complete_callback(struct obc_session *session,
 		goto done;
 	}
 
-	perr = obc_session_get_contents(session, &contents, &size);
+	perr = obc_transfer_get_contents(transfer, &contents, &size);
 	if (perr < 0) {
 		DBusMessage *error = g_dbus_create_error(data->message,
 						"org.openobex.Error.Failed",
diff --git a/client/map.c b/client/map.c
index 05ba6aa..e05850f 100644
--- a/client/map.c
+++ b/client/map.c
@@ -33,6 +33,7 @@
 
 #include "map.h"
 #include "session.h"
+#include "transfer.h"
 #include "driver.h"
 
 #define OBEX_MAS_UUID \
@@ -111,7 +112,7 @@ static void buffer_cb(struct obc_session *session,
 		goto done;
 	}
 
-	perr = obc_session_get_contents(session, &contents, &size);
+	perr = obc_transfer_get_contents(transfer, &contents, &size);
 	if (perr < 0) {
 		reply = g_dbus_create_error(map->msg,
 						"org.openobex.Error.Failed",
diff --git a/client/pbap.c b/client/pbap.c
index 0912ac0..925662d 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -37,6 +37,7 @@
 #include "log.h"
 
 #include "session.h"
+#include "transfer.h"
 #include "driver.h"
 #include "pbap.h"
 
@@ -291,7 +292,7 @@ static void pbap_setpath_cb(struct obc_session *session, GError *err,
 	pending_request_free(request);
 }
 
-static void read_return_apparam(struct obc_session *session,
+static void read_return_apparam(struct obc_transfer *transfer,
 				guint16 *phone_book_size, guint8 *new_missed_calls)
 {
 	const struct apparam_hdr *hdr;
@@ -300,7 +301,7 @@ static void read_return_apparam(struct obc_session *session,
 	*phone_book_size = 0;
 	*new_missed_calls = 0;
 
-	hdr = obc_session_get_params(session, &size);
+	hdr = obc_transfer_get_params(transfer, &size);
 	if (hdr == NULL)
 		return;
 
@@ -355,7 +356,7 @@ static void pull_phonebook_callback(struct obc_session *session,
 		goto send;
 	}
 
-	perr = obc_session_get_contents(session, &contents, &size);
+	perr = obc_transfer_get_contents(transfer, &contents, &size);
 	if (perr < 0) {
 		reply = g_dbus_create_error(request->msg,
 						"org.openobex.Error.Failed",
@@ -395,7 +396,7 @@ static void phonebook_size_callback(struct obc_session *session,
 
 	reply = dbus_message_new_method_return(request->msg);
 
-	read_return_apparam(session, &phone_book_size, &new_missed_calls);
+	read_return_apparam(transfer, &phone_book_size, &new_missed_calls);
 
 	dbus_message_append_args(reply,
 			DBUS_TYPE_UINT16, &phone_book_size,
@@ -425,7 +426,7 @@ static void pull_vcard_listing_callback(struct obc_session *session,
 		goto send;
 	}
 
-	perr = obc_session_get_contents(session, &contents, &size);
+	perr = obc_transfer_get_contents(transfer, &contents, &size);
 	if (perr < 0) {
 		reply = g_dbus_create_error(request->msg,
 						"org.openobex.Error.Failed",
diff --git a/client/sync.c b/client/sync.c
index e3a78d5..96cf486 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -35,6 +35,7 @@
 #include "log.h"
 
 #include "session.h"
+#include "transfer.h"
 #include "driver.h"
 #include "sync.h"
 
@@ -100,7 +101,7 @@ static void sync_getphonebook_callback(struct obc_session *session,
 		goto send;
 	}
 
-	perr = obc_session_get_contents(session, &contents, &size);
+	perr = obc_transfer_get_contents(transfer, &contents, &size);
 	if (perr < 0) {
 		reply = g_dbus_create_error(sync->msg,
 						"org.openobex.Error.Failed",
-- 
1.7.7.6

