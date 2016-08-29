Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Add framework for Extended Controller Information
Date: Mon, 29 Aug 2016 18:57:58 +0200
Message-Id: <1472489878-28374-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h  |  1 +
 include/net/bluetooth/mgmt.h | 18 +++++++++++++
 net/bluetooth/mgmt.c         | 62 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ddb9accac3a5..99aa5e5e3100 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -208,6 +208,7 @@ enum {
 	HCI_MGMT_INDEX_EVENTS,
 	HCI_MGMT_UNCONF_INDEX_EVENTS,
 	HCI_MGMT_EXT_INDEX_EVENTS,
+	HCI_MGMT_EXT_INFO_EVENTS,
 	HCI_MGMT_OPTION_EVENTS,
 	HCI_MGMT_SETTING_EVENTS,
 	HCI_MGMT_DEV_CLASS_EVENTS,
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 7647964b1efa..611b243713ea 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -586,6 +586,18 @@ struct mgmt_rp_get_adv_size_info {
 
 #define MGMT_OP_START_LIMITED_DISCOVERY	0x0041
 
+#define MGMT_OP_READ_EXT_INFO		0x0042
+#define MGMT_READ_EXT_INFO_SIZE		0
+struct mgmt_rp_read_ext_info {
+	bdaddr_t bdaddr;
+	__u8     version;
+	__le16   manufacturer;
+	__le32   supported_settings;
+	__le32   current_settings;
+	__le16   eir_len;
+	__u8     eir[0];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
@@ -800,3 +812,9 @@ struct mgmt_ev_advertising_added {
 struct mgmt_ev_advertising_removed {
 	__u8    instance;
 } __packed;
+
+#define MGMT_EV_EXT_INFO_CHANGED	0x0025
+struct mgmt_ev_ext_info_changed {
+	__le16	eir_len;
+	__u8	eir[0];
+} __packed;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 47efdb4a669a..69001f415efa 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -104,6 +104,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_REMOVE_ADVERTISING,
 	MGMT_OP_GET_ADV_SIZE_INFO,
 	MGMT_OP_START_LIMITED_DISCOVERY,
+	MGMT_OP_READ_EXT_INFO,
 };
 
 static const u16 mgmt_events[] = {
@@ -141,6 +142,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_LOCAL_OOB_DATA_UPDATED,
 	MGMT_EV_ADVERTISING_ADDED,
 	MGMT_EV_ADVERTISING_REMOVED,
+	MGMT_EV_EXT_INFO_CHANGED,
 };
 
 static const u16 mgmt_untrusted_commands[] = {
@@ -149,6 +151,7 @@ static const u16 mgmt_untrusted_commands[] = {
 	MGMT_OP_READ_UNCONF_INDEX_LIST,
 	MGMT_OP_READ_CONFIG_INFO,
 	MGMT_OP_READ_EXT_INDEX_LIST,
+	MGMT_OP_READ_EXT_INFO,
 };
 
 static const u16 mgmt_untrusted_events[] = {
@@ -162,6 +165,7 @@ static const u16 mgmt_untrusted_events[] = {
 	MGMT_EV_NEW_CONFIG_OPTIONS,
 	MGMT_EV_EXT_INDEX_ADDED,
 	MGMT_EV_EXT_INDEX_REMOVED,
+	MGMT_EV_EXT_INFO_CHANGED,
 };
 
 #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
@@ -862,6 +866,52 @@ static int read_controller_info(struct sock *sk, struct hci_dev *hdev,
 				 sizeof(rp));
 }
 
+static int read_ext_controller_info(struct sock *sk, struct hci_dev *hdev,
+				    void *data, u16 data_len)
+{
+	struct mgmt_rp_read_ext_info rp;
+
+	BT_DBG("sock %p %s", sk, hdev->name);
+
+	hci_dev_lock(hdev);
+
+	memset(&rp, 0, sizeof(rp));
+
+	bacpy(&rp.bdaddr, &hdev->bdaddr);
+
+	rp.version = hdev->hci_ver;
+	rp.manufacturer = cpu_to_le16(hdev->manufacturer);
+
+	rp.supported_settings = cpu_to_le32(get_supported_settings(hdev));
+	rp.current_settings = cpu_to_le32(get_current_settings(hdev));
+
+	rp.eir_len = cpu_to_le16(0);
+
+	hci_dev_unlock(hdev);
+
+	/* If this command is called at least once, then the events
+	 * for class of device and local name changes are disabled
+	 * and only the new extended controller information event
+	 * is used.
+	 */
+	hci_sock_set_flag(sk, HCI_MGMT_EXT_INFO_EVENTS);
+	hci_sock_clear_flag(sk, HCI_MGMT_DEV_CLASS_EVENTS);
+	hci_sock_clear_flag(sk, HCI_MGMT_LOCAL_NAME_EVENTS);
+
+	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_READ_EXT_INFO, 0, &rp,
+				 sizeof(rp));
+}
+
+static int ext_info_changed(struct hci_dev *hdev, struct sock *skip)
+{
+	struct mgmt_ev_ext_info_changed ev;
+
+	ev.eir_len = cpu_to_le16(0);
+
+	return mgmt_limited_event(MGMT_EV_EXT_INFO_CHANGED, hdev, &ev,
+				  sizeof(ev), HCI_MGMT_EXT_INFO_EVENTS, skip);
+}
+
 static int send_settings_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev)
 {
 	__le32 settings = cpu_to_le32(get_current_settings(hdev));
@@ -2995,6 +3045,7 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		err = mgmt_limited_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev, data,
 					 len, HCI_MGMT_LOCAL_NAME_EVENTS, sk);
+		ext_info_changed(hdev, sk);
 
 		goto failed;
 	}
@@ -6356,6 +6407,8 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ remove_advertising,	   MGMT_REMOVE_ADVERTISING_SIZE },
 	{ get_adv_size_info,       MGMT_GET_ADV_SIZE_INFO_SIZE },
 	{ start_limited_discovery, MGMT_START_DISCOVERY_SIZE },
