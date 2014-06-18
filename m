Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] socket: Convert service UUID to 16 or 32 bits if possible
Date: Wed, 18 Jun 2014 19:56:27 +0200
Message-Id: <1403114187-16518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/socket.c b/android/socket.c
index 99d6bec..2b836e9 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -360,6 +360,7 @@ static sdp_record_t *create_app_record(uint8_t chan,
 	uuid_t uuid;
 
 	sdp_uuid128_create(&uuid, app_uuid);
+	sdp_uuid128_to_uuid(&uuid);
 
 	record = create_rfcomm_record(chan, &uuid, svc_name, false);
 	if (!record)
-- 
1.9.3

