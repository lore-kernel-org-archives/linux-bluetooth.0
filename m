Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 8/9] audio: Fix tab misuse
Date: Fri, 27 Apr 2012 10:36:51 -0400
Message-Id: <1335537412-26478-9-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/pcm_bluetooth.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/pcm_bluetooth.c b/audio/pcm_bluetooth.c
index 85566a3..b9da805 100644
--- a/audio/pcm_bluetooth.c
+++ b/audio/pcm_bluetooth.c
@@ -212,7 +212,7 @@ static void *playback_hw_thread(void *param)
 			char c = 'w';
 			int frags = periods - prev_periods, n;
 
-			data->hw_ptr += frags *	data->io.period_size;
+			data->hw_ptr += frags * data->io.period_size;
 			data->hw_ptr %= data->io.buffer_size;
 
 			for (n = 0; n < frags; n++) {
-- 
1.7.5.4

