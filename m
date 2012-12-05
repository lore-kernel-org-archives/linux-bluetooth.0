Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 4/7] Use the entire include path for gdbus.h
Date: Wed,  5 Dec 2012 09:22:52 -0200
Message-Id: <1354706575-4718-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1354706575-4718-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1354706575-4718-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

---
 Makefile.am                          | 3 +--
 Makefile.obexd                       | 5 ++---
 attrib/client.c                      | 2 +-
 obexd/client/bluetooth.c             | 2 +-
 obexd/client/dbus.c                  | 2 +-
 obexd/client/driver.c                | 2 +-
 obexd/client/ftp.c                   | 2 +-
 obexd/client/main.c                  | 2 +-
 obexd/client/manager.c               | 2 +-
 obexd/client/map.c                   | 2 +-
 obexd/client/opp.c                   | 2 +-
 obexd/client/pbap.c                  | 2 +-
 obexd/client/session.c               | 2 +-
 obexd/client/session.h               | 2 +-
 obexd/client/sync.c                  | 2 +-
 obexd/client/transfer.c              | 2 +-
 obexd/plugins/bluetooth.c            | 2 +-
 obexd/plugins/pcsuite.c              | 2 +-
 obexd/plugins/syncevolution.c        | 2 +-
 obexd/plugins/usb.c                  | 2 +-
 obexd/plugins/vcard.c                | 2 +-
 obexd/src/main.c                     | 2 +-
 obexd/src/manager.c                  | 2 +-
 plugins/dbusoob.c                    | 2 +-
 plugins/neard.c                      | 2 +-
 plugins/service.c                    | 2 +-
 profiles/alert/server.c              | 2 +-
 profiles/audio/avrcp.c               | 2 +-
 profiles/audio/control.c             | 2 +-
 profiles/audio/device.c              | 2 +-
 profiles/audio/manager.c             | 2 +-
 profiles/audio/media.c               | 2 +-
 profiles/audio/player.c              | 2 +-
 profiles/audio/sink.c                | 2 +-
 profiles/audio/source.c              | 2 +-
 profiles/audio/transport.c           | 2 +-
 profiles/cups/main.c                 | 2 +-
 profiles/cyclingspeed/cyclingspeed.c | 2 +-
 profiles/health/hdp.c                | 2 +-
 profiles/health/hdp_main.c           | 2 +-
 profiles/health/hdp_util.c           | 2 +-
 profiles/heartrate/heartrate.c       | 2 +-
 profiles/heartrate/manager.c         | 2 +-
 profiles/input/device.c              | 2 +-
 profiles/input/main.c                | 2 +-
 profiles/network/connection.c        | 2 +-
 profiles/network/main.c              | 2 +-
 profiles/network/manager.c           | 2 +-
 profiles/network/server.c            | 2 +-
 profiles/proximity/immalert.c        | 2 +-
 profiles/proximity/linkloss.c        | 2 +-
 profiles/proximity/main.c            | 2 +-
 profiles/proximity/manager.c         | 2 +-
 profiles/proximity/monitor.c         | 2 +-
 profiles/proximity/reporter.c        | 2 +-
 profiles/sap/main.c                  | 2 +-
 profiles/sap/sap-dummy.c             | 2 +-
 profiles/sap/server.h                | 2 +-
 profiles/thermometer/thermometer.c   | 2 +-
 src/adapter.c                        | 2 +-
 src/agent.c                          | 2 +-
 src/attrib-server.c                  | 2 +-
 src/dbus-common.c                    | 2 +-
 src/device.c                         | 2 +-
 src/error.c                          | 2 +-
 src/main.c                           | 2 +-
 src/manager.c                        | 2 +-
 src/profile.c                        | 2 +-
 68 files changed, 69 insertions(+), 71 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index a2cdb62..8e717da 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -358,8 +358,7 @@ EXTRA_DIST += doc/manager-api.txt \
 AM_CFLAGS += @DBUS_CFLAGS@ @GLIB_CFLAGS@
 
 AM_CPPFLAGS = -include $(top_builddir)/config.h -I$(builddir)/lib \
-		-I$(builddir)/src -I$(srcdir)/src -I$(srcdir)/gdbus \
-		-I$(srcdir)/btio
+		-I$(builddir)/src -I$(srcdir)/src -I$(srcdir)/btio
 
 if MCAP
 AM_CPPFLAGS += -I$(builddir)/health
