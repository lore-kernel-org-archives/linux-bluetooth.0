Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 06/21] android/hal-sco: Check file descriptor >= 0
Date: Fri, 18 Jul 2014 12:48:05 +0300
Message-Id: <1405676900-17703-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 905d6fc..bcaa820 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -715,11 +715,11 @@ static void sco_close_output_stream(struct audio_hw_device *dev,
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
1.9.1

