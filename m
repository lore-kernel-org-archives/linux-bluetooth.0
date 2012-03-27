Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: dh.herrmann@googlemail.com, chen.ganir@ti.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [RFC 3/8] HoG: enable report characteristic notification
Date: Tue, 27 Mar 2012 19:31:22 -0300
Message-Id: <1332887487-13601-4-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1332887487-13601-1-git-send-email-jprvita@openbossa.org>
References: <1332887487-13601-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: João Paulo Rechi Vita <jprvita@gmail.com>

---
 input/hog_device.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/input/hog_device.c b/input/hog_device.c
index 2228a76..80df978 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -31,6 +31,7 @@
 #include <unistd.h>
 
 #include <bluetooth/bluetooth.h>
+#include <bluetooth/uuid.h>
 
 #include <glib.h>
 
@@ -41,8 +42,10 @@
 
 #include "hog_device.h"
 
+#include "att.h"
 #include "gattrib.h"
 #include "attio.h"
+#include "gatt.h"
 
 struct hog_device {
 	char			*path;
@@ -53,11 +56,27 @@ struct hog_device {
 
 static GSList *devices = NULL;
 
+static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
+					guint16 plen, gpointer user_data)
+{
+	if (status != 0) {
+		error("Write report characteristic descriptor failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	DBG("Report characteristic descriptor written: notification enabled");
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
+	uint8_t value[] = { 0x01, 0x00 };
 
 	hogdev->attrib = g_attrib_ref(attrib);
+
+	gatt_write_char(hogdev->attrib, 0x000c, value, 2,
+						report_ccc_written_cb, hogdev);
 }
 
 static void attio_disconnected_cb(gpointer user_data)
-- 
1.7.7.6

