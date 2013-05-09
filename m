Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 17/26] input: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:47 -0300
Message-Id: <1368073016-28434-17-git-send-email-lucas.demarchi@profusion.mobi>
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
 profiles/input/device.c        | 11 +++++-----
 profiles/input/hog.c           | 48 ++++++++++++++++++++++--------------------
 profiles/input/server.c        |  3 ++-
 profiles/input/suspend-dummy.c |  3 ++-
 4 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 498c226..ef209d2 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdlib.h>
 #include <stdbool.h>
 #include <errno.h>
@@ -72,15 +73,15 @@ struct input_device {
 	uint32_t		handle;
 	GIOChannel		*ctrl_io;
 	GIOChannel		*intr_io;
-	guint			ctrl_watch;
-	guint			intr_watch;
-	guint			sec_watch;
+	unsigned int			ctrl_watch;
+	unsigned int			intr_watch;
+	unsigned int			sec_watch;
 	struct hidp_connadd_req *req;
-	guint			dc_id;
+	unsigned int			dc_id;
 	bool			disable_sdp;
 	char			*name;
 	enum reconnect_mode_t	reconnect_mode;
-	guint			reconnect_timer;
+	unsigned int			reconnect_timer;
 	uint32_t		reconnect_attempt;
 };
 
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 3ce9480..4d9f7b9 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -27,6 +27,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdlib.h>
 #include <stdbool.h>
 #include <errno.h>
@@ -79,12 +80,12 @@ struct hog_device {
 	uint16_t		id;
 	struct btd_device	*device;
 	GAttrib			*attrib;
-	guint			attioid;
+	unsigned int			attioid;
 	struct gatt_primary	*hog_primary;
 	GSList			*reports;
 	int			uhid_fd;
 	gboolean		has_report_id;
-	guint			uhid_watch_id;
+	unsigned int			uhid_watch_id;
 	uint16_t		bcdhid;
 	uint8_t			bcountrycode;
 	uint16_t		proto_mode_handle;
@@ -95,7 +96,7 @@ struct hog_device {
 struct report {
 	uint8_t			id;
 	uint8_t			type;
-	guint			notifyid;
+	unsigned int			notifyid;
 	struct gatt_char	*decl;
 	struct hog_device	*hogdev;
 };
@@ -142,8 +143,8 @@ static void report_value_cb(const uint8_t *pdu, uint16_t len,
 						hogdev->id, hogdev->uhid_fd);
 }
 
-static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void report_ccc_written_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t plen, gpointer user_data)
 {
 	struct report *report = user_data;
 	struct hog_device *hogdev = report->hogdev;
@@ -172,8 +173,8 @@ static void write_ccc(uint16_t handle, gpointer user_data)
 					report_ccc_written_cb, report);
 }
 
-static void report_reference_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void report_reference_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t plen, gpointer user_data)
 {
 	struct report *report = user_data;
 
@@ -193,12 +194,12 @@ static void report_reference_cb(guint8 status, const guint8 *pdu,
 	DBG("Report ID: 0x%02x Report type: 0x%02x", pdu[1], pdu[2]);
 }
 
-static void external_report_reference_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data);
+static void external_report_reference_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t plen, gpointer user_data);
 
 
-static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
-					guint16 len, gpointer user_data)
+static void discover_descriptor_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t len, gpointer user_data)
 {
 	struct disc_desc_cb_data *ddcb_data = user_data;
 	struct report *report;
@@ -282,7 +283,7 @@ static void discover_descriptor(GAttrib *attrib, uint16_t start, uint16_t end,
 	gatt_find_info(attrib, start, end, discover_descriptor_cb, ddcb_data);
 }
 
-static void external_service_char_cb(GSList *chars, guint8 status,
+static void external_service_char_cb(GSList *chars, uint8_t status,
 							gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
@@ -316,8 +317,8 @@ static void external_service_char_cb(GSList *chars, guint8 status,
 	}
 }
 
-static void external_report_reference_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void external_report_reference_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t plen, gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
 	uint16_t uuid16;
@@ -342,8 +343,8 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 					external_service_char_cb, hogdev);
 }
 
-static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void report_map_read_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t plen, gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
 	uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
@@ -403,7 +404,7 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		error("Failed to create uHID device: %s", strerror(errno));
 }
 
-static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
+static void info_read_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
 							gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
@@ -430,8 +431,8 @@ static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 			hogdev->bcdhid, hogdev->bcountrycode, hogdev->flags);
 }
 
-static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void proto_mode_read_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t plen, gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
 	uint8_t value;
@@ -462,7 +463,8 @@ static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 								hogdev->id);
 }
 
-static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
+static void char_discovered_cb(GSList *chars, uint8_t status,
+							gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
 	struct gatt_primary *prim = hogdev->hog_primary;
@@ -530,8 +532,8 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 									hogdev);
 }
 
-static void output_written_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void output_written_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t plen, gpointer user_data)
 {
 	if (status != 0) {
 		error("Write output report failed: %s", att_ecode2str(status));
@@ -554,7 +556,7 @@ static void forward_report(struct hog_device *hogdev,
 	GSList *l;
 	void *data;
 	int size;
-	guint type;
+	unsigned int type;
 
 	if (hogdev->has_report_id) {
 		data = ev->u.output.data + 1;
diff --git a/profiles/input/server.c b/profiles/input/server.c
index 5c98573..6f37158 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <unistd.h>
 #include <stdbool.h>
 #include <errno.h>
@@ -154,7 +155,7 @@ static void confirm_event_cb(GIOChannel *chan, gpointer user_data)
 	bdaddr_t src, dst;
 	GError *err = NULL;
 	char addr[18];
-	guint ret;
+	unsigned int ret;
 
 	bt_io_get(chan, &err,
 			BT_IO_OPT_SOURCE_BDADDR, &src,
diff --git a/profiles/input/suspend-dummy.c b/profiles/input/suspend-dummy.c
index 75dd536..f815703 100644
--- a/profiles/input/suspend-dummy.c
+++ b/profiles/input/suspend-dummy.c
@@ -26,6 +26,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <errno.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -44,7 +45,7 @@
 
 static suspend_event suspend_cb = NULL;
 static resume_event resume_cb = NULL;
-static guint watch = 0;
+static unsigned int watch = 0;
 
 static int fifo_open(void);
 
-- 
1.8.2.2

