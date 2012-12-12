Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 16/16] avctp: Remove double looking for audio device
Date: Wed, 12 Dec 2012 11:28:08 +0100
Message-ID: <1355308088-9080-17-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to double call for manager_get_audio_device with
toggled create flag. manager_get_audio_device with create set to true
will only create new audio device if matching one was not found.
---
 profiles/audio/avctp.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 8ffbf43..013c587 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1132,14 +1132,10 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 	if (session == NULL)
 		return;
 
-	dev = manager_get_audio_device(device, FALSE);
+	dev = manager_get_audio_device(device, TRUE);
 	if (!dev) {
-		dev = manager_get_audio_device(device, TRUE);
-		if (!dev) {
-			error("Unable to get audio device object for %s",
-					address);
-			goto drop;
-		}
+		error("Unable to get audio device object for %s", address);
+		goto drop;
 	}
 
 	if (dev->control == NULL) {
-- 
1.8.0

