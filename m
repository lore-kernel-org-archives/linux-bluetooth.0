Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] media: Fix leaking endpoint in case of failure to register SEP
Date: Mon, 15 Oct 2012 11:51:27 +0200
Message-Id: <1350294687-20718-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This can happen in case of AudioSink and/or AudioSource are disabled in
audio.conf.
---
 audio/media.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/media.c b/audio/media.c
index 5c26035..f2b5b2f 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -769,7 +769,7 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 	}
 
 	if (!succeeded) {
-		g_free(endpoint);
+		media_endpoint_destroy(endpoint);
 		return NULL;
 	}
 
-- 
1.7.11.4

