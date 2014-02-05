Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] android: Connect AVRCP once A2DP is connected
Date: Wed,  5 Feb 2014 12:26:59 +0200
Message-Id: <1391596020-27679-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1391596020-27679-1-git-send-email-luiz.dentz@gmail.com>
References: <1391596020-27679-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case of being the initiator of the A2DP connection also attempt to
connect AVRCP.
---
 android/a2dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index a215ce2..962e7f5 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -45,6 +45,7 @@
 #include "utils.h"
 #include "bluetooth.h"
 #include "avdtp.h"
+#include "avrcp.h"
 #include "audio-msg.h"
 #include "audio-ipc.h"
 
@@ -544,6 +545,7 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 			error("avdtp_discover: %s", strerror(-perr));
 			goto failed;
 		}
+		bt_avrcp_connect(&dev->dst);
 	} else /* Init idle timeout to discover */
 		dev->idle_id = g_timeout_add_seconds(IDLE_TIMEOUT, idle_timeout,
 									dev);
-- 
1.8.5.3

