Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/12] android/haltest: Add check for valid channel
Date: Fri,  4 Jul 2014 16:43:57 +0300
Message-Id: <1404481441-734-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Channel is got from user and needs to be validated before use as index
in the array.
---
 android/client/if-hl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/client/if-hl.c b/android/client/if-hl.c
index 17ba16c..a3c351c 100644
--- a/android/client/if-hl.c
+++ b/android/client/if-hl.c
@@ -329,6 +329,10 @@ static void close_channel_p(int argc, const char **argv)
 	}
 
 	channel_id = atoi(argv[4]);
+	if (channel_id >= CHANNEL_ID_SIZE) {
+		haltest_error("Wrong channel id: %u\n", channel_id);
+		return;
+	}
 
 	if (app[app_id].mdep[index].channel[channel_id].fd >= 0) {
 		shutdown(app[app_id].mdep[index].channel[channel_id].fd,
-- 
1.9.1

