Return-Path: <brian.gix@intel.com>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <brian.gix@intel.com>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Subject: [PATCH 3/5] mesh: Baseline Mesh runtime configuration files
Date: Mon, 14 Aug 2017 12:01:17 -0700
Message-Id: <20170814190119.8684-4-brian.gix@intel.com>
In-Reply-To: <20170814190119.8684-1-brian.gix@intel.com>
References: <20170814190119.8684-1-brian.gix@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mesh/local_node.json | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/prov_db.json    | 37 +++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 mesh/local_node.json
 create mode 100644 mesh/prov_db.json

diff --git a/mesh/local_node.json b/mesh/local_node.json
new file mode 100644
index 0000000..6591289
--- /dev/null
+++ b/mesh/local_node.json
@@ -0,0 +1,61 @@
+{
+  "$schema":"file:\/\/\/Bluetooth SIG\/Mesh\/schema\/mesh.jsonschema",
+  "meshName":"Intel BT Mesh",
+  "netKeys":[
+    {
+      "index": 0,
+      "keyRefresh": 0
+    }
+  ],
+  "appKeys":[
+    {
+      "index": 0,
+      "boundNetKey": 0
+    },
+    {
+      "index": 1,
+      "boundNetKey": 0
+    }
+  ],
+"node": {
+	"IVindex":"00000005",
+	"IVupdate":"0",
+	"sequenceNumber": 0,
+    "composition": {
+        "cid": "0002",
+        "pid": "0010",
+        "vid": "0001",
+        "crpl": "000a",
+        "features": {
+            "relay": false,
+            "proxy": true,
+            "friend": false,
+            "lowPower": false
+        },
+        "elements": [
+            {
+                "elementIndex": 0,
+                "location": "0001",
+                "models": ["0000", "0001", "1001"]
+            }
+        ]
+    },
+    "configuration":{
+        "netKeys": [0],
+        "appKeys": [ 0, 1],
+        "defaultTTL": 10,
+        "elements": [
+          {
+            "elementIndex": 0,
+            "unicastAddress":"0077",
+            "models": [
+               {
+                 "modelId": "1001",
+                 "bind": [1]
+                }
+            ]
+          }
+        ]
+    }
+  }
+}
diff --git a/mesh/prov_db.json b/mesh/prov_db.json
new file mode 100644
index 0000000..d810a7d
--- /dev/null
+++ b/mesh/prov_db.json
@@ -0,0 +1,37 @@
+{
+  "$schema":"file:\/\/\/Bluetooth SIG\/Mesh\/schema\/mesh.jsonschema",
+  "meshName":"Intel BT Mesh",
+  "IVindex":5,
+  "IVupdate":0,
+  "netKeys":[
+    {
+      "index":0,
+      "keyRefresh":0,
+      "key":"18eed9c2a56add85049ffc3c59ad0e12"
+    }
+  ],
+  "appKeys":[
+    {
+      "index":0,
+      "boundNetKey":0,
+      "key":"4f68ad85d9f48ac8589df665b6b49b8a"
+    },
+    {
+      "index":1,
+      "boundNetKey":0,
+      "key":"2aa2a6ded5a0798ceab5787ca3ae39fc"
+    }
+  ],
+  "provisioners":[
+    {
+      "provisionerName":"BT Mesh Provisioner",
+      "unicastAddress":"0077",
+      "allocatedUnicastRange":[
+        {
+          "lowAddress":"0100",
+          "highAddress":"7fff"
+        }
+      ]
+    }
+  ],
+}
-- 
2.9.5
