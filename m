Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/12] android/gatt: Fix length check
Date: Fri,  4 Jul 2014 16:43:59 +0300
Message-Id: <1404481441-734-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Function fill_gatt_response() has check shown below:
	if (!len)
		return;

This eliminates clang warning:
...
android/gatt.c:4443:3: warning: Function call argument is an
uninitialized value
                fill_gatt_response(resp_data, resp_data->handle,
...
---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index fa7e1c3..d37a581 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4439,7 +4439,7 @@ static void read_requested_attributes(void *data, void *user_data)
 
 done:
 	/* We have value here already if no callback will be called */
-	if (value_len >= 0)
+	if (value_len > 0)
 		fill_gatt_response(resp_data, resp_data->handle,
 					resp_data->offset, error, value_len,
 					value);
-- 
1.9.1

