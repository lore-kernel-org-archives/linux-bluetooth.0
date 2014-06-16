Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/17] android/hal-sco: Fix error code printing
Date: Mon, 16 Jun 2014 10:57:45 +0300
Message-Id: <1402905472-17643-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index ef04dc5..faed406 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -712,7 +712,7 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 						RESAMPLER_QUALITY_DEFAULT, NULL,
 						&out->resampler);
 	if (ret) {
-		error("Failed to create resampler (%s)", strerror(ret));
+		error("Failed to create resampler (%s)", strerror(-ret));
 		goto failed;
 	}
 
@@ -1143,7 +1143,7 @@ static int sco_open_input_stream(struct audio_hw_device *dev,
 						RESAMPLER_QUALITY_DEFAULT, NULL,
 						&in->resampler);
 	if (ret) {
-		error("Failed to create resampler (%s)", strerror(ret));
+		error("Failed to create resampler (%s)", strerror(-ret));
 		goto failed;
 	}
 
-- 
1.8.3.2

