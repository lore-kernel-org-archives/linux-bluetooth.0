Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 3/5] gatt: Make Characteristic Flags optional
Date: Thu, 27 Mar 2014 10:21:13 -0300
Message-Id: <1395926475-8841-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395926475-8841-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395926475-8841-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

"Flags" is an optional property. Default value is allow read and
write procedures. If it is not informed the upper-layer should
manage security requirements returning errors using "-errno"
format in the operation result callback.
---
 src/gatt-dbus.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index fbcbcfe..881e214 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -368,6 +368,7 @@ static int register_external_characteristics(GSList *proxies)
 		btd_attr_read_t read_cb;
 		uint8_t propmask = 0;
 
+		/* Mandatory property */
 		if (!g_dbus_proxy_get_property(proxy, "UUID", &iter))
 			return -EINVAL;
 
@@ -379,10 +380,17 @@ static int register_external_characteristics(GSList *proxies)
 		if (bt_string_to_uuid(&uuid, str) < 0)
 			return -EINVAL;
 
-		if (!g_dbus_proxy_get_property(proxy, "Flags", &iter))
-			return -EINVAL;
-
-		propmask = flags_get_bitmask(&iter);
+		/*
+		 * Optional property. If is not informed, read and write
+		 * procedures will be allowed. Upper-layer should handle
+		 * characteristic requirements.
+		 */
+		if (g_dbus_proxy_get_property(proxy, "Flags", &iter))
+			propmask = flags_get_bitmask(&iter);
+		else
+			propmask = GATT_CHR_PROP_WRITE_WITHOUT_RESP
+						| GATT_CHR_PROP_WRITE
+						| GATT_CHR_PROP_READ;
 		if (!propmask)
 			return -EINVAL;
 
-- 
1.8.3.1

