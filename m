Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCV2 08/28] android/hal-sco: Check file descriptor >= 0
Date: Wed,  4 Jun 2014 17:17:39 +0300
Message-Id: <1401891479-11965-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 162ce25..e905d6b 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -713,11 +713,11 @@ static void sco_close_output_stream(struct audio_hw_device *dev,
 	struct sco_dev *sco_dev = (struct sco_dev *) dev;
 	struct sco_stream_out *out = (struct sco_stream_out *) stream_out;
 
-	DBG("dev %p stream %p fd %d", dev, stream_out, sco_dev->out->fd);
+	DBG("dev %p stream %p fd %d", dev, out, sco_dev->out->fd);
 
-	if (sco_dev->out && sco_dev->out->fd) {
-		close(sco_dev->out->fd);
-		sco_dev->out->fd = -1;
+	if (out && out->fd >= 0) {
+		close(out->fd);
+		out->fd = -1;
 	}
 
 	if (out->resampler)
-- 
1.8.3.2

