Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  2/3] audio/player: Add TotalNumberOfItems DBUS method
Date: Wed, 24 Jun 2015 14:41:31 +0530
Message-id: <1435137092-19300-3-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1435137092-19300-1-git-send-email-bharat.panda@samsung.com>
References: <1435137092-19300-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds support for TotalNumberOfItems DBUS method on
org.bluez.MediaFolder1 interface.
---
 profiles/audio/player.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index b7f7b60..c8e10e1 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -877,6 +877,30 @@ static DBusMessage *media_folder_list_items(DBusConnection *conn,
 	return NULL;
 }
 
+static DBusMessage *media_folder_total_items(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct media_player *mp = data;
+	struct media_folder *folder = mp->scope;
+	struct player_callback *cb = mp->cb;
+	int err;
+
+	if (cb->cbs->list_items == NULL)
+		return btd_error_not_supported(msg);
+
+	if (folder->msg != NULL)
+		return btd_error_failed(msg, strerror(EBUSY));
+
+	err = cb->cbs->total_items(mp, folder->item->name,
+							cb->user_data);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	folder->msg = dbus_message_ref(msg);
+
+	return NULL;
+}
+
 static void media_item_free(struct media_item *item)
 {
 	if (item->metadata != NULL)
@@ -1091,6 +1115,10 @@ static const GDBusMethodTable media_folder_methods[] = {
 			GDBUS_ARGS({ "filter", "a{sv}" }),
 			GDBUS_ARGS({ "items", "a{oa{sv}}" }),
 			media_folder_list_items) },
+	{ GDBUS_ASYNC_METHOD("TotalNumberOfItems",
+			NULL,
+			GDBUS_ARGS({ "totalitems", "u" }),
+			media_folder_total_items) },
 	{ GDBUS_ASYNC_METHOD("ChangeFolder",
 			GDBUS_ARGS({ "folder", "o" }), NULL,
 			media_folder_change_folder) },
-- 
1.9.1

