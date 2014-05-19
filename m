Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC 06/11] core: Make connection properties exist only when connected
Date: Tue, 20 May 2014 01:44:38 +0200
Message-Id: <1400543083-28811-7-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1400543083-28811-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400543083-28811-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds common 'exists' function for Connection* properties
on org.bluez.Device1 interface. It will make properties to exist only
when device is connected since they do not make sense otherwise.
---
 src/device.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 8661386..1891735 100644
--- a/src/device.c
+++ b/src/device.c
@@ -864,6 +864,15 @@ static gboolean dev_property_get_conn_max_txpower(
 	return TRUE;
 }
 
+static gboolean dev_property_exists_conn(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct btd_device *device = data;
+
+	/* TODO: only exists when monitoring is enabled? */
+	return btd_device_is_connected(device) ? TRUE : FALSE;
+}
+
 static void set_trust(GDBusPendingPropertySet id, gboolean value, void *data)
 {
 	struct btd_device *device = data;
@@ -1957,9 +1966,12 @@ static const GDBusPropertyTable device_properties[] = {
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

