Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/4] android/handsfree: Fix handsfree idle state handling
Date: Tue,  2 Dec 2014 11:59:36 +0100
Message-Id: <1417517979-18136-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1417517979-18136-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1417517979-18136-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In idle state disconnect_sco is called when handsfree gets new phone
state saying there is 0 active and 0 held calls.
With this patch disconnect_sco is called only when there was any
previous active or held call.
---
 android/handsfree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index c057d5f..f5576a2 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -2457,7 +2457,12 @@ static void phone_state_idle(struct hf_device *dev, int num_active,
 			 * calls present when headset was connected.
 			 */
 			connect_audio(dev);
-		} else if (num_active == 0 && num_held == 0) {
+		} else if (num_active == 0 && num_held == 0 &&
+				(dev->num_active > 0 || dev->num_held > 0)) {
+			/*
+			 * Number of calls is 0 now. If there any outstanding
+			 * call that means we have active SCO. Lets close it.
+			 */
 			disconnect_sco(dev);
 		}
 
-- 
1.8.4

