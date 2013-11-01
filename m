Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] android/daemon: Update CoD and RSSI only when they exist
Date: Fri,  1 Nov 2013 13:46:38 +0200
Message-Id: <1383306399-13750-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This avoid sending zeroed Class of Device and making it unidentified.
...
 prop[0]: type=BT_PROPERTY_CLASS_OF_DEVICE len=4 val=000000
 prop[1]: type=BT_PROPERTY_REMOTE_RSSI len=1 val=-75
 prop[2]: type=BT_PROPERTY_BDNAME len=249 val=Microsoft Bluetooth Number Pad
...
---
 android/adapter.c |   30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 39389ee..314f711 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -454,19 +454,23 @@ static int fill_device_props(struct hal_property *prop, bdaddr_t *addr,
 {
 	uint8_t num_props = 0;
 
-	/* fill cod */
-	prop->type = HAL_PROP_DEVICE_CLASS;
-	prop->len = sizeof(cod);
-	memcpy(prop->val, &cod, prop->len);
-	prop = ((void *) prop) + sizeof(*prop) + sizeof(cod);
-	num_props++;
-
-	/* fill rssi */
-	prop->type = HAL_PROP_DEVICE_RSSI;
-	prop->len = sizeof(rssi);
-	memcpy(prop->val, &rssi, prop->len);
-	prop = ((void *) prop) + sizeof(*prop) + sizeof(rssi);
-	num_props++;
+	/* fill Class of Device */
+	if (cod) {
+		prop->type = HAL_PROP_DEVICE_CLASS;
+		prop->len = sizeof(cod);
+		memcpy(prop->val, &cod, prop->len);
+		prop = ((void *) prop) + sizeof(*prop) + sizeof(cod);
+		num_props++;
+	}
+
+	/* fill RSSI */
+	if (rssi) {
+		prop->type = HAL_PROP_DEVICE_RSSI;
+		prop->len = sizeof(rssi);
+		memcpy(prop->val, &rssi, prop->len);
+		prop = ((void *) prop) + sizeof(*prop) + sizeof(rssi);
+		num_props++;
+	}
 
 	/* fill name */
 	if (name) {
-- 
1.7.10.4

