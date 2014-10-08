Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/8] android/avrcp-lib: Fix AddressedPlayerChanged
Date: Wed,  8 Oct 2014 15:31:43 +0300
Message-Id: <1412771509-7996-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412771509-7996-1-git-send-email-luiz.dentz@gmail.com>
References: <1412771509-7996-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds proper handling for AddressedPlayerChanged in
avrcp_register_notification_rsp.
---
 android/avrcp-lib.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 8350497..a487668 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -3243,6 +3243,7 @@ int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
 					void *data, size_t len)
 {
 	struct iovec iov[2];
+	uint16_t *player;
 
 	if (event > AVRCP_EVENT_LAST)
 		return -EINVAL;
@@ -3269,6 +3270,14 @@ int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
 		put_be32(*(uint32_t *) data, data);
 		break;
 	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
+		if (len != 4)
+			return -EINVAL;
+
+		player = data;
+		put_be16(player[0], &player[0]);
+		put_be16(player[1], &player[1]);
+
+		break;
 	case AVRCP_EVENT_SETTINGS_CHANGED:
 		if (len < sizeof(uint8_t))
 			return -EINVAL;
-- 
1.9.3

