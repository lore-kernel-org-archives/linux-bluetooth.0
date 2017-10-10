Return-Path: <thierry.escande@collabora.com>
From: Thierry Escande <thierry.escande@collabora.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Joseph Hwang <josephsih@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: Add support for advertising intervals
Date: Tue, 10 Oct 2017 23:55:37 +0200
Message-Id: <1507672537-25499-1-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Joseph Hwang <josephsih@chromium.org>

This patch adds support for specification of advertising intervals in
bluetooth kernel subsystem.

A new mgmt handler named set_advertising_intervals is added to support
the new mgmt opcode MGMT_OP_SET_ADVERTISING_INTERVALS. The min_interval
and max_interval values are stored in the hdev structure.

The intervals together with other advertising parameters would be sent
to the controller before advertising is enabled in the procedure of
registering an advertisement.

If advertising has been enabled before set_advertising_intervals is
invoked, it would re-enable advertising to make the intervals take
effect. This is less preferable since bluetooth core specification
states that the parameters should be set before advertising is enabled.
However, the advertising re-enabling feature is kept since it might be
useful in multi-advertisements.

The advertisement duration is modified for existing advertisement
instances only if a duration was provided during their registration.
This is tracked using the individual_duration_flag of the adv_info
structure. The advertising duration of the instances with this flag set
to true would not be modified by the dbus SetAdvertisingIntervals
method. On the other hand, the advertising duration of the instances
with this flag set to false would be updated with the new values
specified by the dbus SetAdvertisingIntervals method.

