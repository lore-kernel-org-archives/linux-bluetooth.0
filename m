Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH V2 6/7] Bump Device ID service version to 1.3
Date: Tue, 20 Mar 2012 17:27:26 +0100
Message-ID: <1332260847-20079-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1332260847-20079-1-git-send-email-szymon.janc@tieto.com>
References: <1332260847-20079-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Device ID information in EIR are specified in DID 1.3 and this is
supported by BlueZ.
---
 src/sdpd-service.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index a6ed90e..c33e1da 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -175,7 +175,7 @@ void register_server_service(void)
 
 void register_device_id(void)
 {
-	const uint16_t spec = 0x0102;
+	const uint16_t spec = 0x0103;
 	const uint8_t primary = 1;
 	sdp_list_t *class_list, *group_list, *profile_list;
 	uuid_t class_uuid, group_uuid;
-- 
on behalf of ST-Ericsson

