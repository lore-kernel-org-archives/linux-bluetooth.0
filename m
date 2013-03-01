Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] core: Rename hcid.h to main.h
Date: Fri,  1 Mar 2013 14:26:13 +0200
Message-Id: <1362140773-13672-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1362140773-13672-1-git-send-email-luiz.dentz@gmail.com>
References: <1362140773-13672-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

main seems more logical than hcid which use to be the binary name of
bluetoothd really long time ago.
---
 Makefile.am                   | 2 +-
 plugins/gatt-example.c        | 2 +-
 plugins/neard.c               | 2 +-
 profiles/proximity/main.c     | 2 +-
 profiles/proximity/reporter.c | 2 +-
 src/adapter.c                 | 2 +-
 src/attrib-server.c           | 2 +-
 src/device.c                  | 2 +-
 src/main.c                    | 2 +-
 src/{hcid.h => main.h}        | 0
 src/plugin.c                  | 2 +-
 src/profile.c                 | 2 +-
 src/rfkill.c                  | 2 +-
 src/sdpd-server.c             | 2 +-
 src/sdpd-service.c            | 2 +-
 15 files changed, 14 insertions(+), 14 deletions(-)
 rename src/{hcid.h => main.h} (100%)

diff --git a/Makefile.am b/Makefile.am
index f75b8d6..74d11de 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -127,7 +127,7 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/bluetooth.ver \
 			src/main.c src/log.h src/log.c \
 			src/systemd.h src/systemd.c \
-			src/rfkill.c src/hcid.h src/sdpd.h \
+			src/rfkill.c src/main.h src/sdpd.h \
 			src/sdpd-server.c src/sdpd-request.c \
 			src/sdpd-service.c src/sdpd-database.c \
 			src/attrib-server.h src/attrib-server.c \
diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index bd0fbff..fd8fcab 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -32,7 +32,7 @@
 
 #include "lib/uuid.h"
 #include "plugin.h"
-#include "hcid.h"
+#include "main.h"
 #include "log.h"
 #include "attrib/gattrib.h"
 #include "attrib/gatt-service.h"
diff --git a/plugins/neard.c b/plugins/neard.c
index c60c076..7752ba3 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -39,7 +39,7 @@
 #include "device.h"
 #include "eir.h"
 #include "agent.h"
-#include "hcid.h"
+#include "main.h"
 
 #define NEARD_NAME "org.neard"
 #define NEARD_PATH "/"
diff --git a/profiles/proximity/main.c b/profiles/proximity/main.c
index 46468d2..ca3b11e 100644
--- a/profiles/proximity/main.c
+++ b/profiles/proximity/main.c
@@ -34,7 +34,7 @@
 #include "log.h"
 #include "plugin.h"
 #include "manager.h"
-#include "hcid.h"
+#include "main.h"
 
 static GKeyFile *config = NULL;
 
diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index 31c33ef..72e816b 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -42,7 +42,7 @@
 #include "error.h"
 #include "device.h"
 #include "profile.h"
-#include "hcid.h"
+#include "main.h"
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
 #include "attrib/gatt.h"
diff --git a/src/adapter.c b/src/adapter.c
index e553626..e45c467 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -52,7 +52,7 @@
 #include "lib/mgmt.h"
 #include "src/shared/mgmt.h"
 
-#include "hcid.h"
+#include "main.h"
 #include "sdpd.h"
 #include "adapter.h"
 #include "device.h"
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 99656e3..ca9e2ff 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -43,7 +43,7 @@
 #include "log.h"
 #include <btio/btio.h>
 #include "sdpd.h"
-#include "hcid.h"
+#include "main.h"
 #include "adapter.h"
 #include "device.h"
 #include "attrib/gattrib.h"
diff --git a/src/device.c b/src/device.c
index 4320234..9a8dbbe 100644
--- a/src/device.c
+++ b/src/device.c
@@ -50,7 +50,7 @@
 #include "lib/uuid.h"
 #include "lib/mgmt.h"
 #include "attrib/att.h"
-#include "hcid.h"
+#include "main.h"
 #include "adapter.h"
 #include "attrib/gattrib.h"
 #include "attio.h"
diff --git a/src/main.c b/src/main.c
index 933c20f..d78de41 100644
--- a/src/main.c
+++ b/src/main.c
@@ -48,7 +48,7 @@
 #include "log.h"
 
 #include "lib/uuid.h"
-#include "hcid.h"
+#include "main.h"
 #include "sdpd.h"
 #include "adapter.h"
 #include "device.h"
diff --git a/src/hcid.h b/src/main.h
similarity index 100%
rename from src/hcid.h
rename to src/main.h
diff --git a/src/plugin.c b/src/plugin.c
index f231f34..61afc3d 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -37,7 +37,7 @@
 
 #include "plugin.h"
 #include "log.h"
-#include "hcid.h"
+#include "main.h"
 
 static GSList *plugins = NULL;
 
diff --git a/src/profile.c b/src/profile.c
index fc62f02..6949dcb 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -50,7 +50,7 @@
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
-#include "hcid.h"
+#include "main.h"
 
 #define DUN_DEFAULT_CHANNEL	1
 #define SPP_DEFAULT_CHANNEL	3
diff --git a/src/rfkill.c b/src/rfkill.c
index 70588c0..07609b3 100644
--- a/src/rfkill.c
+++ b/src/rfkill.c
@@ -37,7 +37,7 @@
 
 #include "log.h"
 #include "adapter.h"
-#include "hcid.h"
+#include "main.h"
 
 enum rfkill_type {
 	RFKILL_TYPE_ALL = 0,
diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index bc96d3c..3046a9b 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -45,7 +45,7 @@
 
 #include <glib.h>
 
-#include "hcid.h"
+#include "main.h"
 #include "log.h"
 #include "sdpd.h"
 
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index b6b135d..478ebb1 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -44,7 +44,7 @@
 #include <glib.h>
 #include <dbus/dbus.h>
 
-#include "hcid.h"
+#include "main.h"
 #include "sdpd.h"
 #include "log.h"
 #include "adapter.h"
-- 
1.8.1.2

