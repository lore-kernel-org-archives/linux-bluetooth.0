Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v2 09/14] advertising-manager: use advertising_data
Date: Tue, 17 Mar 2015 16:49:56 -0700
Message-Id: <1426636201-30057-10-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1426636201-30057-1-git-send-email-jamuraa@chromium.org>
References: <1426636201-30057-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Start using the newly introduced struct advertising_data API.
---
 src/advertising-manager.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/advertising-manager.c b/src/advertising-manager.c
index 0c1a386..72a4f15 100644
--- a/src/advertising-manager.c
+++ b/src/advertising-manager.c
@@ -32,6 +32,7 @@
 #include "dbus-common.h"
 #include "error.h"
 #include "log.h"
+#include "src/shared/advertising-data.h"
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
 
@@ -55,6 +56,7 @@ struct advertisement {
 	DBusMessage *reg;
 	uint8_t type; /* Advertising type */
 	bool published;
+	struct advertising_data *data;
 };
 
 static bool match_advertisement_path(const void *a, const void *b)
@@ -74,8 +76,9 @@ static void advertisement_free(void *data)
 		g_dbus_client_unref(ad->client);
 	}
 
-	if (ad->proxy)
-		g_dbus_proxy_unref(ad->proxy);
+	advertising_data_unref(ad->data);
+
+	g_dbus_proxy_unref(ad->proxy);
 
 	if (ad->owner)
 		g_free(ad->owner);
@@ -224,6 +227,10 @@ static struct advertisement *advertisement_create(DBusConnection *conn,
 
 	ad->reg = dbus_message_ref(msg);
 
+	ad->data = advertising_data_new();
+	if (!ad->data)
+		goto fail;
+
 	return ad;
 
 fail:
-- 
2.2.0.rc0.207.ga3a616c

