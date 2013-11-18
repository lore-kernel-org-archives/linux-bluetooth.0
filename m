Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio/AVCTP: Use A/V_RemoteControl UUID for incoming connections
Date: Mon, 18 Nov 2013 15:42:14 +0200
Message-Id: <1384782134-17118-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

By the time and incoming connection arrives it is not possible to
determine the role, so this changes the UUID to A/V_RemoteControl which
according to assigned number page bellow is the profile UUID for AVRCP:

https://www.bluetooth.org/en-us/specification/assigned-numbers/service-discovery
---
 profiles/audio/avctp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index dac7a66..476f61a 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1311,7 +1311,7 @@ static void avctp_control_confirm(struct avctp *session, GIOChannel *chan,
 	dst = device_get_address(dev);
 
 	session->auth_id = btd_request_authorization(src, dst,
-							AVRCP_TARGET_UUID,
+							AVRCP_REMOTE_UUID,
 							auth_cb, session);
 	if (session->auth_id == 0)
 		goto drop;
-- 
1.8.3.1

