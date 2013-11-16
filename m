Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] android: Fix sending remote device property if name is not present
Date: Sat, 16 Nov 2013 15:09:44 +0100
Message-Id: <1384610986-17990-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix missing bdaddr to string convertion if name was NULL. This
was resulting in using undefined dst value.
---
 android/bluetooth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 83f20e2..4439cc6 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -589,8 +589,10 @@ static void send_remote_device_name_prop(const bdaddr_t *bdaddr)
 
 	/* Use cached name or bdaddr string */
 	name = get_device_name(bdaddr);
-	if (!name)
+	if (!name) {
+		ba2str(bdaddr, dst);
 		name = dst;
+	}
 
 	ev_len = BASELEN_REMOTE_DEV_PROP + strlen(name);
 	ev = g_malloc0(ev_len);
-- 
1.8.4.2

