Return-Path: <cyrus@holtmann.org>
From: Timo Mueller <mail@timomueller.eu>
To: linux-bluetooth@vger.kernel.org
Cc: Timo Mueller <timo.mueller@bmw-carit.de>
Subject: [RFCv4 5/5] Bluetooth: Add management command to relax MITM Protection
Date: Thu, 19 Dec 2013 14:08:18 +0100
Message-Id: <abe483e1f04d10ca279df486f0fe6e9cc3cde1b8.1387450436.git.timo.mueller@bmw-carit.de>
In-Reply-To: <09d079229a9f9a1090e4326b0302a67a9bf0bc97.1387450436.git.timo.mueller@bmw-carit.de>
References: <cover.1387450435.git.timo.mueller@bmw-carit.de>
 <f8e5fc8f70fc013f80c95245a94f6c31c2dfb8f2.1387450436.git.timo.mueller@bmw-carit.de>
 <e95862fa0cf2deb0a55144702941359ea52dda5d.1387450436.git.timo.mueller@bmw-carit.de>
 <60907bf145b53d5bf72ebf8307ee546b707cc4ae.1387450436.git.timo.mueller@bmw-carit.de>
 <09d079229a9f9a1090e4326b0302a67a9bf0bc97.1387450436.git.timo.mueller@bmw-carit.de>
In-Reply-To: <cover.1387450435.git.timo.mueller@bmw-carit.de>
References: <cover.1387450435.git.timo.mueller@bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Timo Mueller <timo.mueller@bmw-carit.de>

As a general rule, the Bluetooth Specification (v4.0 Volume 3, part C,
section 6.5.3) recommends *NOT* to require MITM Protection, unless the
available local services require it. The Kernel doesn't however adhere
to this recommendation because the locally available services are not
known reliably.

This lack of information is exactly what this patch addresses: a
dedicated flag is proposed in the management interface. If set to 1, the
recommentation described in the specification will be followed: it will
be assumed that none of the locally available services require MITM
Protection, unless the Kernel has any evidence of the contrary (i.e. a
socket exists with a high security level, which requires MITM
Protection).

If set to 0, MITM Protection will always be required, provided that it
is possible according to the I/O capabilities. This was the behavior
prior to this patch and therefore the flag is set to 0 by default.

Note that this affects General Bonding and Dedicated Bonding equally as
well as locally or remotely initiated pairing procedures.

Signed-off-by: Timo Mueller <timo.mueller@bmw-carit.de>
---
 include/net/bluetooth/hci.h  |  3 ++-
 include/net/bluetooth/mgmt.h |  3 +++
 net/bluetooth/hci_event.c    | 15 ++++++++++++---
 net/bluetooth/mgmt.c         | 45 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5dc3d90..147fac6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -121,6 +121,7 @@ enum {
 
 	HCI_LE_SCAN,
 	HCI_SSP_ENABLED,
+	HCI_RELAX_MITM,
 	HCI_HS_ENABLED,
 	HCI_LE_ENABLED,
 	HCI_ADVERTISING,
@@ -138,7 +139,7 @@ enum {
  * or the HCI device is closed.
  */
 #define HCI_PERSISTENT_MASK (BIT(HCI_LE_SCAN) | BIT(HCI_PERIODIC_INQ) | \
-			      BIT(HCI_FAST_CONNECTABLE))
+			      BIT(HCI_FAST_CONNECTABLE) | BIT(HCI_RELAX_MITM))
 
 /* HCI ioctl defines */
 #define HCIDEVUP	_IOW('H', 201, int)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 518c5c8..2da018b 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -94,6 +94,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_HS			0x00000100
 #define MGMT_SETTING_LE			0x00000200
 #define MGMT_SETTING_ADVERTISING	0x00000400
+#define MGMT_SETTING_RELAX_MITM	0x00000800
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
@@ -369,6 +370,8 @@ struct mgmt_cp_set_scan_params {
 } __packed;
 #define MGMT_SET_SCAN_PARAMS_SIZE	4
 