diff --git a/Makefile.obexd b/Makefile.obexd
index f8798f6..738e73d 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -32,7 +32,7 @@ obexd_src_obexd_CFLAGS = @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
 obexd_src_obexd_CPPFLAGS = -include $(top_builddir)/config.h -I$(builddir)/lib \
 				-I$(builddir)/obexd/src  \
 				-I$(srcdir)/obexd/src -I$(srcdir)/btio \
-				-I$(srcdir)/gobex -I$(srcdir)/gdbus
+				-I$(srcdir)/gobex
 
 obexd_src_obexd_SHORTNAME = obexd
 
@@ -79,7 +79,6 @@ obexd_client_obex_client_CFLAGS = @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
 
 obexd_client_obex_client_CPPFLAGS = -include $(top_builddir)/config.h \
 				-I$(builddir)/lib -I$(srcdir)/obexd/src \
-				-I$(srcdir)/btio -I$(srcdir)/gobex \
-				-I$(srcdir)/gdbus
+				-I$(srcdir)/btio -I$(srcdir)/gobex
 
 obexd_client_obex_client_SHORTNAME = obex-client
diff --git a/attrib/client.c b/attrib/client.c
index 44a6730..2220ce1 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -31,10 +31,10 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/uuid.h>
 
+#include <gdbus/gdbus.h>
 #include "adapter.h"
 #include "device.h"
 #include "log.h"
-#include "gdbus.h"
 #include "error.h"
 #include "dbus-common.h"
 #include "btio.h"
diff --git a/obexd/client/bluetooth.c b/obexd/client/bluetooth.c
index 528845e..336f112 100644
--- a/obexd/client/bluetooth.c
+++ b/obexd/client/bluetooth.c
@@ -25,7 +25,7 @@
 #include <inttypes.h>
 
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 #include <btio.h>
 
 #include <bluetooth/bluetooth.h>
diff --git a/obexd/client/dbus.c b/obexd/client/dbus.c
index 78e0b96..ad76700 100644
--- a/obexd/client/dbus.c
+++ b/obexd/client/dbus.c
@@ -20,7 +20,7 @@
  */
 
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 #include "dbus.h"
diff --git a/obexd/client/driver.c b/obexd/client/driver.c
index 66501fa..8cd3690 100644
--- a/obexd/client/driver.c
+++ b/obexd/client/driver.c
@@ -24,7 +24,7 @@
 #include <string.h>
 #include <errno.h>
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "transfer.h"
 #include "session.h"
diff --git a/obexd/client/ftp.c b/obexd/client/ftp.c
index e2b650f..ea8be60 100644
--- a/obexd/client/ftp.c
+++ b/obexd/client/ftp.c
@@ -24,7 +24,7 @@
 #include <errno.h>
 #include <string.h>
 
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "dbus.h"
 #include "log.h"
diff --git a/obexd/client/main.c b/obexd/client/main.c
index 80867be..a0b1c97 100644
--- a/obexd/client/main.c
+++ b/obexd/client/main.c
@@ -30,7 +30,7 @@
 #include <sys/signalfd.h>
 
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 #include "manager.h"
diff --git a/obexd/client/manager.c b/obexd/client/manager.c
index 93d16ae..36ca942 100644
--- a/obexd/client/manager.c
+++ b/obexd/client/manager.c
@@ -28,7 +28,7 @@
 #include <syslog.h>
 
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 #include "transfer.h"
diff --git a/obexd/client/map.c b/obexd/client/map.c
index 0f141c1..6d7d926 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -24,7 +24,7 @@
 #include <string.h>
 #include <stdio.h>
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include <gobex-apparam.h>
 
diff --git a/obexd/client/opp.c b/obexd/client/opp.c
index 5f317a2..aa08db6 100644
--- a/obexd/client/opp.c
+++ b/obexd/client/opp.c
@@ -22,7 +22,7 @@
  */
 
 #include <errno.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 
diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index fa8b126..00b631a 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -26,7 +26,7 @@
 #include <string.h>
 #include <stdio.h>
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include <bluetooth/bluetooth.h>
 #include <gobex-apparam.h>
diff --git a/obexd/client/session.c b/obexd/client/session.c
index 4339327..4ee9d21 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -31,7 +31,7 @@
 #include <sys/stat.h>
 
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 #include <gobex.h>
 
 #include "dbus.h"
