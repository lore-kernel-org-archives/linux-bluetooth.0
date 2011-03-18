Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH] Fix adapter drivers unload order
Date: Fri, 18 Mar 2011 16:18:50 +0200
Message-Id: <1300457930-16282-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1300457930-16282-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1300457930-16282-1-git-send-email-dmitriy.paliy@nokia.com>
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
 src/adapter.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index cc4f43e..3455237 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2494,6 +2494,7 @@ static void remove_driver(gpointer data, gpointer user_data)
 
 static void unload_drivers(struct btd_adapter *adapter)
 {
+	adapter->loaded_drivers = g_slist_reverse(adapter->loaded_drivers);
 	g_slist_foreach(adapter->loaded_drivers, remove_driver, adapter);
 	g_slist_free(adapter->loaded_drivers);
 	adapter->loaded_drivers = NULL;
-- 
1.7.1

