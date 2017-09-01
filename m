Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <brian.gix@intel.com>
Subject: [PATCH 1/1] mesh: Enforce HIGH security when provisioning
Date: Fri,  1 Sep 2017 08:35:46 -0700
Message-Id: <20170901153546.17111-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mesh/prov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/prov.c b/mesh/prov.c
index 32785dd..f78a876 100644
--- a/mesh/prov.c
+++ b/mesh/prov.c
@@ -57,7 +57,7 @@
 #define MESH_PROV_SEC_LOW	0
 
 /* For Deployment, Security levels below HIGH are *not* recomended */
-#define mesh_gatt_prov_security()	MESH_PROV_SEC_MED
+#define mesh_gatt_prov_security()	MESH_PROV_SEC_HIGH
 
 #define PROV_INVITE	0x00
 #define PROV_CAPS	0x01
-- 
2.9.5

