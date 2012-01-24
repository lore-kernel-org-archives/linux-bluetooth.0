Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Scott James Remnant <scott@netsplit.com>
Subject: [PATCHv2 4/4] bonding: call plugin callback on cancellation
Date: Tue, 24 Jan 2012 10:47:58 -0800
Message-Id: <1327430878-23913-5-git-send-email-scott@netsplit.com>
In-Reply-To: <1327430878-23913-1-git-send-email-scott@netsplit.com>
References: <1327430878-23913-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Call the plugin callbacks when a bonding request is cancelled.
---
 src/device.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index c36173d..67537fc 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2504,6 +2504,8 @@ void device_cancel_bonding(struct btd_device *device, uint8_t status)
 	struct bonding_req *bonding = device->bonding;
 	DBusMessage *reply;
 	char addr[18];
+	GSList *l;
+	btd_device_bonding_cb_t cb;
 
 	if (!bonding)
 		return;
@@ -2511,6 +2513,14 @@ void device_cancel_bonding(struct btd_device *device, uint8_t status)
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