+	{ read_ext_controller_info,MGMT_READ_EXT_INFO_SIZE,
+						HCI_MGMT_UNTRUSTED },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
@@ -6494,10 +6547,12 @@ void __mgmt_power_off(struct hci_dev *hdev)
 
 	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status);
 
-	if (memcmp(hdev->dev_class, zero_cod, sizeof(zero_cod)) != 0)
+	if (memcmp(hdev->dev_class, zero_cod, sizeof(zero_cod)) != 0) {
 		mgmt_limited_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
 				   zero_cod, sizeof(zero_cod),
 				   HCI_MGMT_DEV_CLASS_EVENTS, NULL);
+		ext_info_changed(hdev, NULL);
+	}
 
 	new_settings(hdev, match.sk);
 
@@ -7093,9 +7148,11 @@ void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 	mgmt_pending_foreach(MGMT_OP_ADD_UUID, hdev, sk_lookup, &match);
 	mgmt_pending_foreach(MGMT_OP_REMOVE_UUID, hdev, sk_lookup, &match);
 
-	if (!status)
+	if (!status) {
 		mgmt_limited_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev, dev_class,
 				   3, HCI_MGMT_DEV_CLASS_EVENTS, NULL);
+		ext_info_changed(hdev, NULL);
+	}
 
 	if (match.sk)
 		sock_put(match.sk);
@@ -7126,6 +7183,7 @@ void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 
 	mgmt_limited_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev, &ev, sizeof(ev),
 			   HCI_MGMT_LOCAL_NAME_EVENTS, cmd ? cmd->sk : NULL);
+	ext_info_changed(hdev, cmd ? cmd->sk : NULL);
 }
 
 static inline bool has_uuid(u8 *uuid, u16 uuid_count, u8 (*uuids)[16])
-- 
2.7.4

