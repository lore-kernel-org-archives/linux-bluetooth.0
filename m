Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 06/11] android/tester: Update test data
Date: Tue, 11 Feb 2014 17:58:16 +0100
Message-ID: <1392137901-3403-7-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Trying to listen on already assigned channel will now return busy
status instead of just fail.
---
 android/android-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 870ad8d..9198514 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -2757,7 +2757,7 @@ static const struct socket_data btsock_inv_listen_listen = {
 	.service_uuid = NULL,
 	.service_name = "Test service",
 	.flags = 0,
-	.expected_status = BT_STATUS_FAIL,
+	.expected_status = BT_STATUS_BUSY,
 	.test_channel = true,
 };
 
-- 
1.8.5.3

