Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 2/2] Ensure config.h is included by using CPPFLAGS
Date: Tue,  4 Dec 2012 10:19:00 -0200
Message-Id: <1354623540-21149-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1354623540-21149-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1354623540-21149-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Instead of trying to include config.h in each file over the tree and
possibly forgetting to include it, give a "-include config.h" argument
to the compiler so it's guaranteed that a) it will be included for all
source files and b) it will be the first header included.

gdbus/ directory is left out, since it would break other projects using
it.
---
 Makefile.am                        | 5 +++--
 attrib/client.c                    | 4 ----
 attrib/gatt-service.c              | 4 ----
 attrib/gatt.c                      | 4 ----
 attrib/gatttool.c                  | 4 ----
 emulator/b1ee.c                    | 4 ----
 emulator/btdev.c                   | 4 ----
 emulator/main.c                    | 4 ----
 emulator/server.c                  | 4 ----
 emulator/vhci.c                    | 4 ----
 lib/bluetooth.c                    | 4 ----
 lib/hci.c                          | 4 ----
 lib/sdp.c                          | 4 ----
 lib/uuid.c                         | 4 ----
 monitor/btsnoop.c                  | 4 ----
 monitor/control.c                  | 4 ----
 monitor/display.c                  | 4 ----
 monitor/hcidump.c                  | 4 ----
 monitor/l2cap.c                    | 4 ----
 monitor/main.c                     | 4 ----
 monitor/mainloop.c                 | 4 ----
 monitor/packet.c                   | 4 ----
 monitor/sdp.c                      | 4 ----
 monitor/uuid.c                     | 4 ----
 plugins/adaptername.c              | 4 ----
 plugins/dbusoob.c                  | 4 ----
 plugins/external-dummy.c           | 4 ----
 plugins/formfactor.c               | 4 ----
 plugins/gatt-example.c             | 4 ----
 plugins/neard.c                    | 4 ----
 plugins/service.c                  | 4 ----
 plugins/storage.c                  | 4 ----
 plugins/wiimote.c                  | 4 ----
 profiles/alert/main.c              | 4 ----
 profiles/alert/manager.c           | 4 ----
 profiles/alert/server.c            | 4 ----
 profiles/audio/a2dp.c              | 4 ----
 profiles/audio/avctp.c             | 4 ----
 profiles/audio/avdtp.c             | 4 ----
 profiles/audio/avrcp.c             | 4 ----
 profiles/audio/control.c           | 4 ----
 profiles/audio/device.c            | 4 ----
 profiles/audio/main.c              | 4 ----
 profiles/audio/manager.c           | 4 ----
 profiles/audio/media.c             | 4 ----
 profiles/audio/player.c            | 4 ----
 profiles/audio/sink.c              | 4 ----
 profiles/audio/source.c            | 4 ----
 profiles/audio/transport.c         | 4 ----
 profiles/cups/hcrp.c               | 4 ----
 profiles/cups/main.c               | 4 ----
 profiles/cups/sdp.c                | 4 ----
 profiles/cups/spp.c                | 4 ----
 profiles/deviceinfo/deviceinfo.c   | 4 ----
 profiles/deviceinfo/main.c         | 4 ----
 profiles/gatt/gas.c                | 4 ----
 profiles/gatt/main.c               | 4 ----
 profiles/health/hdp_main.c         | 4 ----
 profiles/health/hdp_manager.c      | 4 ----
 profiles/health/hdp_util.c         | 4 ----
 profiles/health/mcap_sync.c        | 4 ----
 profiles/heartrate/heartrate.c     | 4 ----
 profiles/heartrate/main.c          | 4 ----
 profiles/input/device.c            | 4 ----
 profiles/input/hog_device.c        | 4 ----
 profiles/input/hog_manager.c       | 4 ----
 profiles/input/main.c              | 4 ----
 profiles/input/manager.c           | 4 ----
 profiles/input/server.c            | 4 ----
 profiles/input/suspend-dummy.c     | 4 ----
 profiles/network/common.c          | 4 ----
 profiles/network/connection.c      | 4 ----
 profiles/network/main.c            | 4 ----
 profiles/network/manager.c         | 4 ----
 profiles/network/server.c          | 4 ----
 profiles/proximity/immalert.c      | 4 ----
 profiles/proximity/linkloss.c      | 4 ----
 profiles/proximity/main.c          | 4 ----
 profiles/proximity/manager.c       | 4 ----
 profiles/proximity/monitor.c       | 4 ----
 profiles/proximity/reporter.c      | 4 ----
 profiles/sap/main.c                | 4 ----
 profiles/sap/manager.c             | 4 ----
 profiles/sap/sap-dummy.c           | 4 ----
 profiles/sap/server.c              | 4 ----
 profiles/scanparam/main.c          | 4 ----
 profiles/scanparam/manager.c       | 4 ----
 profiles/scanparam/scan.c          | 4 ----
 profiles/thermometer/main.c        | 4 ----
 profiles/thermometer/thermometer.c | 4 ----
 profiles/time/main.c               | 4 ----
 profiles/time/manager.c            | 4 ----
 profiles/time/server.c             | 4 ----
 src/adapter.c                      | 4 ----
 src/agent.c                        | 4 ----
 src/attrib-server.c                | 4 ----
 src/dbus-common.c                  | 4 ----
 src/device.c                       | 4 ----
 src/eir.c                          | 4 ----
 src/error.c                        | 4 ----
 src/glib-helper.c                  | 4 ----
 src/log.c                          | 4 ----
 src/main.c                         | 4 ----
 src/manager.c                      | 4 ----
 src/mgmt.c                         | 4 ----
 src/oui.c                          | 4 ----
 src/plugin.c                       | 4 ----
 src/profile.c                      | 4 ----
 src/rfkill.c                       | 4 ----
 src/sdp-client.c                   | 4 ----
 src/sdp-xml.c                      | 4 ----
 src/sdpd-database.c                | 4 ----
 src/sdpd-request.c                 | 4 ----
 src/sdpd-server.c                  | 4 ----
 src/sdpd-service.c                 | 4 ----
 src/storage.c                      | 4 ----
 src/textfile.c                     | 4 ----
 test/agent.c                       | 4 ----
 test/attest.c                      | 4 ----
 test/avtest.c                      | 4 ----
 test/bdaddr.c                      | 4 ----
 test/gaptest.c                     | 4 ----
 test/hciemu.c                      | 4 ----
 test/hstest.c                      | 4 ----
 test/l2test.c                      | 4 ----
 test/lmptest.c                     | 4 ----
 test/mpris-player.c                | 4 ----
 test/rctest.c                      | 4 ----
 test/scotest.c                     | 4 ----
 test/sdptest.c                     | 4 ----
 test/test-textfile.c               | 4 ----
 tools/avinfo.c                     | 4 ----
 tools/bccmd.c                      | 4 ----
 tools/btattach.c                   | 4 ----
 tools/btmgmt.c                     | 4 ----
 tools/btsnoop.c                    | 4 ----
 tools/ciptool.c                    | 4 ----
 tools/csr.c                        | 4 ----
 tools/csr_3wire.c                  | 4 ----
 tools/csr_bcsp.c                   | 4 ----
 tools/csr_h4.c                     | 4 ----
 tools/csr_hci.c                    | 4 ----
 tools/csr_usb.c                    | 4 ----
 tools/dfu.c                        | 4 ----
 tools/dfutool.c                    | 4 ----
 tools/hciattach.c                  | 4 ----
 tools/hciattach_ath3k.c            | 4 ----
 tools/hciattach_intel.c            | 4 ----
 tools/hciattach_qualcomm.c         | 4 ----
 tools/hciattach_st.c               | 4 ----
 tools/hciattach_ti.c               | 4 ----
 tools/hciattach_tialt.c            | 4 ----
 tools/hciconfig.c                  | 4 ----
 tools/hcieventmask.c               | 4 ----
 tools/hcisecfilter.c               | 4 ----
 tools/hcitool.c                    | 4 ----
 tools/hid2hci.c                    | 4 ----
 tools/l2ping.c                     | 4 ----
 tools/rfcomm.c                     | 4 ----
 tools/sdptool.c                    | 4 ----
 tools/ubcsp.c                      | 4 ----
 unit/test-eir.c                    | 4 ----
 162 files changed, 3 insertions(+), 646 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index e95ba1a..3be058b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -345,8 +345,9 @@ EXTRA_DIST += doc/manager-api.txt \
 
 AM_CFLAGS += @DBUS_CFLAGS@ @GLIB_CFLAGS@
 
