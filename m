Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] android/gatt: Fix incorrect entry check
Date: Thu, 12 Jun 2014 11:08:24 +0200
Message-Id: <1402564106-27044-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1402564106-27044-1-git-send-email-marcin.kraglak@tieto.com>
References: <1402564106-27044-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index cfcfd9b..7ae0f55 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4131,7 +4131,7 @@ static void fill_gatt_response_by_handle(uint16_t handle, uint16_t offset,
 
 	entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
 							UINT_TO_PTR(handle));
-	if (entry) {
+	if (!entry) {
 		DBG("No pending response found! Bogus android response?");
 		return;
 	}
-- 
1.9.3

