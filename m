Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] device: Remove not used variables from search_cb
Date: Tue, 2 Oct 2012 13:39:55 +0200
Message-ID: <1349177995-29253-1-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349176333-26638-1-git-send-email-szymon.janc@tieto.com>
References: <1349176333-26638-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

sda and dba are not used in function code.

---
 src/device.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/src/device.c b/src/device.c
index c41b0c8..fb7c4f8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1818,14 +1818,8 @@ send_reply:
 	}
 
 cleanup:
-	if (!device->temporary) {
-		bdaddr_t sba, dba;
-
-		adapter_get_address(device->adapter, &sba);
-		device_get_address(device, &dba, NULL);
-
+	if (!device->temporary)
 		store_profiles(device);
-	}
 
 	device->browse = NULL;
 	browse_request_free(req);
-- 
1.7.9.5

