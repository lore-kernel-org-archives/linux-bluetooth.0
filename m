Return-Path: <johan.hedberg@gmail.com>
From: Inga Stotland <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/2] tools: Move meshctl tool under tools directory
Date: Thu, 21 Jun 2018 23:31:59 -0700
Message-Id: <20180622063200.7394-2-inga.stotland@intel.com>
In-Reply-To: <20180622063200.7394-1-inga.stotland@intel.com>
References: <20180622063200.7394-1-inga.stotland@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools                 | 48 +++++++++++++++++++++---------------------
 mesh/main.c => tools/meshctl.c |  0
 2 files changed, 24 insertions(+), 24 deletions(-)
 rename mesh/main.c => tools/meshctl.c (100%)

diff --git a/Makefile.tools b/Makefile.tools
index 9647fb027..42c1f2735 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -12,30 +12,6 @@ client_bluetoothctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				@GLIB_LIBS@ @DBUS_LIBS@ -lreadline
 endif
 
-if MESH
-bin_PROGRAMS += mesh/meshctl
-
-mesh_meshctl_SOURCES = mesh/main.c \
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
-mesh_meshctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
-				lib/libbluetooth-internal.la \
-				@GLIB_LIBS@ @DBUS_LIBS@ -ljson-c -lreadline
-endif
-
-EXTRA_DIST += mesh/local_node.json mesh/prov_db.json
-
 if MONITOR
 bin_PROGRAMS += monitor/btmon
 
@@ -316,6 +292,30 @@ dist_man_MANS += tools/rctest.1 tools/l2ping.1 tools/bccmd.1 tools/btattach.1
 
 EXTRA_DIST += tools/bdaddr.1
 
+if MESH
+bin_PROGRAMS += tools/meshctl
+
+tools_meshctl_SOURCES = tools/meshctl.c \
+				mesh/mesh-net.h \
+				mesh/node.h mesh/node.c \
+				mesh/gatt.h mesh/gatt.c \
+				mesh/crypto.h mesh/crypto.c \
+				mesh/keys.h \
+				mesh/net.h mesh/net.c \
+				mesh/prov.h mesh/prov.c \
+				mesh/util.h mesh/util.c \
+				mesh/agent.h mesh/agent.c \
+				mesh/prov-db.h mesh/prov-db.c \
+				mesh/config-model.h mesh/config-client.c \
+				mesh/config-server.c \
+				mesh/onoff-model.h mesh/onoff-model.c
+tools_meshctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
+				lib/libbluetooth-internal.la \
+				@GLIB_LIBS@ @DBUS_LIBS@ -ljson-c -lreadline
+endif
+
+EXTRA_DIST += mesh/local_node.json mesh/prov_db.json
+
 if DEPRECATED
 bin_PROGRAMS += tools/hciattach tools/hciconfig tools/hcitool tools/hcidump \
 			tools/rfcomm tools/sdptool tools/ciptool
diff --git a/mesh/main.c b/tools/meshctl.c
similarity index 100%
rename from mesh/main.c
rename to tools/meshctl.c
-- 
2.14.4

