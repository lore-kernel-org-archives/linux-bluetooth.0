Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix dict_append_array to accept types other than string
Date: Fri, 10 Sep 2010 14:50:03 +0300
Message-Id: <1284119403-9367-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 src/dbus-common.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/src/dbus-common.c b/src/dbus-common.c
index 0484450..5e4813c 100644
--- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -210,8 +210,6 @@ static void append_array_variant(DBusMessageIter *iter, int type, void *val,
 	DBusMessageIter variant, array;
 	char type_sig[2] = { type, '\0' };
 	char array_sig[3] = { DBUS_TYPE_ARRAY, type, '\0' };
-	const char ***str_array = val;
-	int i;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
 						array_sig, &variant);
@@ -219,9 +217,17 @@ static void append_array_variant(DBusMessageIter *iter, int type, void *val,
 	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
 						type_sig, &array);
 
-	for (i = 0; i < n_elements; i++)
-		dbus_message_iter_append_basic(&array, type,
-						&((*str_array)[i]));
+	if (dbus_type_is_fixed(type) == TRUE) {
+		dbus_message_iter_append_fixed_array(&array, type, val,
+							n_elements);
+	} else if (type == DBUS_TYPE_STRING || type == DBUS_TYPE_OBJECT_PATH) {
+		const char ***str_array = (const char ***) val;
+		int i;
+
+		for (i = 0; i < n_elements; i++)
+			dbus_message_iter_append_basic(&array, type,
+							&((*str_array)[i]));
+	}
 
 	dbus_message_iter_close_container(&variant, &array);
 
-- 
1.7.1

