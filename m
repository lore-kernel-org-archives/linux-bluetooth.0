Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Use reference counting of the device object while discovering services
Date: Wed, 10 Nov 2010 19:55:59 -0200
Message-Id: <1289426161-10045-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 1f2c217..955e623 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -158,6 +158,7 @@ static void gatt_service_free(void *user_data)
 	g_slist_free(gatt->primary);
 	g_attrib_unref(gatt->attrib);
 	g_free(gatt->path);
+	btd_device_unref(gatt->dev);
 	g_free(gatt);
 }
 
@@ -1335,7 +1336,7 @@ int attrib_client_register(struct btd_device *device, int psm)
 	device_get_address(device, &dba);
 
 	gatt = g_new0(struct gatt_service, 1);
-	gatt->dev = device;
+	gatt->dev = btd_device_ref(device);
 	gatt->listen = FALSE;
 	gatt->path = g_strdup(path);
 	bacpy(&gatt->sba, &sba);
-- 
1.7.3.2

