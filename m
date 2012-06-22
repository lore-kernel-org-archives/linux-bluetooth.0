Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 17/19] hog: Handle feature reports
Date: Fri, 22 Jun 2012 12:08:05 -0300
Message-Id: <1340377687-4711-18-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1340377687-4711-1-git-send-email-jprvita@openbossa.org>
References: <1340377687-4711-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch writes the feature reports coming from the HID host on the
device's Feature Report characteristic.
---
 input/hog_device.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/input/hog_device.c b/input/hog_device.c
index 374f9fe..3876d98 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -56,6 +56,7 @@
 
 #define HOG_REPORT_TYPE_INPUT	1
 #define HOG_REPORT_TYPE_OUTPUT	2
+#define HOG_REPORT_TYPE_FEATURE	3
 
 #define UHID_DEVICE_FILE	"/dev/uhid"
 
@@ -366,10 +367,20 @@ static void forward_report(struct hog_device *hogdev,
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
@@ -413,6 +424,7 @@ static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
 
 	switch (ev.type) {
 	case UHID_OUTPUT:
+	case UHID_FEATURE:
 		forward_report(hogdev, &ev);
 		break;
 	case UHID_OUTPUT_EV:
-- 
1.7.10.2

