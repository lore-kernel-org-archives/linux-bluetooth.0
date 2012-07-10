Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 13/13] hog: Fix destroying the uhid device when disconnecting
Date: Tue, 10 Jul 2012 16:17:05 -0300
Message-Id: <1341947825-14789-14-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1341947825-14789-1-git-send-email-jprvita@openbossa.org>
References: <1341947825-14789-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

The uhid device should have the lifetime of the hog_device structure.
So, only destroy the uhid device when hog_device is destroyed.
---
 profiles/input/hog_device.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 7f4cf2d..10bc622 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -550,12 +550,6 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 static void attio_disconnected_cb(gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
-	struct uhid_event ev;
-
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_DESTROY;
-	if (write(hogdev->uhid_fd, &ev, sizeof(ev)) < 0)
-		error("Failed to destroy uHID device: %s", strerror(errno));
 
 	g_attrib_unregister(hogdev->attrib, hogdev->report_cb_id);
 	hogdev->report_cb_id = 0;
@@ -675,6 +669,7 @@ int hog_device_register(struct btd_device *device, const char *path)
 int hog_device_unregister(const char *path)
 {
 	struct hog_device *hogdev;
+	struct uhid_event ev;
 
 	hogdev = find_device_by_path(devices, path);
 	if (hogdev == NULL)
@@ -687,6 +682,11 @@ int hog_device_unregister(const char *path)
 		hogdev->uhid_watch_id = 0;
 	}
 
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_DESTROY;
+	if (write(hogdev->uhid_fd, &ev, sizeof(ev)) < 0)
+		error("Failed to destroy uHID device: %s", strerror(errno));
+
 	close(hogdev->uhid_fd);
 	hogdev->uhid_fd = -1;
 
-- 
1.7.10.4

