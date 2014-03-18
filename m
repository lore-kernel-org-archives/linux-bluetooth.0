Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/avrcp: Fix possible buffer overflow
Date: Tue, 18 Mar 2014 14:24:07 +0200
Message-Id: <1395145447-11205-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 5bbc407..509b6c1 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -831,7 +831,7 @@ int avrcp_set_addressed_player(struct avrcp *session, uint16_t player_id,
 int avrcp_get_capabilities_rsp(struct avrcp *session, uint8_t transaction,
 						uint8_t number, uint8_t *events)
 {
-	uint8_t pdu[AVRCP_EVENT_LAST];
+	uint8_t pdu[AVRCP_EVENT_LAST + 1];
 
 	if (number > AVRCP_EVENT_LAST)
 		return -EINVAL;
-- 
1.8.3.2

