Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix possible crash when removing disconnect watches
Date: Mon,  8 Nov 2010 16:43:52 +0200
Message-Id: <1289227432-13354-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

The callback may have remove itself before returning.
---
 src/device.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index c2b6682..7c421e3 100644
--- a/src/device.c
+++ b/src/device.c
@@ -798,6 +798,10 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 			data->watch(device, device->temporary,
 							data->user_data);
 
+		/* Check if the watch has been removed by callback function */
+		if (!g_slist_find(device->watches, data))
+			continue;
+
 		device->watches = g_slist_remove(device->watches, data);
 		g_free(data);
 	}
-- 
1.7.1

