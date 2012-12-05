Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 5/7] Use the entire include path for btio.h
Date: Wed,  5 Dec 2012 09:22:53 -0200
Message-Id: <1354706575-4718-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1354706575-4718-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1354706575-4718-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

---
 Makefile.am                   | 2 +-
 Makefile.obexd                | 4 ++--
 attrib/client.c               | 2 +-
 attrib/gattrib.c              | 2 +-
 attrib/gatttool.c             | 2 +-
 attrib/interactive.c          | 2 +-
 attrib/utils.c                | 2 +-
 obexd/client/bluetooth.c      | 2 +-
 obexd/plugins/bluetooth.c     | 2 +-
 obexd/plugins/syncevolution.c | 2 +-
 obexd/src/manager.c           | 2 +-
 obexd/src/obex.c              | 2 +-
 profiles/audio/avctp.c        | 2 +-
 profiles/audio/avdtp.c        | 2 +-
 profiles/audio/main.c         | 2 +-
 profiles/audio/manager.c      | 2 +-
 profiles/gatt/gas.c           | 2 +-
 profiles/health/hdp.c         | 2 +-
 profiles/health/hdp_manager.c | 2 +-
 profiles/health/hdp_util.c    | 2 +-
 profiles/health/mcap.c        | 2 +-
 profiles/health/mcap_sync.c   | 2 +-
 profiles/input/device.c       | 2 +-
 profiles/input/server.c       | 2 +-
 profiles/network/connection.c | 2 +-
 profiles/network/server.c     | 2 +-
 profiles/sap/server.c         | 2 +-
 src/attrib-server.c           | 2 +-
 src/device.c                  | 2 +-
 src/plugin.c                  | 2 +-
 src/profile.c                 | 2 +-
 src/sdp-client.c              | 2 +-
 test/btiotest.c               | 2 +-
 33 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 8e717da..1c3e955 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -358,7 +358,7 @@ EXTRA_DIST += doc/manager-api.txt \
 AM_CFLAGS += @DBUS_CFLAGS@ @GLIB_CFLAGS@
 
 AM_CPPFLAGS = -include $(top_builddir)/config.h -I$(builddir)/lib \
-		-I$(builddir)/src -I$(srcdir)/src -I$(srcdir)/btio
+		-I$(builddir)/src -I$(srcdir)/src
 
 if MCAP
 AM_CPPFLAGS += -I$(builddir)/health
diff --git a/Makefile.obexd b/Makefile.obexd
index 738e73d..a895753 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -31,7 +31,7 @@ obexd_src_obexd_CFLAGS = @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
 
 obexd_src_obexd_CPPFLAGS = -include $(top_builddir)/config.h -I$(builddir)/lib \
 				-I$(builddir)/obexd/src  \
-				-I$(srcdir)/obexd/src -I$(srcdir)/btio \
+				-I$(srcdir)/obexd/src \
 				-I$(srcdir)/gobex
 
 obexd_src_obexd_SHORTNAME = obexd
@@ -79,6 +79,6 @@ obexd_client_obex_client_CFLAGS = @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
 
 obexd_client_obex_client_CPPFLAGS = -include $(top_builddir)/config.h \
 				-I$(builddir)/lib -I$(srcdir)/obexd/src \
-				-I$(srcdir)/btio -I$(srcdir)/gobex
+				-I$(srcdir)/gobex
 
 obexd_client_obex_client_SHORTNAME = obex-client
diff --git a/attrib/client.c b/attrib/client.c
index 2220ce1..41a96d5 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -37,7 +37,7 @@
 #include "log.h"
 #include "error.h"
 #include "dbus-common.h"
-#include "btio.h"
+#include <btio/btio.h>
 #include "storage.h"
 
 #include "att.h"
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 309e58f..9ba850a 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -33,7 +33,7 @@
 
 #include "log.h"
 #include "att.h"
-#include "btio.h"
+#include <btio/btio.h>
 #include "gattrib.h"
 
 #define GATT_TIMEOUT 30
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index dcfc856..5bda975 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -33,7 +33,7 @@
 #include <bluetooth/uuid.h>
 
 #include "att.h"
-#include "btio.h"
+#include <btio/btio.h>
 #include "gattrib.h"
 #include "gatt.h"
 #include "gatttool.h"
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 6030fb7..940cd50 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -32,7 +32,7 @@
 #include <readline/history.h>
 
 #include "att.h"
-#include "btio.h"
+#include <btio/btio.h>
 #include "gattrib.h"
 #include "gatt.h"
 #include "gatttool.h"
