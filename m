Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 12/13] hog: Fix re-discovering HoG characteristics when reconnecting
Date: Tue, 10 Jul 2012 16:17:04 -0300
Message-Id: <1341947825-14789-13-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1341947825-14789-1-git-send-email-jprvita@openbossa.org>
References: <1341947825-14789-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

If the reports list is already present there's no need rediscovering all
the characteristics. This should also make reconnections faster.
---
 profiles/input/hog_device.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 18854b8..7f4cf2d 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -536,12 +536,15 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 
 	hogdev->attrib = g_attrib_ref(attrib);
 
-	gatt_discover_char(hogdev->attrib, prim->range.start, prim->range.end,
-					NULL, char_discovered_cb, hogdev);
-
 	hogdev->report_cb_id = g_attrib_register(hogdev->attrib,
 					ATT_OP_HANDLE_NOTIFY, report_value_cb,
 					hogdev, NULL);
+
+	if (hogdev->reports == NULL) {
+		gatt_discover_char(hogdev->attrib, prim->range.start,
+						prim->range.end, NULL,
+						char_discovered_cb, hogdev);
+	}
 }
 
 static void attio_disconnected_cb(gpointer user_data)
-- 
1.7.10.4

