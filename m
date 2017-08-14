Return-Path: <brian.gix@intel.com>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <brian.gix@intel.com>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Subject: [PATCH 5/5] mesh: Add mesh to main bluez build
Date: Mon, 14 Aug 2017 12:01:19 -0700
Message-Id: <20170814190119.8684-6-brian.gix@intel.com>
In-Reply-To: <20170814190119.8684-1-brian.gix@intel.com>
References: <20170814190119.8684-1-brian.gix@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools      | 24 ++++++++++++++++++++++++
 bootstrap-configure |  1 +
 configure.ac        | 18 ++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/Makefile.tools b/Makefile.tools
index 0fd6dec..f646bb7 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -13,6 +13,30 @@ client_bluetoothctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				@GLIB_LIBS@ @DBUS_LIBS@ -lreadline
 endif
 
+if BTMESH
+bin_PROGRAMS += mesh/meshctl
+
+mesh_meshctl_SOURCES = mesh/main.c \
+					mesh/node.h mesh/node.c \
+					mesh/gatt.h mesh/gatt.c \
+					mesh/crypto.h mesh/crypto.c \
+					mesh/keys.h \
+					mesh/net.h mesh/net.c \
+					mesh/prov.h mesh/prov.c \
+					mesh/util.h mesh/util.c \
+					mesh/agent.h mesh/agent.c \
+					mesh/prov-db.h mesh/prov-db.c \
+					mesh/config-model.h mesh/config-client.c \
+					mesh/config-server.c \
+					mesh/onoff-model.h mesh/onoff-model.c \
+					client/display.h client/display.c \
+					monitor/uuid.h monitor/uuid.c
+mesh_meshctl_LDADD = lib/libbluetooth-internal.la gdbus/libgdbus-internal.la \
+					src/libshared-glib.la \
+					@GLIB_LIBS@ @DBUS_LIBS@ -ljson-c -lreadline
+endif
+
+
 if MONITOR
 bin_PROGRAMS += monitor/btmon
 
diff --git a/bootstrap-configure b/bootstrap-configure
index 47926fc..658eef2 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -23,4 +23,5 @@ fi
 		--enable-android \
 		--enable-sixaxis \
 		--enable-midi \
+		--enable-mesh \
 		--disable-datafiles $*
diff --git a/configure.ac b/configure.ac
index 89b164b..bbbc760 100644
--- a/configure.ac
+++ b/configure.ac
@@ -331,6 +331,24 @@ AC_DEFINE_UNQUOTED(CONFIGDIR, "${configdir}",
 			[Directory for the configuration files])
 AC_SUBST(CONFIGDIR, "${configdir}")
 
+AC_ARG_ENABLE(mesh, AC_HELP_STRING([--enable-mesh],
+			[enable BlueZ for Bluetooth Mesh]),
+					[enable_mesh=${enableval}])
+AM_CONDITIONAL(BTMESH, test "${enable_mesh}" = "yes")
+
+if (test "${enable_mesh}" == "yes"); then
+	PKG_CHECK_MODULES(JSONC, json-c, dummy=yes,
+				AC_MSG_ERROR(json-c is required))
+	AC_SUBST(JSON_CFLAGS)
+	AC_SUBST(JSON_LIBS)
+fi
+
+if (test "${enable_mesh}" == "yes"); then
+	AC_CHECK_HEADERS(readline/readline.h, enable_readline=yes,
+                AC_MSG_ERROR(readline header files are required))
+fi
+AM_CONDITIONAL(READLINE, test "${enable_readline}" = "yes")
+
 AC_ARG_ENABLE(android, AC_HELP_STRING([--enable-android],
 			[enable BlueZ for Android]),
 					[enable_android=${enableval}])
-- 
2.9.5
