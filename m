Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/8] deviceinfo: Fix not handling accept properly
Date: Mon, 12 Sep 2016 17:07:37 +0300
Message-Id: <1473689259-9523-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1473689259-9523-1-git-send-email-luiz.dentz@gmail.com>
References: <1473689259-9523-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

On accept the profile shall check about existing attribute, etc and once
done call btd_service_connecting_complete updating the service state
properly.
---
 profiles/deviceinfo/deviceinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index 0c48f00..34d9e20 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -136,6 +136,8 @@ static int deviceinfo_driver_accept(struct btd_service *service)
 	gatt_db_foreach_service(db, &deviceinfo_uuid,
 					foreach_deviceinfo_service, device);
 
+	btd_service_connecting_complete(service, 0);
+
 	return 0;
 }
 
-- 
2.7.4

