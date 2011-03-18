Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH] Fix adapter drivers unload order
Date: Fri, 18 Mar 2011 10:25:29 +0200
Message-Id: <1300436729-3578-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Order of unloading drivers shell be preserved as given in
audio_manager_exit. It was reverted in 'c772636 Fix unloading of adapter
drivers', which causes in turn bluetoothd crash on exit.

Removing of media end-point results in removing of A2DP end-point for
the corresponding A2DP server but not vice versa. Therefore, unregistering
and destroying A2DP server, which clears all A2DP end-points, before media
server is incorrect.
---
 src/adapter.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8c368fe..9fa7c4d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2258,8 +2258,8 @@ static void probe_driver(struct btd_adapter *adapter, gpointer user_data)
 		return;
 	}
 
-	adapter->loaded_drivers = g_slist_prepend(adapter->loaded_drivers,
-									driver);
+	adapter->loaded_drivers = g_slist_append(adapter->loaded_drivers,
+								driver);
 }
 
 static void load_drivers(struct btd_adapter *adapter)
-- 
1.7.1

