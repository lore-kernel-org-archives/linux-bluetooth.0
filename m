Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [RFC v2 15/16] HoG: Register only one notification callback
Date: Wed, 18 Apr 2012 19:08:23 -0300
Message-Id: <1334786904-26282-16-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
References: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

Fix registering the notification callback per report. Only one instance
of GAttrib callback for all report notifications should be registered.
---
 input/hog_device.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/input/hog_device.c b/input/hog_device.c
index a522699..cfe8f03 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -68,6 +68,7 @@ struct hog_device {
 	struct btd_device	*device;
 	GAttrib			*attrib;
 	guint			attioid;
+	guint			report_cb_id;
 	struct gatt_primary	*hog_primary;
 	GSList			*reports;
 	int			uhid_fd;
@@ -111,8 +112,6 @@ static void report_value_cb(const uint8_t *pdu, uint16_t len, gpointer user_data
 static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct hog_device *hogdev = user_data;
-
 	if (status != 0) {
 		error("Write report characteristic descriptor failed: %s",
 							att_ecode2str(status));
@@ -120,9 +119,6 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 	}
 
 	DBG("Report characteristic descriptor written: notification enabled");
-
-	g_attrib_register(hogdev->attrib, ATT_OP_HANDLE_NOTIFY, report_value_cb,
-								hogdev, NULL);
 }
 
 static void write_ccc(uint16_t handle, gpointer user_data)
@@ -309,8 +305,14 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 		return;
 
 	hogdev->uhid_fd = open(UHID_DEVICE_FILE, O_RDWR | O_CLOEXEC);
-	if (hogdev->uhid_fd < 0)
+	if (hogdev->uhid_fd < 0) {
 		error("Failed to open UHID device: %s", strerror(errno));
+		return;
+	}
+
+	hogdev->report_cb_id = g_attrib_register(hogdev->attrib,
+					ATT_OP_HANDLE_NOTIFY, report_value_cb,
+					hogdev, NULL);
 }
 
 static void attio_disconnected_cb(gpointer user_data)
@@ -326,6 +328,9 @@ static void attio_disconnected_cb(gpointer user_data)
 	close(hogdev->uhid_fd);
 	hogdev->uhid_fd = -1;
 
+	g_attrib_unregister(hogdev->attrib, hogdev->report_cb_id);
+	hogdev->report_cb_id = 0;
+
 	g_attrib_unref(hogdev->attrib);
 	hogdev->attrib = NULL;
 }
-- 
1.7.7.6

