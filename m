Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] health: Fix HealthDevice dbus registration
Date: Fri,  7 Feb 2014 19:27:58 -0300
Message-Id: <1391812080-19529-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For some reason, HealthDevice property table wasn't been registered.
---
 profiles/health/hdp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 622d95b..48dad52 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -2145,7 +2145,8 @@ static struct hdp_device *create_health_device(struct btd_device *device)
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					path, HEALTH_DEVICE,
 					health_device_methods,
-					health_device_signals, NULL,
+					health_device_signals,
+					health_device_properties,
 					dev, health_device_destroy)) {
 		error("D-Bus failed to register %s interface", HEALTH_DEVICE);
 		goto fail;
-- 
1.8.5.3

