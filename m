Return-Path: <johan.hedberg@gmail.com>
From: Inga Stotland <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/2] tools: Move meshctl sources under tools/mesh directory
Date: Thu, 21 Jun 2018 23:32:00 -0700
Message-Id: <20180622063200.7394-3-inga.stotland@intel.com>
In-Reply-To: <20180622063200.7394-1-inga.stotland@intel.com>
References: <20180622063200.7394-1-inga.stotland@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This is a temporary location until the unified mesh solution is provided
---
 Makefile.tools                       | 28 ++++++++++++++--------------
 {mesh => tools/mesh}/README          |  0
 {mesh => tools/mesh}/agent.c         |  4 ++--
 {mesh => tools/mesh}/agent.h         |  0
 {mesh => tools/mesh}/config-client.c | 14 +++++++-------
 {mesh => tools/mesh}/config-model.h  |  0
 {mesh => tools/mesh}/config-server.c | 14 +++++++-------
 {mesh => tools/mesh}/crypto.c        |  4 ++--
 {mesh => tools/mesh}/crypto.h        |  0
 {mesh => tools/mesh}/gatt.c          | 10 +++++-----
 {mesh => tools/mesh}/gatt.h          |  0
 {mesh => tools/mesh}/keys.h          |  0
 {mesh => tools/mesh}/local_node.json |  0
 {mesh => tools/mesh}/mesh-net.h      |  0
 {mesh => tools/mesh}/net.c           | 16 ++++++++--------
 {mesh => tools/mesh}/net.h           |  0
 {mesh => tools/mesh}/node.c          | 16 ++++++++--------
 {mesh => tools/mesh}/node.h          |  0
 {mesh => tools/mesh}/onoff-model.c   | 14 +++++++-------
 {mesh => tools/mesh}/onoff-model.h   |  0
 {mesh => tools/mesh}/prov-db.c       | 14 +++++++-------
 {mesh => tools/mesh}/prov-db.h       |  0
 {mesh => tools/mesh}/prov.c          | 16 ++++++++--------
 {mesh => tools/mesh}/prov.h          |  0
 {mesh => tools/mesh}/prov_db.json    |  0
 {mesh => tools/mesh}/util.c          |  6 +++---
 {mesh => tools/mesh}/util.h          |  0
 27 files changed, 78 insertions(+), 78 deletions(-)
 rename {mesh => tools/mesh}/README (100%)
 rename {mesh => tools/mesh}/agent.c (98%)
 rename {mesh => tools/mesh}/agent.h (100%)
 rename {mesh => tools/mesh}/config-client.c (99%)
 rename {mesh => tools/mesh}/config-model.h (100%)
 rename {mesh => tools/mesh}/config-server.c (94%)
 rename {mesh => tools/mesh}/crypto.c (99%)
 rename {mesh => tools/mesh}/crypto.h (100%)
 rename {mesh => tools/mesh}/gatt.c (98%)
 rename {mesh => tools/mesh}/gatt.h (100%)
 rename {mesh => tools/mesh}/keys.h (100%)
 rename {mesh => tools/mesh}/local_node.json (100%)
 rename {mesh => tools/mesh}/mesh-net.h (100%)
 rename {mesh => tools/mesh}/net.c (99%)
 rename {mesh => tools/mesh}/net.h (100%)
 rename {mesh => tools/mesh}/node.c (98%)
 rename {mesh => tools/mesh}/node.h (100%)
 rename {mesh => tools/mesh}/onoff-model.c (96%)
 rename {mesh => tools/mesh}/onoff-model.h (100%)
 rename {mesh => tools/mesh}/prov-db.c (99%)
 rename {mesh => tools/mesh}/prov-db.h (100%)
 rename {mesh => tools/mesh}/prov.c (98%)
 rename {mesh => tools/mesh}/prov.h (100%)
 rename {mesh => tools/mesh}/prov_db.json (100%)
 rename {mesh => tools/mesh}/util.c (98%)
 rename {mesh => tools/mesh}/util.h (100%)

