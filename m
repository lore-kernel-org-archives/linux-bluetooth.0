Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 05/20] android/avrcp: Use defined constant instead of magic number
Date: Mon, 31 Mar 2014 15:24:59 +0300
Message-Id: <1396268714-4056-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1396268714-4056-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1396268714-4056-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 42e00de..48c5221 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -908,7 +908,7 @@ done:
 int avrcp_register_notification(struct avrcp *session, uint8_t event,
 							uint32_t interval)
 {
-	uint8_t params[5];
+	uint8_t params[AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH];
 
 	params[0] = event;
 	put_be32(interval, &params[1]);
-- 
1.8.3.2

