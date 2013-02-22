Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/14] Bluetooth: Split HCI init sequence into three stages
Date: Fri, 22 Feb 2013 15:12:27 +0200
Message-Id: <1361538759-13558-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1361538759-13558-1-git-send-email-johan.hedberg@gmail.com>
References: <1361538759-13558-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Having contitional command sending during a request has always been
problematic and caused hacks like the hdev->init_last_cmd variable. This
patch removes these conditionals and instead splits the init sequence
into three stages, each with its own __hci_request() call.

This also paves the way to the upcoming transaction framework which will
also benefit by having a simpler implementation if it doesn't need to
cater for transactions that change on the fly.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c  |  271 ++++++++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/hci_event.c |  255 +-----------------------------------------
 2 files changed, 271 insertions(+), 255 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fd6921f..9730424 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -193,6 +193,9 @@ static void bredr_init(struct hci_dev *hdev)
 
 	/* Read Local Version */
 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
+
+	/* Read BD Address */
+	hci_send_cmd(hdev, HCI_OP_READ_BD_ADDR, 0, NULL);
 }
 
 static void amp_init(struct hci_dev *hdev)
@@ -209,7 +212,7 @@ static void amp_init(struct hci_dev *hdev)
 	hci_send_cmd(hdev, HCI_OP_READ_DATA_BLOCK_SIZE, 0, NULL);
 }
 
-static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
+static void hci_init1_req(struct hci_dev *hdev, unsigned long opt)
 {
 	struct sk_buff *skb;
 
@@ -246,6 +249,270 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 	}
 }
 
