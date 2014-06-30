Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/12] android/dis: Detach on free
Date: Mon, 30 Jun 2014 16:47:59 +0300
Message-Id: <1404136079-24846-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1404136079-24846-1-git-send-email-luiz.dentz@gmail.com>
References: <1404136079-24846-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/dis.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/dis.c b/android/dis.c
index ce6e063..0a2a18e 100644
--- a/android/dis.c
+++ b/android/dis.c
@@ -62,8 +62,7 @@ struct characteristic {
 
 static void dis_free(struct bt_dis *dis)
 {
-	if (dis->attrib)
-		g_attrib_unref(dis->attrib);
+	bt_dis_detach(dis);
 
 	g_free(dis->primary);
 	g_free(dis);
-- 
1.9.3