Also, the advertising duration is adjusted according to the max
advertising interval so that multiple advertisements could be
interleaved in a round-robin manner. Besides, millisecond is used
as the unit of duration instead of second for finer resolution.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h | 27 +++++++++++++-
 include/net/bluetooth/mgmt.h     |  8 ++++
 net/bluetooth/hci_core.c         | 15 +++++---
 net/bluetooth/hci_request.c      | 19 +++++++---
 net/bluetooth/mgmt.c             | 79 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 138 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index fe98f0a..24d9add 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -247,6 +247,7 @@ enum {
 	HCI_LE_ENABLED,
 	HCI_ADVERTISING,
 	HCI_ADVERTISING_CONNECTABLE,
+	HCI_ADVERTISING_INTERVALS,
 	HCI_CONNECTABLE,
 	HCI_DISCOVERABLE,
 	HCI_LIMITED_DISCOVERABLE,
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 95ccc1e..4385600 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -167,6 +167,7 @@ struct adv_info {
 	__u16	timeout;
 	__u16	remaining_time;
 	__u16	duration;
+	__u8	individual_duration_flag;
 	__u16	adv_data_len;
 	__u8	adv_data[HCI_MAX_AD_LENGTH];
 	__u16	scan_rsp_len;
@@ -174,7 +175,29 @@ struct adv_info {
 };
 
 #define HCI_MAX_ADV_INSTANCES		5
-#define HCI_DEFAULT_ADV_DURATION	2
+#define HCI_DEFAULT_ADV_DURATION	2000
+
+/*
+ * Refer to BLUETOOTH SPECIFICATION Version 4.2 [Vol 2, Part E]
+ * Section 7.8.5 about
+ * - the default min/max intervals, and
+ * - the valid range of min/max intervals.
+ */
+#define HCI_DEFAULT_LE_ADV_MIN_INTERVAL	0x0800
+#define HCI_DEFAULT_LE_ADV_MAX_INTERVAL	0x0800
+#define HCI_VALID_LE_ADV_MIN_INTERVAL	0x0020
+#define HCI_VALID_LE_ADV_MAX_INTERVAL	0x4000
+#define ADV_DURATION_MIN_GRACE_PERIOD	5
+
+/* Multiply m by 0.625 (or 5 / 8) to derive time in ms. */
+#define CONVERT_TO_ADV_INTERVAL_MS(m) ((m * 5) >> 3)
+
+/*
+ * We want to multiply the duration (d) by a factor near 0.1
+ * to derive a grace period in ms. This is done by multiplying
+ * d by 0.109375 (or 7 / 64)
+ */
+#define ADV_DURATION_GRACE_PERIOD(d) ((d * 7) >> 6)
 
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
@@ -240,6 +263,8 @@ struct hci_dev {
 	__u8		le_adv_channel_map;
 	__u16		le_adv_min_interval;
 	__u16		le_adv_max_interval;
+	__u16		le_adv_duration;
+	__u8		le_adv_param_changed;
 	__u8		le_scan_type;
 	__u16		le_scan_interval;
 	__u16		le_scan_window;
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 72a456b..2ca6e3b 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -101,6 +101,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_PRIVACY		0x00002000
 #define MGMT_SETTING_CONFIGURATION	0x00004000
 #define MGMT_SETTING_STATIC_ADDRESS	0x00008000
+#define MGMT_SETTING_ADVERTISING_INTERVALS	0x00010000
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
@@ -604,6 +605,13 @@ struct mgmt_cp_set_appearance {
 } __packed;
 #define MGMT_SET_APPEARANCE_SIZE	2
 
+#define MGMT_OP_SET_ADVERTISING_INTERVALS	0x0044
+struct mgmt_cp_set_advertising_intervals {
+	__le16	min_interval;
+	__le16	max_interval;
+} __packed;
+#define MGMT_SET_ADVERTISING_INTERVALS_SIZE	4
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6bc679c..63350c2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2741,10 +2741,13 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 	adv_instance->timeout = timeout;
 	adv_instance->remaining_time = timeout;
 
-	if (duration == 0)
-		adv_instance->duration = HCI_DEFAULT_ADV_DURATION;
-	else
+	if (duration == 0) {
+		adv_instance->duration = hdev->le_adv_duration;
+		adv_instance->individual_duration_flag = 0;
+	} else {
 		adv_instance->duration = duration;
+		adv_instance->individual_duration_flag = 1;
+	}
 
 	BT_DBG("%s for %dMR", hdev->name, instance);
 
@@ -2995,8 +2998,10 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->sniff_min_interval = 80;
 
 	hdev->le_adv_channel_map = 0x07;
-	hdev->le_adv_min_interval = 0x0800;
-	hdev->le_adv_max_interval = 0x0800;
+	hdev->le_adv_min_interval = HCI_DEFAULT_LE_ADV_MIN_INTERVAL;
+	hdev->le_adv_max_interval = HCI_DEFAULT_LE_ADV_MAX_INTERVAL;
+	hdev->le_adv_duration = HCI_DEFAULT_ADV_DURATION;
+	hdev->le_adv_param_changed = false;
 	hdev->le_scan_interval = 0x0060;
 	hdev->le_scan_window = 0x0030;
 	hdev->le_conn_min_interval = 0x0018;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index b73ac14..f7d6ba6 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1284,20 +1284,29 @@ int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
 	hdev->adv_instance_timeout = timeout;
 	queue_delayed_work(hdev->req_workqueue,
 			   &hdev->adv_instance_expire,
-			   msecs_to_jiffies(timeout * 1000));
+			   msecs_to_jiffies(timeout));
 
-	/* If we're just re-scheduling the same instance again then do not
-	 * execute any HCI commands. This happens when a single instance is
-	 * being advertised.
+	/* In case of one single advertising instance, if the same instance
+	 * is rescheduled, the update on the advertising data and scan response
+	 * data depends on the value of flag le_adv_param_changed.
 	 */
 	if (!force && hdev->cur_adv_instance == instance &&
-	    hci_dev_test_flag(hdev, HCI_LE_ADV))
+	    hci_dev_test_flag(hdev, HCI_LE_ADV)) {
+		/* If advertising parameters have been changed, we need to
+		 * update the parameters and re-enable advertising.
+		 */
+		if (hdev->le_adv_param_changed) {
+			__hci_req_enable_advertising(req);
+			hdev->le_adv_param_changed = false;
+		}
 		return 0;
+	}
 
 	hdev->cur_adv_instance = instance;
 	__hci_req_update_adv_data(req, instance);
 	__hci_req_update_scan_rsp_data(req, instance);
 	__hci_req_enable_advertising(req);
+	hdev->le_adv_param_changed = false;
 
 	return 0;
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1fba2a0..3849cee 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -106,6 +106,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_START_LIMITED_DISCOVERY,
 	MGMT_OP_READ_EXT_INFO,
 	MGMT_OP_SET_APPEARANCE,
+	MGMT_OP_SET_ADVERTISING_INTERVALS,
 };
 
 static const u16 mgmt_events[] = {
@@ -648,6 +649,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 		settings |= MGMT_SETTING_SECURE_CONN;
 		settings |= MGMT_SETTING_PRIVACY;
 		settings |= MGMT_SETTING_STATIC_ADDRESS;
+		settings |= MGMT_SETTING_ADVERTISING_INTERVALS;
 	}
 
 	if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
