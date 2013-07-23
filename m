Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] audio/media: Fix not updating position
Date: Tue, 23 Jul 2013 15:52:31 +0300
Message-Id: <1374583952-16361-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1374583952-16361-1-git-send-email-luiz.dentz@gmail.com>
References: <1374583952-16361-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The status may not be 'playing' as MPRIS documents it as 'Playing'
instead, to make this less prone to typos like this the code now
uses strcasecmp.
---
 profiles/audio/media.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index f1ad439..715d49c 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1131,7 +1131,7 @@ static uint32_t get_position(void *user_data)
 	double timedelta;
 	uint32_t sec, msec;
 
-	if (g_strcmp0(mp->status, "playing") != 0)
+	if (mp->status == NULL || strcasecmp(mp->status, "Playing") != 0)
 		return mp->position;
 
 	timedelta = g_timer_elapsed(mp->timer, NULL);
-- 
1.8.3.1