diff --git a/Makefile.tools b/Makefile.tools
index 42c1f2735..f81fd0a4c 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -296,25 +296,25 @@ if MESH
 bin_PROGRAMS += tools/meshctl
 
 tools_meshctl_SOURCES = tools/meshctl.c \
-				mesh/mesh-net.h \
-				mesh/node.h mesh/node.c \
-				mesh/gatt.h mesh/gatt.c \
-				mesh/crypto.h mesh/crypto.c \
-				mesh/keys.h \
-				mesh/net.h mesh/net.c \
-				mesh/prov.h mesh/prov.c \
-				mesh/util.h mesh/util.c \
-				mesh/agent.h mesh/agent.c \
-				mesh/prov-db.h mesh/prov-db.c \
-				mesh/config-model.h mesh/config-client.c \
-				mesh/config-server.c \
-				mesh/onoff-model.h mesh/onoff-model.c
+				tools/mesh/mesh-net.h \
+				tools/mesh/node.h tools/mesh/node.c \
+				tools/mesh/gatt.h tools/mesh/gatt.c \
+				tools/mesh/crypto.h tools/mesh/crypto.c \
+				tools/mesh/keys.h \
+				tools/mesh/net.h tools/mesh/net.c \
+				tools/mesh/prov.h tools/mesh/prov.c \
+				tools/mesh/util.h tools/mesh/util.c \
+				tools/mesh/agent.h tools/mesh/agent.c \
+				tools/mesh/prov-db.h tools/mesh/prov-db.c \
+				tools/mesh/config-model.h tools/mesh/config-client.c \
+				tools/mesh/config-server.c \
+				tools/mesh/onoff-model.h tools/mesh/onoff-model.c
 tools_meshctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				lib/libbluetooth-internal.la \
 				@GLIB_LIBS@ @DBUS_LIBS@ -ljson-c -lreadline
 endif
 
-EXTRA_DIST += mesh/local_node.json mesh/prov_db.json
+EXTRA_DIST += tools/mesh/local_node.json tools/mesh/prov_db.json
 
 if DEPRECATED
 bin_PROGRAMS += tools/hciattach tools/hciconfig tools/hcitool tools/hcidump \
diff --git a/mesh/README b/tools/mesh/README
similarity index 100%
rename from mesh/README
rename to tools/mesh/README
diff --git a/mesh/agent.c b/tools/mesh/agent.c
similarity index 98%
rename from mesh/agent.c
rename to tools/mesh/agent.c
index b8a14f015..08e498541 100644
--- a/mesh/agent.c
+++ b/tools/mesh/agent.c
@@ -35,8 +35,8 @@
 #include <lib/bluetooth.h>
 
 #include "src/shared/shell.h"
