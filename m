Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix deinitializing telephony backend when it wasn't initialized
Date: Thu,  2 Dec 2010 10:46:04 +0200
Message-Id: <1291279564-16615-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Telephony driver is now deinitialized on headset adapter driver remove so
telephony_exit should not be called on plugin exit anymore.
---
 audio/manager.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 12671c7..035656b 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -1264,10 +1264,8 @@ void audio_manager_exit(void)
 	if (enabled.media)
 		btd_unregister_adapter_driver(&media_server_driver);
 
-	if (enabled.headset) {
+	if (enabled.headset)
 		btd_unregister_adapter_driver(&headset_server_driver);
-		telephony_exit();
-	}
 
 	if (enabled.gateway)
 		btd_unregister_adapter_driver(&gateway_server_driver);
-- 
1.7.1

