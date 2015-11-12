Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 7/7] input/hog-lib: Print report value handle and type
Date: Thu, 12 Nov 2015 17:46:28 +0200
Message-Id: <1447343188-21628-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1447343188-21628-1-git-send-email-luiz.dentz@gmail.com>
References: <1447343188-21628-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds better debug logs when discovering report type.
---
 profiles/input/hog-lib.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index a45e59f..1df1799 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -369,6 +369,20 @@ static void ccc_read_cb(guint8 status, const guint8 *pdu, guint16 len,
 	write_ccc(report->hog, report->hog->attrib, report->ccc_handle, report);
 }
 
+static const char *type_to_string(uint8_t type)
+{
+	switch (type) {
+	case HOG_REPORT_TYPE_INPUT:
+		return "input";
+	case HOG_REPORT_TYPE_OUTPUT:
+		return "output";
+	case HOG_REPORT_TYPE_FEATURE:
+		return "feature";
+	}
+
+	return NULL;
+}
+
 static void report_reference_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
@@ -390,7 +404,9 @@ static void report_reference_cb(guint8 status, const guint8 *pdu,
 
 	report->id = pdu[1];
 	report->type = pdu[2];
-	DBG("Report ID: 0x%02x Report type: 0x%02x", pdu[1], pdu[2]);
+
+	DBG("Report 0x%04x: id 0x%02x type %s", report->decl->value_handle,
+				report->id, type_to_string(report->type));
 
 	/* Enable notifications only for Input Reports */
 	if (report->type == HOG_REPORT_TYPE_INPUT)
-- 
2.4.3

