Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/2] proximity: Change Monitor drivers function prefix to monitor_
Date: Wed, 19 Sep 2012 16:27:19 +0200
Message-ID: <1348064839-5602-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348064839-5602-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348064839-5602-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/proximity/manager.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/profiles/proximity/manager.c b/profiles/proximity/manager.c
index df87cb0..f458927 100644
--- a/profiles/proximity/manager.c
+++ b/profiles/proximity/manager.c
@@ -56,7 +56,7 @@ static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
 	return g_strcmp0(prim->uuid, uuid);
 }
 
-static int attio_device_probe(struct btd_device *device, GSList *uuids)
+static int monitor_device_probe(struct btd_device *device, GSList *uuids)
 {
 	struct gatt_primary *linkloss, *txpower, *immediate;
 	GSList *l, *primaries;
@@ -76,7 +76,7 @@ static int attio_device_probe(struct btd_device *device, GSList *uuids)
 	return monitor_register(device, linkloss, txpower, immediate, &enabled);
 }
 
-static void attio_device_remove(struct btd_device *device)
+static void monitor_device_remove(struct btd_device *device)
 {
 	monitor_unregister(device);
 }
@@ -85,8 +85,8 @@ static struct btd_profile pxp_monitor_profile = {
 	.name		= "Proximity Monitor GATT Driver",
 	.remote_uuids	= BTD_UUIDS(IMMEDIATE_ALERT_UUID,
 						LINK_LOSS_UUID, TX_POWER_UUID),
-	.device_probe	= attio_device_probe,
-	.device_remove	= attio_device_remove,
+	.device_probe	= monitor_device_probe,
+	.device_remove	= monitor_device_remove,
 };
 
 static struct btd_profile pxp_reporter_profile = {
-- 
1.7.11.3

