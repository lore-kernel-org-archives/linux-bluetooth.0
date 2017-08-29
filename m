Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <brian.gix@intel.com>
Subject: [PATCH 1/1] mesh: remove hardcoded keys to force randomization
Date: Tue, 29 Aug 2017 12:51:21 -0700
Message-Id: <20170829195121.9868-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mesh/prov_db.json | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mesh/prov_db.json b/mesh/prov_db.json
index d810a7d..dbed934 100644
--- a/mesh/prov_db.json
+++ b/mesh/prov_db.json
@@ -1,25 +1,22 @@
 {
   "$schema":"file:\/\/\/Bluetooth SIG\/Mesh\/schema\/mesh.jsonschema",
   "meshName":"Intel BT Mesh",
-  "IVindex":5,
+  "IVindex":1,
   "IVupdate":0,
   "netKeys":[
     {
       "index":0,
       "keyRefresh":0,
-      "key":"18eed9c2a56add85049ffc3c59ad0e12"
     }
   ],
   "appKeys":[
     {
       "index":0,
       "boundNetKey":0,
-      "key":"4f68ad85d9f48ac8589df665b6b49b8a"
     },
     {
       "index":1,
       "boundNetKey":0,
-      "key":"2aa2a6ded5a0798ceab5787ca3ae39fc"
     }
   ],
   "provisioners":[
-- 
2.9.5

