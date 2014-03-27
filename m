Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 2/5] gatt: Set read and write callbacks based on Flags
Date: Thu, 27 Mar 2014 10:21:12 -0300
Message-Id: <1395926475-8841-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395926475-8841-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395926475-8841-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch checks the characteristic property bitmask before setting
read and write callbacks. This approach avoids additional GDBusProxy
calls and later verifications if the characteristic doesn't support
read or write procedures.
---
 src/gatt-dbus.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 4eaf562..fbcbcfe 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -364,6 +364,8 @@ static int register_external_characteristics(GSList *proxies)
 		bt_uuid_t uuid;
 		struct btd_attribute *attr;
 		GDBusProxy *proxy = list->data;
+		btd_attr_write_t write_cb;
+		btd_attr_read_t read_cb;
 		uint8_t propmask = 0;
 
 		if (!g_dbus_proxy_get_property(proxy, "UUID", &iter))
@@ -384,8 +386,18 @@ static int register_external_characteristics(GSList *proxies)
 		if (!propmask)
 			return -EINVAL;
 
-		attr = btd_gatt_add_char(&uuid, propmask, proxy_read_cb,
-							proxy_write_cb);
+		if (propmask & GATT_CHR_PROP_READ)
+			read_cb = proxy_read_cb;
+		else
+			read_cb = NULL;
+
+		if (propmask & (GATT_CHR_PROP_WRITE |
+					GATT_CHR_PROP_WRITE_WITHOUT_RESP))
+			write_cb = proxy_write_cb;
+		else
+			write_cb = NULL;
+
+		attr = btd_gatt_add_char(&uuid, propmask, read_cb, write_cb);
 		if (!attr)
 			return -EINVAL;
 
-- 
1.8.3.1