diff --git a/attrib/utils.c b/attrib/utils.c
index b5ade9a..4ffcd93 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -33,7 +33,7 @@
 #include "att.h"
 #include "gattrib.h"
 #include "gatt.h"
-#include "btio.h"
+#include <btio/btio.h>
 #include "gatttool.h"
 
 GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
diff --git a/obexd/client/bluetooth.c b/obexd/client/bluetooth.c
index 336f112..6406b8b 100644
--- a/obexd/client/bluetooth.c
+++ b/obexd/client/bluetooth.c
@@ -26,7 +26,7 @@
 
 #include <glib.h>
 #include <gdbus/gdbus.h>
-#include <btio.h>
+#include <btio/btio.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/rfcomm.h>
diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index b2d6f28..f57a511 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -38,7 +38,7 @@
 #include "transport.h"
 #include "service.h"
 #include "log.h"
-#include "btio.h"
+#include <btio/btio.h>
 
 #define BT_RX_MTU 32767
 #define BT_TX_MTU 32767
diff --git a/obexd/plugins/syncevolution.c b/obexd/plugins/syncevolution.c
index 24b2d5e..93cf2bf 100644
--- a/obexd/plugins/syncevolution.c
+++ b/obexd/plugins/syncevolution.c
@@ -39,7 +39,7 @@
 #include "mimetype.h"
 #include "log.h"
 #include "manager.h"
-#include "btio.h"
+#include <btio/btio.h>
 #include "obexd.h"
 #include "filesystem.h"
 
diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index aaf911a..3743bbf 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -37,7 +37,7 @@
 #include "server.h"
 #include "manager.h"
 #include "log.h"
-#include "btio.h"
+#include <btio/btio.h>
 #include "service.h"
 
 #define OBEX_MANAGER_PATH "/"
diff --git a/obexd/src/obex.c b/obexd/src/obex.c
index 4656493..e7e6c6f 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -47,7 +47,7 @@
 #include "mimetype.h"
 #include "service.h"
 #include "transport.h"
-#include "btio.h"
+#include <btio/btio.h>
 
 /* Challenge request */
 #define NONCE_TAG 0x00
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index ee19ae5..1bf06f2 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -48,7 +48,7 @@
 #include "log.h"
 #include "error.h"
 #include "uinput.h"
-#include "btio.h"
+#include <btio/btio.h>
 #include "manager.h"
 #include "device.h"
 #include "avctp.h"
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 3fe21da..b9f7d85 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -50,7 +50,7 @@
 #include "manager.h"
 #include "control.h"
 #include "avdtp.h"
-#include "btio.h"
+#include <btio/btio.h>
 #include "sink.h"
 #include "source.h"
 
diff --git a/profiles/audio/main.c b/profiles/audio/main.c
index fa48e23..21961cb 100644
--- a/profiles/audio/main.c
+++ b/profiles/audio/main.c
@@ -34,7 +34,7 @@
 #include <dbus/dbus.h>
 
 #include "glib-helper.h"
-#include "btio.h"
+#include <btio/btio.h>
 #include "plugin.h"
 #include "log.h"
 #include "device.h"
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 0361ae4..67a0153 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -45,7 +45,7 @@
 #include <gdbus/gdbus.h>
 
 #include "glib-helper.h"
-#include "btio.h"
+#include <btio/btio.h>
 #include "../src/adapter.h"
 #include "../src/manager.h"
 #include "../src/device.h"
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 78b6ff1..42db6a2 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -35,7 +35,7 @@
 #include "attrib/att.h"
 #include "attrib/gattrib.h"
 #include "attio.h"
-#include "btio.h"
+#include <btio/btio.h>
 #include "attrib/gatt.h"
 #include "log.h"
 #include "textfile.h"
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index d062abb..23cdc5f 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -35,7 +35,7 @@
 #include <error.h>
 #include <adapter.h>
 #include <device.h>
-#include <btio.h>
+#include <btio/btio.h>
 
 #include "mcap_lib.h"
 #include "hdp_types.h"
diff --git a/profiles/health/hdp_manager.c b/profiles/health/hdp_manager.c
index c182852..3945bf8 100644
--- a/profiles/health/hdp_manager.c
+++ b/profiles/health/hdp_manager.c
@@ -26,7 +26,7 @@
 #include <bluetooth/sdp_lib.h>
 #include <bluetooth/uuid.h>
 
-#include <btio.h>
+#include <btio/btio.h>
 #include <adapter.h>
 #include <device.h>
 #include <profile.h>
diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 8aa5723..339f8cf 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -36,7 +36,7 @@
 #include <sdp-client.h>
 #include <glib-helper.h>
 
-#include <btio.h>
+#include <btio/btio.h>
 
 #include <log.h>
 
diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index 57ea1c3..466d266 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -30,7 +30,7 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/l2cap.h>
 
-#include <btio.h>
+#include <btio/btio.h>
 #include <log.h>
 #include <error.h>
 
diff --git a/profiles/health/mcap_sync.c b/profiles/health/mcap_sync.c
index 0e21877..06ea7da 100644
--- a/profiles/health/mcap_sync.c
+++ b/profiles/health/mcap_sync.c
@@ -31,7 +31,7 @@
 #include <bluetooth/l2cap.h>
 #include <adapter.h>
 #include <manager.h>
-#include <btio.h>
+#include <btio/btio.h>
 #include <log.h>
 
 #include "mcap.h"
diff --git a/profiles/input/device.c b/profiles/input/device.c
index b876765..986e924 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -45,7 +45,7 @@
 
 #include "device.h"
 #include "error.h"
-#include "btio.h"
+#include <btio/btio.h>
 
 #include "sdp-client.h"
 
diff --git a/profiles/input/server.c b/profiles/input/server.c
index 4f8cc90..db5592b 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -35,7 +35,7 @@
 #include "log.h"
 
 #include "glib-helper.h"
-#include "btio.h"
+#include <btio/btio.h>
 #include "../src/adapter.h"
 #include "../src/device.h"
 #include "../src/profile.h"
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index e1e0376..c91e59d 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -35,7 +35,7 @@
 #include <gdbus/gdbus.h>
 
 #include "log.h"
-#include "btio.h"
+#include <btio/btio.h>
 #include "dbus-common.h"
 #include "adapter.h"
 #include "device.h"
diff --git a/profiles/network/server.c b/profiles/network/server.c
index c093d34..09ea0e7 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -42,7 +42,7 @@
 #include "log.h"
 #include "error.h"
 #include "sdpd.h"
-#include "btio.h"
+#include <btio/btio.h>
 
 #include "common.h"
 #include "server.h"
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index 24441d1..033b9a3 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -31,7 +31,7 @@
 #include <bluetooth/uuid.h>
 
 #include "adapter.h"
-#include "btio.h"
+#include <btio/btio.h>
 #include "sdpd.h"
 #include "log.h"
 #include "error.h"
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 0718c4b..bdf5b38 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -36,7 +36,7 @@
 
 #include <gdbus/gdbus.h>
 #include "log.h"
-#include "btio.h"
+#include <btio/btio.h>
 #include "sdpd.h"
 #include "hcid.h"
 #include "adapter.h"
diff --git a/src/device.c b/src/device.c
index 5b570bc..e12f63a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -58,7 +58,7 @@
 #include "agent.h"
 #include "sdp-xml.h"
 #include "storage.h"
-#include "btio.h"
+#include <btio/btio.h>
 #include "attrib-server.h"
 #include "attrib/client.h"
 
diff --git a/src/plugin.c b/src/plugin.c
index d576207..a16deb8 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -33,7 +33,7 @@
 #include "plugin.h"
 #include "log.h"
 #include "hcid.h"
-#include "btio.h"
+#include <btio/btio.h>
 
 static GSList *plugins = NULL;
 
diff --git a/src/profile.c b/src/profile.c
index 88d7cdb..6613b1c 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -35,7 +35,7 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
-#include "btio.h"
+#include <btio/btio.h>
 #include "sdpd.h"
 #include "log.h"
 #include "error.h"
diff --git a/src/sdp-client.c b/src/sdp-client.c
index d378446..b2a253e 100644
--- a/src/sdp-client.c
+++ b/src/sdp-client.c
@@ -29,7 +29,7 @@
 
 #include <glib.h>
 
-#include "btio.h"
+#include <btio/btio.h>
 #include "sdp-client.h"
 
 /* Number of seconds to keep a sdp_session_t in the cache */
diff --git a/test/btiotest.c b/test/btiotest.c
index 593bafc..4b170ac 100644
--- a/test/btiotest.c
+++ b/test/btiotest.c
@@ -30,7 +30,7 @@
 
 #include <glib.h>
 
-#include "btio.h"
+#include <btio/btio.h>
 
 #define DEFAULT_ACCEPT_TIMEOUT 2
 static gint opt_update_sec = 0;
-- 
1.8.0.1

