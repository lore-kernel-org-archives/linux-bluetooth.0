Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 02/16] android/hidhost: Remove invalid connecting state notification
Date: Tue,  2 Sep 2014 12:09:47 +0200
Message-Id: <1409652601-28689-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HIDHOST_STATE_CONNECTING is reserved for local initiated connections
according to Android framework.
Sending it on incoming connection might confuse Android state machines.
---
 android/hidhost.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 476742e..652baa0 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -802,10 +802,8 @@ static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
 		goto fail;
 	}
 
-	if (!dev) {
+	if (!dev)
 		dev = hid_device_new(addr);
-		bt_hid_notify_state(dev, HAL_HIDHOST_STATE_CONNECTING);
-	}
 
 	if (!dev->hog) {
 		/* TODO: Get device details and primary */
-- 
1.8.4

