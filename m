Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/6] android/gatt: Fix error message in signed_write_cmd
Date: Fri, 27 Feb 2015 16:01:13 +0100
Message-Id: <1425049274-11552-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1425049274-11552-1-git-send-email-szymon.janc@tieto.com>
References: <1425049274-11552-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 2e3a5c9..6e9181e 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3271,7 +3271,7 @@ static guint signed_write_cmd(struct gatt_device *dev, uint16_t handle,
 	res = gatt_signed_write_cmd(dev->attrib, handle, value, vlen, crypto,
 						csrk, sign_cnt, NULL, NULL);
 	if (!res) {
-		error("gatt: Could write signed cmd");
+		error("gatt: Could not write signed cmd");
 		return 0;
 	}
 
-- 
1.9.3

