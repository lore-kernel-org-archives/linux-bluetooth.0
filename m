Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 08/13] hog: Handle feature reports
Date: Tue, 10 Jul 2012 16:17:00 -0300
Message-Id: <1341947825-14789-9-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1341947825-14789-1-git-send-email-jprvita@openbossa.org>
References: <1341947825-14789-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch writes the feature reports coming from the HID host on the
device's Feature Report characteristic.
---
 profiles/input/hog_device.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 236745a..00127c3 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -56,6 +56,7 @@
 
 #define HOG_REPORT_TYPE_INPUT	1
 #define HOG_REPORT_TYPE_OUTPUT	2
+#define HOG_REPORT_TYPE_FEATURE	3
 
 #define UHID_DEVICE_FILE	"/dev/uhid"
 
@@ -362,10 +363,20 @@ static void forward_report(struct hog_device *hogdev,
 	int size;
 	guint type;
 
-	type = HOG_REPORT_TYPE_OUTPUT;
 	data = ev->u.output.data;
 	size = ev->u.output.size;
 
+	switch (ev->type) {
+	case UHID_OUTPUT:
+		type = HOG_REPORT_TYPE_OUTPUT;
+		break;
+	case UHID_FEATURE:
+		type = HOG_REPORT_TYPE_FEATURE;
+		break;
+	default:
+		return;
+	}
+
 	l = g_slist_find_custom(hogdev->reports, GUINT_TO_POINTER(type),
 							report_type_cmp);
 	if (!l)
@@ -409,6 +420,7 @@ static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
 
 	switch (ev.type) {
 	case UHID_OUTPUT:
+	case UHID_FEATURE:
 		forward_report(hogdev, &ev);
 		break;
 	case UHID_OUTPUT_EV:
-- 
1.7.10.4

