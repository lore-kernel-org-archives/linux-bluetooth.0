Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 09/15] thermometer: Update driver naming style
Date: Tue, 9 Oct 2012 13:19:52 +0200
Message-ID: <1349781598-22580-10-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1349781598-22580-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1349781598-22580-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes device probe and remove functions name to include
'device' rather than 'driver' name as it better describes what both
do.

Also profile driver name is changed to better describe that it's now
profile driver rather than device driver only.
---
 profiles/thermometer/manager.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/profiles/thermometer/manager.c b/profiles/thermometer/manager.c
index 86e3a0f..6057633 100644
--- a/profiles/thermometer/manager.c
+++ b/profiles/thermometer/manager.c
@@ -41,7 +41,7 @@ static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
 	return g_strcmp0(prim->uuid, uuid);
 }
 
-static int thermometer_driver_probe(struct btd_profile *p,
+static int thermometer_device_probe(struct btd_profile *p,
 					struct btd_device *device,
 					GSList *uuids)
 {
@@ -60,7 +60,7 @@ static int thermometer_driver_probe(struct btd_profile *p,
 	return thermometer_register(device, tattr);
 }
 
-static void thermometer_driver_remove(struct btd_profile *p,
+static void thermometer_device_remove(struct btd_profile *p,
 						struct btd_device *device)
 {
 	thermometer_unregister(device);
@@ -79,10 +79,10 @@ static void thermometer_adapter_remove(struct btd_profile *p,
 }
 
 static struct btd_profile thermometer_profile = {
-	.name		= "thermometer-device-driver",
+	.name		= "Health Thermometer GATT driver",
 	.remote_uuids	= BTD_UUIDS(HEALTH_THERMOMETER_UUID),
-	.device_probe	= thermometer_driver_probe,
-	.device_remove	= thermometer_driver_remove,
+	.device_probe	= thermometer_device_probe,
+	.device_remove	= thermometer_device_remove,
 	.adapter_probe	= thermometer_adapter_probe,
 	.adapter_remove	= thermometer_adapter_remove
 };
-- 
1.7.11.3

