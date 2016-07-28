Return-Path: <andrey.zheregelya@dsr-company.com>
From: andrey.zheregelya@dsr-company.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Andrey Zheregelya <andrey.zheregelya@dsr-company.com>
Subject: [PATCH][BlueZ] device: LastSeen property for D-Bus interface
Date: Thu, 28 Jul 2016 21:54:08 +0300
Message-Id: <20160728185408.14343-1-andrey.zheregelya@dsr-company.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrey Zheregelya <andrey.zheregelya@dsr-company.com>

It returns le_seen or bredr_seen to caller. Marked as experimental.
Can be used to detect if device is still reachable.
---
 src/device.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/device.c b/src/device.c
index 82704f8..8d572c5 100644
--- a/src/device.c
+++ b/src/device.c
@@ -937,6 +937,17 @@ static gboolean dev_property_get_tx_power(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean dev_property_get_last_seen(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *dev = data;
+	dbus_int64_t val = (dev->bredr_seen > dev->le_seen) ? dev->bredr_seen : dev->le_seen;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_INT64, &val);
+
+	return TRUE;
+}
+
 static gboolean dev_property_exists_tx_power(const GDBusPropertyTable *property,
 								void *data)
 {
@@ -2533,6 +2544,8 @@ static const GDBusPropertyTable device_properties[] = {
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "ServicesResolved", "b", dev_property_get_svc_resolved, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "LastSeen", "x", dev_property_get_last_seen, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 
 	{ }
 };
-- 
2.9.0
