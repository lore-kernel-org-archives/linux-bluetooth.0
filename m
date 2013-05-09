Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v5 7/8] core: Expose the last bonding attempt timeout on retry
Date: Wed,  8 May 2013 17:38:01 -0700
Message-Id: <1368059882-9986-8-git-send-email-deymo@chromium.org>
In-Reply-To: <1368059882-9986-1-git-send-email-deymo@chromium.org>
References: <1368059882-9986-1-git-send-email-deymo@chromium.org>
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
 src/device.c  | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h  |  2 ++
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index bca1515..2a4084e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4558,10 +4558,22 @@ int btd_adapter_remove_bonding(struct btd_adapter *adapter,
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
 
@@ -4590,9 +4602,14 @@ int btd_adapter_pincode_reply(struct btd_adapter *adapter,
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
index 681d0c8..e373908 100644
--- a/src/device.c
+++ b/src/device.c
@@ -35,6 +35,7 @@
 #include <sys/ioctl.h>
 #include <errno.h>
 #include <dirent.h>
+#include <time.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
@@ -90,6 +91,8 @@ struct bonding_req {
 	struct btd_adapter_pin_cb_iter *cb_iter;
 	uint8_t status;
 	guint retry_timer;
+	struct timespec attempt_start_time;
+	long last_attempt_duration_ms;
 };
 
 typedef enum {
@@ -1493,12 +1496,56 @@ static struct bonding_req *bonding_request_new(DBusMessage *msg,
 
 	bonding->cb_iter = btd_adapter_pin_cb_iter_new(device->adapter);
 
+	/* Marks the bonding start time for the first attempt on request
+	 * construction. The following attempts will be updated on
+	 * device_bonding_retry. */
+	clock_gettime(CLOCK_MONOTONIC, &bonding->attempt_start_time);
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
+	clock_gettime(CLOCK_MONOTONIC, &device->bonding->attempt_start_time);
+}
+
+static void bonding_request_stop_timer(struct bonding_req *bonding)
+{
+	struct timespec current;
+
+	clock_gettime(CLOCK_MONOTONIC, &current);
+
+	/* Compute the time difference in ms. */
+	bonding->last_attempt_duration_ms =
+		(current.tv_sec - bonding->attempt_start_time.tv_sec) * 1000L +
+		(current.tv_nsec - bonding->attempt_start_time.tv_nsec)
+								/ 1000000L;
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
+long device_bonding_last_duration(struct btd_device *device)
+{
+	struct bonding_req *bonding = device->bonding;
+
+	if (!bonding)
+		return 0;
+
+	return bonding->last_attempt_duration_ms;
+}
+
 static void create_bond_req_exit(DBusConnection *conn, void *user_data)
 {
 	struct btd_device *device = user_data;
@@ -3837,6 +3884,12 @@ static gboolean device_bonding_retry(gpointer data)
 	DBG("retrying bonding");
 	bonding->retry_timer = 0;
 
+	/* Restart the bonding timer to the begining of the pairing. If not
+	 * pincode request/reply occurs during this retry,
+	 * device_bonding_last_duration() will return a consistent value from
+	 * this point. */
+	device_bonding_restart_timer(device);
+
 	if (bonding->agent)
 		io_cap = agent_get_io_capability(bonding->agent);
 	else
@@ -3861,6 +3914,10 @@ int device_bonding_attempt_retry(struct btd_device *device)
 	if (!bonding)
 		return -EINVAL;
 
+	/* Mark the end of a bonding attempt to compute the delta for the
+	 * retry. */
+	bonding_request_stop_timer(bonding);
+
 	if (btd_adapter_pin_cb_iter_end(bonding->cb_iter))
 		return -EINVAL;
 
diff --git a/src/device.h b/src/device.h
index 07639c5..2a82aa2 100644
--- a/src/device.h
+++ b/src/device.h
@@ -82,6 +82,8 @@ void device_bonding_attempt_failed(struct btd_device *device, uint8_t status);
 void device_bonding_failed(struct btd_device *device, uint8_t status);
 struct btd_adapter_pin_cb_iter *device_bonding_iter(struct btd_device *device);
 int device_bonding_attempt_retry(struct btd_device *device);
+long device_bonding_last_duration(struct btd_device *device);
+void device_bonding_restart_timer(struct btd_device *device);
 int device_request_pincode(struct btd_device *device, gboolean secure);
 int device_request_passkey(struct btd_device *device);
 int device_confirm_passkey(struct btd_device *device, uint32_t passkey,
-- 
1.8.2.1