-AM_CPPFLAGS = -I$(builddir)/lib -I$(builddir)/src -I$(srcdir)/src \
-			-I$(srcdir)/gdbus -I$(srcdir)/btio
+AM_CPPFLAGS = -include $(top_builddir)/config.h -I$(builddir)/lib \
+		-I$(builddir)/src -I$(srcdir)/src -I$(srcdir)/gdbus \
+		-I$(srcdir)/btio
 
 if MCAP
 AM_CPPFLAGS += -I$(builddir)/health
diff --git a/attrib/client.c b/attrib/client.c
index 51c2b83..44a6730 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -23,10 +23,6 @@
  */
 
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 #include <stdlib.h>
 #include <stdbool.h>
diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index e8788d9..80e76eb 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <glib.h>
 #include <bluetooth/uuid.h>
 #include <bluetooth/sdp.h>
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 38c050e..cfa3c53 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdint.h>
 #include <stdlib.h>
 #include <glib.h>
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 2fe95c0..dcfc856 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 #include <glib.h>
 #include <stdlib.h>
diff --git a/emulator/b1ee.c b/emulator/b1ee.c
index 17a60fc..18b827e 100644
--- a/emulator/b1ee.c
+++ b/emulator/b1ee.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/emulator/btdev.c b/emulator/btdev.c
index 700c6a8..bd158ee 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <ctype.h>
 #include <stdlib.h>
