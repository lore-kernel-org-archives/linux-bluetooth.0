Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Scott James Remnant <scott@netsplit.com>
Subject: [PATCHv2 3/4] bonding: retry if callback returns TRUE
Date: Tue, 24 Jan 2012 10:47:57 -0800
Message-Id: <1327430878-23913-4-git-send-email-scott@netsplit.com>
In-Reply-To: <1327430878-23913-1-git-send-email-scott@netsplit.com>
References: <1327430878-23913-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a bonding completes, pass the status to any plugin bonding
callbacks; if any return TRUE than set a timer to retry the bonding
after an appropriate backoff period.
---
 src/device.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index 4e11447..c36173d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2354,6 +2354,44 @@ void btd_device_unregister_bonding_cb(struct btd_device *device,
 						device->bonding_callbacks, cb);
 }
 
+static gboolean device_bonding_retry(gpointer data)
+{
+	struct btd_device *device = data;
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct bonding_req *bonding = device->bonding;
+	int err;
+
+	if (!bonding)
+		return FALSE;
+
+	DBG("retrying bonding");
+	err = adapter_create_bonding(adapter, &device->bdaddr,
+							bonding->capability);
+	if (err < 0)
+		device_bonding_complete(device, bonding->status);
+
+	bonding->retry_timer = 0;
+	return FALSE;
+}
+
+static gboolean device_bonding_get_retry(struct btd_device *device,
+								uint8_t status)
+{
+	GSList *l;
+	btd_device_bonding_cb_t cb;
+	gboolean retry = FALSE;
+
+	for (l = device->bonding_callbacks; l != NULL; l = g_slist_next(l)) {
+		cb = l->data;
+		retry |= cb(device, TRUE, status);
+	}
+
+	g_slist_free(device->bonding_callbacks);
+	device->bonding_callbacks = NULL;
+
+	return retry;
+}
+
 gboolean device_is_retrying(struct btd_device *device)
 {
 	struct bonding_req *bonding = device->bonding;
@@ -2368,6 +2406,14 @@ void device_bonding_complete(struct btd_device *device, uint8_t status)
 
 	DBG("bonding %p status 0x%02x", bonding, status);
 
+	if (device_bonding_get_retry(device, status) && status) {
+		DBG("backing off and retrying");
+		bonding->status = status;
+		bonding->retry_timer = g_timeout_add(3000,
+						device_bonding_retry, device);
+		return;
+	}
+
 	if (auth && auth->type == AUTH_TYPE_NOTIFY && auth->agent)
 		agent_cancel(auth->agent);
 
-- 
1.7.7.3

