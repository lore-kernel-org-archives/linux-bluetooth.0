Return-Path: <cyrus@holtmann.org>
From: Tommi Keisala <ext-tommi.keisala@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Tommi Keisala <ext-tommi.keisala@nokia.com>
Subject: [PATCH] This patch avoids a crash when org.bluez.Manager GetProperties request is received and there is not yet any adapters ready. Happens often for example when bluetoothd and ofonod is started next ot each other.
Date: Sat, 23 Oct 2010 08:33:18 +0300
Message-Id: <1287811998-20490-2-git-send-email-ext-tommi.keisala@nokia.com>
In-Reply-To: <20101022131207.GA29655 () jh-x301>
References: <20101022131207.GA29655 () jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/manager.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index aff069c..dd9560f 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -197,13 +197,14 @@ static DBusMessage *get_properties(DBusConnection *conn,
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
 	array = g_new0(char *, g_slist_length(adapters) + 1);
-	for (i = 0, list = adapters; list; list = list->next, i++) {
+	for (i = 0, list = adapters; list; list = list->next) {
 		struct btd_adapter *adapter = list->data;
 
 		if (!adapter_is_ready(adapter))
 			continue;
 
 		array[i] = (char *) adapter_get_path(adapter);
+		i++;
 	}
 	dict_append_array(&dict, "Adapters", DBUS_TYPE_OBJECT_PATH, &array, i);
 	g_free(array);
-- 
1.7.0.4

