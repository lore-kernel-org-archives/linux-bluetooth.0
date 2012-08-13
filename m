Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v4 5/8] dbusoob: Add support for Class in AddRemoteData
Date: Mon, 13 Aug 2012 12:46:37 +0200
Message-ID: <1344854800-20972-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1344854800-20972-1-git-send-email-szymon.janc@tieto.com>
References: <1344854800-20972-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Class received in AddRemoteData is stored for future use when device
object is created.

---
 plugins/dbusoob.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 2ae80fa..97de9c0 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -43,6 +43,7 @@
 #include "event.h"
 #include "error.h"
 #include "oob.h"
+#include "storage.h"
 
 #define OOB_INTERFACE	"org.bluez.OutOfBand"
 
@@ -55,6 +56,7 @@ struct oob_data {
 	char *addr;
 	uint8_t *hash;
 	uint8_t *randomizer;
+	uint32_t class;
 };
 
 static GSList *oob_requests = NULL;
@@ -189,6 +191,12 @@ static gboolean parse_data(DBusMessageIter *data, struct oob_data *remote_data)
 
 			if (size != 16)
 				return FALSE;
+		} else if (strcasecmp(key, "Class") == 0) {
+			if (var != DBUS_TYPE_UINT32)
+				return FALSE;
+
+			dbus_message_iter_get_basic(&value,
+							&remote_data->class);
 		}
 
 		dbus_message_iter_next(data);
@@ -223,6 +231,13 @@ static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
 			return FALSE;
 	}
 
+	if (data->class) {
+		bdaddr_t local;
+		adapter_get_address(adapter, &local);
+
+		write_remote_class(&local, &bdaddr, data->class);
+	}
+
 	return TRUE;
 }
 
-- 
1.7.9.5

