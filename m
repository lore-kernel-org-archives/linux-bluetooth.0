Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 11/11] Makefile for meshd and configure.ac
Date: Wed, 25 Apr 2018 10:50:37 -0700
Message-Id: <20180425175037.20946-12-brian.gix@intel.com>
In-Reply-To: <20180425175037.20946-1-brian.gix@intel.com>
References: <20180425175037.20946-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Inga Stotland <inga.stotland@intel.com>

---
 Makefile.am    |  1 +
 Makefile.meshd | 44 ++++++++++++++++++++++++++++++++++++++++++++
 configure.ac   |  2 +-
 3 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 Makefile.meshd

diff --git a/Makefile.am b/Makefile.am
index daf34b6ca..2a96fa1d3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -225,6 +225,7 @@ unit_tests =
 include Makefile.tools
 include Makefile.obexd
 include android/Makefile.am
+include Makefile.meshd
 
 if HID2HCI
 rulesdir = @UDEV_DIR@/rules.d
diff --git a/Makefile.meshd b/Makefile.meshd
new file mode 100644
index 000000000..4a9d45a12
--- /dev/null
+++ b/Makefile.meshd
@@ -0,0 +1,44 @@
+if MESH
+mesh_json_sources = meshd/mesh-json/mesh-db.h meshd/mesh-json/mesh-db.c
+mesh_common_sources = meshd/common/mesh-defs.h \
+					meshd/common/util.h meshd/common/util.c
+
+meshd_sources = $(mesh_common_sources) $(mesh_json_sources) \
+				meshd/src/mesh.h meshd/src/mesh.c \
+				meshd/src/mesh-io.h meshd/src/mesh-io.c \
+				meshd/src/mesh-io-api.h meshd/src/bt.h \
+				meshd/src/mesh-io-generic.h \
+				meshd/src/mesh-io-generic.c \
+				meshd/src/hci.h meshd/src/hci.c \
+				meshd/src/storage.h meshd/src/storage.c \
+				meshd/src/net.h meshd/src/net.c \
+				meshd/src/display.h meshd/src/display.c \
+				meshd/src/crypto.h meshd/src/crypto.c \
+				meshd/src/friend.h meshd/src/friend.c \
+				meshd/src/appkeys.h meshd/src/appkey.c \
+				meshd/src/node.h meshd/src/node.c \
+				meshd/src/prov.h meshd/src/prov.c \
+				meshd/src/provision.h meshd/src/provision.c \
+				meshd/src/model.h meshd/src/model.c \
+				meshd/src/cfgmod.h meshd/src/cfgmod-server.c
+
+libexec_PROGRAMS += meshd/src/meshd
+
+meshd_src_meshd_SOURCES = $(meshd_sources) \
+						meshd/src/main.c
+
+meshd_src_meshd_LDADD = /usr/lib64/libell.la src/shared/ecc.lo \
+			@DBUS_LIBS@ -lell -ljson-c -ldl
+
+noinst_PROGRAMS += meshd/src/btmesh
+
+meshd_src_btmesh_SOURCES = $(meshd_sources) \
+						meshd/common/agent.h \
+						meshd/common/agent.c \
+						meshd/src/btmesh.c
+
+meshd_src_btmesh_LDADD = /usr/lib64/libell.la src/shared/ecc.lo \
+						src/libshared-mainloop.la \
+						-lreadline -lell -ljson-c -ldl
+
+endif
diff --git a/configure.ac b/configure.ac
index 5132131f2..f6259c0fe 100644
--- a/configure.ac
+++ b/configure.ac
@@ -248,7 +248,7 @@ AC_ARG_ENABLE(btpclient, AC_HELP_STRING([--enable-btpclient],
 		[enable BTP client]), [enable_btpclient=${enableval}])
 AM_CONDITIONAL(BTPCLIENT, test "${enable_btpclient}" = "yes")
 
-if (test "${enable_btpclient}" = "yes"); then
+if (test "${enable_btpclient}" = "yes" || test "${enable_mesh}" == "yes"); then
 	PKG_CHECK_MODULES(ELL, ell >= 0.3, dummy=yes,
 			  AC_MSG_ERROR(ell library >= 0.3 is required))
 	AC_SUBST(ELL_CFLAGS)
-- 
2.14.3

