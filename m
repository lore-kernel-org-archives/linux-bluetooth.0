Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 04/12] android/hog: Read CCC initial value for Input Report
Date: Mon, 30 Jun 2014 17:17:33 +0300
Message-Id: <1404137861-9313-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1404137861-9313-1-git-send-email-luiz.dentz@gmail.com>
References: <1404137861-9313-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is required by the following test:

 - TP/HGRF/RH/BV-05-I [Read Client Characteristic Configuration Descriptors
for Report Characteristics – Input Report]
---
 android/hog.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/android/hog.c b/android/hog.c
index f69fe2a..1069cca 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -177,6 +177,19 @@ static void write_ccc(GAttrib *attrib, uint16_t handle, void *user_data)
 					report_ccc_written_cb, user_data);
 }
 
+static void ccc_read_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct report *report = user_data;
+
+	if (status != 0) {
+		error("Error reading CCC value: %s", att_ecode2str(status));
+		return;
+	}
+
+	write_ccc(report->hog->attrib, report->ccc_handle, report);
+}
+
 static void report_reference_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
@@ -199,7 +212,8 @@ static void report_reference_cb(guint8 status, const guint8 *pdu,
 
 	/* Enable notifications only for Input Reports */
 	if (report->type == HOG_REPORT_TYPE_INPUT)
-		write_ccc(report->hog->attrib, report->ccc_handle, report);
+		gatt_read_char(report->hog->attrib, report->ccc_handle,
+							ccc_read_cb, report);
 }
 
 static void external_report_reference_cb(guint8 status, const guint8 *pdu,
-- 
1.9.3

