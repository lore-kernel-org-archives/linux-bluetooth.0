Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/12] android/scpp: Fix not detaching on free
Date: Mon, 30 Jun 2014 16:47:56 +0300
Message-Id: <1404136079-24846-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1404136079-24846-1-git-send-email-luiz.dentz@gmail.com>
References: <1404136079-24846-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/scpp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/scpp.c b/android/scpp.c
index b831680..9d8bb10 100644
--- a/android/scpp.c
+++ b/android/scpp.c
@@ -62,8 +62,7 @@ struct bt_scpp {
 
 static void scpp_free(struct bt_scpp *scan)
 {
-	if (scan->attrib)
-		g_attrib_unref(scan->attrib);
+	bt_scpp_detach(scan);
 
 	g_free(scan->primary);
 	g_free(scan);
-- 
1.9.3

