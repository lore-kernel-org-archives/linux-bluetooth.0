Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 07/12] android/hog: Remove unused code
Date: Mon, 30 Jun 2014 17:17:36 +0300
Message-Id: <1404137861-9313-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1404137861-9313-1-git-send-email-luiz.dentz@gmail.com>
References: <1404137861-9313-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

report_free is only called once after detaching so this code is no longer
necessary.
---
 android/hog.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 5a758f3..319cb2a 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -699,10 +699,6 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 static void report_free(void *data)
 {
 	struct report *report = data;
-	struct bt_hog *hog = report->hog;
-
-	if (hog->attrib)
-		g_attrib_unregister(hog->attrib, report->notifyid);
 
 	g_free(report->decl);
 	g_free(report);
-- 
1.9.3

