Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, marcel@holtmann.org, hadess@hadess.net,
	Scott James Remnant <scott@netsplit.com>
Subject: [PATCHv3 4/4] bonding: call plugin callback on cancellation
Date: Thu,  5 Apr 2012 15:40:53 -0700
Message-Id: <1333665653-30266-5-git-send-email-scott@netsplit.com>
In-Reply-To: <1333665653-30266-1-git-send-email-scott@netsplit.com>
References: <1333665653-30266-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Call the plugin callbacks when a bonding request is cancelled.
---
 src/device.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index 343e2bc..448c8fd 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2715,6 +2715,8 @@ void device_cancel_bonding(struct btd_device *device, uint8_t status)
 	struct bonding_req *bonding = device->bonding;
 	DBusMessage *reply;
 	char addr[18];
+	GSList *l;
+	btd_device_bonding_cb_t cb;
 
 	if (!bonding)
 		return;
@@ -2722,6 +2724,14 @@ void device_cancel_bonding(struct btd_device *device, uint8_t status)
 	ba2str(&device->bdaddr, addr);
 	DBG("Canceling bonding request for %s", addr);
 
+	for (l = device->bonding_callbacks; l != NULL; l = g_slist_next(l)) {
+		cb = l->data;
+		cb(device, FALSE, 0);
+	}
+
+	g_slist_free(device->bonding_callbacks);
+	device->bonding_callbacks = NULL;
+
 	if (device->authr)
 		device_cancel_authentication(device, FALSE);
 
-- 
1.7.7.3

