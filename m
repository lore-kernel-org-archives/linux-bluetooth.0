Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v2 7/8] core: Expose the last bonding attempt duration on retry
Date: Fri, 12 Apr 2013 16:28:37 -0700
Message-Id: <1365809318-17775-8-git-send-email-deymo@chromium.org>
In-Reply-To: <1365809318-17775-1-git-send-email-deymo@chromium.org>
References: <1365809318-17775-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

One of the interesting values for pincode plugins is the timeout of a
bonding attempt. For keyboards supporting any random pincode as long as
it is also typed in the keyboard, the timeout until it fails is in the
order of the seconds to allow the user type the pincode on the bluetooth
keyboard. In the case of a dumb keyboard accepting only a fixed pincode
the timeout before the keyboard fails is in the order of a fraction of
a second.

This patch computes the elapsed time between the pairing started or the
pin code was sent to the device and the device returns with an error.
This measured duration is exposed in milliseconds to the plugins when
retrying the bonding attempt.
---
 src/adapter.c | 19 ++++++++++++++++++-
 src/device.c  | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h  |  2 ++
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 93cea81..fefb7e5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4570,10 +4570,22 @@ int btd_adapter_remove_bonding(struct btd_adapter *adapter,
 	return -EIO;
 }
 
+static void pincode_reply_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_device *device = user_data;
+
+	/* If the MGMT_OP_PIN_CODE_REPLY command is acknowledged, move the
+	 * starting time to that point. This give a better sense of time
+	 * evaluating the pincode. */
+	device_bonding_restart_timer(device);
+}
+
 int btd_adapter_pincode_reply(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
 					const char *pin, size_t pin_len)
 {
+	struct btd_device *device;
 	unsigned int id;
 	char addr[18];
 
@@ -4602,9 +4614,14 @@ int btd_adapter_pincode_reply(struct btd_adapter *adapter,
 		cp.pin_len = pin_len;
 		memcpy(cp.pin_code, pin, pin_len);
 
+		/* Since a pincode was requested, update the starting time to
+		 * the point where the pincode is provided. */
+		device = adapter_find_device(adapter, bdaddr);
+		device_bonding_restart_timer(device);
+
 		id = mgmt_reply(adapter->mgmt, MGMT_OP_PIN_CODE_REPLY,
 					adapter->dev_id, sizeof(cp), &cp,
-					NULL, NULL, NULL);
+					pincode_reply_complete, device, NULL);
 	}
 
 	if (id == 0)
diff --git a/src/device.c b/src/device.c
index 4ce7b8c..cfd1027 100644
--- a/src/device.c
+++ b/src/device.c
@@ -89,6 +89,8 @@ struct bonding_req {
 	uint8_t capability;
 	uint8_t status;
 	guint retry_timer;
+	gint64 attempt_start_time_us;
+	gint64 last_attempt_duration_us;
 };
 
 typedef enum {
@@ -1420,12 +1422,55 @@ static struct bonding_req *bonding_request_new(DBusMessage *msg,
 
 	bonding->capability = io_cap;
 
+	/* Marks the bonding start time for the first attempt on request
+	 * construction. The following attempts will be updated on
+	 * device_bonding_retry. */
+	bonding->attempt_start_time_us = g_get_monotonic_time();
+
 	if (agent)
 		bonding->agent = agent_ref(agent);
 
 	return bonding;
 }
 
+void device_bonding_restart_timer(struct btd_device *device)
+{
+	if (!device || !device->bonding)
+		return;
+
+	device->bonding->attempt_start_time_us = g_get_monotonic_time();
+}
+
+static void bonding_request_stop_timer(struct bonding_req *bonding)
+{
+	gint64 current = g_get_monotonic_time();
+
+	/* Compute the time difference in ms. */
+	if (current > bonding->attempt_start_time_us)
+		bonding->last_attempt_duration_us =
+				current - bonding->attempt_start_time_us;
+	else
+		bonding->last_attempt_duration_us = 0;
+}
+
+/* Returns the duration of the last bonding attempt in milliseconds. The
+ * duration is measured starting from the latest of the following three
+ * events and finishing when the Command complete event is received for the
+ * authentication request:
+ *  - MGMT_OP_PAIR_DEVICE is sent,
+ *  - MGMT_OP_PIN_CODE_REPLY is sent and
+ *  - Command complete event is received for the sent MGMT_OP_PIN_CODE_REPLY.
+ */
+gint64 device_bonding_last_duration(struct btd_device *device)
+{
+	struct bonding_req *bonding = device->bonding;
+
+	if (!bonding)
+		return 0;
+
+	return bonding->last_attempt_duration_us / 1000;
+}
+
 static void create_bond_req_exit(DBusConnection *conn, void *user_data)
 {
 	struct btd_device *device = user_data;
@@ -3761,6 +3806,12 @@ static gboolean device_bonding_retry(gpointer data)
 	DBG("retrying bonding");
 	bonding->retry_timer = 0;
 
+	/* Restart the bonding timer to the begining of the pairing. If not
+	 * pincode request/reply occurs during this retry,
+	 * device_bonding_last_duration() will return a consistent value from
+	 * this point. */
+	device_bonding_restart_timer(device);
+
 	err = adapter_bonding_attempt(adapter, &device->bdaddr,
 				device->bdaddr_type, bonding->capability);
 	if (err < 0)
@@ -3779,6 +3830,10 @@ int device_bonding_attempt_retry(struct btd_device *device) {
 	if (!bonding)
 		return -EINVAL;
 
+	/* Mark the end of a bonding attempt to compute the delta for the
+	 * retry. */
+	bonding_request_stop_timer(bonding);
+
 	if (pincb_iter_end(bonding->cb_iter))
 		return -EINVAL;
 
diff --git a/src/device.h b/src/device.h
index ab243f9..26aab5f 100644
--- a/src/device.h
+++ b/src/device.h
@@ -81,6 +81,8 @@ void device_bonding_attempt_failed(struct btd_device *device, uint8_t status);
 void device_bonding_failed(struct btd_device *device, uint8_t status);
 struct pincb_iter *device_bonding_iter(struct btd_device *device);
 int device_bonding_attempt_retry(struct btd_device *device);
+gint64 device_bonding_last_duration(struct btd_device *device);
+void device_bonding_restart_timer(struct btd_device *device);
 int device_request_pincode(struct btd_device *device, gboolean secure);
 int device_request_passkey(struct btd_device *device);
 int device_confirm_passkey(struct btd_device *device, uint32_t passkey,
-- 
1.8.1.3
