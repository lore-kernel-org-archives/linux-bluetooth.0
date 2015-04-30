Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com
Subject: [PATCH v2 3/3] hog: fix HoG reconnect handling in attio_connected_cb()
Message-Id: <20150430214020.8A22E220C1B@puck.mtv.corp.google.com>
Date: Thu, 30 Apr 2015 14:40:20 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On HoG device reconnect, attio_connected_cb() should re-enable
HoG report notification callbacks for only those HoG reports that
have a valid CCC handle and notifications enabled on the device.

Note that the call:
enable_report_notifications(r, false)

only reinstalls the callback for HoG report notifications. It doesn't
rewrite the HoG report notification enable bit on the HoG device.
---
 profiles/input/hog.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index ff0c559..bb3f182 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -858,10 +858,7 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	for (l = hogdev->reports; l; l = l->next) {
 		struct report *r = l->data;
 
-		r->notifyid = g_attrib_register(hogdev->attrib,
-					ATT_OP_HANDLE_NOTIFY,
-					r->decl->value_handle,
-					report_value_cb, r, NULL);
+		enable_report_notifications(r, false);
 	}
 }
 
-- 
2.2.0.rc0.207.ga3a616c

