Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] core/device: call btd_service_disconnect when discconected from peripheral
Date: Fri,  4 Dec 2015 11:36:42 +0000
Message-Id: <1449229003-7193-2-git-send-email-eu@felipetonello.com>
In-Reply-To: <1449229003-7193-1-git-send-email-eu@felipetonello.com>
References: <1449229003-7193-1-git-send-email-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This call was missing, so services were never changing its state properly and
never called profiles disconnect callback function as well.
---
 src/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/device.c b/src/device.c
index 9021914..d4fe861 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4479,6 +4479,7 @@ static void att_disconnected_cb(int err, void *user_data)
 	DBG("%s (%d)", strerror(err), err);
 
 	g_slist_foreach(device->attios, attio_disconnected, NULL);
+	g_slist_foreach(device->services, dev_disconn_service, NULL);
 
 	btd_gatt_client_disconnected(device->client_dbus);
 
-- 
2.5.0

