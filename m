Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 17/20] android/hal-handsfree: Fix handling of dial notification
Date: Sat,  8 Mar 2014 01:20:01 +0100
Message-Id: <1394238004-15691-18-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Empty number means re-dial and should be passed as NULL.
---
 android/hal-handsfree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 4117ed0..196b046 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -89,8 +89,13 @@ static void handle_dial(void *buf, uint16_t len)
 		exit(EXIT_FAILURE);
 	}
 
-	if (cbs->dial_call_cmd_cb)
+	if (!cbs->dial_call_cmd_cb)
+		return;
+
+	if (ev->number_len)
 		cbs->dial_call_cmd_cb((char *) ev->number);
+	else
+		cbs->dial_call_cmd_cb(NULL);
 }
 
 static void handle_dtmf(void *buf, uint16_t len)
-- 
1.8.5.3

