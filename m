Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Fix creating device object when connection fails
Date: Mon, 31 Jan 2011 14:56:35 +0200
Message-Id: <1296478596-18269-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

There is no need to create a new object since there is no connection and
the device is not permanent/paired.
---
 src/event.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/event.c b/src/event.c
index ff768c0..166e401 100644
--- a/src/event.c
+++ b/src/event.c
@@ -676,7 +676,9 @@ void btd_event_conn_failed(bdaddr_t *local, bdaddr_t *peer, uint8_t status)
 	struct btd_device *device;
 	DBusConnection *conn = get_dbus_connection();
 
-	if (!get_adapter_and_device(local, peer, &adapter, &device, TRUE))
+	DBG("");
+
+	if (!get_adapter_and_device(local, peer, &adapter, &device, FALSE))
 		return;
 
 	if (device_is_temporary(device))
-- 
1.7.1

