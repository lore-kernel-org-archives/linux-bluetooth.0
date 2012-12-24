Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Subject: [PATCH] Fix missing config.h includes
Date: Sun, 23 Dec 2012 21:32:30 -0300
Message-Id: <1356309150-22990-1-git-send-email-crrodriguez@opensuse.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.c                      | 4 ++++
 attrib/gattrib.c                  | 4 ++++
 attrib/interactive.c              | 5 +++++
 attrib/utils.c                    | 4 ++++
 btio/btio.c                       | 5 +++++
 obexd/plugins/phonebook-tracker.c | 4 ++++
 profiles/gatt/manager.c           | 4 ++++
 profiles/health/hdp.c             | 4 ++++
 profiles/health/mcap.c            | 4 ++++
 profiles/sap/sap-u8500.c          | 4 ++++
 tools/btiotest.c                  | 5 +++++
 tools/obex-client-tool.c          | 4 ++++
 unit/test-gobex-apparam.c         | 4 ++++
 unit/test-gobex-header.c          | 4 ++++
 unit/test-gobex-packet.c          | 4 ++++
 unit/test-gobex-transfer.c        | 4 ++++
 unit/test-gobex.c                 | 4 ++++
 unit/util.c                       | 4 ++++
 18 files changed, 75 insertions(+)

diff --git a/attrib/att.c b/attrib/att.c
index 0ed4178..de11811 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -22,6 +22,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <errno.h>
 #include <stdint.h>
 #include <stdlib.h>
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 0acefc8..bf40532 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -22,6 +22,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <stdint.h>
 #include <string.h>
 #include <glib.h>
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 1ea35cd..51f620a 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -20,6 +20,11 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
  */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
diff --git a/attrib/utils.c b/attrib/utils.c
index 08365bd..43244c2 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -21,6 +21,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <stdlib.h>
 #include <glib.h>
 
diff --git a/btio/btio.c b/btio/btio.c
index 44c2f9b..bbf1208 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -21,6 +21,11 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
  */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <stdarg.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/obexd/plugins/phonebook-tracker.c b/obexd/plugins/phonebook-tracker.c
index 2fd7ba1..433f95a 100644
--- a/obexd/plugins/phonebook-tracker.c
+++ b/obexd/plugins/phonebook-tracker.c
@@ -20,6 +20,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <string.h>
 #include <stdlib.h>
 #include <time.h>
diff --git a/profiles/gatt/manager.c b/profiles/gatt/manager.c
index ce0ed91..151d60f 100644
--- a/profiles/gatt/manager.c
+++ b/profiles/gatt/manager.c
@@ -20,6 +20,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <glib.h>
 #include <errno.h>
 #include <stdbool.h>
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index bf8f82f..e637420 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -20,6 +20,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <stdlib.h>
 #include <stdint.h>
 #include <stdbool.h>
diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index 466d266..f08a7fa 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -20,6 +20,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <netinet/in.h>
 #include <stdlib.h>
 #include <errno.h>
diff --git a/profiles/sap/sap-u8500.c b/profiles/sap/sap-u8500.c
index b1aee57..39169a0 100644
--- a/profiles/sap/sap-u8500.c
+++ b/profiles/sap/sap-u8500.c
@@ -22,6 +22,10 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <fcntl.h>
diff --git a/tools/btiotest.c b/tools/btiotest.c
index 4b170ac..7a77bb7 100644
--- a/tools/btiotest.c
+++ b/tools/btiotest.c
@@ -21,6 +21,11 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
  */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
diff --git a/tools/obex-client-tool.c b/tools/obex-client-tool.c
index 8488a20..b7220fa 100644
--- a/tools/obex-client-tool.c
+++ b/tools/obex-client-tool.c
@@ -19,6 +19,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <fcntl.h>
diff --git a/unit/test-gobex-apparam.c b/unit/test-gobex-apparam.c
index f232380..1c86274 100644
--- a/unit/test-gobex-apparam.c
+++ b/unit/test-gobex-apparam.c
@@ -19,6 +19,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <stdint.h>
 #include <string.h>
 
diff --git a/unit/test-gobex-header.c b/unit/test-gobex-header.c
index c933a01..2a198c6 100644
--- a/unit/test-gobex-header.c
+++ b/unit/test-gobex-header.c
@@ -19,6 +19,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <stdint.h>
 #include <string.h>
 
diff --git a/unit/test-gobex-packet.c b/unit/test-gobex-packet.c
index 39650f9..b40dc66 100644
--- a/unit/test-gobex-packet.c
+++ b/unit/test-gobex-packet.c
@@ -19,6 +19,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <stdint.h>
 #include <string.h>
 #include <errno.h>
diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index f013617..a8578fd 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -19,6 +19,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/socket.h>
diff --git a/unit/test-gobex.c b/unit/test-gobex.c
index 2075f4a..8beaa44 100644
--- a/unit/test-gobex.c
+++ b/unit/test-gobex.c
@@ -19,6 +19,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/socket.h>
diff --git a/unit/util.c b/unit/util.c
index a591ab1..c76acdf 100644
--- a/unit/util.c
+++ b/unit/util.c
@@ -19,6 +19,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <unistd.h>
-- 
1.8.0.2

