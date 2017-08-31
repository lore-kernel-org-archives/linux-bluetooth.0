Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ 3/3] mesh: Use security low as default
Date: Thu, 31 Aug 2017 12:12:57 +0200
Message-Id: <20170831101257.1644-3-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <20170831101257.1644-1-lukasz.rymanowski@codecoup.pl>
References: <20170831101257.1644-1-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mesh/prov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/prov.c b/mesh/prov.c
index 32785dda1..964259cd0 100644
--- a/mesh/prov.c
+++ b/mesh/prov.c
@@ -57,7 +57,7 @@
 #define MESH_PROV_SEC_LOW	0
 
 /* For Deployment, Security levels below HIGH are *not* recomended */
-#define mesh_gatt_prov_security()	MESH_PROV_SEC_MED
+#define mesh_gatt_prov_security()	MESH_PROV_SEC_LOW
 
 #define PROV_INVITE	0x00
 #define PROV_CAPS	0x01
-- 
2.11.0

