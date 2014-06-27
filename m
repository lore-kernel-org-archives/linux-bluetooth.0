Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 12/12] android/hog: Only discover if External Report has a Report UUID
Date: Fri, 27 Jun 2014 21:09:00 +0300
Message-Id: <1403892540-21222-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403892540-21222-1-git-send-email-luiz.dentz@gmail.com>
References: <1403892540-21222-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some devices, including PTS, may include characteristics other than
Report as External Report.
---
 android/hog.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/hog.c b/android/hog.c
index 83f5d53..7e61790 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -328,6 +328,11 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 	uuid16 = get_le16(&pdu[1]);
 	DBG("External report reference read, external report characteristic "
 						"UUID: 0x%04x", uuid16);
+
+	/* Do not discover if is not a Report */
+	if (uuid16 != HOG_REPORT_UUID)
+		return;
+
 	bt_uuid16_create(&uuid, uuid16);
 	gatt_discover_char(hog->attrib, 0x0001, 0xffff, &uuid,
 					external_service_char_cb, hog);
-- 
1.9.3

