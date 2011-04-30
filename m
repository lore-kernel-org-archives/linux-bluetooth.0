Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 11/16] Implement start_discovery hciops callback
Date: Fri, 29 Apr 2011 21:27:27 -0300
Message-Id: <1304123252-14464-12-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/hciops.c |   98 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 965e9de..23e8915 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -56,11 +56,26 @@
 #define DISCOV_INQ 1
 #define DISCOV_SCAN 2
 
+#define TIMEOUT_BR_LE_SCAN 5120 /* TGAP(100)/2 */
+#define TIMEOUT_LE_SCAN 10240 /* TGAP(gen_disc_scan_min) */
+
+#define LENGTH_BR_INQ 0x08
+#define LENGTH_BR_LE_INQ 0x04
+
+static int hciops_start_scanning(int index, int timeout);
+
 static int child_pipe[2] = { -1, -1 };
 
 static guint child_io_id = 0;
 static guint ctl_io_id = 0;
 
+enum adapter_type {
+	BR_EDR,
+	LE_ONLY,
+	BR_EDR_LE,
+	UNKNOWN,
+};
+
 /* Commands sent by kernel on starting an adapter */
 enum {
 	PENDING_BDADDR,
@@ -151,27 +166,74 @@ static inline int get_state(int index)
 	return dev->discov_state;
 }
 
+static inline gboolean is_resolvname_enabled(void)
+{
+	return main_opts.name_resolv ? TRUE : FALSE;
+}
+
 static void set_state(int index, int state)
 {
+	struct btd_adapter *adapter;
 	struct dev_info *dev = &devs[index];
 
 	if (dev->discov_state == state)
 		return;
 
+	adapter = manager_find_adapter_by_id(index);
+	if (!adapter) {
+		error("No matching adapter found");
+		return;
+	}
+
 	dev->discov_state = state;
 
 	DBG("hci%d: new state %d", index, dev->discov_state);
 
 	switch (dev->discov_state) {
 	case DISCOV_HALTED:
+		if (adapter_get_state(adapter) == STATE_SUSPENDED)
+			return;
+
+		if (is_resolvname_enabled() &&
+					adapter_has_discov_sessions(adapter))
+			adapter_set_state(adapter, STATE_RESOLVNAME);
+		else
+			adapter_set_state(adapter, STATE_IDLE);
 		break;
 	case DISCOV_INQ:
-		break;
 	case DISCOV_SCAN:
+		adapter_set_state(adapter, STATE_DISCOV);
 		break;
 	}
 }
 
+static inline gboolean is_le_capable(int index)
+{
+	struct dev_info *dev = &devs[index];
+
+	return (main_opts.le && dev->features[4] & LMP_LE &&
+			dev->extfeatures[0] & LMP_HOST_LE) ? TRUE : FALSE;
+}
+
+static inline gboolean is_bredr_capable(int index)
+{
+	struct dev_info *dev = &devs[index];
+
+	return (dev->features[4] & LMP_NO_BREDR) == 0 ? TRUE : FALSE;
+}
+
+static int get_adapter_type(int index)
+{
+	if (is_le_capable(index) && is_bredr_capable(index))
+		return BR_EDR_LE;
+	else if (is_le_capable(index))
+		return LE_ONLY;
+	else if (is_bredr_capable(index))
+		return BR_EDR;
+
+	return UNKNOWN;
+}
+
 static int ignore_device(struct hci_dev_info *di)
 {
 	return hci_test_bit(HCI_RAW, &di->flags) || di->type >> 4 != HCI_BREDR;
@@ -1831,12 +1893,30 @@ static void read_local_oob_data_complete(int index, uint8_t status,
 
 static inline void inquiry_complete_evt(int index, uint8_t status)
 {
+	int adapter_type;
+	struct btd_adapter *adapter;
+
 	if (status) {
 		error("Inquiry Failed with status 0x%02x", status);
 		return;
 	}
 
-	set_state(index, DISCOV_HALTED);
+	adapter = manager_find_adapter_by_id(index);
+	if (!adapter) {
+		error("No matching adapter found");
+		return;
+	}
+
+	adapter_type = get_adapter_type(index);
+
+	if (adapter_type == BR_EDR_LE &&
+					adapter_has_discov_sessions(adapter)) {
+		int err = hciops_start_scanning(index, TIMEOUT_BR_LE_SCAN);
+		if (err < 0)
+			set_state(index, DISCOV_HALTED);
+	} else {
+		set_state(index, DISCOV_HALTED);
+	}
 }
 
 static inline void cc_inquiry_cancel(int index, uint8_t status)
@@ -3159,8 +3239,18 @@ static int hciops_cancel_resolve_name(int index, bdaddr_t *bdaddr)
 
 static int hciops_start_discovery(int index)
 {
-	DBG("index %d", index);
-	return -ENOSYS;
+	int adapter_type = get_adapter_type(index);
+
+	switch (adapter_type) {
+	case BR_EDR_LE:
+		return hciops_start_inquiry(index, LENGTH_BR_LE_INQ, FALSE);
+	case BR_EDR:
+		return hciops_start_inquiry(index, LENGTH_BR_INQ, FALSE);
+	case LE_ONLY:
+		return hciops_start_scanning(index, TIMEOUT_LE_SCAN);
+	default:
+		return -EINVAL;
+	}
 }
 
 static int hciops_stop_discovery(int index)
-- 
1.7.1

