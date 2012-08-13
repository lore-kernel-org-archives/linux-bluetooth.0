Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v4 6/8] dbusoob: Add support for Name in AddRemoteData
Date: Mon, 13 Aug 2012 12:46:38 +0200
Message-ID: <1344854800-20972-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1344854800-20972-1-git-send-email-szymon.janc@tieto.com>
References: <1344854800-20972-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Name received in AddRemoteData is stored for future use when device
object is created.

---
 plugins/dbusoob.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 97de9c0..0e0eeca 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -57,6 +57,7 @@ struct oob_data {
 	uint8_t *hash;
 	uint8_t *randomizer;
 	uint32_t class;
+	char *name;
 };
 
 static GSList *oob_requests = NULL;
@@ -197,6 +198,12 @@ static gboolean parse_data(DBusMessageIter *data, struct oob_data *remote_data)
 
 			dbus_message_iter_get_basic(&value,
 							&remote_data->class);
+		} else if (strcasecmp(key, "Name") == 0) {
+			if (var != DBUS_TYPE_STRING)
+				return FALSE;
+
+			dbus_message_iter_get_basic(&value,
+							&remote_data->name);
 		}
 
 		dbus_message_iter_next(data);
@@ -215,8 +222,10 @@ static gboolean parse_data(DBusMessageIter *data, struct oob_data *remote_data)
 static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
 {
 	bdaddr_t bdaddr;
+	bdaddr_t local;
 
 	str2ba(data->addr, &bdaddr);
+	adapter_get_address(adapter, &local);
 
 	if (data->hash) {
 		uint8_t empty_randomizer[16];
@@ -231,12 +240,11 @@ static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
 			return FALSE;
 	}
 
-	if (data->class) {
-		bdaddr_t local;
-		adapter_get_address(adapter, &local);
-
+	if (data->class)
 		write_remote_class(&local, &bdaddr, data->class);
-	}
+
+	if (data->name)
+		write_device_name(&local, &bdaddr, 0, data->name);
 
 	return TRUE;
 }
-- 
1.7.9.5

