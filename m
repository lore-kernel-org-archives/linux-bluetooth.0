Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 6/7] Reorder btio.h includes
Date: Wed,  5 Dec 2012 09:22:54 -0200
Message-Id: <1354706575-4718-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1354706575-4718-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1354706575-4718-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Let "#include <btio/btio.h>" together with other includes using '<'
rather than '"'.
---
 attrib/client.c               | 2 +-
 attrib/gattrib.c              | 2 +-
 attrib/interactive.c          | 2 +-
 attrib/utils.c                | 2 +-
 obexd/plugins/bluetooth.c     | 2 +-
 obexd/plugins/syncevolution.c | 2 +-
 obexd/src/manager.c           | 2 +-
 obexd/src/obex.c              | 2 +-
 profiles/audio/avctp.c        | 2 +-
 profiles/audio/avdtp.c        | 2 +-
 profiles/audio/main.c         | 2 +-
 profiles/audio/manager.c      | 2 +-
 profiles/gatt/gas.c           | 2 +-
 profiles/network/connection.c | 2 +-
 profiles/network/server.c     | 2 +-
 src/device.c                  | 2 +-
 src/plugin.c                  | 2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 41a96d5..d533732 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -32,12 +32,12 @@
 #include <bluetooth/uuid.h>
 
 #include <gdbus/gdbus.h>
+#include <btio/btio.h>
 #include "adapter.h"
 #include "device.h"
 #include "log.h"
 #include "error.h"
 #include "dbus-common.h"
-#include <btio/btio.h>
 #include "storage.h"
 
 #include "att.h"
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 9ba850a..0acefc8 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -31,9 +31,9 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/uuid.h>
 
+#include <btio/btio.h>
 #include "log.h"
 #include "att.h"
-#include <btio/btio.h>
 #include "gattrib.h"
 
 #define GATT_TIMEOUT 30
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 940cd50..50f7e44 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -31,8 +31,8 @@
 #include <readline/readline.h>
 #include <readline/history.h>
 
-#include "att.h"
 #include <btio/btio.h>
+#include "att.h"
 #include "gattrib.h"
 #include "gatt.h"
 #include "gatttool.h"
diff --git a/attrib/utils.c b/attrib/utils.c
index 4ffcd93..08365bd 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -30,10 +30,10 @@
 #include <bluetooth/uuid.h>
 #include <bluetooth/sdp.h>
 
+#include <btio/btio.h>
 #include "att.h"
 #include "gattrib.h"
 #include "gatt.h"
-#include <btio/btio.h>
 #include "gatttool.h"
 
 GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index f57a511..4cbeac4 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -30,6 +30,7 @@
 
 #include <glib.h>
 #include <gdbus/gdbus.h>
+#include <btio/btio.h>
 
 #include "obexd.h"
 #include "plugin.h"
@@ -38,7 +39,6 @@
 #include "transport.h"
 #include "service.h"
 #include "log.h"
-#include <btio/btio.h>
 
 #define BT_RX_MTU 32767
 #define BT_TX_MTU 32767
diff --git a/obexd/plugins/syncevolution.c b/obexd/plugins/syncevolution.c
index 93cf2bf..02c02d4 100644
--- a/obexd/plugins/syncevolution.c
+++ b/obexd/plugins/syncevolution.c
@@ -32,6 +32,7 @@
 
 #include <bluetooth/bluetooth.h>
 
+#include <btio/btio.h>
 #include <gdbus/gdbus.h>
 #include "plugin.h"
 #include "obex.h"
@@ -39,7 +40,6 @@
 #include "mimetype.h"
 #include "log.h"
 #include "manager.h"
-#include <btio/btio.h>
 #include "obexd.h"
 #include "filesystem.h"
 
diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 3743bbf..ccf03ca 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -29,6 +29,7 @@
 #include <sys/socket.h>
 #include <inttypes.h>
 
+#include <btio/btio.h>
 #include <gobex.h>
 
 #include "obexd.h"
@@ -37,7 +38,6 @@
 #include "server.h"
 #include "manager.h"
 #include "log.h"
-#include <btio/btio.h>
 #include "service.h"
 
 #define OBEX_MANAGER_PATH "/"
diff --git a/obexd/src/obex.c b/obexd/src/obex.c
index e7e6c6f..bdaf923 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -36,6 +36,7 @@
 #include <inttypes.h>
 
 #include <glib.h>
