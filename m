Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 4/6] client: Use new session callback style in modules
Date: Thu,  3 May 2012 10:28:28 +0200
Message-Id: <1336033710-2471-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1336033710-2471-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1336033710-2471-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The session API now provides the transfer object in the callback, so
the modules can directly access the transfer object.
---
 client/ftp.c     |    2 +-
 client/manager.c |    2 +-
 client/map.c     |    2 +-
 client/pbap.c    |   10 +++++-----
 client/sync.c    |    2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index 0cb3adc..86c2a3c 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -204,7 +204,7 @@ static void list_folder_callback(struct obc_session *session,
 
 	reply = dbus_message_new_method_return(msg);
 
-	if (obc_session_get_contents(session, &contents, &size) < 0)
+	if (obc_transfer_get_contents(transfer, &contents, &size) < 0)
 		goto done;
 
 	dbus_message_iter_init_append(reply, &iter);
diff --git a/client/manager.c b/client/manager.c
index 820ef37..a46519f 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -468,7 +468,7 @@ static void capabilities_complete_callback(struct obc_session *session,
 		goto done;
 	}
 
-	perr = obc_session_get_contents(session, &contents, &size);
+	perr = obc_transfer_get_contents(transfer, &contents, &size);
 	if (perr < 0) {
 		DBusMessage *error = g_dbus_create_error(data->message,
 						"org.openobex.Error.Failed",
diff --git a/client/map.c b/client/map.c
index 50d02c6..eb06834 100644
--- a/client/map.c
+++ b/client/map.c
@@ -113,7 +113,7 @@ static void buffer_cb(struct obc_session *session,
 		goto done;
 	}
 
-	perr = obc_session_get_contents(session, &contents, &size);
+	perr = obc_transfer_get_contents(transfer, &contents, &size);
 	if (perr < 0) {
 		reply = g_dbus_create_error(map->msg,
 						"org.openobex.Error.Failed",
diff --git a/client/pbap.c b/client/pbap.c
index c43d8dd..b178aff 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -293,7 +293,7 @@ static void pbap_setpath_cb(struct obc_session *session,
 	pending_request_free(request);
 }
 
-static void read_return_apparam(struct obc_session *session,
+static void read_return_apparam(struct obc_transfer *transfer,
 				guint16 *phone_book_size, guint8 *new_missed_calls)
 {
 	const struct apparam_hdr *hdr;
@@ -302,7 +302,7 @@ static void read_return_apparam(struct obc_session *session,
 	*phone_book_size = 0;
 	*new_missed_calls = 0;
 
-	hdr = obc_session_get_params(session, &size);
+	hdr = obc_transfer_get_params(transfer, &size);
 	if (hdr == NULL)
 		return;
 
@@ -357,7 +357,7 @@ static void pull_phonebook_callback(struct obc_session *session,
 		goto send;
 	}
 
-	perr = obc_session_get_contents(session, &contents, &size);
+	perr = obc_transfer_get_contents(transfer, &contents, &size);
 	if (perr < 0) {
 		reply = g_dbus_create_error(request->msg,
 						"org.openobex.Error.Failed",
@@ -397,7 +397,7 @@ static void phonebook_size_callback(struct obc_session *session,
 
 	reply = dbus_message_new_method_return(request->msg);
 
-	read_return_apparam(session, &phone_book_size, &new_missed_calls);
+	read_return_apparam(transfer, &phone_book_size, &new_missed_calls);
 
 	dbus_message_append_args(reply,
 			DBUS_TYPE_UINT16, &phone_book_size,
@@ -427,7 +427,7 @@ static void pull_vcard_listing_callback(struct obc_session *session,
 		goto send;
 	}
 
-	perr = obc_session_get_contents(session, &contents, &size);
+	perr = obc_transfer_get_contents(transfer, &contents, &size);
 	if (perr < 0) {
 		reply = g_dbus_create_error(request->msg,
 						"org.openobex.Error.Failed",
diff --git a/client/sync.c b/client/sync.c
index c549040..c0b3800 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -101,7 +101,7 @@ static void sync_getphonebook_callback(struct obc_session *session,
 		goto send;
 	}
 
-	perr = obc_session_get_contents(session, &contents, &size);
+	perr = obc_transfer_get_contents(transfer, &contents, &size);
 	if (perr < 0) {
 		reply = g_dbus_create_error(sync->msg,
 						"org.openobex.Error.Failed",
-- 
1.7.7.6

