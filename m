Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 19/26] proximity: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:49 -0300
Message-Id: <1368073016-28434-19-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

guint -> unsigned int
guint8 -> uint8_t
guint16 -> uint16_t
guint32 -> uint32_t
guint64 -> uint64_t

Add "#include <inttypes.h>" where appropriate.
---
 profiles/proximity/immalert.c |  3 ++-
 profiles/proximity/linkloss.c |  5 +++--
 profiles/proximity/main.c     |  2 +-
 profiles/proximity/monitor.c  | 16 ++++++++--------
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/profiles/proximity/immalert.c b/profiles/proximity/immalert.c
index 06e8eb8..60487c6 100644
--- a/profiles/proximity/immalert.c
+++ b/profiles/proximity/immalert.c
@@ -24,6 +24,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdbool.h>
 
 #include <glib.h>
@@ -56,7 +57,7 @@ struct connected_device {
 	struct btd_device *device;
 	struct imm_alert_adapter *adapter;
 	uint8_t alert_level;
-	guint callback_id;
+	unsigned int callback_id;
 };
 
 static GSList *imm_alert_adapters;
diff --git a/profiles/proximity/linkloss.c b/profiles/proximity/linkloss.c
index cb87b12..b4cf8d3 100644
--- a/profiles/proximity/linkloss.c
+++ b/profiles/proximity/linkloss.c
@@ -24,6 +24,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdbool.h>
 
 #include <glib.h>
@@ -57,8 +58,8 @@ struct connected_device {
 	struct btd_device *device;
 	struct link_loss_adapter *adapter;
 	uint8_t alert_level;
-	guint callback_id;
-	guint local_disc_id;
+	unsigned int callback_id;
+	unsigned int local_disc_id;
 };
 
 static GSList *link_loss_adapters;
diff --git a/profiles/proximity/main.c b/profiles/proximity/main.c
index 46468d2..f6ed629 100644
--- a/profiles/proximity/main.c
+++ b/profiles/proximity/main.c
@@ -27,7 +27,7 @@
 #endif
 
 #include <errno.h>
-#include <stdint.h>
+#include <inttypes.h>
 #include <glib.h>
 #include <gdbus/gdbus.h>
 
diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index eaa5b0d..a084475 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -29,7 +29,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <gdbus/gdbus.h>
-#include <stdint.h>
+#include <inttypes.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -80,8 +80,8 @@ struct monitor {
 					 * Value Handle */
 	uint16_t txpowerhandle;		/* Tx Characteristic Value Handle */
 	uint16_t immediatehandle;	/* Immediate Alert Value Handle */
-	guint immediateto;		/* Reset Immediate Alert to "none" */
-	guint attioid;
+	unsigned int immediateto;	/* Reset Immediate Alert to "none" */
+	unsigned int attioid;
 };
 
 static GSList *monitors = NULL;
@@ -166,7 +166,7 @@ static uint8_t str2level(const char *level)
 	return ALERT_NONE;
 }
 
-static void linkloss_written(guint8 status, const guint8 *pdu, guint16 plen,
+static void linkloss_written(uint8_t status, const uint8_t *pdu, uint16_t plen,
 							gpointer user_data)
 {
 	struct monitor *monitor = user_data;
@@ -190,7 +190,7 @@ static void linkloss_written(guint8 status, const guint8 *pdu, guint16 plen,
 				PROXIMITY_INTERFACE, "LinkLossAlertLevel");
 }
 
-static void char_discovered_cb(GSList *characteristics, guint8 status,
+static void char_discovered_cb(GSList *characteristics, uint8_t status,
 							gpointer user_data)
 {
 	struct monitor *monitor = user_data;
@@ -234,7 +234,7 @@ static int write_alert_level(struct monitor *monitor)
 	return 0;
 }
 
-static void tx_power_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
+static void tx_power_read_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
 							gpointer user_data)
 {
 	uint8_t value[TX_POWER_SIZE];
@@ -259,7 +259,7 @@ static void tx_power_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	DBG("Tx Power Level: %02x", (int8_t) value[0]);
 }
 
-static void tx_power_handle_cb(GSList *characteristics, guint8 status,
+static void tx_power_handle_cb(GSList *characteristics, uint8_t status,
 							gpointer user_data)
 {
 	struct monitor *monitor = user_data;
@@ -346,7 +346,7 @@ static void write_immediate_alert(struct monitor *monitor)
 						immediate_written, monitor);
 }
 
-static void immediate_handle_cb(GSList *characteristics, guint8 status,
+static void immediate_handle_cb(GSList *characteristics, uint8_t status,
 							gpointer user_data)
 {
 	struct monitor *monitor = user_data;
-- 
1.8.2.2

