Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>,
	Petri Gynther <pgynther@google.com>
Subject: [PATCH 2/2] hog: handle HoG init failures correctly
Date: Fri,  4 Sep 2015 11:30:00 -0700
Message-Id: <1441391400-24990-2-git-send-email-pgynther@google.com>
In-Reply-To: <1441391400-24990-1-git-send-email-pgynther@google.com>
References: <1441391400-24990-1-git-send-email-pgynther@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When attio_connected_cb() is called for a HoG device, BlueZ should
be in one of the two states:

1) hogdev->uhid_created == FALSE && hogdev->reports == NULL
   * initial connection to HoG device, or first reconnect after
     BlueZ has been restarted
   * BlueZ needs to discover all HoG device characteristics
     (including report map) and create uHID device for HID input

2) hogdev->uhid_created == TRUE && hogdev->reports != NULL
   * second or subsequent reconnect
   * all HoG device characteristics (including report map) have
     been successfully discovered previously, and uHID device
     has been created

However, it is possible that the connection between BlueZ and
HoG device is abruptly terminated amid HoG device characteristics
discovery. Or, HoG report map discovery might intermittently fail.
This can leave BlueZ in inconsistent state such that it knows about
some of the characteristics, but the report map was never received
and uHID device not created, i.e.:
hogdev->uhid_created == FALSE && hogdev->reports != NULL

attio_connected_cb() needs to detect this condition, clean up
hogdev->reports, and re-discover HoG device characteristics.
---
 profiles/input/hog.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index bd35830..e006add 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -844,6 +844,18 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 									hogdev);
 }
 
+static void report_free(void *data)
+{
+	struct report *report = data;
+	struct hog_device *hogdev = report->hogdev;
+
+	if (hogdev->attrib)
+		g_attrib_unregister(hogdev->attrib, report->notifyid);
+
+	g_free(report->decl);
+	g_free(report);
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
@@ -852,6 +864,12 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 
 	DBG("HoG connected");
 
+	if (!hogdev->uhid_created && hogdev->reports) {
+		DBG("HoG init failed previously, preparing for re-init");
+		g_slist_free_full(hogdev->reports, report_free);
+		hogdev->reports = NULL;
+	}
+
 	hogdev->attrib = g_attrib_ref(attrib);
 
 	if (hogdev->reports == NULL) {
@@ -901,18 +919,6 @@ static struct hog_device *hog_new_device(struct btd_device *device,
 	return hogdev;
 }
 
-static void report_free(void *data)
-{
-	struct report *report = data;
-	struct hog_device *hogdev = report->hogdev;
-
-	if (hogdev->attrib)
-		g_attrib_unregister(hogdev->attrib, report->notifyid);
-
-	g_free(report->decl);
-	g_free(report);
-}
-
 static void hog_free_device(struct hog_device *hogdev)
 {
 	btd_device_unref(hogdev->device);
-- 
2.5.0.457.gab17608

