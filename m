Return-Path: <brian.gix@intel.com>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <brian.gix@intel.com>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Subject: [PATCH 1/5] mesh: Add BT SIG reserved numbers for Mesh
Date: Mon, 14 Aug 2017 12:01:15 -0700
Message-Id: <20170814190119.8684-2-brian.gix@intel.com>
In-Reply-To: <20170814190119.8684-1-brian.gix@intel.com>
References: <20170814190119.8684-1-brian.gix@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/uuid.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 2dcfe9e..2c57a33 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -139,6 +139,16 @@ extern "C" {
 #define GATT_EXTERNAL_REPORT_REFERENCE			0x2907
 #define GATT_REPORT_REFERENCE				0x2908
 
+/* GATT Mesh Services */
+#define MESH_PROV_SVC_UUID	"00001827-0000-1000-8000-00805f9b34fb"
+#define MESH_PROXY_SVC_UUID	"00001828-0000-1000-8000-00805f9b34fb"
+
+/* GATT Mesh Characteristic Types */
+#define MESH_PROVISIONING_DATA_IN			0x2ADB
+#define MESH_PROVISIONING_DATA_OUT			0x2ADC
+#define MESH_PROXY_DATA_IN				0x2ADD
+#define MESH_PROXY_DATA_OUT				0x2ADE
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
-- 
2.9.5
