Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] lib/uuid: Fix using unitialized values
Date: Thu, 28 Jul 2016 17:27:45 +0300
Message-Id: <1469716070-16506-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1469716070-16506-1-git-send-email-luiz.dentz@gmail.com>
References: <1469716070-16506-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The strings passed to bt_uuid_strcmp may not be valid UUIDs so the return
of bt_string_to_uuid needs to be checked otherwise bt_uuid_cmp may attempt
to access unitialized values:

Conditional jump or move depends on uninitialised value(s)
   at 0x4C1D4D: bt_uuid_to_uuid128 (uuid.c:78)
   by 0x4C1F22: bt_uuid_cmp (uuid.c:131)
   by 0x4C24A8: bt_uuid_strcmp (uuid.c:286)
   by 0x40F8A8: reconnect_match (policy.c:514)
   by 0x40F8A8: service_cb (policy.c:655)
   by 0x499331: change_state (service.c:109)
   by 0x499BBB: btd_service_connecting_complete (service.c:361)
   by 0x4178C1: stream_state_changed (source.c:163)
   by 0x422C78: avdtp_sep_set_state (avdtp.c:1013)
   by 0x42372A: handle_transport_connect (avdtp.c:844)
   by 0x423D8B: avdtp_connect_cb (avdtp.c:2326)
   by 0x465BBB: connect_cb (btio.c:232)
   by 0x50CA702: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4800.1)
 Uninitialised value was created by a stack allocation
   at 0x4C2460: bt_uuid_strcmp (uuid.c:280)
---
 lib/uuid.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index ac071fa..d4c7002 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -280,8 +280,11 @@ int bt_uuid_strcmp(const void *a, const void *b)
 {
 	bt_uuid_t u1, u2;
 
-	bt_string_to_uuid(&u1, a);
-	bt_string_to_uuid(&u2, b);
+	if (bt_string_to_uuid(&u1, a) < 0)
+		return -EINVAL;
+
+	if (bt_string_to_uuid(&u2, b) < 0)
+		return -EINVAL;
 
 	return bt_uuid_cmp(&u1, &u2);
 }
-- 
2.7.4

