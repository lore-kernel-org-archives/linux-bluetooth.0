Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <marcel@holtmann.org>, Andrzej Kaczmarek
	<andrzej.kaczmarek@tieto.com>
Subject: [PATCH 5/9] core: Make connection properties exist only when connected
Date: Tue, 27 May 2014 09:52:47 +0200
Message-ID: <1401177171-19994-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401177171-19994-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401177171-19994-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds common 'exists' function for Connection* properties
on org.bluez.Device1 interface. It will make properties to exist only
when device is connected since they do not make sense otherwise.
---
 src/device.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 8661386..a66f397 100644
--- a/src/device.c
+++ b/src/device.c
@@ -864,6 +864,22 @@ static gboolean dev_property_get_conn_max_txpower(
 	return TRUE;
 }
 
+static gboolean dev_property_exists_conn(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct btd_device *device = data;
+
+	/* Properties do not exist on disconnected device */
+	if (!btd_device_is_connected(device))
+		return FALSE;
+
+	/* Properties do not exist if no one requested monitoring */
+	if (!queue_length(device->monitor_list))
+		return FALSE;
+
+	return TRUE;
+}
+
 static void set_trust(GDBusPendingPropertySet id, gboolean value, void *data)
 {
 	struct btd_device *device = data;
@@ -1957,9 +1973,12 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "Modalias", "s", dev_property_get_modalias, NULL,
 						dev_property_exists_modalias },
 	{ "Adapter", "o", dev_property_get_adapter },
-	{ "ConnectionRSSI", "n", dev_property_get_conn_rssi },
-	{ "ConnectionTXPower", "n", dev_property_get_conn_txpower },
-	{ "ConnectionTXPowerMax", "n", dev_property_get_conn_max_txpower },
+	{ "ConnectionRSSI", "n", dev_property_get_conn_rssi, NULL,
+						dev_property_exists_conn },
+	{ "ConnectionTXPower", "n", dev_property_get_conn_txpower, NULL,
+						dev_property_exists_conn },
+	{ "ConnectionTXPowerMax", "n", dev_property_get_conn_max_txpower, NULL,
+						dev_property_exists_conn },
 	{ }
 };
 
-- 
1.9.3
