Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/12] android/hog: Fix not resetting properly on detach
Date: Mon, 30 Jun 2014 16:47:52 +0300
Message-Id: <1404136079-24846-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1404136079-24846-1-git-send-email-luiz.dentz@gmail.com>
References: <1404136079-24846-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hog.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/android/hog.c b/android/hog.c
index 1069cca..2cce4e9 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -1007,7 +1007,10 @@ void bt_hog_detach(struct bt_hog *hog)
 	for (l = hog->reports; l; l = l->next) {
 		struct report *r = l->data;
 
-		g_attrib_unregister(hog->attrib, r->notifyid);
+		if (r->notifyid > 0) {
+			g_attrib_unregister(hog->attrib, r->notifyid);
+			r->notifyid = 0;
+		}
 	}
 
 	if (hog->scpp)
-- 
1.9.3

