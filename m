Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0] avctp: Fix missing UUID registration
Date: Fri, 10 May 2013 13:41:04 +0200
Message-Id: <1368186064-10960-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

When there is an incoming connection to AVCTP PSM, there is no way to
know if the remote UUID corresponds to AVRCP_REMOTE_UUID or
AVRCP_TARGET_UUID. Therefore both UUIDs should be reported to the core.

Without this patch, a crash has been observed with the iPhone 5
immediately after pairing.
---
I don't have the log traces right now but submitting the patch anyway due to the upcoming release.

 profiles/audio/avctp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 21aeb6f..6f1fc17 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1324,6 +1324,8 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 
 	if (dev->control == NULL) {
 		btd_device_add_uuid(dev->btd_dev, AVRCP_REMOTE_UUID);
+		btd_device_add_uuid(dev->btd_dev, AVRCP_TARGET_UUID);
+
 		if (dev->control == NULL)
 			goto drop;
 	}
-- 
1.8.1.4

