Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] android/hal-avrcp: Fill attributes in case of empty for GetElementAttributes
Date: Sun,  9 Mar 2014 13:24:44 +0200
Message-Id: <1394364285-684-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This has to be done since the upper layer to not interpret empty list as
get all attributes.
---
 android/hal-avrcp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index 5f98f5b..0a5f500 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -134,11 +134,19 @@ static void handle_get_element_attrs(void *buf, uint16_t len)
 	if (!cbs->get_element_attr_cb)
 		return;
 
+	/* Set everything in case of empty list */
+	if (ev->number == 0) {
+		for (i = 0; i < BTRC_MAX_APP_SETTINGS; i++)
+			attrs[i] = i;
+		goto done;
+	}
+
 	/* Convert uint8_t array to btrc_media_attr_t array */
 	for (i = 0; i < ev->number; i++)
 		attrs[i] = ev->attrs[i];
 
-	cbs->get_element_attr_cb(ev->number, attrs);
+done:
+	cbs->get_element_attr_cb(i, attrs);
 }
 
 static void handle_register_notification(void *buf, uint16_t len)
-- 
1.8.5.3

