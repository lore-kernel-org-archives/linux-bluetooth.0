Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: andrey.zheregelya@dsr-company.com
To: linux-bluetooth@vger.kernel.org
Cc: Andrey Zheregelya <andrey.zheregelya@dsr-company.com>
Subject: [PATCH 1/2] device: LastSeen property for D-Bus interface
Date: Tue,  2 Aug 2016 18:40:58 +0300
Message-Id: <20160802154059.24472-1-andrey.zheregelya@dsr-company.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrey Zheregelya <andrey.zheregelya@dsr-company.com>

It returns le_seen or bredr_seen to caller. Marked as experimental.
Can be used to detect if device is still reachable.
---
 src/device.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/device.c b/src/device.c
index 264d599..7fe4d32 100644
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
@@ -2529,6 +2540,8 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "TxPower", "n", dev_property_get_tx_power, NULL,
 					dev_property_exists_tx_power },
 	{ "ServicesResolved", "b", dev_property_get_svc_resolved, NULL, NULL },
+	{ "LastSeen", "x", dev_property_get_last_seen, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 
 	{ }
 };
-- 
2.9.2