+#define MGMT_OP_SET_RELAX_MITM		0x002D
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4516215..d23370b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3042,6 +3042,12 @@ static u8 hci_get_auth_req(struct hci_conn *conn)
 	    conn->remote_auth == HCI_AT_NO_BONDING_MITM)
 		return conn->remote_auth | (conn->auth_type & 0x01);
 
+	/* MITM Protection should be used only if strictly required, so follow
+	 * the recommendation in the Spec and do not require it otherwise
+	 */
+	if (test_bit(HCI_RELAX_MITM, &conn->hdev->dev_flags))
+		return conn->remote_auth | (conn->auth_type & 0x01);
+
 	/* If both remote and local have enough IO capabilities, require
 	 * MITM protection
 	 */
@@ -3085,11 +3091,14 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		if (conn->remote_auth == 0xff) {
 			cp.authentication = conn->auth_type;
 
-			/* Request MITM protection if our IO caps allow it
-			 * except for the no-bonding case
+			/* MITM Protection should be used only if strictly
+			 * required, so follow the recommendation in the Spec
+			 * and do not require it otherwise (no-bonding is left
+			 * unmodified in any case)
 			 */
 			if (conn->io_capability != HCI_IO_NO_INPUT_OUTPUT &&
-			    cp.authentication != HCI_AT_NO_BONDING)
+			    cp.authentication != HCI_AT_NO_BONDING &&
+			    !test_bit(HCI_RELAX_MITM, &conn->hdev->dev_flags))
 				cp.authentication |= 0x01;
 		} else {
 			conn->auth_type = hci_get_auth_req(conn);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8e302f4..2aca565 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -79,6 +79,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_BREDR,
 	MGMT_OP_SET_STATIC_ADDRESS,
 	MGMT_OP_SET_SCAN_PARAMS,
+	MGMT_OP_SET_RELAX_MITM,
 };
 
 static const u16 mgmt_events[] = {
@@ -375,6 +376,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 		if (lmp_ssp_capable(hdev)) {
 			settings |= MGMT_SETTING_SSP;
 			settings |= MGMT_SETTING_HS;
+			settings |= MGMT_SETTING_RELAX_MITM;
 		}
 	}
 
@@ -423,6 +425,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
 		settings |= MGMT_SETTING_ADVERTISING;
 
+	if (test_bit(HCI_RELAX_MITM, &hdev->dev_flags))
+		settings |= MGMT_SETTING_RELAX_MITM;
+
 	return settings;
 }
 
@@ -1719,6 +1724,45 @@ failed:
 	return err;
 }
 
+static int set_relax_mitm(struct sock *sk, struct hci_dev *hdev, void *data,
+			    u16 len)
+{
+	struct mgmt_mode *cp = data;
+	u8 val;
+	int err;
+
+	BT_DBG("request for %s", hdev->name);
+
+	if (!lmp_ssp_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_RELAX_MITM,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
+	if (cp->val != 0x00 && cp->val != 0x01)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_RELAX_MITM,
+				  MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	val = !!cp->val;
+
+	if (val == test_bit(HCI_RELAX_MITM, &hdev->dev_flags)) {
+		err = send_settings_rsp(sk, MGMT_OP_SET_RELAX_MITM, hdev);
+		goto failed;
+	}
+
+	change_bit(HCI_RELAX_MITM, &hdev->dev_flags);
+
+	err = send_settings_rsp(sk, MGMT_OP_SET_RELAX_MITM, hdev);
+	if (err < 0)
+		goto failed;
+
+	err = new_settings(hdev, sk);
+
+failed:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
@@ -4124,6 +4168,7 @@ static const struct mgmt_handler {
 	{ set_bredr,              false, MGMT_SETTING_SIZE },
 	{ set_static_address,     false, MGMT_SET_STATIC_ADDRESS_SIZE },
 	{ set_scan_params,        false, MGMT_SET_SCAN_PARAMS_SIZE },
+	{ set_relax_mitm,        false, MGMT_SETTING_SIZE },
 };
 
 
-- 
1.8.3.1

