Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/3] android/handsfree-client: Fix for correct audio state
Date: Tue,  2 Dec 2014 12:03:18 +0100
Message-Id: <1417518200-18428-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1417518200-18428-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1417518200-18428-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Disconnect audio state shall be set just after bt_sco_disconnect has
been called.
---
 android/handsfree-client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 9818a47..b84ad79 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -387,6 +387,8 @@ static void handle_disconnect_audio(const void *buf, uint16_t len)
 	}
 
 	bt_sco_disconnect(sco);
+	set_audio_state(dev, HAL_HF_CLIENT_AUDIO_STATE_DISCONNECTED);
+
 	status = HAL_STATUS_SUCCESS;
 
 done:
-- 
1.8.4

