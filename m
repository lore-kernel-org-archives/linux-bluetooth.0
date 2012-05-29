Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/2] GATT: Move GATT assigned numbers to GATT header
Date: Tue, 29 May 2012 10:58:12 -0300
Message-Id: <1338299892-26278-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1338299892-26278-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1338299892-26278-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.h           |   27 ---------------------------
 attrib/gatt-service.c  |    3 ++-
 attrib/gatt.h          |   28 ++++++++++++++++++++++++++++
 plugins/gatt-example.c |    1 +
 proximity/immalert.c   |    3 ++-
 proximity/linkloss.c   |    3 ++-
 proximity/reporter.c   |    3 ++-
 src/attrib-server.c    |    3 ++-
 time/server.c          |    3 ++-
 9 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 9bf9092..d12a7f2 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -22,29 +22,6 @@
  *
  */
 
-/* GATT Profile Attribute types */
-#define GATT_PRIM_SVC_UUID		0x2800
-#define GATT_SND_SVC_UUID		0x2801
-#define GATT_INCLUDE_UUID		0x2802
-#define GATT_CHARAC_UUID		0x2803
-
-/* GATT Characteristic Types */
-#define GATT_CHARAC_DEVICE_NAME			0x2A00
-#define GATT_CHARAC_APPEARANCE			0x2A01
-#define GATT_CHARAC_PERIPHERAL_PRIV_FLAG	0x2A02
-#define GATT_CHARAC_RECONNECTION_ADDRESS	0x2A03
-#define GATT_CHARAC_PERIPHERAL_PREF_CONN	0x2A04
-#define GATT_CHARAC_SERVICE_CHANGED		0x2A05
-
-/* GATT Characteristic Descriptors */
-#define GATT_CHARAC_EXT_PROPER_UUID	0x2900
-#define GATT_CHARAC_USER_DESC_UUID	0x2901
-#define GATT_CLIENT_CHARAC_CFG_UUID	0x2902
-#define GATT_SERVER_CHARAC_CFG_UUID	0x2903
-#define GATT_CHARAC_FMT_UUID		0x2904
-#define GATT_CHARAC_AGREG_FMT_UUID	0x2905
-#define GATT_CHARAC_VALID_RANGE_UUID	0x2906
-
 /* Attribute Protocol Opcodes */
 #define ATT_OP_ERROR			0x01
 #define ATT_OP_MTU_REQ			0x02
@@ -106,10 +83,6 @@
 #define ATT_CHAR_PROPER_AUTH			0x40
 #define ATT_CHAR_PROPER_EXT_PROPER		0x80
 
-/* Client Characteristic Configuration bit field */
-#define GATT_CLIENT_CHARAC_CFG_NOTIF_BIT	0x0001
-#define GATT_CLIENT_CHARAC_CFG_IND_BIT		0x0002
-
 #define ATT_MAX_MTU				256
 #define ATT_DEFAULT_L2CAP_MTU			48
 #define ATT_DEFAULT_LE_MTU			23
diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index d8f7b37..a9de98c 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -31,9 +31,10 @@
 #include <bluetooth/sdp.h>
 #include <adapter.h>
 
+#include "gattrib.h"
 #include "att.h"
+#include "gatt.h"
 #include "att-database.h"
-#include "gattrib.h"
 #include "attrib-server.h"
 #include "gatt-service.h"
 #include "log.h"
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 1732270..9ffe58f 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -21,8 +21,36 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
  */
+
 #include <bluetooth/sdp.h>
 
