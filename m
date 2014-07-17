Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 20/23] android/hal-sco: Fix error code printing
Date: Thu, 17 Jul 2014 11:54:20 +0300
Message-Id: <1405587263-19867-21-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405587263-19867-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405587263-19867-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index b6ba55f..0e87aad 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -697,7 +697,7 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 						RESAMPLER_QUALITY_DEFAULT, NULL,
 						&out->resampler);
 	if (ret) {
-		error("Failed to create resampler (%s)", strerror(ret));
+		error("Failed to create resampler (%s)", strerror(-ret));
 		goto failed;
 	}
 
@@ -1128,7 +1128,7 @@ static int sco_open_input_stream(struct audio_hw_device *dev,
 						RESAMPLER_QUALITY_DEFAULT, NULL,
 						&in->resampler);
 	if (ret) {
-		error("Failed to create resampler (%s)", strerror(ret));
+		error("Failed to create resampler (%s)", strerror(-ret));
 		goto failed;
 	}
 
-- 
1.9.1

