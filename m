Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v1 12/16] client: Make D-Bus exposure of transfers optional
Date: Fri, 25 May 2012 12:11:29 +0200
Message-Id: <1337940693-3417-13-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337940693-3417-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337940693-3417-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The session API lets the modules decide if each transfer should be
exposed in D-Bus or not, instead of relying on a internal policy inside
transfer.c that would decide this based on the transfer type.
---
 client/ftp.c      |    6 +++---
 client/map.c      |    6 ++++--
 client/opp.c      |    4 ++--
 client/pbap.c     |    8 +++++---
 client/session.c  |   15 ++++++++-------
 client/session.h  |    2 +-
 client/sync.c     |    4 ++--
 client/transfer.c |    7 -------
 8 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index 9b2c51d..b7b5081 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -237,7 +237,7 @@ static DBusMessage *list_folder(DBusConnection *connection,
 		goto fail;
 
 	if (obc_session_queue(session, transfer, list_folder_callback,
-							message, &err)) {
+							message, FALSE, &err)) {
 		dbus_message_ref(message);
 		return NULL;
 	}
@@ -271,7 +271,7 @@ static DBusMessage *get_file(DBusConnection *connection,
 		goto fail;
 
 	if (obc_session_queue(session, transfer, get_file_callback, message,
-								&err)) {
+								TRUE, &err)) {
 		dbus_message_ref(message);
 		return NULL;
 	}
@@ -306,7 +306,7 @@ static DBusMessage *put_file(DBusConnection *connection,
 	if (transfer == NULL)
 		goto fail;
 
-	if (obc_session_queue(session, transfer, NULL, NULL, &err))
+	if (obc_session_queue(session, transfer, NULL, NULL, TRUE, &err))
 		return dbus_message_new_method_return(message);
 
 fail:
diff --git a/client/map.c b/client/map.c
index 52b7c68..add302a 100644
--- a/client/map.c
+++ b/client/map.c
@@ -143,7 +143,8 @@ static DBusMessage *map_get_folder_listing(DBusConnection *connection,
 	if (transfer == NULL)
 		goto fail;
 
-	if (obc_session_queue(map->session, transfer, buffer_cb, map, &err)) {
+	if (obc_session_queue(map->session, transfer, buffer_cb, map, FALSE,
+									&err)) {
 		map->msg = dbus_message_ref(message);
 		return NULL;
 	}
@@ -177,7 +178,8 @@ static DBusMessage *map_get_message_listing(DBusConnection *connection,
 	if (transfer == NULL)
 		goto fail;
 
-	if (obc_session_queue(map->session, transfer, buffer_cb, map, &err)) {
+	if (obc_session_queue(map->session, transfer, buffer_cb, map, FALSE,
+									&err)) {
 		map->msg = dbus_message_ref(message);
 		return NULL;
 	}
diff --git a/client/opp.c b/client/opp.c
index 67b01a9..f6ba398 100644
--- a/client/opp.c
+++ b/client/opp.c
@@ -88,7 +88,7 @@ static DBusMessage *opp_send_file(DBusConnection *connection,
 		goto fail;
 
 	if (!obc_session_queue(opp->session, transfer, send_file_callback,
-								message, &err))
+							message, TRUE, &err))
 		goto fail;
 
 	dbus_message_ref(message);
@@ -144,7 +144,7 @@ static DBusMessage *opp_pull_business_card(DBusConnection *connection,
 		goto fail;
 
 	if (!obc_session_queue(opp->session, pull, pull_complete_callback,
-								message, &err))
+							message, TRUE, &err))
 		goto fail;
 
 	dbus_message_ref(message);
diff --git a/client/pbap.c b/client/pbap.c
index 3a771ab..1945fad 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -500,7 +500,8 @@ static DBusMessage *pull_phonebook(struct pbap_data *pbap,
 
 	obc_transfer_set_params(transfer, &apparam, sizeof(apparam));
 
-	if (obc_session_queue(pbap->session, transfer, func, request, &err))
+	if (obc_session_queue(pbap->session, transfer, func, request,
+								FALSE, &err))
 		return NULL;
 
 	pending_request_free(request);
@@ -567,7 +568,8 @@ static DBusMessage *pull_vcard_listing(struct pbap_data *pbap,
 	obc_transfer_set_params(transfer, apparam, apparam_size);
 
 	if (obc_session_queue(pbap->session, transfer,
-				pull_vcard_listing_callback, request, &err))
+					pull_vcard_listing_callback, request,
+					FALSE, &err))
 		return NULL;
 
 	pending_request_free(request);
@@ -796,7 +798,7 @@ static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
 	obc_transfer_set_params(transfer, &apparam, sizeof(apparam));
 
 	if (obc_session_queue(pbap->session, transfer, pull_phonebook_callback,
-								request, &err))
+							request, FALSE, &err))
 		return NULL;
 
 	pending_request_free(request);
diff --git a/client/session.c b/client/session.c
index 9670968..bb20a61 100644
--- a/client/session.c
+++ b/client/session.c
@@ -604,7 +604,7 @@ static DBusMessage *get_capabilities(DBusConnection *connection,
 		goto fail;
 
 	if (!obc_session_queue(session, pull, capabilities_complete_callback,
-								message, &gerr))
+							message, FALSE, &gerr))
 		goto fail;
 
 	dbus_message_ref(message);
