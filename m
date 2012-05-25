Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] audio: Fix updating volume property for non-A2DP transports
Date: Fri, 25 May 2012 18:02:45 +0300
Message-Id: <1337958168-9875-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1337958168-9875-1-git-send-email-luiz.dentz@gmail.com>
References: <1337958168-9875-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Volume property is A2DP only
---
 audio/media.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index cb8872f..2a2cf37 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1357,16 +1357,14 @@ static void set_volume(uint8_t volume, struct audio_device *dev, void *user_data
 	mp->volume = volume;
 
 	for (l = mp->adapter->endpoints; l; l = l->next) {
-
-		struct media_endpoint *endpoint;
+		struct media_endpoint *endpoint = l->data;
 		struct media_transport *transport;
 
-		if (l->data == NULL)
+		/* Volume is A2DP only */
+		if (endpoint->sep == NULL)
 			continue;
 
-		endpoint = l->data;
 		transport = find_device_transport(endpoint, dev);
-
 		if (transport == NULL)
 			continue;
 
-- 
1.7.7.6

