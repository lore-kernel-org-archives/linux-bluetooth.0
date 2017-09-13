Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <brian.gix@intel.com>
Subject: [PATCH 1/1] Rename sample JSON Databases
Date: Wed, 13 Sep 2017 11:16:25 -0700
Message-Id: <20170913181625.27309-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mesh/local_node.json | 4 ++--
 mesh/prov_db.json    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mesh/local_node.json b/mesh/local_node.json
index 6591289..5ffa7ad 100644
--- a/mesh/local_node.json
+++ b/mesh/local_node.json
@@ -1,6 +1,6 @@
 {
-  "$schema":"file:\/\/\/Bluetooth SIG\/Mesh\/schema\/mesh.jsonschema",
-  "meshName":"Intel BT Mesh",
+  "$schema":"file:\/\/\/BlueZ\/Mesh\/local_schema\/mesh.jsonschema",
+  "meshName":"BT Mesh",
   "netKeys":[
     {
       "index": 0,
diff --git a/mesh/prov_db.json b/mesh/prov_db.json
index dbed934..e9d038d 100644
--- a/mesh/prov_db.json
+++ b/mesh/prov_db.json
@@ -1,6 +1,6 @@
 {
-  "$schema":"file:\/\/\/Bluetooth SIG\/Mesh\/schema\/mesh.jsonschema",
-  "meshName":"Intel BT Mesh",
+  "$schema":"file:\/\/\/BlueZ\/Mesh\/schema\/mesh.jsonschema",
+  "meshName":"BT Mesh",
   "IVindex":1,
   "IVupdate":0,
   "netKeys":[
-- 
2.9.5

