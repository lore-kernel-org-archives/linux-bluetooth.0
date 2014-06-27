Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/health: Fix NULL dereference
Date: Fri, 27 Jun 2014 17:07:34 +0300
Message-Id: <1403878054-26178-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/health.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index 5f86727..2dc35d4 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1878,7 +1878,7 @@ static void channel_delete_cb(GError *gerr, gpointer data)
 
 	DBG("");
 
-	if (!gerr) {
+	if (gerr) {
 		error("health: channel delete failed %s", gerr->message);
 		return;
 	}
-- 
1.8.3.2

