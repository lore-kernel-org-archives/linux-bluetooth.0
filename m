Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 3/3] input: Add DualShock 4 detection
Date: Sat, 18 Jan 2014 15:57:14 +0100
Message-Id: <1390057034-7983-3-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1390057034-7983-1-git-send-email-szymon.janc@gmail.com>
References: <1390057034-7983-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

DS4 tries to connect right after pairing before SDP search completed
and no idev is present yet.
---
 profiles/input/server.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/profiles/input/server.c b/profiles/input/server.c
index 3814eaf..21c589c 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -118,18 +118,24 @@ static void sixaxis_browse_sdp(const bdaddr_t *src, const bdaddr_t *dst,
 static bool dev_is_sixaxis(const bdaddr_t *src, const bdaddr_t *dst)
 {
 	struct btd_device *device;
+	uint16_t vid, pid;
 
 	device = btd_adapter_find_device(adapter_find(src), dst);
 	if (!device)
 		return false;
 
-	if (btd_device_get_vendor(device) != 0x054c)
-		return false;
+	vid = btd_device_get_vendor(device);
+	pid = btd_device_get_product(device);
 
-	if (btd_device_get_product(device) != 0x0268)
-		return false;
+	/* DualShock 3 */
+	if (vid == 0x054c && pid == 0x0268)
+		return true;
+
+	/* DualShock 4 */
+	if (vid == 0x054c && pid == 0x05c4)
+		return true;
 
-	return true;
+	return false;
 }
 
 static void connect_event_cb(GIOChannel *chan, GError *err, gpointer data)
-- 
1.8.5.3

