Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] Bluetooth: Add support for setting LE advertising data
Date: Thu, 25 Oct 2012 00:09:56 +0300
Message-Id: <1351112996-9597-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
References: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds support for setting basing LE advertising data. The
three elements supported for now are the advertising flags, the TX power
and the friendly name.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h      |   15 ++++++
 include/net/bluetooth/hci_core.h |    2 +
 net/bluetooth/hci_event.c        |    9 ++++
 net/bluetooth/mgmt.c             |  102 ++++++++++++++++++++++++++++++++++++--
 4 files changed, 125 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index a633da0..f850e94 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -335,6 +335,13 @@ enum {
 #define EIR_SSP_RAND_R		0x0F /* Simple Pairing Randomizer R */
 #define EIR_DEVICE_ID		0x10 /* device ID */
 
+/* Low Energy Advertising Flags */
+#define LE_AD_LIMITED		0x01 /* Limited Discoverable */
+#define LE_AD_GENERAL		0x02 /* General Discoverable */
+#define LE_AD_NO_BREDR		0x04 /* BR/EDR not supported */
+#define LE_AD_SIM_LE_BREDR_CTRL	0x08 /* Simultaneous LE & BR/EDR Controller */
+#define LE_AD_SIM_LE_BREDR_HOST	0x10 /* Simultaneous LE & BR/EDR Host */
+
 /* -----  HCI Commands ---- */
 #define HCI_OP_NOP			0x0000
 
@@ -939,6 +946,14 @@ struct hci_rp_le_read_adv_tx_power {
 	__s8	tx_power;
 } __packed;
 
+#define HCI_MAX_AD_LENGTH		31
+
+#define HCI_OP_LE_SET_ADV_DATA		0x2008
+struct hci_cp_le_set_adv_data {
+	__u8		length;
+	__u8		data[HCI_MAX_AD_LENGTH];
+} __packed;
+
 #define HCI_OP_LE_SET_ADV_ENABLE	0x200a
 
 #define HCI_OP_LE_SET_SCAN_PARAM	0x200b
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9d7e94e..0981d3c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -279,6 +279,8 @@ struct hci_dev {
 	struct le_scan_params	le_scan_params;
 
 	__s8			adv_tx_power;
+	__u8			adv_data[HCI_MAX_AD_LENGTH];
+	__u8			adv_data_len;
 
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ed6b1e2..3691251 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1108,6 +1108,15 @@ static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
 	if (!rp->status)
 		hdev->adv_tx_power = rp->tx_power;
 
+	if (hdev->adv_data_len > 0) {
+		struct hci_cp_le_set_adv_data cp;
+
+		memcpy(cp.data, hdev->adv_data, sizeof(cp.data));
+		cp.length = cpu_to_le16(hdev->adv_data_len);
+
+		hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
+	}
+
 	hci_req_complete(hdev, HCI_OP_LE_READ_ADV_TX_POWER, rp->status);
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6770835..98c776a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -593,6 +593,93 @@ static int update_eir(struct hci_dev *hdev)
 	return hci_send_cmd(hdev, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
 }
 
+static u16 create_ad(struct hci_dev *hdev, u8 *data)
+{
+	u8 *ptr = data;
+	u16 ad_len = 0;
+	size_t name_len;
+	u8 flags = 0;
+
+	if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
+		flags |= LE_AD_GENERAL;
+
+	if (!lmp_bredr_capable(hdev))
+		flags |= LE_AD_NO_BREDR;
+
+	if (lmp_le_br_capable(hdev))
+		flags |= LE_AD_SIM_LE_BREDR_CTRL;
+
+	if (lmp_host_le_br_capable(hdev))
+		flags |= LE_AD_SIM_LE_BREDR_HOST;
+
+	if (flags) {
+		BT_DBG("adv flags 0x%02x", flags);
+
+		ptr[0] = 2;
+		ptr[1] = EIR_FLAGS;
+		ptr[2] = flags;
+
+		ad_len += 3;
+		ptr += 3;
+	}
+
+	if (hdev->adv_tx_power) {
+		ptr[0] = 2;
+		ptr[1] = EIR_TX_POWER;
+		ptr[2] = (u8) hdev->adv_tx_power;
+
+		ad_len += 3;
+		ptr += 3;
+	}
+
+	name_len = strlen(hdev->dev_name);
+	if (name_len > 0) {
+		size_t max_len = HCI_MAX_AD_LENGTH - ad_len - 2;
+
+		if (name_len > max_len) {
+			name_len = max_len;
+			ptr[1] = EIR_NAME_SHORT;
+		} else
+			ptr[1] = EIR_NAME_COMPLETE;
+
+		ptr[0] = name_len + 1;
+
+		memcpy(ptr + 2, hdev->dev_name, name_len);
+
+		ad_len += (name_len + 2);
+		ptr += (name_len + 2);
+	}
+
+	return ad_len;
+}
+
+static int update_ad(struct hci_dev *hdev)
+{
+	struct hci_cp_le_set_adv_data cp;
+	u16 len;
+
+	if (!hdev_is_powered(hdev))
+		return 0;
+
+	if (!lmp_le_capable(hdev))
+		return 0;
+
+	memset(&cp, 0, sizeof(cp));
+
+	len = create_ad(hdev, cp.data);
+
+	if (hdev->adv_data_len == len &&
+	    memcmp(cp.data, hdev->adv_data, len) == 0)
+		return 0;
+
+	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
+	hdev->adv_data_len = len;
+
+	cp.length = cpu_to_le16(len);
+
+	return hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
+}
+
 static u8 get_service_classes(struct hci_dev *hdev)
 {
 	struct bt_uuid *uuid;
@@ -1279,8 +1366,10 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	/* If we're switching away from or into peripheral role toggle
 	 * the corresponding flag
 	 */
-	if (old_mode == MGMT_LE_PERIPHERAL || new_mode == MGMT_LE_PERIPHERAL)
+	if (old_mode == MGMT_LE_PERIPHERAL || new_mode == MGMT_LE_PERIPHERAL) {
 		change_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
+		update_ad(hdev);
+	}
 
 	if (!hdev_is_powered(hdev)) {
 		if (old_mode == MGMT_LE_OFF || new_mode == MGMT_LE_OFF)
@@ -3002,6 +3091,7 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 			update_name(hdev, hdev->dev_name);
 			update_eir(hdev);
 		}
+		update_ad(hdev);
 	} else {
 		u8 status = MGMT_STATUS_NOT_POWERED;
 		mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
@@ -3582,12 +3672,14 @@ send_event:
 		err = mgmt_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev, &ev,
 				 sizeof(ev), cmd ? cmd->sk : NULL);
 
-	/* EIR is taken care of separately when powering on the
+	/* EIR and AD are taken care of separately when powering on the
 	 * adapter so only update them here if this is a name change
 	 * unrelated to power on.
 	 */
-	if (!test_bit(HCI_INIT, &hdev->flags))
+	if (!test_bit(HCI_INIT, &hdev->flags)) {
 		update_eir(hdev);
+		update_ad(hdev);
+	}
 
 failed:
 	if (cmd)
@@ -3662,6 +3754,8 @@ int mgmt_le_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	if (enable && cp->val == MGMT_LE_PERIPHERAL)
 		return hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE,
 				    sizeof(enable), &enable);
+	else
+		update_ad(hdev);
 
 	send_settings_rsp(cmd->sk, cmd->opcode, hdev);
 	list_del(&cmd->list);
@@ -3687,6 +3781,8 @@ int mgmt_le_adv_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 		mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, cmd_status_rsp,
 				     &mgmt_err);
 
+		update_ad(hdev);
+
 		return 0;
 	}
 
-- 
1.7.10.4

