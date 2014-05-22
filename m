Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/4] android/gatt: Fix minor style code issue
Date: Thu, 22 May 2014 13:17:44 +0200
Message-Id: <1400757465-11522-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400757465-11522-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400757465-11522-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 51fccd9..39314a1 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3513,7 +3513,6 @@ static void send_dev_pending_response(struct gatt_device *device,
 		int length;
 		struct queue *temp;
 
-
 		temp = queue_new();
 		if (!temp)
 			goto done;
-- 
1.8.4

