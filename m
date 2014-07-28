Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] input/hog: Cleanup unnecessary code
Date: Mon, 28 Jul 2014 14:39:25 +0300
Message-Id: <1406547566-23105-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The callback register by bt_uhid_register already contains the event type
so there is no need to check for it again.
---
 profiles/input/hog.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 491f933..df2b30b 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -340,9 +340,6 @@ static void forward_report(struct uhid_event *ev, void *user_data)
 		size = ev->u.output.size;
 	}
 
-	if (ev->type != UHID_OUTPUT)
-		return;
-
 	type = HOG_REPORT_TYPE_OUTPUT;
 
 	l = g_slist_find_custom(hogdev->reports, GUINT_TO_POINTER(type),
-- 
1.9.3