diff --git a/obexd/client/session.h b/obexd/client/session.h
index af71568..402c042 100644
--- a/obexd/client/session.h
+++ b/obexd/client/session.h
@@ -24,7 +24,7 @@
 
 #include <stdint.h>
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 struct obc_session;
 
diff --git a/obexd/client/sync.c b/obexd/client/sync.c
index 45e49b0..a555430 100644
--- a/obexd/client/sync.c
+++ b/obexd/client/sync.c
@@ -26,7 +26,7 @@
 #include <string.h>
 
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 
diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index 67b8eaf..662e087 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -32,7 +32,7 @@
 #include <inttypes.h>
 
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 #include <gobex.h>
 
 #include "dbus.h"
diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index 24fd1cb..b2d6f28 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -29,7 +29,7 @@
 #include <sys/socket.h>
 
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "obexd.h"
 #include "plugin.h"
diff --git a/obexd/plugins/pcsuite.c b/obexd/plugins/pcsuite.c
index b479980..6d5bea4 100644
--- a/obexd/plugins/pcsuite.c
+++ b/obexd/plugins/pcsuite.c
@@ -35,7 +35,7 @@
 #include <inttypes.h>
 
 #include <glib.h>
-#include "gdbus.h"
+#include <gdbus/gdbus.h>
 
 #include "obexd.h"
 #include "plugin.h"
diff --git a/obexd/plugins/syncevolution.c b/obexd/plugins/syncevolution.c
index 1e8f78a..24b2d5e 100644
--- a/obexd/plugins/syncevolution.c
+++ b/obexd/plugins/syncevolution.c
@@ -32,6 +32,7 @@
 
 #include <bluetooth/bluetooth.h>
 
+#include <gdbus/gdbus.h>
 #include "plugin.h"
 #include "obex.h"
 #include "service.h"
@@ -40,7 +41,6 @@
 #include "manager.h"
 #include "btio.h"
 #include "obexd.h"
-#include "gdbus.h"
 #include "filesystem.h"
 
 #define SYNCML_TARGET_SIZE 11
diff --git a/obexd/plugins/usb.c b/obexd/plugins/usb.c
index 32e7159..350b37b 100644
--- a/obexd/plugins/usb.c
+++ b/obexd/plugins/usb.c
@@ -33,7 +33,7 @@
 #include <inttypes.h>
 
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "obexd.h"
 #include "plugin.h"
diff --git a/obexd/plugins/vcard.c b/obexd/plugins/vcard.c
index baf0696..c9f178a 100644
--- a/obexd/plugins/vcard.c
+++ b/obexd/plugins/vcard.c
@@ -27,7 +27,7 @@
 #include <errno.h>
 
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "vcard.h"
 
diff --git a/obexd/src/main.c b/obexd/src/main.c
index fb38265..d9329ce 100644
--- a/obexd/src/main.c
+++ b/obexd/src/main.c
@@ -38,7 +38,7 @@
 #include <syslog.h>
 #include <glib.h>
 
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 #include "obexd.h"
diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index e038b9e..aaf911a 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -25,7 +25,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <errno.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 #include <sys/socket.h>
 #include <inttypes.h>
 
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 95e52f9..5c4f650 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -26,7 +26,7 @@
 #include <stdbool.h>
 
 #include <errno.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
diff --git a/plugins/neard.c b/plugins/neard.c
index 842eabf..8db8520 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -22,7 +22,7 @@
  */
 
 #include <errno.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
diff --git a/plugins/service.c b/plugins/service.c
index d7c9b29..81318d7 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -30,7 +30,7 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "dbus-common.h"
 #include "sdpd.h"
diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 60d0108..4bc0265 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -24,7 +24,7 @@
 
 #include <stdbool.h>
 #include <errno.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 #include <glib.h>
 #include <bluetooth/uuid.h>
 #include <stdlib.h>
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index c69652f..6da001a 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -41,7 +41,7 @@
 
 #include <glib.h>
 #include <dbus/dbus.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "../src/adapter.h"
 #include "../src/device.h"
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 489ad07..b8a66f0 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -40,7 +40,7 @@
 
 #include <glib.h>
 #include <dbus/dbus.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "../src/adapter.h"
 #include "../src/device.h"
diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index c111262..2ee0d3d 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -36,7 +36,7 @@
 
 #include <glib.h>
 #include <dbus/dbus.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 #include "../src/adapter.h"
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 7544197..0361ae4 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -42,7 +42,7 @@
 
 #include <glib.h>
 #include <dbus/dbus.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "glib-helper.h"
 #include "btio.h"
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 2ac7d7d..db60d7d 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -28,7 +28,7 @@
 #include <bluetooth/uuid.h>
 
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "../src/adapter.h"
 #include "../src/device.h"
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 460fb5a..66af11e 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -31,7 +31,7 @@
 
 #include <glib.h>
 #include <dbus/dbus.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 #include "player.h"
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index e7901e0..c8f7207 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -31,7 +31,7 @@
 
 #include <glib.h>
 #include <dbus/dbus.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 8913ab1..964f273 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -32,7 +32,7 @@
 
 #include <glib.h>
 #include <dbus/dbus.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 79355ce..112e9a5 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -27,7 +27,7 @@
 #include <bluetooth/uuid.h>
 
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "../src/adapter.h"
 #include "../src/device.h"
diff --git a/profiles/cups/main.c b/profiles/cups/main.c
index 7c06efe..73a568d 100644
--- a/profiles/cups/main.c
+++ b/profiles/cups/main.c
@@ -35,7 +35,7 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "cups.h"
 
diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index f678ed9..468f180 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -20,7 +20,7 @@
  *
  */
 
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 #include <errno.h>
 #include <stdbool.h>
 #include <glib.h>
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 0692d43..d062abb 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -29,7 +29,7 @@
 #include <glib.h>
 
 #include <bluetooth/l2cap.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 #include <dbus-common.h>
 #include <log.h>
 #include <error.h>
diff --git a/profiles/health/hdp_main.c b/profiles/health/hdp_main.c
index 96dc678..7f4e8d5 100644
--- a/profiles/health/hdp_main.c
+++ b/profiles/health/hdp_main.c
@@ -22,7 +22,7 @@
 
 #include <errno.h>
 
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "plugin.h"
 #include "hdp_manager.h"
diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 714117c..8aa5723 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -25,7 +25,7 @@
 
 #include <glib.h>
 
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include <adapter.h>
 #include <device.h>
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index ab61b87..7abb6ed 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -20,7 +20,7 @@
  *
  */
 
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 #include <errno.h>
 #include <stdbool.h>
 #include <glib.h>
diff --git a/profiles/heartrate/manager.c b/profiles/heartrate/manager.c
index aeb69f4..b939a2a 100644
--- a/profiles/heartrate/manager.c
+++ b/profiles/heartrate/manager.c
@@ -20,7 +20,7 @@
  *
  */
 
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 #include <errno.h>
 #include <stdbool.h>
 #include <bluetooth/uuid.h>
diff --git a/profiles/input/device.c b/profiles/input/device.c
index d512f48..b876765 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -33,7 +33,7 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 
diff --git a/profiles/input/main.c b/profiles/input/main.c
index 3595b0b..6b66f8b 100644
--- a/profiles/input/main.c
+++ b/profiles/input/main.c
@@ -25,7 +25,7 @@
 
 #include <bluetooth/bluetooth.h>
 
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "plugin.h"
 #include "hcid.h"
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index b97c151..e1e0376 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -32,7 +32,7 @@
 #include <bluetooth/sdp.h>
 
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 #include "btio.h"
diff --git a/profiles/network/main.c b/profiles/network/main.c
index c8f9ea0..98eb7b5 100644
--- a/profiles/network/main.c
+++ b/profiles/network/main.c
@@ -23,7 +23,7 @@
 
 #include <errno.h>
 
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "plugin.h"
 #include "manager.h"
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index d3da540..70ad888 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -29,7 +29,7 @@
 #include <bluetooth/uuid.h>
 
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 153ec08..c093d34 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -34,7 +34,7 @@
 #include <netinet/in.h>
 
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "../src/dbus-common.h"
 #include "../src/adapter.h"
diff --git a/profiles/proximity/immalert.c b/profiles/proximity/immalert.c
index 8ea37b6..92166d4 100644
--- a/profiles/proximity/immalert.c
+++ b/profiles/proximity/immalert.c
@@ -27,7 +27,7 @@
 #include <adapter.h>
 
 #include <dbus/dbus.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 #include "attrib/gattrib.h"
diff --git a/profiles/proximity/linkloss.c b/profiles/proximity/linkloss.c
index a325ef1..648202f 100644
--- a/profiles/proximity/linkloss.c
+++ b/profiles/proximity/linkloss.c
@@ -27,7 +27,7 @@
 #include <adapter.h>
 
 #include <dbus/dbus.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 #include "attrib/att-database.h"