@@ -722,6 +724,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 			settings |= MGMT_SETTING_STATIC_ADDRESS;
 	}
 
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INTERVALS))
+		settings |= MGMT_SETTING_ADVERTISING_INTERVALS;
+
 	return settings;
 }
 
@@ -4252,6 +4257,79 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int set_advertising_intervals(struct sock *sk, struct hci_dev *hdev,
+				     void *data, u16 len)
+{
+	struct mgmt_cp_set_advertising_intervals *cp = data;
+	int err;
+	u16 max_interval_ms, grace_period;
+	/* If both min_interval and max_interval are 0, use default values. */
+	bool use_default = cp->min_interval == 0 && cp->max_interval == 0;
+	struct adv_info *adv_instance;
+	int instance;
+
+	BT_DBG("%s", hdev->name);
+
+	/* This method is intended for LE devices only.*/
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_ADVERTISING_INTERVALS,
+				       MGMT_STATUS_REJECTED);
+
+	/* Check the validity of the intervals. */
+	if (!use_default && (cp->min_interval < HCI_VALID_LE_ADV_MIN_INTERVAL ||
+			     cp->max_interval > HCI_VALID_LE_ADV_MAX_INTERVAL ||
+			     cp->min_interval > cp->max_interval)) {
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_ADVERTISING_INTERVALS,
+				       MGMT_STATUS_INVALID_PARAMS);
+	}
+
+	hci_dev_lock(hdev);
+
+	if (use_default) {
+		hci_dev_clear_flag(hdev, HCI_ADVERTISING_INTERVALS);
+		hdev->le_adv_min_interval = HCI_DEFAULT_LE_ADV_MIN_INTERVAL;
+		hdev->le_adv_max_interval = HCI_DEFAULT_LE_ADV_MAX_INTERVAL;
+		hdev->le_adv_duration = HCI_DEFAULT_ADV_DURATION;
+	} else {
+		hci_dev_set_flag(hdev, HCI_ADVERTISING_INTERVALS);
+		hdev->le_adv_min_interval = cp->min_interval;
+		hdev->le_adv_max_interval = cp->max_interval;
+
+		max_interval_ms = CONVERT_TO_ADV_INTERVAL_MS(cp->max_interval);
+		grace_period = ADV_DURATION_GRACE_PERIOD(max_interval_ms);
+		if (grace_period < ADV_DURATION_MIN_GRACE_PERIOD)
+			grace_period = ADV_DURATION_MIN_GRACE_PERIOD;
+		hdev->le_adv_duration = max_interval_ms + grace_period;
+	}
+	hdev->le_adv_param_changed = true;
+
+	/* hdev->le_adv_duration would be copied to adv instances created
+	 * hereafter. However, for any existing adv instance of which the
+	 * individual_duration_flag is false, we should modify its duration.
+	 */
+	for (instance = 1;  instance <= HCI_MAX_ADV_INSTANCES; instance++) {
+		adv_instance = hci_find_adv_instance(hdev, instance);
+		if (adv_instance && !adv_instance->individual_duration_flag)
+			adv_instance->duration = hdev->le_adv_duration;
+	}
+
+	/* If advertising is not enabled, the new parameters will take effect
+	 * when advertising is enabled.
+	 * If advertising has been enabled, the new parameters will take effect
+	 * when next adv instance is scheduled by
+	 * __hci_req_schedule_adv_instance().
+	 * Hence, it is ok to send settings response now.
+	 */
+	err = send_settings_rsp(sk, MGMT_OP_SET_ADVERTISING_INTERVALS, hdev);
+	new_settings(hdev, sk);
+
+	hci_dev_unlock(hdev);
+
+	return err;
+}
+
 static void set_bredr_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	struct mgmt_pending_cmd *cmd;
@@ -6538,6 +6616,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ read_ext_controller_info,MGMT_READ_EXT_INFO_SIZE,
 						HCI_MGMT_UNTRUSTED },
 	{ set_appearance,	   MGMT_SET_APPEARANCE_SIZE },
+	{ set_advertising_intervals, MGMT_SET_ADVERTISING_INTERVALS_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.7.4
