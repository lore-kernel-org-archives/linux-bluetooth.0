Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] android/hog: Fix code style
Date: Wed, 25 Jun 2014 12:09:26 +0300
Message-Id: <1403687366-18493-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403687366-18493-1-git-send-email-luiz.dentz@gmail.com>
References: <1403687366-18493-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hog.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index c7ac6d1..652c374 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -199,7 +199,6 @@ static void report_reference_cb(guint8 status, const guint8 *pdu,
 static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data);
 
-
 static void discover_descriptor_cb(uint8_t status, GSList *descs,
 								void *user_data)
 {
@@ -613,8 +612,7 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 			report = g_new0(struct report, 1);
 			report->hog = hog;
 			report->decl = g_memdup(chr, sizeof(*chr));
-			hog->reports = g_slist_append(hog->reports,
-								report);
+			hog->reports = g_slist_append(hog->reports, report);
 			discover_descriptor(hog->attrib, start, end, report);
 		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0) {
 			gatt_read_char(hog->attrib, chr->value_handle,
@@ -635,8 +633,7 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 	}
 
 	if (info_handle)
-		gatt_read_char(hog->attrib, info_handle, info_read_cb,
-									hog);
+		gatt_read_char(hog->attrib, info_handle, info_read_cb, hog);
 }
 
 static void report_free(void *data)
-- 
1.9.3

