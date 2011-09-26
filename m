Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 09/11] Add an interval between connection attempts
Date: Mon, 26 Sep 2011 14:48:26 -0300
Message-Id: <1317059308-20038-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For connection attempts to the same remote device, add 5 seconds
interval until the next connect attempt. At the moment, the behaviour
depends on if address is found in the advertising kernel cache only.

Passive scanning kernel patches are not upstream yet. LE scanning will
be executed in background during a short period of time until it finds
the address or EHOSTDOWN is returned to the connection attempt.
---
 src/device.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index f56d57f..3407dc3 100644
--- a/src/device.c
+++ b/src/device.c
@@ -66,6 +66,8 @@
 #define DISCONNECT_TIMER	2
 #define DISCOVERY_TIMER		2
 
+#define AUTO_CONNECTION_INTERVAL	5 /* Next connection attempt */
+
 /* When all services should trust a remote device */
 #define GLOBAL_TRUST "[all]"
 
@@ -1705,8 +1707,9 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 			device->browse = NULL;
 			browse_request_free(req, TRUE);
 		} else if (device->auto_connect)
-			device->auto_id = g_idle_add_full(
+			device->auto_id = g_timeout_add_seconds_full(
 						G_PRIORITY_DEFAULT_IDLE,
+						AUTO_CONNECTION_INTERVAL,
 						att_connect, device,
 						att_connect_dispatched);
 
-- 
1.7.6.1

