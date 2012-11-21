Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] core: Fix connection order of Device.Connect
Date: Wed, 21 Nov 2012 14:10:13 +0200
Message-Id: <1353499818-10153-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

We should with higher priority first.
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 0053098..fd29a7f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1299,7 +1299,7 @@ static gint profile_prio_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct btd_profile *p1 = a, *p2 = b;
 
-	return p1->priority - p2->priority;
+	return p2->priority - p1->priority;
 }
 
 static DBusMessage *connect_profiles(struct btd_device *dev, DBusMessage *msg,
-- 
1.7.11.7

