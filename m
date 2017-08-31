Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ 2/3] mesh: Typo fix
Date: Thu, 31 Aug 2017 12:12:56 +0200
Message-Id: <20170831101257.1644-2-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <20170831101257.1644-1-lukasz.rymanowski@codecoup.pl>
References: <20170831101257.1644-1-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mesh/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/main.c b/mesh/main.c
index 2289d7d10..ecf324e15 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -718,7 +718,7 @@ static void update_device_info(GDBusProxy *proxy)
 		dev = find_device_by_uuid(adapter->mesh_devices,
 							prov_data.dev_uuid);
 
-		/* Display provisioning service once per sicovery session */
+		/* Display provisioning service once per discovery session */
 		if (discovering && (!dev || !dev->hide))
 						print_prov_service(&prov_data);
 
-- 
2.11.0

