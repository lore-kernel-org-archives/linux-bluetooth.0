Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] media: Remove left over of HFP removal
Date: Thu, 29 Nov 2012 11:06:36 +0200
Message-Id: <1354179996-17019-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1354179996-17019-1-git-send-email-luiz.dentz@gmail.com>
References: <1354179996-17019-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/transport.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index d8116fd..610aca3 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -90,11 +90,6 @@ struct a2dp_transport {
 	uint16_t		volume;
 };
 
-struct headset_transport {
-	struct audio_device	*device;
-	unsigned int		nrec_id;
-};
-
 struct media_transport {
 	char			*path;		/* Transport object path */
 	struct audio_device	*device;	/* Transport device */
-- 
1.7.11.7

