Return-Path: <brian.gix@intel.com>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	inga.stotland@intel.com
Subject: [PATCH BlueZ v6 13/14] mesh: Sample device composition in JSON format
Date: Mon,  9 Jul 2018 11:32:10 -0700
Message-Id: <20180709183211.16588-14-brian.gix@intel.com>
In-Reply-To: <20180709183211.16588-1-brian.gix@intel.com>
References: <20180709183211.16588-1-brian.gix@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Inga Stotland <inga.stotland@intel.com>

This is a sample unprovisioned device composition described
in JSON format.
---
 mesh/config/composition.json | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 mesh/config/composition.json

diff --git a/mesh/config/composition.json b/mesh/config/composition.json
new file mode 100644
index 000000000..20c0d0c3a
--- /dev/null
+++ b/mesh/config/composition.json
@@ -0,0 +1,44 @@
+{
+  "$schema":"file:\/\/\/BlueZ\/MeshD\/local_schema\/mesh.jsonschema",
+  "meshName":"BT Mesh sample node",
+  "UUID":"E0ED0F0200000000203C100200000000",
+  "cid":"0002",
+  "pid":"0010",
+  "vid":"0001",
+  "crpl":"000a",
+  "proxy":"unsupported",
+  "friend":"disabled",
+  "lowPower":"disabled",
+  "relay":{
+    "mode":"enabled"
+  },
+  "elements":[
+    {
+      "elementIndex":0,
+      "location":"0001",
+      "models":[
+        {
+          "modelId":"0000"
+        },
+        {
+          "modelId":"1001"
+        }
+      ]
+    }
+  ],
+  "provision": {
+    "privateKey": "729aa0670d72cd6497502ed473502b037e8803b5c60829a5a3caa219505530ba",
+    "algorithms": [ 0 ],
+	"inputOOB": {
+       "size": 8,
+       "actions": [ 2, 3]
+    },
+    "outputOOB": {
+      "size": 8,
+      "actions": [ 3, 4]
+    },
+    "publicType": false,
+    "staticType": false
+  },
+   }
+}
-- 
2.14.4
