Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/gatt: Fix for read request
Date: Fri, 16 May 2014 12:47:32 +0200
Message-Id: <1400237252-3968-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If there is no attribute in database we should return immediately.
---
 android/gatt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 9bbcc48..9d90f3a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3656,8 +3656,10 @@ static void read_requested_attributes(void *data, void *user_data)
 						resp_data->offset,
 						process_data->opcode,
 						&process_data->device->bdaddr,
-						&value, &value_len))
+						&value, &value_len)) {
 		resp_data->length = READ_FAILED;
+		return;
+	}
 
 	/* We have value here already if no callback will be called */
 	if (value_len >= 0) {
-- 
1.8.4

