Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v8 02/10] core/advertising: use bt_ad
Date: Wed,  1 Apr 2015 14:09:54 -0700
Message-Id: <1427922602-6253-3-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1427922602-6253-1-git-send-email-jamuraa@chromium.org>
References: <1427922602-6253-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Start using the newly introduced struct bt_ad API.
---
 src/advertising.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 04492f7..275e2d7 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -32,6 +32,7 @@
 #include "dbus-common.h"
 #include "error.h"
 #include "log.h"
+#include "src/shared/ad.h"
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
 
@@ -54,6 +55,7 @@ struct advertisement {
 	GDBusProxy *proxy;
 	DBusMessage *reg;
 	uint8_t type; /* Advertising type */
+	struct bt_ad *data;
 };
 
 static bool match_advertisement_path(const void *a, const void *b)
@@ -73,8 +75,9 @@ static void advertisement_free(void *data)
 		g_dbus_client_unref(ad->client);
 	}
 
-	if (ad->proxy)
-		g_dbus_proxy_unref(ad->proxy);
+	bt_ad_unref(ad->data);
+
+	g_dbus_proxy_unref(ad->proxy);
 
 	if (ad->owner)
 		g_free(ad->owner);
@@ -244,6 +247,10 @@ static struct advertisement *advertisement_create(DBusConnection *conn,
 
 	ad->reg = dbus_message_ref(msg);
 
+	ad->data = bt_ad_new();
+	if (!ad->data)
+		goto fail;
+
 	return ad;
 
 fail:
-- 
2.2.0.rc0.207.ga3a616c

