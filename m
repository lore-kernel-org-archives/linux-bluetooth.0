Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v4 3/8] dbusoob: Change ReadLocalData to match new API
Date: Mon, 13 Aug 2012 12:46:35 +0200
Message-ID: <1344854800-20972-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1344854800-20972-1-git-send-email-szymon.janc@tieto.com>
References: <1344854800-20972-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ReadLocalData now returns dictionary instead of hardcoded pair of
arrays.

---
 plugins/dbusoob.c |   31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index d259159..92c4df1 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -79,20 +79,36 @@ static void read_local_data_complete(struct btd_adapter *adapter, uint8_t *hash,
 {
 	struct DBusMessage *reply;
 	struct oob_request *oob_request;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
 
 	oob_request = find_oob_request(adapter);
 	if (!oob_request)
 		return;
 
-	if (hash && randomizer)
-		reply = g_dbus_create_reply(oob_request->msg,
-			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE, &hash, 16,
-			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE, &randomizer, 16,
-			DBUS_TYPE_INVALID);
-	else
+	if (!hash || !randomizer) {
 		reply = btd_error_failed(oob_request->msg,
 					"Failed to read local OOB data.");
+		goto done;
+	}
+
+	reply = dbus_message_new_method_return(oob_request->msg);
+	if (!reply)
+		goto done;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	dict_append_array(&dict, "Hash", DBUS_TYPE_BYTE, &hash, 16);
+	dict_append_array(&dict, "Randomizer", DBUS_TYPE_BYTE, &randomizer, 16);
+
+	dbus_message_iter_close_container(&iter, &dict);
 
+done:
 	oob_requests = g_slist_remove(oob_requests, oob_request);
 	dbus_message_unref(oob_request->msg);
 	g_free(oob_request);
@@ -182,8 +198,7 @@ static const GDBusMethodTable oob_methods[] = {
 			GDBUS_ARGS({ "address", "s" }), NULL,
 			remove_remote_data) },
 	{ GDBUS_ASYNC_METHOD("ReadLocalData",
-			NULL, GDBUS_ARGS({ "hash", "ay" },
-						{ "randomizer", "ay" }),
+			NULL, GDBUS_ARGS({ "data", "a{sv}" }),
 			read_local_data) },
 	{ }
 };
-- 
1.7.9.5

