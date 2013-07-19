Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 03/11] attrib: Do not use Write Command in gatt_write_char()
Date: Fri, 19 Jul 2013 13:34:09 -0400
Message-Id: <1374255257-8753-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously, if no callback was given to gatt_write_char(), it was
assumed that a "Write Without Response" (which uses Write Command)
should be used instead of Write Request.

This "shortcut" is unnecessary (there is gatt_write_cmd() for the
situations where Write Without Response is required) and just duplicates
code.

This commit also fixes the few places where gatt_write_cmd() should be
used.
---
 attrib/gatt.c             |   22 ++++++++++------------
 attrib/interactive.c      |    2 +-
 profiles/input/hog.c      |    6 +++---
 profiles/scanparam/scan.c |    2 +-
 4 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index d21dd39..9de07e4 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -785,23 +785,21 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 {
 	uint8_t *buf;
 	size_t buflen;
-	guint16 plen;
 	struct write_long_data *long_write;
 
 	buf = g_attrib_get_buffer(attrib, &buflen);
 
-	/* Only use Write Request/Command if payload fits on a single transfer,
-	 * including 3 bytes for the header. */
+	/* Use Write Request if payload fits on a single transfer, including 3
+	 * bytes for the header. */
 	if (vlen <= buflen - 3) {
-		if (func)
-			plen = enc_write_req(handle, value, vlen, buf,
-								buflen);
-		else
-			plen = enc_write_cmd(handle, value, vlen, buf,
-								buflen);
-
-		return g_attrib_send(attrib, 0, buf, plen, func,
-							user_data, NULL);
+		uint16_t plen;
+
+		plen = enc_write_req(handle, value, vlen, buf, buflen);
+		if (plen == 0)
+			return 0;
+
+		return g_attrib_send(attrib, 0, buf, plen, func, user_data,
+									NULL);
 	}
 
 	/* Write Long Characteristic Values */
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 1f3122f..5bd27af 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -675,7 +675,7 @@ static void cmd_char_write(int argcp, char **argvp)
 		gatt_write_char(attrib, handle, value, plen,
 					char_write_req_cb, NULL);
 	else
-		gatt_write_char(attrib, handle, value, plen, NULL, NULL);
+		gatt_write_cmd(attrib, handle, value, plen, NULL, NULL);
 
 	g_free(value);
 }
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 6bbf35f..91c2802 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -456,7 +456,7 @@ static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		DBG("HoG device 0x%04X is operating in Boot Procotol Mode",
 								hogdev->id);
 
-		gatt_write_char(hogdev->attrib, hogdev->proto_mode_handle, &nval,
+		gatt_write_cmd(hogdev->attrib, hogdev->proto_mode_handle, &nval,
 						sizeof(nval), NULL, NULL);
 	} else if (value == HOG_PROTO_MODE_REPORT)
 		DBG("HoG device 0x%04X is operating in Report Protocol Mode",
@@ -593,7 +593,7 @@ static void forward_report(struct hog_device *hogdev,
 		gatt_write_char(hogdev->attrib, report->decl->value_handle,
 				data, size, output_written_cb, hogdev);
 	else if (report->decl->properties & ATT_CHAR_PROPER_WRITE_WITHOUT_RESP)
-		gatt_write_char(hogdev->attrib, report->decl->value_handle,
+		gatt_write_cmd(hogdev->attrib, report->decl->value_handle,
 						data, size, NULL, NULL);
 }
 
@@ -794,7 +794,7 @@ static int set_control_point(struct hog_device *hogdev, gboolean suspend)
 	if (hogdev->ctrlpt_handle == 0)
 		return -ENOTSUP;
 
-	gatt_write_char(hogdev->attrib, hogdev->ctrlpt_handle, &value,
+	gatt_write_cmd(hogdev->attrib, hogdev->ctrlpt_handle, &value,
 					sizeof(value), NULL, NULL);
 
 	return 0;
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 5982c38..f5db5ed 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -71,7 +71,7 @@ static void write_scan_params(GAttrib *attrib, uint16_t handle)
 	att_put_u16(SCAN_INTERVAL, &value[0]);
 	att_put_u16(SCAN_WINDOW, &value[2]);
 
-	gatt_write_char(attrib, handle, value, sizeof(value), NULL, NULL);
+	gatt_write_cmd(attrib, handle, value, sizeof(value), NULL, NULL);
 }
 
 static void refresh_value_cb(const uint8_t *pdu, uint16_t len,
-- 
1.7.9.5