+/* GATT Profile Attribute types */
+#define GATT_PRIM_SVC_UUID		0x2800
+#define GATT_SND_SVC_UUID		0x2801
+#define GATT_INCLUDE_UUID		0x2802
+#define GATT_CHARAC_UUID		0x2803
+
+/* GATT Characteristic Types */
+#define GATT_CHARAC_DEVICE_NAME			0x2A00
+#define GATT_CHARAC_APPEARANCE			0x2A01
+#define GATT_CHARAC_PERIPHERAL_PRIV_FLAG	0x2A02
+#define GATT_CHARAC_RECONNECTION_ADDRESS	0x2A03
+#define GATT_CHARAC_PERIPHERAL_PREF_CONN	0x2A04
+#define GATT_CHARAC_SERVICE_CHANGED		0x2A05
+
+/* GATT Characteristic Descriptors */
+#define GATT_CHARAC_EXT_PROPER_UUID	0x2900
+#define GATT_CHARAC_USER_DESC_UUID	0x2901
+#define GATT_CLIENT_CHARAC_CFG_UUID	0x2902
+#define GATT_SERVER_CHARAC_CFG_UUID	0x2903
+#define GATT_CHARAC_FMT_UUID		0x2904
+#define GATT_CHARAC_AGREG_FMT_UUID	0x2905
+#define GATT_CHARAC_VALID_RANGE_UUID	0x2906
+
+/* Client Characteristic Configuration bit field */
+#define GATT_CLIENT_CHARAC_CFG_NOTIF_BIT	0x0001
+#define GATT_CLIENT_CHARAC_CFG_IND_BIT		0x0002
+
 typedef void (*gatt_cb_t) (GSList *l, guint8 status, gpointer user_data);
 
 struct gatt_primary {
diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index 482bc2d..cd2c481 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -37,6 +37,7 @@
 #include "gattrib.h"
 #include "gatt-service.h"
 #include "att.h"
+#include "gatt.h"
 #include "att-database.h"
 #include "attrib-server.h"
 
diff --git a/proximity/immalert.c b/proximity/immalert.c
index 4aa973f..1540b61 100644
--- a/proximity/immalert.c
+++ b/proximity/immalert.c
@@ -32,9 +32,10 @@
 #include <gdbus.h>
 
 #include "log.h"
+#include "gattrib.h"
 #include "att.h"
+#include "gatt.h"
 #include "att-database.h"
-#include "gattrib.h"
 #include "gatt-service.h"
 #include "attrib-server.h"
 #include "device.h"
diff --git a/proximity/linkloss.c b/proximity/linkloss.c
index 239eba9..14403cb 100644
--- a/proximity/linkloss.c
+++ b/proximity/linkloss.c
@@ -32,9 +32,10 @@
 #include <gdbus.h>
 
 #include "log.h"
-#include "att.h"
 #include "att-database.h"
 #include "gattrib.h"
+#include "att.h"
+#include "gatt.h"
 #include "gatt-service.h"
 #include "attrib-server.h"
 #include "device.h"
diff --git a/proximity/reporter.c b/proximity/reporter.c
index b9872ab..20779a8 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -40,9 +40,10 @@
 #include "error.h"
 #include "device.h"
 #include "hcid.h"
+#include "gattrib.h"
 #include "att.h"
+#include "gatt.h"
 #include "att-database.h"
-#include "gattrib.h"
 #include "attrib-server.h"
 #include "reporter.h"
 #include "linkloss.h"
diff --git a/src/attrib-server.c b/src/attrib-server.c
index dd1bba4..a6262d0 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -45,9 +45,10 @@
 #include "adapter.h"
 #include "device.h"
 #include "manager.h"
+#include "gattrib.h"
 #include "att.h"
+#include "gatt.h"
 #include "att-database.h"
-#include "gattrib.h"
 #include "storage.h"
 
 #include "attrib-server.h"
diff --git a/time/server.c b/time/server.c
index 58d0bcc..13a7bbe 100644
--- a/time/server.c
+++ b/time/server.c
@@ -32,9 +32,10 @@
 #include <bluetooth/uuid.h>
 #include <adapter.h>
 
+#include "gattrib.h"
 #include "att.h"
+#include "gatt.h"
 #include "att-database.h"
-#include "gattrib.h"
 #include "attrib-server.h"
 #include "gatt-service.h"
 #include "log.h"
-- 
1.7.8.6