-#include "mesh/util.h"
-#include "mesh/agent.h"
+#include "tools/mesh/util.h"
+#include "tools/mesh/agent.h"
 
 struct input_request {
 	oob_type_t type;
diff --git a/mesh/agent.h b/tools/mesh/agent.h
similarity index 100%
rename from mesh/agent.h
rename to tools/mesh/agent.h
diff --git a/mesh/config-client.c b/tools/mesh/config-client.c
similarity index 99%
rename from mesh/config-client.c
rename to tools/mesh/config-client.c
index b6b02ef93..df2643622 100644
--- a/mesh/config-client.c
+++ b/tools/mesh/config-client.c
@@ -39,13 +39,13 @@
 
 #include "src/shared/shell.h"
 #include "src/shared/util.h"
-#include "mesh/mesh-net.h"
-#include "mesh/keys.h"
-#include "mesh/net.h"
-#include "mesh/node.h"
-#include "mesh/prov-db.h"
-#include "mesh/util.h"
-#include "mesh/config-model.h"
+#include "tools/mesh/mesh-net.h"
+#include "tools/mesh/keys.h"
+#include "tools/mesh/net.h"
+#include "tools/mesh/node.h"
+#include "tools/mesh/prov-db.h"
+#include "tools/mesh/util.h"
+#include "tools/mesh/config-model.h"
 
 #define MIN_COMPOSITION_LEN 16
 
diff --git a/mesh/config-model.h b/tools/mesh/config-model.h
similarity index 100%
rename from mesh/config-model.h
rename to tools/mesh/config-model.h
diff --git a/mesh/config-server.c b/tools/mesh/config-server.c
similarity index 94%
rename from mesh/config-server.c
rename to tools/mesh/config-server.c
index 2d6576375..55035bacf 100644
--- a/mesh/config-server.c
+++ b/tools/mesh/config-server.c
@@ -39,13 +39,13 @@
 
 #include "src/shared/util.h"
 #include "src/shared/shell.h"
-#include "mesh/mesh-net.h"
-#include "mesh/keys.h"
-#include "mesh/net.h"
-#include "mesh/node.h"
-#include "mesh/prov-db.h"
-#include "mesh/util.h"
-#include "mesh/config-model.h"
+#include "tools/mesh/mesh-net.h"
+#include "tools/mesh/keys.h"
+#include "tools/mesh/net.h"
+#include "tools/mesh/node.h"
+#include "tools/mesh/prov-db.h"
+#include "tools/mesh/util.h"
+#include "tools/mesh/config-model.h"
 
 static bool server_msg_recvd(uint16_t src, uint8_t *data,
 				uint16_t len, void *user_data)
diff --git a/mesh/crypto.c b/tools/mesh/crypto.c
similarity index 99%
rename from mesh/crypto.c
rename to tools/mesh/crypto.c
index efb9df8ac..9935612cf 100644
--- a/mesh/crypto.c
+++ b/tools/mesh/crypto.c
@@ -43,8 +43,8 @@
 #endif
 
 #include "src/shared/util.h"
-#include "mesh/mesh-net.h"
-#include "mesh/crypto.h"
+#include "tools/mesh/mesh-net.h"
+#include "tools/mesh/crypto.h"
 
 static int alg_new(int fd, const void *keyval, socklen_t keylen,
 		size_t mic_size)
diff --git a/mesh/crypto.h b/tools/mesh/crypto.h
similarity index 100%
rename from mesh/crypto.h
rename to tools/mesh/crypto.h
diff --git a/mesh/gatt.c b/tools/mesh/gatt.c
similarity index 98%
rename from mesh/gatt.c
rename to tools/mesh/gatt.c
index 693577a3a..2c29c09b5 100644
--- a/mesh/gatt.c
+++ b/tools/mesh/gatt.c
@@ -40,11 +40,11 @@
 #include "gdbus/gdbus.h"
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
-#include "mesh/node.h"
-#include "mesh/util.h"
-#include "mesh/gatt.h"
-#include "mesh/prov.h"
-#include "mesh/net.h"
+#include "tools/mesh/node.h"
+#include "tools/mesh/util.h"
+#include "tools/mesh/gatt.h"
+#include "tools/mesh/prov.h"
+#include "tools/mesh/net.h"
 
 #define MESH_PROV_DATA_OUT_UUID_STR	"00002adc-0000-1000-8000-00805f9b34fb"
 #define MESH_PROXY_DATA_OUT_UUID_STR	"00002ade-0000-1000-8000-00805f9b34fb"
diff --git a/mesh/gatt.h b/tools/mesh/gatt.h
similarity index 100%
rename from mesh/gatt.h
rename to tools/mesh/gatt.h
diff --git a/mesh/keys.h b/tools/mesh/keys.h
similarity index 100%
rename from mesh/keys.h
rename to tools/mesh/keys.h
diff --git a/mesh/local_node.json b/tools/mesh/local_node.json
similarity index 100%
rename from mesh/local_node.json
rename to tools/mesh/local_node.json
diff --git a/mesh/mesh-net.h b/tools/mesh/mesh-net.h
similarity index 100%
rename from mesh/mesh-net.h
rename to tools/mesh/mesh-net.h
diff --git a/mesh/net.c b/tools/mesh/net.c
similarity index 99%
rename from mesh/net.c
rename to tools/mesh/net.c
index 20dfcb8a8..d1b3f79dd 100644
--- a/mesh/net.c
+++ b/tools/mesh/net.c
@@ -35,14 +35,14 @@
 #include "src/shared/util.h"
 #include "src/shared/shell.h"
 
-#include "mesh/crypto.h"
-#include "mesh/gatt.h"
-#include "mesh/mesh-net.h"
-#include "mesh/util.h"
-#include "mesh/keys.h"
-#include "mesh/node.h"
-#include "mesh/prov-db.h"
-#include "mesh/net.h"
+#include "tools/mesh/crypto.h"
+#include "tools/mesh/gatt.h"
+#include "tools/mesh/mesh-net.h"
+#include "tools/mesh/util.h"
+#include "tools/mesh/keys.h"
+#include "tools/mesh/node.h"
+#include "tools/mesh/prov-db.h"
+#include "tools/mesh/net.h"
 
 struct address_range
 {
diff --git a/mesh/net.h b/tools/mesh/net.h
similarity index 100%
rename from mesh/net.h
rename to tools/mesh/net.h
diff --git a/mesh/node.c b/tools/mesh/node.c
similarity index 98%
rename from mesh/node.c
rename to tools/mesh/node.c
index 9ff741962..d23315ce4 100644
--- a/mesh/node.c
+++ b/tools/mesh/node.c
@@ -39,14 +39,14 @@
 #include "src/shared/util.h"
 #include "src/shared/shell.h"
 #include "gdbus/gdbus.h"
-#include "mesh/mesh-net.h"
-#include "mesh/config-model.h"
-#include "mesh/node.h"
-#include "mesh/keys.h"
-#include "mesh/gatt.h"
-#include "mesh/net.h"
-#include "mesh/prov-db.h"
-#include "mesh/util.h"
+#include "tools/mesh/mesh-net.h"
+#include "tools/mesh/config-model.h"
+#include "tools/mesh/node.h"
+#include "tools/mesh/keys.h"
+#include "tools/mesh/gatt.h"
+#include "tools/mesh/net.h"
+#include "tools/mesh/prov-db.h"
+#include "tools/mesh/util.h"
 
 struct mesh_model {
 	struct mesh_model_ops cbs;
diff --git a/mesh/node.h b/tools/mesh/node.h
similarity index 100%
rename from mesh/node.h
rename to tools/mesh/node.h
diff --git a/mesh/onoff-model.c b/tools/mesh/onoff-model.c
similarity index 96%
rename from mesh/onoff-model.c
rename to tools/mesh/onoff-model.c
index 49be089aa..b52afe2c8 100644
--- a/mesh/onoff-model.c
+++ b/tools/mesh/onoff-model.c
@@ -40,13 +40,13 @@
 
 #include "src/shared/shell.h"
 #include "src/shared/util.h"
-#include "mesh/mesh-net.h"
-#include "mesh/keys.h"
-#include "mesh/net.h"
-#include "mesh/node.h"
-#include "mesh/prov-db.h"
-#include "mesh/util.h"
-#include "mesh/onoff-model.h"
+#include "tools/mesh/mesh-net.h"
+#include "tools/mesh/keys.h"
+#include "tools/mesh/net.h"
+#include "tools/mesh/node.h"
+#include "tools/mesh/prov-db.h"
+#include "tools/mesh/util.h"
+#include "tools/mesh/onoff-model.h"
 
 static uint8_t trans_id;
 static uint16_t onoff_app_idx = APP_IDX_INVALID;
diff --git a/mesh/onoff-model.h b/tools/mesh/onoff-model.h
similarity index 100%
rename from mesh/onoff-model.h
rename to tools/mesh/onoff-model.h
diff --git a/mesh/prov-db.c b/tools/mesh/prov-db.c
similarity index 99%
rename from mesh/prov-db.c
rename to tools/mesh/prov-db.c
index 019b4e173..05b2547fd 100644
--- a/mesh/prov-db.c
+++ b/tools/mesh/prov-db.c
@@ -42,13 +42,13 @@
 #include "src/shared/util.h"
 #include "src/shared/shell.h"
 
-#include "mesh/mesh-net.h"
-#include "mesh/crypto.h"
-#include "mesh/keys.h"
-#include "mesh/net.h"
-#include "mesh/node.h"
-#include "mesh/util.h"
-#include "mesh/prov-db.h"
+#include "tools/mesh/mesh-net.h"
+#include "tools/mesh/crypto.h"
+#include "tools/mesh/keys.h"
+#include "tools/mesh/net.h"
+#include "tools/mesh/node.h"
+#include "tools/mesh/util.h"
+#include "tools/mesh/prov-db.h"
 
 #define CHECK_KEY_IDX_RANGE(x) (((x) >= 0) && ((x) <= 4095))
 
diff --git a/mesh/prov-db.h b/tools/mesh/prov-db.h
similarity index 100%
rename from mesh/prov-db.h
rename to tools/mesh/prov-db.h
diff --git a/mesh/prov.c b/tools/mesh/prov.c
similarity index 98%
rename from mesh/prov.c
rename to tools/mesh/prov.c
index d1b855552..acbc5a1c8 100644
--- a/mesh/prov.c
+++ b/tools/mesh/prov.c
@@ -41,14 +41,14 @@
 #include "src/shared/shell.h"
 
 #include "gdbus/gdbus.h"
-#include "mesh/node.h"
-#include "mesh/gatt.h"
-#include "mesh/crypto.h"
-#include "mesh/mesh-net.h"
-#include "mesh/util.h"
-#include "mesh/agent.h"
-#include "mesh/prov.h"
-#include "mesh/net.h"
+#include "tools/mesh/node.h"
+#include "tools/mesh/gatt.h"
+#include "tools/mesh/crypto.h"
+#include "tools/mesh/mesh-net.h"
+#include "tools/mesh/util.h"
+#include "tools/mesh/agent.h"
+#include "tools/mesh/prov.h"
+#include "tools/mesh/net.h"
 
 /* Provisioning Security Levels */
 #define MESH_PROV_SEC_HIGH	2
diff --git a/mesh/prov.h b/tools/mesh/prov.h
similarity index 100%
rename from mesh/prov.h
rename to tools/mesh/prov.h
diff --git a/mesh/prov_db.json b/tools/mesh/prov_db.json
similarity index 100%
rename from mesh/prov_db.json
rename to tools/mesh/prov_db.json
diff --git a/mesh/util.c b/tools/mesh/util.c
similarity index 98%
rename from mesh/util.c
rename to tools/mesh/util.c
index d38d87514..47abc0b24 100644
--- a/mesh/util.c
+++ b/tools/mesh/util.c
@@ -33,9 +33,9 @@
 
 #include "src/shared/shell.h"
 #include "src/shared/util.h"
-#include "mesh/mesh-net.h"
-#include "mesh/node.h"
-#include "mesh/util.h"
+#include "tools/mesh/mesh-net.h"
+#include "tools/mesh/node.h"
+#include "tools/mesh/util.h"
 
 void set_menu_prompt(const char *name, const char *id)
 {
diff --git a/mesh/util.h b/tools/mesh/util.h
similarity index 100%
rename from mesh/util.h
rename to tools/mesh/util.h
-- 
2.14.4