diff --git a/emulator/main.c b/emulator/main.c
index 807c663..4124702 100644
--- a/emulator/main.c
+++ b/emulator/main.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <getopt.h>
diff --git a/emulator/server.c b/emulator/server.c
index e4c4570..ea8fa21 100644
--- a/emulator/server.c
+++ b/emulator/server.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <ctype.h>
diff --git a/emulator/vhci.c b/emulator/vhci.c
index 52876ba..0062beb 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index d9360dc..42075a4 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -23,10 +23,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <ctype.h>
diff --git a/lib/hci.c b/lib/hci.c
index 66b2d5f..ba5f582 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -23,10 +23,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/lib/sdp.c b/lib/sdp.c
index dbffec0..1cee8dc 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -24,10 +24,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/lib/uuid.c b/lib/uuid.c
index 4363aee..0035c6c 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
diff --git a/monitor/btsnoop.c b/monitor/btsnoop.c
index 04a6dff..e8de179 100644
--- a/monitor/btsnoop.c
+++ b/monitor/btsnoop.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/monitor/control.c b/monitor/control.c
index 3447b7a..160ce4c 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/monitor/display.c b/monitor/display.c
index 7b6fc98..48c3bac 100644
--- a/monitor/display.c
+++ b/monitor/display.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/monitor/hcidump.c b/monitor/hcidump.c
index e69bcb1..f57ba81 100644
--- a/monitor/hcidump.c
+++ b/monitor/hcidump.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index e982bdd..db62b05 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <inttypes.h>
diff --git a/monitor/main.c b/monitor/main.c
index 27a5722..5a0229e 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <ctype.h>
 #include <stdlib.h>
