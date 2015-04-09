Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/device: Fix memory leak
Date: Thu,  9 Apr 2015 20:47:56 +0300
Message-Id: <1428601676-22927-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

btd_device_connect_services should not reference the services given as
pending list handling does not unreference them.
---
 src/device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 6e6c9ee..d4360e6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1520,8 +1520,7 @@ int btd_device_connect_services(struct btd_device *dev, GSList *services)
 	for (l = services; l; l = g_slist_next(l)) {
 		struct btd_service *service = l->data;
 
-		dev->pending = g_slist_append(dev->pending,
-						btd_service_ref(service));
+		dev->pending = g_slist_append(dev->pending, service);
 	}
 
 	return connect_next(dev);
-- 
2.1.0

