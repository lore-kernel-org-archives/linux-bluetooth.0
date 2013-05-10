Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/8] media: Fix not handling "Playlist" as possible value to LoopStatus
Date: Fri, 10 May 2013 14:02:05 +0300
Message-Id: <1368183727-24461-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1368183727-24461-1-git-send-email-luiz.dentz@gmail.com>
References: <1368183727-24461-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/media.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 327b58e..33847e5 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1482,7 +1482,7 @@ static const char *loop_status_to_repeat(const char *value)
 		return "off";
 	else if (strcasecmp(value, "Track") == 0)
 		return "singletrack";
-	else if (strcasecmp(value, "Track") == 0)
+	else if (strcasecmp(value, "Playlist") == 0)
 		return "alltracks";
 
 	return NULL;
-- 
1.8.1.4

