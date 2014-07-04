Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 32/32] android/hal-sco: Fix error code printing
Date: Fri,  4 Jul 2014 16:47:17 +0300
Message-Id: <1404481637-900-33-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 6a46e90..e7ab1a0 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -703,7 +703,7 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 						RESAMPLER_QUALITY_DEFAULT, NULL,
 						&out->resampler);
 	if (ret) {
-		error("Failed to create resampler (%s)", strerror(ret));
+		error("Failed to create resampler (%s)", strerror(-ret));
 		goto failed;
 	}
 
@@ -1134,7 +1134,7 @@ static int sco_open_input_stream(struct audio_hw_device *dev,
 						RESAMPLER_QUALITY_DEFAULT, NULL,
 						&in->resampler);
 	if (ret) {
-		error("Failed to create resampler (%s)", strerror(ret));
+		error("Failed to create resampler (%s)", strerror(-ret));
 		goto failed;
 	}
 
-- 
1.9.1

