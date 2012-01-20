Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] Remove dead code from device_create_bonding
Date: Fri, 20 Jan 2012 16:26:27 +0100
Message-ID: <1327073187-1009-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1327073187-1009-1-git-send-email-szymon.janc@tieto.com>
References: <1327073187-1009-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

bonding_request_new always return valid pointer so there is not need
to check for NULL as this will never happen.
---
 src/device.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index 5224984..12463cf 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2303,10 +2303,6 @@ DBusMessage *device_create_bonding(struct btd_device *device,
 
 	bonding = bonding_request_new(conn, msg, device, agent_path,
 					capability);
-	if (!bonding) {
-		adapter_cancel_bonding(adapter, &device->bdaddr);
-		return NULL;
-	}
 
 	bonding->listener_id = g_dbus_add_disconnect_watch(conn,
 						dbus_message_get_sender(msg),
-- 
on behalf of ST-Ericsson

