Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <lucas.demarchi@profusion.mobi>,
	<johan.hedberg@gmail.com>,
	Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v3 08/14] AVRCP: Register AVRCP before MEDIA interface
Date: Thu, 28 Jun 2012 12:22:33 +0200
Message-ID: <1340878959-1343-8-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1340878959-1343-1-git-send-email-michal.labedzki@tieto.com>
References: <1340878959-1343-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Register AVRCP before MEDIA interface to avoid searching for or
accessing non-existent AVRCP server.
---
 audio/manager.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index d442d1d..076346a 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -1238,6 +1238,9 @@ proceed:
 	if (enabled.socket)
 		unix_init();
 
+	if (enabled.control)
+		btd_register_adapter_driver(&avrcp_server_driver);
+
 	if (enabled.media)
 		btd_register_adapter_driver(&media_server_driver);
 
@@ -1250,9 +1253,6 @@ proceed:
 	if (enabled.source || enabled.sink)
 		btd_register_adapter_driver(&a2dp_server_driver);
 
-	if (enabled.control)
-		btd_register_adapter_driver(&avrcp_server_driver);
-
 	btd_register_device_driver(&audio_driver);
 
 	*enable_sco = (enabled.gateway || enabled.headset);
-- 
on behalf of ST-Ericsson