+#include <btio/btio.h>
 #include <gobex/gobex.h>
 
 #include "obexd.h"
@@ -47,7 +48,6 @@
 #include "mimetype.h"
 #include "service.h"
 #include "transport.h"
-#include <btio/btio.h>
 
 /* Challenge request */
 #define NONCE_TAG 0x00
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 1bf06f2..061ebd0 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -41,6 +41,7 @@
 #include <bluetooth/l2cap.h>
 
 #include <glib.h>
+#include <btio/btio.h>
 
 #include "adapter.h"
 #include "../src/device.h"
@@ -48,7 +49,6 @@
 #include "log.h"
 #include "error.h"
 #include "uinput.h"
-#include <btio/btio.h>
 #include "manager.h"
 #include "device.h"
 #include "avctp.h"
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index b9f7d85..8fd7118 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -39,6 +39,7 @@
 
 #include <glib.h>
 #include <dbus/dbus.h>
+#include <btio/btio.h>
 
 #include "log.h"
 
@@ -50,7 +51,6 @@
 #include "manager.h"
 #include "control.h"
 #include "avdtp.h"
-#include <btio/btio.h>
 #include "sink.h"
 #include "source.h"
 
diff --git a/profiles/audio/main.c b/profiles/audio/main.c
index 21961cb..0c3a703 100644
--- a/profiles/audio/main.c
+++ b/profiles/audio/main.c
@@ -32,9 +32,9 @@
 
 #include <glib.h>
 #include <dbus/dbus.h>
+#include <btio/btio.h>
 
 #include "glib-helper.h"
-#include <btio/btio.h>
 #include "plugin.h"
 #include "log.h"
 #include "device.h"
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 67a0153..5efe166 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -42,10 +42,10 @@
 
 #include <glib.h>
 #include <dbus/dbus.h>
+#include <btio/btio.h>
 #include <gdbus/gdbus.h>
 
 #include "glib-helper.h"
-#include <btio/btio.h>
 #include "../src/adapter.h"
 #include "../src/manager.h"
 #include "../src/device.h"
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 42db6a2..5ec0a8f 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -29,13 +29,13 @@
 
 #include <glib.h>
 #include <bluetooth/uuid.h>
+#include <btio/btio.h>
 
 #include "adapter.h"
 #include "device.h"
 #include "attrib/att.h"
 #include "attrib/gattrib.h"
 #include "attio.h"
-#include <btio/btio.h>
 #include "attrib/gatt.h"
 #include "log.h"
 #include "textfile.h"
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index c91e59d..8df4a6b 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -33,9 +33,9 @@
 
 #include <glib.h>
 #include <gdbus/gdbus.h>
+#include <btio/btio.h>
 
 #include "log.h"
-#include <btio/btio.h>
 #include "dbus-common.h"
 #include "adapter.h"
 #include "device.h"
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 09ea0e7..6d0274a 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -35,6 +35,7 @@
 
 #include <glib.h>
 #include <gdbus/gdbus.h>
+#include <btio/btio.h>
 
 #include "../src/dbus-common.h"
 #include "../src/adapter.h"
@@ -42,7 +43,6 @@
 #include "log.h"
 #include "error.h"
 #include "sdpd.h"
-#include <btio/btio.h>
 
 #include "common.h"
 #include "server.h"
diff --git a/src/device.c b/src/device.c
index e12f63a..2032b80 100644
--- a/src/device.c
+++ b/src/device.c
@@ -40,6 +40,7 @@
 #include <glib.h>
 #include <dbus/dbus.h>
 #include <gdbus/gdbus.h>
+#include <btio/btio.h>
 
 #include "log.h"
 
@@ -58,7 +59,6 @@
 #include "agent.h"
 #include "sdp-xml.h"
 #include "storage.h"
-#include <btio/btio.h>
 #include "attrib-server.h"
 #include "attrib/client.h"
 
diff --git a/src/plugin.c b/src/plugin.c
index a16deb8..c931e68 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -29,11 +29,11 @@
 #include <bluetooth/bluetooth.h>
 
 #include <glib.h>
+#include <btio/btio.h>
 
 #include "plugin.h"
 #include "log.h"
 #include "hcid.h"
-#include <btio/btio.h>
 
 static GSList *plugins = NULL;
 
-- 
1.8.0.1

