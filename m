Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] device: Remove not used variable from search_cb
Date: Tue, 2 Oct 2012 13:12:13 +0200
Message-ID: <1349176333-26638-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

dba is not used in function code.

---
 src/device.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/src/device.c b/src/device.c
index ab9e897..cb6812a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1802,13 +1802,8 @@ send_reply:
 	}
 
 cleanup:
-	if (!device->temporary) {
-		bdaddr_t dba;
-
-		device_get_address(device, &dba, NULL);
-
+	if (!device->temporary)
 		store_profiles(device);
-	}
 
 	device->browse = NULL;
 	browse_request_free(req);
-- 
1.7.9.5