+static void bredr_setup(struct hci_dev *hdev)
+{
+	struct hci_cp_delete_stored_link_key cp;
+	__le16 param;
+	__u8 flt_type;
+
+	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
+	hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
+
+	/* Read Class of Device */
+	hci_send_cmd(hdev, HCI_OP_READ_CLASS_OF_DEV, 0, NULL);
+
+	/* Read Local Name */
+	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_NAME, 0, NULL);
+
+	/* Read Voice Setting */
+	hci_send_cmd(hdev, HCI_OP_READ_VOICE_SETTING, 0, NULL);
+
+	/* Clear Event Filters */
+	flt_type = HCI_FLT_CLEAR_ALL;
+	hci_send_cmd(hdev, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
+
+	/* Connection accept timeout ~20 secs */
+	param = __constant_cpu_to_le16(0x7d00);
+	hci_send_cmd(hdev, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
+
+	bacpy(&cp.bdaddr, BDADDR_ANY);
+	cp.delete_all = 1;
+	hci_send_cmd(hdev, HCI_OP_DELETE_STORED_LINK_KEY, sizeof(cp), &cp);
+}
+
+static void le_setup(struct hci_dev *hdev)
+{
+	/* Read LE Buffer Size */
+	hci_send_cmd(hdev, HCI_OP_LE_READ_BUFFER_SIZE, 0, NULL);
+
+	/* Read LE Local Supported Features */
+	hci_send_cmd(hdev, HCI_OP_LE_READ_LOCAL_FEATURES, 0, NULL);
+
+	/* Read LE Advertising Channel TX Power */
+	hci_send_cmd(hdev, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
+
+	/* Read LE White List Size */
+	hci_send_cmd(hdev, HCI_OP_LE_READ_WHITE_LIST_SIZE, 0, NULL);
+
+	/* Read LE Supported States */
+	hci_send_cmd(hdev, HCI_OP_LE_READ_SUPPORTED_STATES, 0, NULL);
+}
+
+static u8 hci_get_inquiry_mode(struct hci_dev *hdev)
+{
+	if (lmp_ext_inq_capable(hdev))
+		return 2;
+
+	if (lmp_inq_rssi_capable(hdev))
+		return 1;
+
+	if (hdev->manufacturer == 11 && hdev->hci_rev == 0x00 &&
+	    hdev->lmp_subver == 0x0757)
+		return 1;
+
+	if (hdev->manufacturer == 15) {
+		if (hdev->hci_rev == 0x03 && hdev->lmp_subver == 0x6963)
+			return 1;
+		if (hdev->hci_rev == 0x09 && hdev->lmp_subver == 0x6963)
+			return 1;
+		if (hdev->hci_rev == 0x00 && hdev->lmp_subver == 0x6965)
+			return 1;
+	}
+
+	if (hdev->manufacturer == 31 && hdev->hci_rev == 0x2005 &&
+	    hdev->lmp_subver == 0x1805)
+		return 1;
+
+	return 0;
+}
+
+static void hci_setup_inquiry_mode(struct hci_dev *hdev)
+{
+	u8 mode;
+
+	mode = hci_get_inquiry_mode(hdev);
+
+	hci_send_cmd(hdev, HCI_OP_WRITE_INQUIRY_MODE, 1, &mode);
+}
+
+static void hci_setup_event_mask(struct hci_dev *hdev)
+{
+	/* The second byte is 0xff instead of 0x9f (two reserved bits
+	 * disabled) since a Broadcom 1.2 dongle doesn't respond to the
+	 * command otherwise.
+	 */
+	u8 events[8] = { 0xff, 0xff, 0xfb, 0xff, 0x00, 0x00, 0x00, 0x00 };
+
+	/* CSR 1.1 dongles does not accept any bitfield so don't try to set
+	 * any event mask for pre 1.2 devices.
+	 */
+	if (hdev->hci_ver < BLUETOOTH_VER_1_2)
+		return;
+
+	if (lmp_bredr_capable(hdev)) {
+		events[4] |= 0x01; /* Flow Specification Complete */
+		events[4] |= 0x02; /* Inquiry Result with RSSI */
+		events[4] |= 0x04; /* Read Remote Extended Features Complete */
+		events[5] |= 0x08; /* Synchronous Connection Complete */
+		events[5] |= 0x10; /* Synchronous Connection Changed */
+	}
+
+	if (lmp_inq_rssi_capable(hdev))
+		events[4] |= 0x02; /* Inquiry Result with RSSI */
+
+	if (lmp_sniffsubr_capable(hdev))
+		events[5] |= 0x20; /* Sniff Subrating */
+
+	if (lmp_pause_enc_capable(hdev))
+		events[5] |= 0x80; /* Encryption Key Refresh Complete */
+
+	if (lmp_ext_inq_capable(hdev))
+		events[5] |= 0x40; /* Extended Inquiry Result */
+
+	if (lmp_no_flush_capable(hdev))
+		events[7] |= 0x01; /* Enhanced Flush Complete */
+
+	if (lmp_lsto_capable(hdev))
+		events[6] |= 0x80; /* Link Supervision Timeout Changed */
+
+	if (lmp_ssp_capable(hdev)) {
+		events[6] |= 0x01;	/* IO Capability Request */
+		events[6] |= 0x02;	/* IO Capability Response */
+		events[6] |= 0x04;	/* User Confirmation Request */
+		events[6] |= 0x08;	/* User Passkey Request */
+		events[6] |= 0x10;	/* Remote OOB Data Request */
+		events[6] |= 0x20;	/* Simple Pairing Complete */
+		events[7] |= 0x04;	/* User Passkey Notification */
+		events[7] |= 0x08;	/* Keypress Notification */
+		events[7] |= 0x10;	/* Remote Host Supported
+					 * Features Notification
+					 */
+	}
+
+	if (lmp_le_capable(hdev))
+		events[7] |= 0x20;	/* LE Meta-Event */
+
+	hci_send_cmd(hdev, HCI_OP_SET_EVENT_MASK, sizeof(events), events);
+
+	if (lmp_le_capable(hdev)) {
+		memset(events, 0, sizeof(events));
+		events[0] = 0x1f;
+		hci_send_cmd(hdev, HCI_OP_LE_SET_EVENT_MASK,
+			     sizeof(events), events);
+	}
+}
+
+static void hci_init2_req(struct hci_dev *hdev, unsigned long opt)
+{
+	if (lmp_bredr_capable(hdev))
+		bredr_setup(hdev);
+
+	if (lmp_le_capable(hdev))
+		le_setup(hdev);
+
+	hci_setup_event_mask(hdev);
+
+	if (hdev->hci_ver > BLUETOOTH_VER_1_1)
+		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_COMMANDS, 0, NULL);
+
+	if (lmp_ssp_capable(hdev)) {
+		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
+			u8 mode = 0x01;
+			hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE,
+				     sizeof(mode), &mode);
+		} else {
+			struct hci_cp_write_eir cp;
+
+			memset(hdev->eir, 0, sizeof(hdev->eir));
+			memset(&cp, 0, sizeof(cp));
+
+			hci_send_cmd(hdev, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
+		}
+	}
+
+	if (lmp_inq_rssi_capable(hdev))
+		hci_setup_inquiry_mode(hdev);
+
+	if (lmp_inq_tx_pwr_capable(hdev))
+		hci_send_cmd(hdev, HCI_OP_READ_INQ_RSP_TX_POWER, 0, NULL);
+
+	if (lmp_ext_feat_capable(hdev)) {
+		struct hci_cp_read_local_ext_features cp;
+
+		cp.page = 0x01;
+		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, sizeof(cp),
+			     &cp);
+	}
+
+	if (test_bit(HCI_LINK_SECURITY, &hdev->dev_flags)) {
+		u8 enable = 1;
+		hci_send_cmd(hdev, HCI_OP_WRITE_AUTH_ENABLE, sizeof(enable),
+			     &enable);
+	}
+}
+
+static void hci_setup_link_policy(struct hci_dev *hdev)
+{
+	struct hci_cp_write_def_link_policy cp;
+	u16 link_policy = 0;
+
+	if (lmp_rswitch_capable(hdev))
+		link_policy |= HCI_LP_RSWITCH;
+	if (lmp_hold_capable(hdev))
+		link_policy |= HCI_LP_HOLD;
+	if (lmp_sniff_capable(hdev))
+		link_policy |= HCI_LP_SNIFF;
+	if (lmp_park_capable(hdev))
+		link_policy |= HCI_LP_PARK;
+
+	cp.policy = cpu_to_le16(link_policy);
+	hci_send_cmd(hdev, HCI_OP_WRITE_DEF_LINK_POLICY, sizeof(cp), &cp);
+}
+
+static void hci_set_le_support(struct hci_dev *hdev)
+{
+	struct hci_cp_write_le_host_supported cp;
+
+	memset(&cp, 0, sizeof(cp));
+
+	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
+		cp.le = 1;
+		cp.simul = lmp_le_br_capable(hdev);
+	}
+
+	if (cp.le != lmp_host_le_capable(hdev))
+		hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(cp),
+			     &cp);
+}
+
+static void hci_init3_req(struct hci_dev *hdev, unsigned long opt)
+{
+	if (hdev->commands[5] & 0x10)
+		hci_setup_link_policy(hdev);
+
+	if (lmp_le_capable(hdev))
+		hci_set_le_support(hdev);
+}
+
+static int __hci_init(struct hci_dev *hdev)
+{
+	int err;
+
+	err = __hci_request(hdev, hci_init1_req, 0, HCI_INIT_TIMEOUT);
+	if (err < 0)
+		return err;
+
+	/* AMP controllers do not need stage 2/3 init */
+	if (hdev->dev_type != HCI_BREDR)
+		return 0;
+
+	err = __hci_request(hdev, hci_init2_req, 0, HCI_INIT_TIMEOUT);
+	if (err < 1)
+		return err;
+
+	return __hci_request(hdev, hci_init3_req, 0, HCI_INIT_TIMEOUT);
+}
+
 static void hci_scan_req(struct hci_dev *hdev, unsigned long opt)
 {
 	__u8 scan = opt;
@@ -745,7 +1012,7 @@ int hci_dev_open(__u16 dev)
 		set_bit(HCI_INIT, &hdev->flags);
 		hdev->init_last_cmd = 0;
 
-		ret = __hci_request(hdev, hci_init_req, 0, HCI_INIT_TIMEOUT);
+		ret = __hci_init(hdev);
 
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5892e54..14e872a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -472,211 +472,6 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
-static u8 hci_get_inquiry_mode(struct hci_dev *hdev)
-{
-	if (lmp_ext_inq_capable(hdev))
-		return 2;
-
-	if (lmp_inq_rssi_capable(hdev))
-		return 1;
-
-	if (hdev->manufacturer == 11 && hdev->hci_rev == 0x00 &&
-	    hdev->lmp_subver == 0x0757)
-		return 1;
-
-	if (hdev->manufacturer == 15) {
-		if (hdev->hci_rev == 0x03 && hdev->lmp_subver == 0x6963)
-			return 1;
-		if (hdev->hci_rev == 0x09 && hdev->lmp_subver == 0x6963)
-			return 1;
-		if (hdev->hci_rev == 0x00 && hdev->lmp_subver == 0x6965)
-			return 1;
-	}
-
-	if (hdev->manufacturer == 31 && hdev->hci_rev == 0x2005 &&
-	    hdev->lmp_subver == 0x1805)
-		return 1;
-
-	return 0;
-}
-
-static void hci_setup_inquiry_mode(struct hci_dev *hdev)
-{
-	u8 mode;
-
-	mode = hci_get_inquiry_mode(hdev);
-
-	hci_send_cmd(hdev, HCI_OP_WRITE_INQUIRY_MODE, 1, &mode);
-}
-
-static void hci_setup_event_mask(struct hci_dev *hdev)
-{
-	/* The second byte is 0xff instead of 0x9f (two reserved bits
-	 * disabled) since a Broadcom 1.2 dongle doesn't respond to the
-	 * command otherwise */
-	u8 events[8] = { 0xff, 0xff, 0xfb, 0xff, 0x00, 0x00, 0x00, 0x00 };
-
-	/* CSR 1.1 dongles does not accept any bitfield so don't try to set
-	 * any event mask for pre 1.2 devices */
-	if (hdev->hci_ver < BLUETOOTH_VER_1_2)
-		return;
-
-	if (lmp_bredr_capable(hdev)) {
-		events[4] |= 0x01; /* Flow Specification Complete */
-		events[4] |= 0x02; /* Inquiry Result with RSSI */
-		events[4] |= 0x04; /* Read Remote Extended Features Complete */
-		events[5] |= 0x08; /* Synchronous Connection Complete */
-		events[5] |= 0x10; /* Synchronous Connection Changed */
-	}
-
-	if (lmp_inq_rssi_capable(hdev))
-		events[4] |= 0x02; /* Inquiry Result with RSSI */
-
-	if (lmp_sniffsubr_capable(hdev))
-		events[5] |= 0x20; /* Sniff Subrating */
-
-	if (lmp_pause_enc_capable(hdev))
-		events[5] |= 0x80; /* Encryption Key Refresh Complete */
-
-	if (lmp_ext_inq_capable(hdev))
-		events[5] |= 0x40; /* Extended Inquiry Result */
-
-	if (lmp_no_flush_capable(hdev))
-		events[7] |= 0x01; /* Enhanced Flush Complete */
-
-	if (lmp_lsto_capable(hdev))
-		events[6] |= 0x80; /* Link Supervision Timeout Changed */
-
-	if (lmp_ssp_capable(hdev)) {
-		events[6] |= 0x01;	/* IO Capability Request */
-		events[6] |= 0x02;	/* IO Capability Response */
-		events[6] |= 0x04;	/* User Confirmation Request */
-		events[6] |= 0x08;	/* User Passkey Request */
-		events[6] |= 0x10;	/* Remote OOB Data Request */
-		events[6] |= 0x20;	/* Simple Pairing Complete */
-		events[7] |= 0x04;	/* User Passkey Notification */
-		events[7] |= 0x08;	/* Keypress Notification */
-		events[7] |= 0x10;	/* Remote Host Supported
-					 * Features Notification */
-	}
-
-	if (lmp_le_capable(hdev))
-		events[7] |= 0x20;	/* LE Meta-Event */
-
-	hci_send_cmd(hdev, HCI_OP_SET_EVENT_MASK, sizeof(events), events);
-
-	if (lmp_le_capable(hdev)) {
-		memset(events, 0, sizeof(events));
-		events[0] = 0x1f;
-		hci_send_cmd(hdev, HCI_OP_LE_SET_EVENT_MASK,
-			     sizeof(events), events);
-	}
-}
-
-static void bredr_setup(struct hci_dev *hdev)
-{
-	struct hci_cp_delete_stored_link_key cp;
-	__le16 param;
-	__u8 flt_type;
-
-	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
-	hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
-
-	/* Read Class of Device */
-	hci_send_cmd(hdev, HCI_OP_READ_CLASS_OF_DEV, 0, NULL);
-
-	/* Read Local Name */
-	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_NAME, 0, NULL);
-
-	/* Read Voice Setting */
-	hci_send_cmd(hdev, HCI_OP_READ_VOICE_SETTING, 0, NULL);
-
-	/* Clear Event Filters */
-	flt_type = HCI_FLT_CLEAR_ALL;
-	hci_send_cmd(hdev, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
-
-	/* Connection accept timeout ~20 secs */
-	param = __constant_cpu_to_le16(0x7d00);
-	hci_send_cmd(hdev, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
-
-	bacpy(&cp.bdaddr, BDADDR_ANY);
-	cp.delete_all = 1;
-	hci_send_cmd(hdev, HCI_OP_DELETE_STORED_LINK_KEY, sizeof(cp), &cp);
-}
-
-static void le_setup(struct hci_dev *hdev)
-{
-	/* Read LE Buffer Size */
-	hci_send_cmd(hdev, HCI_OP_LE_READ_BUFFER_SIZE, 0, NULL);
-
-	/* Read LE Local Supported Features */
-	hci_send_cmd(hdev, HCI_OP_LE_READ_LOCAL_FEATURES, 0, NULL);
-
-	/* Read LE Advertising Channel TX Power */
-	hci_send_cmd(hdev, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
-
-	/* Read LE White List Size */
-	hci_send_cmd(hdev, HCI_OP_LE_READ_WHITE_LIST_SIZE, 0, NULL);
-
-	/* Read LE Supported States */
-	hci_send_cmd(hdev, HCI_OP_LE_READ_SUPPORTED_STATES, 0, NULL);
-}
-
-static void hci_setup(struct hci_dev *hdev)
-{
-	if (hdev->dev_type != HCI_BREDR)
-		return;
-
-	/* Read BD Address */
-	hci_send_cmd(hdev, HCI_OP_READ_BD_ADDR, 0, NULL);
-
-	if (lmp_bredr_capable(hdev))
-		bredr_setup(hdev);
-
-	if (lmp_le_capable(hdev))
-		le_setup(hdev);
-
-	hci_setup_event_mask(hdev);
-
-	if (hdev->hci_ver > BLUETOOTH_VER_1_1)
-		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_COMMANDS, 0, NULL);
-
-	if (lmp_ssp_capable(hdev)) {
-		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
-			u8 mode = 0x01;
-			hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE,
-				     sizeof(mode), &mode);
-		} else {
-			struct hci_cp_write_eir cp;
-
-			memset(hdev->eir, 0, sizeof(hdev->eir));
-			memset(&cp, 0, sizeof(cp));
-
-			hci_send_cmd(hdev, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
-		}
-	}
-
-	if (lmp_inq_rssi_capable(hdev))
-		hci_setup_inquiry_mode(hdev);
-
-	if (lmp_inq_tx_pwr_capable(hdev))
-		hci_send_cmd(hdev, HCI_OP_READ_INQ_RSP_TX_POWER, 0, NULL);
-
-	if (lmp_ext_feat_capable(hdev)) {
-		struct hci_cp_read_local_ext_features cp;
-
-		cp.page = 0x01;
-		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, sizeof(cp),
-			     &cp);
-	}
-
-	if (test_bit(HCI_LINK_SECURITY, &hdev->dev_flags)) {
-		u8 enable = 1;
-		hci_send_cmd(hdev, HCI_OP_WRITE_AUTH_ENABLE, sizeof(enable),
-			     &enable);
-	}
-}
-
 static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_read_local_version *rp = (void *) skb->data;
