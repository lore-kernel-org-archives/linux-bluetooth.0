Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/12] android/hog: Fix not detaching on free
Date: Mon, 30 Jun 2014 16:47:53 +0300
Message-Id: <1404136079-24846-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1404136079-24846-1-git-send-email-luiz.dentz@gmail.com>
References: <1404136079-24846-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hog.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/hog.c b/android/hog.c
index 2cce4e9..5a758f3 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -712,6 +712,8 @@ static void hog_free(void *data)
 {
 	struct bt_hog *hog = data;
 
+	bt_hog_detach(hog);
+
 	g_slist_free_full(hog->instances, hog_free);
 
 	bt_scpp_unref(hog->scpp);
@@ -719,7 +721,6 @@ static void hog_free(void *data)
 	bt_bas_unref(hog->bas);
 	bt_uhid_unref(hog->uhid);
 	g_slist_free_full(hog->reports, report_free);
-	g_attrib_unref(hog->attrib);
 	g_free(hog->name);
 	g_free(hog->primary);
 	g_free(hog);
-- 
1.9.3

