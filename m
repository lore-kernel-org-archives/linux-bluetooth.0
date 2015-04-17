Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] hog: re-enable HoG report notifications on HoG device reconnect
Message-Id: <20150417220040.A379A220209@puck.mtv.corp.google.com>
Date: Fri, 17 Apr 2015 15:00:40 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On HoG device reconnect, re-enable HoG report notifications every
time by writing the client characteristic configuration attribute
of each HoG report.

Doing this on every reconnect:
1. ensures that HoG report notifications are always enabled
   (e.g. lost report notification state in battery swap).
2. signals to HoG device that it can start sending HoG reports
   (e.g. buffered keypresses while the reconnect is still pending).
---
 profiles/input/hog.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index c55443c..690fd43 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -842,10 +842,7 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	for (l = hogdev->reports; l; l = l->next) {
 		struct report *r = l->data;
 
-		r->notifyid = g_attrib_register(hogdev->attrib,
-					ATT_OP_HANDLE_NOTIFY,
-					r->decl->value_handle,
-					report_value_cb, r, NULL);
+		enable_report_notification(r);
 	}
 }
 
-- 
2.2.0.rc0.207.ga3a616c

