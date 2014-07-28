Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] android/hog: Fix handling UHID_FEATURE as UHID_OUTPUT
Date: Mon, 28 Jul 2014 14:39:26 +0300
Message-Id: <1406547566-23105-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1406547566-23105-1-git-send-email-luiz.dentz@gmail.com>
References: <1406547566-23105-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

As with input plugin this code contain the same issue handling
UHID_FEATURE events can cause a crash.
---
 android/hog.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 9f8c7e5..ef5690c 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -404,16 +404,7 @@ static void forward_report(struct uhid_event *ev, void *user_data)
 		size = ev->u.output.size;
 	}
 
-	switch (ev->type) {
-	case UHID_OUTPUT:
-		type = HOG_REPORT_TYPE_OUTPUT;
-		break;
-	case UHID_FEATURE:
-		type = HOG_REPORT_TYPE_FEATURE;
-		break;
-	default:
-		return;
-	}
+	type = HOG_REPORT_TYPE_OUTPUT;
 
 	l = g_slist_find_custom(hog->reports, GUINT_TO_POINTER(type),
 							report_type_cmp);
@@ -573,7 +564,6 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	}
 
 	bt_uhid_register(hog->uhid, UHID_OUTPUT, forward_report, hog);
-	bt_uhid_register(hog->uhid, UHID_FEATURE, forward_report, hog);
 }
 
 static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-- 
1.9.3

