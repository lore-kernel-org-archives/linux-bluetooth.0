Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android/handsfree-client: Fix missing connected state notification
Date: Fri,  6 Feb 2015 12:29:53 +0100
Message-Id: <1423222193-27653-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1423222193-27653-1-git-send-email-szymon.janc@tieto.com>
References: <1423222193-27653-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is additional state 'connected' that should be entered when
RFCOMM is connected but before SLC is completed.
---
 android/handsfree-client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index e1f2c16..0e2bd40 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -1748,6 +1748,8 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		goto failed;
 	}
 
+	device_set_state(dev, HAL_HF_CLIENT_CONN_STATE_CONNECTED);
+
 	return;
 
 failed:
-- 
1.9.1

