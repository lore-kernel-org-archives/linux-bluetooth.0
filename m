Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] android/hal-audio: Fix memory leak
Date: Fri, 31 Jan 2014 16:18:48 +0200
Message-Id: <1391177929-31416-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1391177929-31416-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391177929-31416-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Free preset if set_blocking() fails.
---
 android/hal-audio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 4b80da8..dfe8b68 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -1176,8 +1176,10 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	if (!preset || fd < 0)
 		goto fail;
 
-	if (set_blocking(fd) < 0)
+	if (set_blocking(fd) < 0) {
+		free(preset);
 		goto fail;
+	}
 
 	out->ep->fd = fd;
 	codec = out->ep->codec;
-- 
1.8.3.2

