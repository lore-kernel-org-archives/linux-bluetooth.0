Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] android/A2DP: Change to connected state when a transport open
Date: Wed, 15 Jan 2014 15:06:44 +0200
Message-Id: <1389791204-20703-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This changes the connected state to be only sent once a transport is
open, before this was done right after the signalling was connected but
this reflect in the audio HAL side attempting to open a stream while
with possible no transport available.
---
 android/a2dp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 35ffe46..a5fc652 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -401,8 +401,6 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 		}
 	}
 
-	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_CONNECTED);
-
 	return;
 
 failed:
@@ -544,6 +542,8 @@ static void transport_connect_cb(GIOChannel *chan, GError *err,
 		g_io_channel_unref(dev->io);
 		dev->io = NULL;
 	}
+
+	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_CONNECTED);
 }
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
-- 
1.8.4.2

