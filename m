Return-Path: <brian.gix@intel.com>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	inga.stotland@intel.com
Subject: [PATCH BlueZ v7 14/14] Makefile for meshd
Date: Sat, 14 Jul 2018 12:59:03 -0700
Message-Id: <20180714195903.7402-15-brian.gix@intel.com>
In-Reply-To: <20180714195903.7402-1-brian.gix@intel.com>
References: <20180714195903.7402-1-brian.gix@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Inga Stotland <inga.stotland@intel.com>

---
 Makefile.am   |  1 +
 Makefile.mesh | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 Makefile.mesh

diff --git a/Makefile.am b/Makefile.am
index 2c9490f5f..0ccf393c6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -235,6 +235,7 @@ unit_tests =
 include Makefile.tools
 include Makefile.obexd
 include android/Makefile.am
+include Makefile.mesh
 
 if HID2HCI
 rulesdir = @UDEV_DIR@/rules.d
diff --git a/Makefile.mesh b/Makefile.mesh
new file mode 100644
index 000000000..a11c68576
--- /dev/null
+++ b/Makefile.mesh
@@ -0,0 +1,41 @@
+if MESH
+mesh_sources = mesh/mesh.h mesh/mesh.c \
+				mesh/mesh-io.h mesh/mesh-io.c \
+				mesh/mesh-io-api.h mesh/bt.h \
+				mesh/mesh-io-generic.h \
+				mesh/mesh-io-generic.c \
+				mesh/storage.h mesh/storage.c \
+				mesh/net.h mesh/net.c \
+				mesh/display.h mesh/display.c \
+				mesh/crypto.h mesh/crypto.c \
+				mesh/friend.h mesh/friend.c \
+				mesh/appkeys.h mesh/appkey.c \
+				mesh/node.h mesh/node.c \
+				mesh/prov.h mesh/prov.c \
+				mesh/provision.h mesh/provision.c \
+				mesh/model.h mesh/model.c \
+				mesh/cfgmod.h mesh/cfgmod-server.c \
+				mesh/mesh-db.h mesh/mesh-db.c \
+				mesh/util.h mesh/util.c \
+				mesh/mesh-defs.h
+libexec_PROGRAMS += mesh/meshd
+
+mesh_meshd_SOURCES = $(mesh_sources) mesh/main.c
+
+mesh_meshd_LDADD = src/shared/ecc.lo src/shared/queue.lo src/shared/io-ell.lo \
+				src/shared/util.lo src/shared/hci.lo \
+				@DBUS_LIBS@ @ELL_LIBS@ -ljson-c
+
+noinst_PROGRAMS += mesh/btmesh
+
+mesh_btmesh_SOURCES = $(mesh_sources) \
+						mesh/agent.h \
+						mesh/agent.c \
+						mesh/btmesh.c
+
+mesh_btmesh_LDADD = src/shared/ecc.lo src/shared/queue.lo src/shared/io-ell.lo \
+				src/shared/util.lo src/shared/hci.lo \
+				src/libshared-mainloop.la \
+				-lreadline @ELL_LIBS@ -ljson-c
+
+endif
-- 
2.14.4
