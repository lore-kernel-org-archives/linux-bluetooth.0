Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] media: Fix not handling "Playlist" as possible value to LoopStatus
Date: Fri, 19 Apr 2013 15:31:11 +0300
Message-Id: <1366374673-24937-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1366374673-24937-1-git-send-email-luiz.dentz@gmail.com>
References: <1366374673-24937-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/media.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 972af50..4295180 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1479,7 +1479,7 @@ static const char *loop_status_to_repeat(const char *value)
 		return "off";
 	else if (strcasecmp(value, "Track") == 0)
 		return "singletrack";
-	else if (strcasecmp(value, "Track") == 0)
+	else if (strcasecmp(value, "Playlist") == 0)
 		return "alltracks";
 
 	return NULL;
-- 
1.8.1.4