diff --git a/monitor/mainloop.c b/monitor/mainloop.c
index 1cc787e..99f156c 100644
--- a/monitor/mainloop.c
+++ b/monitor/mainloop.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/monitor/packet.c b/monitor/packet.c
index 6bbdb43..8a80c19 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <ctype.h>
diff --git a/monitor/sdp.c b/monitor/sdp.c
index 45ee59b..5cdf47d 100644
--- a/monitor/sdp.c
+++ b/monitor/sdp.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/monitor/uuid.c b/monitor/uuid.c
index c348e17..ca79b68 100644
--- a/monitor/uuid.c
+++ b/monitor/uuid.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include "uuid.h"
 
 static struct {
diff --git a/plugins/adaptername.c b/plugins/adaptername.c
index 179152f..fbb9470 100644
--- a/plugins/adaptername.c
+++ b/plugins/adaptername.c
@@ -25,10 +25,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdlib.h>
 #include <stdbool.h>
 #include <unistd.h>
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 9dfca46..95e52f9 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -23,10 +23,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdbool.h>
 
 #include <errno.h>
diff --git a/plugins/external-dummy.c b/plugins/external-dummy.c
index ff31290..86e0ae9 100644
--- a/plugins/external-dummy.c
+++ b/plugins/external-dummy.c
@@ -18,10 +18,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include "plugin.h"
 #include "log.h"
 
diff --git a/plugins/formfactor.c b/plugins/formfactor.c
index 1978f03..c72fb8a 100644
--- a/plugins/formfactor.c
+++ b/plugins/formfactor.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdlib.h>
 #include <errno.h>
 
diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index de090e9..0d3ce6f 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <glib.h>
 #include <bluetooth/uuid.h>
 #include <errno.h>
diff --git a/plugins/neard.c b/plugins/neard.c
index 124b97a..842eabf 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 #include <gdbus.h>
 
diff --git a/plugins/service.c b/plugins/service.c
index ba7a693..d7c9b29 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/plugins/storage.c b/plugins/storage.c
index 04a02c7..e5a0a7c 100644
--- a/plugins/storage.c
+++ b/plugins/storage.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <bluetooth/bluetooth.h>
 
 #include "plugin.h"
diff --git a/plugins/wiimote.c b/plugins/wiimote.c
index 90d6d7b..319d08c 100644
--- a/plugins/wiimote.c
+++ b/plugins/wiimote.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdbool.h>
 
 #include <bluetooth/bluetooth.h>
diff --git a/profiles/alert/main.c b/profiles/alert/main.c
index b9df0d4..70595f5 100644
--- a/profiles/alert/main.c
+++ b/profiles/alert/main.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdint.h>
 #include <glib.h>
 #include <errno.h>
diff --git a/profiles/alert/manager.c b/profiles/alert/manager.c
index eb2d627..1a655f0 100644
--- a/profiles/alert/manager.c
+++ b/profiles/alert/manager.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include "manager.h"
 #include "server.h"
 
diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 1c92906..60d0108 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdbool.h>
 #include <errno.h>
 #include <gdbus.h>
diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 177f653..ffdcec6 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -23,10 +23,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdlib.h>
 #include <errno.h>
 
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index dcffb05..ee19ae5 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -23,10 +23,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdlib.h>
 #include <stdint.h>
 #include <stdbool.h>
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index e38c95b..86b4644 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdlib.h>
 #include <stdio.h>
 #include <stdint.h>
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 2517df8..c69652f 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -23,10 +23,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdlib.h>
 #include <stdint.h>
 #include <stdbool.h>
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 7299b7e..489ad07 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -23,10 +23,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdlib.h>
 #include <stdint.h>
 #include <errno.h>
diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index fef2bea..c111262 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/profiles/audio/main.c b/profiles/audio/main.c
index ce060fc..c7aa1c5 100644
--- a/profiles/audio/main.c
+++ b/profiles/audio/main.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 #include <sys/socket.h>
 #include <unistd.h>
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 714489a..85c11ea 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdarg.h>
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 2041d23..2ac7d7d 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -23,10 +23,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 
 #include <bluetooth/uuid.h>
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 34b1f20..460fb5a 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdlib.h>
 #include <stdint.h>
 #include <stdbool.h>
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 466c0a8..3ea143b 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdint.h>
 #include <stdbool.h>
 #include <errno.h>
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 157a4e8..e01e618 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -23,10 +23,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdint.h>
 #include <stdbool.h>
 #include <errno.h>
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 610aca3..79355ce 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 
 #include <bluetooth/uuid.h>
diff --git a/profiles/cups/hcrp.c b/profiles/cups/hcrp.c
index a93dda0..4af47a9 100644
--- a/profiles/cups/hcrp.c
+++ b/profiles/cups/hcrp.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/profiles/cups/main.c b/profiles/cups/main.c
index 5aa927f..7c06efe 100644
--- a/profiles/cups/main.c
+++ b/profiles/cups/main.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/profiles/cups/sdp.c b/profiles/cups/sdp.c
index c7f17a4..203577b 100644
--- a/profiles/cups/sdp.c
+++ b/profiles/cups/sdp.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/profiles/cups/spp.c b/profiles/cups/spp.c
index d906ed2..fba9632 100644
--- a/profiles/cups/spp.c
+++ b/profiles/cups/spp.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index da27df8..e2daab5 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -20,10 +20,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdbool.h>
 
 #include <glib.h>
diff --git a/profiles/deviceinfo/main.c b/profiles/deviceinfo/main.c
index 3884579..d67e58b 100644
--- a/profiles/deviceinfo/main.c
+++ b/profiles/deviceinfo/main.c
@@ -20,10 +20,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <glib.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index e6cddad..78b6ff1 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -20,10 +20,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdbool.h>
 #include <stdlib.h>
 #include <sys/types.h>
diff --git a/profiles/gatt/main.c b/profiles/gatt/main.c
index ecd4455..6b90dc2 100644
--- a/profiles/gatt/main.c
+++ b/profiles/gatt/main.c
@@ -20,10 +20,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdint.h>
 #include <glib.h>
 #include <errno.h>
diff --git a/profiles/health/hdp_main.c b/profiles/health/hdp_main.c
index 1d38bea..96dc678 100644
--- a/profiles/health/hdp_main.c
+++ b/profiles/health/hdp_main.c
@@ -20,10 +20,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 
 #include <gdbus.h>
diff --git a/profiles/health/hdp_manager.c b/profiles/health/hdp_manager.c
index 7b799f4..c182852 100644
--- a/profiles/health/hdp_manager.c
+++ b/profiles/health/hdp_manager.c
@@ -20,10 +20,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdbool.h>
 
 #include <bluetooth/sdp.h>
diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 1fd33e5..714117c 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -20,10 +20,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdint.h>
 #include <stdbool.h>
 
diff --git a/profiles/health/mcap_sync.c b/profiles/health/mcap_sync.c
index 6d8d66b..0e21877 100644
--- a/profiles/health/mcap_sync.c
+++ b/profiles/health/mcap_sync.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdint.h>
 #include <netinet/in.h>
 #include <time.h>
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 535d55b..ab61b87 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -20,10 +20,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <gdbus.h>
 #include <errno.h>
 #include <stdbool.h>
diff --git a/profiles/heartrate/main.c b/profiles/heartrate/main.c
index 80a6ba4..23337c4 100644
--- a/profiles/heartrate/main.c
+++ b/profiles/heartrate/main.c
@@ -20,10 +20,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdint.h>
 #include <glib.h>
 #include <errno.h>
diff --git a/profiles/input/device.c b/profiles/input/device.c
index d713ebe..d512f48 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdlib.h>
 #include <stdbool.h>
 #include <errno.h>
diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index a873eac..1e06c79 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -23,10 +23,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdlib.h>
 #include <stdbool.h>
 #include <errno.h>
diff --git a/profiles/input/hog_manager.c b/profiles/input/hog_manager.c
index 595b160..d16bf5f 100644
--- a/profiles/input/hog_manager.c
+++ b/profiles/input/hog_manager.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 #include <stdbool.h>
 
diff --git a/profiles/input/main.c b/profiles/input/main.c
index 4ddc511..3595b0b 100644
--- a/profiles/input/main.c
+++ b/profiles/input/main.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 
 #include <bluetooth/bluetooth.h>
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index b8e89c3..2b1b38c 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 #include <stdbool.h>
 
diff --git a/profiles/input/server.c b/profiles/input/server.c
index eaf3b6a..4f8cc90 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <unistd.h>
 #include <stdbool.h>
 #include <errno.h>
diff --git a/profiles/input/suspend-dummy.c b/profiles/input/suspend-dummy.c
index b43946d..d76fac5 100644
--- a/profiles/input/suspend-dummy.c
+++ b/profiles/input/suspend-dummy.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/profiles/network/common.c b/profiles/network/common.c
index 34ab788..107d58d 100644
--- a/profiles/network/common.c
+++ b/profiles/network/common.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 3203848..b97c151 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <stdbool.h>
 #include <errno.h>
diff --git a/profiles/network/main.c b/profiles/network/main.c
index 8ec1f3f..c8f9ea0 100644
--- a/profiles/network/main.c
+++ b/profiles/network/main.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 
 #include <gdbus.h>
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 06ef9fc..d3da540 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdbool.h>
 
 #include <bluetooth/bluetooth.h>
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 7e5e653..153ec08 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <unistd.h>
 #include <stdlib.h>
diff --git a/profiles/proximity/immalert.c b/profiles/proximity/immalert.c
index 8deecb3..8ea37b6 100644
--- a/profiles/proximity/immalert.c
+++ b/profiles/proximity/immalert.c
@@ -20,10 +20,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdbool.h>
 
 #include <glib.h>
diff --git a/profiles/proximity/linkloss.c b/profiles/proximity/linkloss.c
index 30e4ca8..a325ef1 100644
--- a/profiles/proximity/linkloss.c
+++ b/profiles/proximity/linkloss.c
@@ -20,10 +20,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdbool.h>
 
 #include <glib.h>
diff --git a/profiles/proximity/main.c b/profiles/proximity/main.c
index 1e627a3..93f4a1c 100644
--- a/profiles/proximity/main.c
+++ b/profiles/proximity/main.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 #include <stdint.h>
 #include <glib.h>
diff --git a/profiles/proximity/manager.c b/profiles/proximity/manager.c
index fb34e8f..9190b63 100644
--- a/profiles/proximity/manager.c
+++ b/profiles/proximity/manager.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdbool.h>
 
 #include <glib.h>
diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index 58c0ed6..9868fce 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 #include <fcntl.h>
 #include <gdbus.h>
diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index 17a084a..c279062 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdbool.h>
 #include <errno.h>
 
diff --git a/profiles/sap/main.c b/profiles/sap/main.c
index 4894f2e..c5df5a1 100644
--- a/profiles/sap/main.c
+++ b/profiles/sap/main.c
@@ -18,10 +18,6 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 #include <gdbus.h>
 #include "plugin.h"
diff --git a/profiles/sap/manager.c b/profiles/sap/manager.c
index fddd7aa..36fdb6c 100644
--- a/profiles/sap/manager.c
+++ b/profiles/sap/manager.c
@@ -18,10 +18,6 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdbool.h>
 
 #include "log.h"
diff --git a/profiles/sap/sap-dummy.c b/profiles/sap/sap-dummy.c
index 36354b8..a3e08bb 100644
--- a/profiles/sap/sap-dummy.c
+++ b/profiles/sap/sap-dummy.c
@@ -22,10 +22,6 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <glib.h>
 #include <gdbus.h>
 #include <stdint.h>
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index bb37c18..24441d1 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -24,10 +24,6 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 #include <glib.h>
 #include <bluetooth/sdp.h>
diff --git a/profiles/scanparam/main.c b/profiles/scanparam/main.c
index 74e8a55..5099666 100644
--- a/profiles/scanparam/main.c
+++ b/profiles/scanparam/main.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 #include <stdint.h>
 #include <glib.h>
diff --git a/profiles/scanparam/manager.c b/profiles/scanparam/manager.c
index cea2b29..8acade1 100644
--- a/profiles/scanparam/manager.c
+++ b/profiles/scanparam/manager.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdbool.h>
 #include <errno.h>
 #include <glib.h>
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 849336e..49f1eda 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdbool.h>
 
 #include <bluetooth/bluetooth.h>
diff --git a/profiles/thermometer/main.c b/profiles/thermometer/main.c
index 6c1c40c..bf2b54c 100644
--- a/profiles/thermometer/main.c
+++ b/profiles/thermometer/main.c
@@ -20,10 +20,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdint.h>
 #include <glib.h>
 #include <errno.h>
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 9c497c9..6fb0d03 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -20,10 +20,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdbool.h>
 #include <errno.h>
 
diff --git a/profiles/time/main.c b/profiles/time/main.c
index 08abed2..3cbecd1 100644
--- a/profiles/time/main.c
+++ b/profiles/time/main.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdint.h>
 #include <glib.h>
 #include <errno.h>
diff --git a/profiles/time/manager.c b/profiles/time/manager.c
index 608a807..fec9084 100644
--- a/profiles/time/manager.c
+++ b/profiles/time/manager.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdbool.h>
 
 #include "manager.h"
diff --git a/profiles/time/server.c b/profiles/time/server.c
index 0a17b83..c6405b1 100644
--- a/profiles/time/server.c
+++ b/profiles/time/server.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <glib.h>
 #include <time.h>
 #include <errno.h>
diff --git a/src/adapter.c b/src/adapter.c
index ae229b0..b387a9f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/src/agent.c b/src/agent.c
index e206c56..5c667f4 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 1a9bd69..5cd5460 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 #include <stdint.h>
 #include <stdbool.h>
diff --git a/src/dbus-common.c b/src/dbus-common.c
index afd07de..3c73e32 100644
--- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -23,10 +23,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <stdint.h>
 
diff --git a/src/device.c b/src/device.c
index 254aa77..8b215b8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/src/eir.c b/src/eir.c
index 5162b85..c9bcd1c 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 #include <ctype.h>
 #include <stdlib.h>
diff --git a/src/error.c b/src/error.c
index c2d9baa..c5747c0 100644
--- a/src/error.c
+++ b/src/error.c
@@ -23,10 +23,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <gdbus.h>
 
 #include "error.h"
diff --git a/src/glib-helper.c b/src/glib-helper.c
index fe5713a..9647ef2 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdlib.h>
 #include <errno.h>
 
diff --git a/src/log.c b/src/log.c
index 75a98a9..14090ad 100644
--- a/src/log.c
+++ b/src/log.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <stdarg.h>
 #include <syslog.h>
diff --git a/src/main.c b/src/main.c
index bc53a8e..90cd326 100644
--- a/src/main.c
+++ b/src/main.c
@@ -23,10 +23,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 #include <stdio.h>
 #include <unistd.h>
diff --git a/src/manager.c b/src/manager.c
index 3088dd9..8711d39 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdlib.h>
 #include <stdio.h>
 #include <stdbool.h>
diff --git a/src/mgmt.c b/src/mgmt.c
index 2dc8a16..8ae6dae 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/src/oui.c b/src/oui.c
index 80bb3d3..b239231 100644
--- a/src/oui.c
+++ b/src/oui.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/src/plugin.c b/src/plugin.c
index 2a86e68..d576207 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 #include <dlfcn.h>
 #include <string.h>
diff --git a/src/profile.c b/src/profile.c
index a085ab2..755c387 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdlib.h>
diff --git a/src/rfkill.c b/src/rfkill.c
index f82596b..4c4c62c 100644
--- a/src/rfkill.c
+++ b/src/rfkill.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 #include <stdio.h>
 #include <fcntl.h>
diff --git a/src/sdp-client.c b/src/sdp-client.c
index 55e59c2..d378446 100644
--- a/src/sdp-client.c
+++ b/src/sdp-client.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <errno.h>
 
 #include <bluetooth/bluetooth.h>
diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index 7d5f626..a3615e3 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <ctype.h>
diff --git a/src/sdpd-database.c b/src/sdpd-database.c
index dd492bf..0abdb90 100644
--- a/src/sdpd-database.c
+++ b/src/sdpd-database.c
@@ -24,10 +24,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 2af743e..8f9f1cc 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -24,10 +24,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index 1d9509e..979c193 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -24,10 +24,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index b43ddc2..570ab56 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -24,10 +24,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
diff --git a/src/storage.c b/src/storage.c
index ac66021..090df92 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <ctype.h>
diff --git a/src/textfile.c b/src/textfile.c
index b6a7e1f..167bc97 100644
--- a/src/textfile.c
+++ b/src/textfile.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <ctype.h>
diff --git a/test/agent.c b/test/agent.c
index 5cdeeb4..0e7048c 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/test/attest.c b/test/attest.c
index 12ba682..c74df9a 100644
--- a/test/attest.c
+++ b/test/attest.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/test/avtest.c b/test/avtest.c
index 541b3cd..85e5aae 100644
--- a/test/avtest.c
+++ b/test/avtest.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/test/bdaddr.c b/test/bdaddr.c
index f87fa38..062ebc6 100644
--- a/test/bdaddr.c
+++ b/test/bdaddr.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
diff --git a/test/gaptest.c b/test/gaptest.c
index a0541b1..175c9d8 100644
--- a/test/gaptest.c
+++ b/test/gaptest.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
diff --git a/test/hciemu.c b/test/hciemu.c
index a125cf4..61ad0bd 100644
--- a/test/hciemu.c
+++ b/test/hciemu.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/test/hstest.c b/test/hstest.c
index ac68059..edf6f89 100644
--- a/test/hstest.c
+++ b/test/hstest.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/test/l2test.c b/test/l2test.c
index 7645681..c5b6efe 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -23,10 +23,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <ctype.h>
diff --git a/test/lmptest.c b/test/lmptest.c
index 549ae12..81d0bee 100644
--- a/test/lmptest.c
+++ b/test/lmptest.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
diff --git a/test/mpris-player.c b/test/mpris-player.c
index 7985cdd..86ddca5 100644
--- a/test/mpris-player.c
+++ b/test/mpris-player.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/test/rctest.c b/test/rctest.c
index de38bd0..417cb3f 100644
--- a/test/rctest.c
+++ b/test/rctest.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <ctype.h>
diff --git a/test/scotest.c b/test/scotest.c
index a40e395..89dd771 100644
--- a/test/scotest.c
+++ b/test/scotest.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <ctype.h>
diff --git a/test/sdptest.c b/test/sdptest.c
index 480a468..f05cd65 100644
--- a/test/sdptest.c
+++ b/test/sdptest.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
diff --git a/test/test-textfile.c b/test/test-textfile.c
index e0a0c5b..b30e355 100644
--- a/test/test-textfile.c
+++ b/test/test-textfile.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/avinfo.c b/tools/avinfo.c
index d237742..55dd9b4 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <ctype.h>
diff --git a/tools/bccmd.c b/tools/bccmd.c
index 952bf13..3aa6112 100644
--- a/tools/bccmd.c
+++ b/tools/bccmd.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
diff --git a/tools/btattach.c b/tools/btattach.c
index a69c49e..5de97b6 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index ff6a46a..cd1ff4b 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -19,10 +19,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
diff --git a/tools/btsnoop.c b/tools/btsnoop.c
index dcb4a26..ad7d785 100644
--- a/tools/btsnoop.c
+++ b/tools/btsnoop.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/ciptool.c b/tools/ciptool.c
index e240f38..5e38407 100644
--- a/tools/ciptool.c
+++ b/tools/ciptool.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
diff --git a/tools/csr.c b/tools/csr.c
index b4ea1fb..5851ace 100644
--- a/tools/csr.c
+++ b/tools/csr.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/csr_3wire.c b/tools/csr_3wire.c
index 33fcf38..7537e6b 100644
--- a/tools/csr_3wire.c
+++ b/tools/csr_3wire.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/tools/csr_bcsp.c b/tools/csr_bcsp.c
index f7afe53..d69808f 100644
--- a/tools/csr_bcsp.c
+++ b/tools/csr_bcsp.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/csr_h4.c b/tools/csr_h4.c
index 3371770..796dac4 100644
--- a/tools/csr_h4.c
+++ b/tools/csr_h4.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/csr_hci.c b/tools/csr_hci.c
index 6bd37c3..78ef758 100644
--- a/tools/csr_hci.c
+++ b/tools/csr_hci.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
diff --git a/tools/csr_usb.c b/tools/csr_usb.c
index 19903b0..c4f6614 100644
--- a/tools/csr_usb.c
+++ b/tools/csr_usb.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
diff --git a/tools/dfu.c b/tools/dfu.c
index 39ec088..47d8251 100644
--- a/tools/dfu.c
+++ b/tools/dfu.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
diff --git a/tools/dfutool.c b/tools/dfutool.c
index 16dd62e..260684d 100644
--- a/tools/dfutool.c
+++ b/tools/dfutool.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <ctype.h>
diff --git a/tools/hciattach.c b/tools/hciattach.c
index e1e80af..34aaf80 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -23,10 +23,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/hciattach_ath3k.c b/tools/hciattach_ath3k.c
index 23208c6..4dd6036 100644
--- a/tools/hciattach_ath3k.c
+++ b/tools/hciattach_ath3k.c
@@ -17,10 +17,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/tools/hciattach_intel.c b/tools/hciattach_intel.c
index 749098e..9bca0d4 100644
--- a/tools/hciattach_intel.c
+++ b/tools/hciattach_intel.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/tools/hciattach_qualcomm.c b/tools/hciattach_qualcomm.c
index 0e02e1e..b5a2d89 100644
--- a/tools/hciattach_qualcomm.c
+++ b/tools/hciattach_qualcomm.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/hciattach_st.c b/tools/hciattach_st.c
index dbb7c47..7b25760 100644
--- a/tools/hciattach_st.c
+++ b/tools/hciattach_st.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/hciattach_ti.c b/tools/hciattach_ti.c
index b57c6b7..9db26c8 100644
--- a/tools/hciattach_ti.c
+++ b/tools/hciattach_ti.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/tools/hciattach_tialt.c b/tools/hciattach_tialt.c
index c3caa49..18a304c 100644
--- a/tools/hciattach_tialt.c
+++ b/tools/hciattach_tialt.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 045e9a8..b0a4f3b 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -23,10 +23,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <ctype.h>
diff --git a/tools/hcieventmask.c b/tools/hcieventmask.c
index 87beac9..e556c1b 100644
--- a/tools/hcieventmask.c
+++ b/tools/hcieventmask.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
diff --git a/tools/hcisecfilter.c b/tools/hcisecfilter.c
index 9ad4ce0..97f0691 100644
--- a/tools/hcisecfilter.c
+++ b/tools/hcisecfilter.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <sys/socket.h>
 
diff --git a/tools/hcitool.c b/tools/hcitool.c
index a05e31f..9b541a3 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -23,10 +23,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <ctype.h>
diff --git a/tools/hid2hci.c b/tools/hid2hci.c
index e3a5b2e..fe27d29 100644
--- a/tools/hid2hci.c
+++ b/tools/hid2hci.c
@@ -22,10 +22,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/l2ping.c b/tools/l2ping.c
index 29fb3d0..8d35fd9 100644
--- a/tools/l2ping.c
+++ b/tools/l2ping.c
@@ -23,10 +23,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/tools/rfcomm.c b/tools/rfcomm.c
index affdbc7..984ea3e 100644
--- a/tools/rfcomm.c
+++ b/tools/rfcomm.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/sdptool.c b/tools/sdptool.c
index a55df50..18c062c 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -25,10 +25,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <stdio.h>
 #include <errno.h>
 #include <ctype.h>
diff --git a/tools/ubcsp.c b/tools/ubcsp.c
index b3f883a..6bba7e2 100644
--- a/tools/ubcsp.c
+++ b/tools/ubcsp.c
@@ -26,10 +26,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 /*****************************************************************************/
 /*****************************************************************************/
 /*****************************************************************************/
diff --git a/unit/test-eir.c b/unit/test-eir.c
index cefcacd..90aebbf 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -21,10 +21,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
 #include <check.h>
 
 #include <stdint.h>
-- 
1.8.0.1