@@ -644,7 +644,7 @@ static gboolean session_queue_complete(gpointer data)
 guint obc_session_queue(struct obc_session *session,
 				struct obc_transfer *transfer,
 				session_callback_t func, void *user_data,
-				GError **err)
+				gboolean dbus_register, GError **err)
 {
 	struct pending_request *p;
 
@@ -655,11 +655,12 @@ guint obc_session_queue(struct obc_session *session,
 		return 0;
 	}
 
-	if (!obc_transfer_register(transfer, session->conn, session->owner,
-									err)) {
-		obc_transfer_unregister(transfer);
-		return 0;
-	}
+	if (dbus_register)
+		if (!obc_transfer_register(transfer, session->conn,
+							session->owner, err)) {
+			obc_transfer_unregister(transfer);
+			return 0;
+		}
 
 	obc_transfer_set_callback(transfer, transfer_complete, session);
 
diff --git a/client/session.h b/client/session.h
index 7f37d29..1f77d56 100644
--- a/client/session.h
+++ b/client/session.h
@@ -56,7 +56,7 @@ const char *obc_session_register(struct obc_session *session,
 guint obc_session_queue(struct obc_session *session,
 				struct obc_transfer *transfer,
 				session_callback_t func, void *user_data,
-				GError **err);
+				gboolean dbus_register, GError **err);
 guint obc_session_setpath(struct obc_session *session, const char *path,
 				session_callback_t func, void *user_data,
 				GError **err);
diff --git a/client/sync.c b/client/sync.c
index d56e066..032f400 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -146,7 +146,7 @@ static DBusMessage *sync_getphonebook(DBusConnection *connection,
 
 	if (obc_session_queue(sync->session, transfer,
 						sync_getphonebook_callback,
-						sync, &err)) {
+						sync, TRUE, &err)) {
 		sync->msg = dbus_message_ref(message);
 		return NULL;
 	}
@@ -182,7 +182,7 @@ static DBusMessage *sync_putphonebook(DBusConnection *connection,
 	if (transfer == NULL)
 		goto fail;
 
-	if (obc_session_queue(sync->session, transfer, NULL, NULL, &err))
+	if (obc_session_queue(sync->session, transfer, NULL, NULL, TRUE, &err))
 		return dbus_message_new_method_return(message);
 
 fail:
diff --git a/client/transfer.c b/client/transfer.c
index 4599995..025109a 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -253,12 +253,6 @@ gboolean obc_transfer_register(struct obc_transfer *transfer,
 						const char *owner,
 						GError **err)
 {
-	/* for OBEX specific mime types we don't need to register a transfer */
-	if (transfer->type != NULL &&
-			(strncmp(transfer->type, "x-obex/", 7) == 0 ||
-			strncmp(transfer->type, "x-bt/", 5) == 0))
-		goto done;
-
 	transfer->owner = g_strdup(owner);
 
 	transfer->path = g_strdup_printf("%s/transfer%ju",
@@ -280,7 +274,6 @@ gboolean obc_transfer_register(struct obc_transfer *transfer,
 		return FALSE;
 	}
 
-done:
 	DBG("%p registered %s", transfer, transfer->path);
 
 	return TRUE;
-- 
1.7.7.6

