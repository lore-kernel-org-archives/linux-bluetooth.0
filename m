Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 05/16] android/avrcp: Use defined constant instead of magic number
Date: Fri, 14 Mar 2014 17:17:47 +0200
Message-Id: <1394810278-11013-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394810278-11013-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394810278-11013-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 0e9f0df..fe6d7b4 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -346,7 +346,7 @@ int avrcp_register_notification(struct avrcp *session, uint8_t event,
 					uint32_t interval, avctp_rsp_cb func,
 					void *user_data)
 {
-	uint8_t params[5];
+	uint8_t params[AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH];
 
 	params[0] = event;
 	bt_put_be32(interval, &params[1]);
-- 
1.8.3.2