@@ -695,31 +490,10 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s manufacturer 0x%4.4x hci ver %d:%d", hdev->name,
 	       hdev->manufacturer, hdev->hci_ver, hdev->hci_rev);
 
-	if (test_bit(HCI_INIT, &hdev->flags))
-		hci_setup(hdev);
-
 done:
 	hci_req_complete(hdev, HCI_OP_READ_LOCAL_VERSION, rp->status);
 }
 
-static void hci_setup_link_policy(struct hci_dev *hdev)
-{
-	struct hci_cp_write_def_link_policy cp;
-	u16 link_policy = 0;
-
-	if (lmp_rswitch_capable(hdev))
-		link_policy |= HCI_LP_RSWITCH;
-	if (lmp_hold_capable(hdev))
-		link_policy |= HCI_LP_HOLD;
-	if (lmp_sniff_capable(hdev))
-		link_policy |= HCI_LP_SNIFF;
-	if (lmp_park_capable(hdev))
-		link_policy |= HCI_LP_PARK;
-
-	cp.policy = cpu_to_le16(link_policy);
-	hci_send_cmd(hdev, HCI_OP_WRITE_DEF_LINK_POLICY, sizeof(cp), &cp);
-}
-
 static void hci_cc_read_local_commands(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
@@ -727,15 +501,9 @@ static void hci_cc_read_local_commands(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
-	if (rp->status)
-		goto done;
-
-	memcpy(hdev->commands, rp->commands, sizeof(hdev->commands));
-
-	if (test_bit(HCI_INIT, &hdev->flags) && (hdev->commands[5] & 0x10))
-		hci_setup_link_policy(hdev);
+	if (!rp->status)
+		memcpy(hdev->commands, rp->commands, sizeof(hdev->commands));
 
-done:
 	hci_req_complete(hdev, HCI_OP_READ_LOCAL_COMMANDS, rp->status);
 }
 
@@ -795,22 +563,6 @@ static void hci_cc_read_local_features(struct hci_dev *hdev,
 	       hdev->features[6], hdev->features[7]);
 }
 
-static void hci_set_le_support(struct hci_dev *hdev)
-{
-	struct hci_cp_write_le_host_supported cp;
-
-	memset(&cp, 0, sizeof(cp));
-
-	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
-		cp.le = 1;
-		cp.simul = lmp_le_br_capable(hdev);
-	}
-
-	if (cp.le != lmp_host_le_capable(hdev))
-		hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(cp),
-			     &cp);
-}
-
 static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
@@ -830,9 +582,6 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 		break;
 	}
 
-	if (test_bit(HCI_INIT, &hdev->flags) && lmp_le_capable(hdev))
-		hci_set_le_support(hdev);
-
 done:
 	hci_req_complete(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, rp->status);
 }
-- 
1.7.10.4