diff --git a/profiles/proximity/main.c b/profiles/proximity/main.c
index 93f4a1c..b795fd7 100644
--- a/profiles/proximity/main.c
+++ b/profiles/proximity/main.c
@@ -25,7 +25,7 @@
 #include <errno.h>
 #include <stdint.h>
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 #include "plugin.h"
diff --git a/profiles/proximity/manager.c b/profiles/proximity/manager.c
index 9190b63..6da08ed 100644
--- a/profiles/proximity/manager.c
+++ b/profiles/proximity/manager.c
@@ -25,7 +25,7 @@
 #include <stdbool.h>
 
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 #include <bluetooth/uuid.h>
 
 #include "adapter.h"
diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index 9868fce..517e50d 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -24,7 +24,7 @@
 
 #include <errno.h>
 #include <fcntl.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 #include <stdint.h>
 #include <stdbool.h>
 #include <stdio.h>
diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index c279062..d504f9d 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -30,7 +30,7 @@
 #include <adapter.h>
 
 #include <dbus/dbus.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 
diff --git a/profiles/sap/main.c b/profiles/sap/main.c
index c5df5a1..d2218d4 100644
--- a/profiles/sap/main.c
+++ b/profiles/sap/main.c
@@ -19,7 +19,7 @@
  */
 
 #include <errno.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 #include "plugin.h"
 #include "manager.h"
 
diff --git a/profiles/sap/sap-dummy.c b/profiles/sap/sap-dummy.c
index a3e08bb..0f9265c 100644
--- a/profiles/sap/sap-dummy.c
+++ b/profiles/sap/sap-dummy.c
@@ -23,7 +23,7 @@
  */
 
 #include <glib.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 #include <stdint.h>
 
 #include "dbus-common.h"
diff --git a/profiles/sap/server.h b/profiles/sap/server.h
index e636d91..73b38ab 100644
--- a/profiles/sap/server.h
+++ b/profiles/sap/server.h
@@ -18,7 +18,7 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 int sap_server_register(const char *path, const bdaddr_t *src);
 void sap_server_unregister(const char *path);
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 6fb0d03..31bf718 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -25,7 +25,7 @@
 
 #include <bluetooth/uuid.h>
 
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "dbus-common.h"
 #include "adapter.h"
diff --git a/src/adapter.c b/src/adapter.c
index 7994d89..4a69923 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -39,7 +39,7 @@
 
 #include <glib.h>
 #include <dbus/dbus.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 #include "textfile.h"
diff --git a/src/agent.c b/src/agent.c
index 97d34ce..82a0e9c 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -34,7 +34,7 @@
 
 #include <glib.h>
 #include <dbus/dbus.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 5cd5460..0718c4b 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -34,8 +34,8 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
+#include <gdbus/gdbus.h>
 #include "log.h"
-#include "gdbus.h"
 #include "btio.h"
 #include "sdpd.h"
 #include "hcid.h"
diff --git a/src/dbus-common.c b/src/dbus-common.c
index 3c73e32..579e704 100644
--- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -28,7 +28,7 @@
 
 #include <glib.h>
 #include <dbus/dbus.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 
diff --git a/src/device.c b/src/device.c
index 32fb788..5b570bc 100644
--- a/src/device.c
+++ b/src/device.c
@@ -39,7 +39,7 @@
 
 #include <glib.h>
 #include <dbus/dbus.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 
diff --git a/src/error.c b/src/error.c
index c5747c0..a019dae 100644
--- a/src/error.c
+++ b/src/error.c
@@ -23,7 +23,7 @@
  *
  */
 
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "error.h"
 
diff --git a/src/main.c b/src/main.c
index 90cd326..0534e26 100644
--- a/src/main.c
+++ b/src/main.c
@@ -40,7 +40,7 @@
 
 #include <dbus/dbus.h>
 
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 
diff --git a/src/manager.c b/src/manager.c
index 8711d39..6f17f7c 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -38,7 +38,7 @@
 
 #include <dbus/dbus.h>
 
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include "glib-helper.h"
 #include "hcid.h"
diff --git a/src/profile.c b/src/profile.c
index 755c387..88d7cdb 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -28,7 +28,7 @@
 
 #include <glib.h>
 #include <dbus/dbus.h>
-#include <gdbus.h>
+#include <gdbus/gdbus.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/uuid.h>
-- 
1.8.0.1

