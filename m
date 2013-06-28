Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Timo Mueller <timo.mueller@bmw-carit.de>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v3 8/8] Bluetooth: Add management command to relax MITM Protection
Date: Fri, 28 Jun 2013 10:56:34 +0200
Message-Id: <1372409794-24688-9-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372409794-24688-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372409794-24688-1-git-send-email-mikel.astiz.oss@gmail.com>
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
Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
---
 include/net/bluetooth/hci.h  |  3 ++-
 include/net/bluetooth/mgmt.h |  3 +++
 net/bluetooth/hci_event.c    | 15 +++++++++++---
 net/bluetooth/mgmt.c         | 48 +++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index a01fbb4..9973fcc 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -112,6 +112,7 @@ enum {
 
 	HCI_LE_SCAN,
 	HCI_SSP_ENABLED,
+	HCI_RELAX_MITM,
 	HCI_HS_ENABLED,
 	HCI_LE_ENABLED,
 	HCI_LE_PERIPHERAL,
@@ -126,7 +127,7 @@ enum {
  * or the HCI device is closed.
  */
 #define HCI_PERSISTENT_MASK (BIT(HCI_LE_SCAN) | BIT(HCI_PERIODIC_INQ) | \
-			      BIT(HCI_FAST_CONNECTABLE))
+			      BIT(HCI_FAST_CONNECTABLE) | BIT(HCI_RELAX_MITM))
 
 /* HCI ioctl defines */
 #define HCIDEVUP	_IOW('H', 201, int)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 9944c3e..9a3218f 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -93,6 +93,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_BREDR		0x00000080
 #define MGMT_SETTING_HS			0x00000100
 #define MGMT_SETTING_LE			0x00000200
+#define MGMT_SETTING_RELAX_MITM		0x00000400
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
@@ -351,6 +352,8 @@ struct mgmt_cp_set_device_id {
 } __packed;
 #define MGMT_SET_DEVICE_ID_SIZE		8
 
+#define MGMT_OP_SET_RELAX_MITM		0x0029
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 461150d..4c978d6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3028,6 +3028,12 @@ static u8 hci_get_auth_req(struct hci_conn *conn)
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
@@ -3071,11 +3077,14 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
index ca0ad32..66fdd8e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -76,6 +76,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_BLOCK_DEVICE,
 	MGMT_OP_UNBLOCK_DEVICE,
 	MGMT_OP_SET_DEVICE_ID,
+	MGMT_OP_SET_RELAX_MITM,
 };
 
 static const u16 mgmt_events[] = {
@@ -366,8 +367,10 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	settings |= MGMT_SETTING_POWERED;
 	settings |= MGMT_SETTING_PAIRABLE;
 
-	if (lmp_ssp_capable(hdev))
+	if (lmp_ssp_capable(hdev)) {
 		settings |= MGMT_SETTING_SSP;
+		settings |= MGMT_SETTING_RELAX_MITM;
+	}
 
 	if (lmp_bredr_capable(hdev)) {
 		settings |= MGMT_SETTING_CONNECTABLE;
@@ -421,6 +424,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_HS_ENABLED, &hdev->dev_flags))
 		settings |= MGMT_SETTING_HS;
 
+	if (test_bit(HCI_RELAX_MITM, &hdev->dev_flags))
+		settings |= MGMT_SETTING_RELAX_MITM;
+
 	return settings;
 }
 
@@ -1299,6 +1305,45 @@ failed:
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
@@ -3273,6 +3318,7 @@ static const struct mgmt_handler {
 	{ block_device,           false, MGMT_BLOCK_DEVICE_SIZE },
 	{ unblock_device,         false, MGMT_UNBLOCK_DEVICE_SIZE },
 	{ set_device_id,          false, MGMT_SET_DEVICE_ID_SIZE },
+	{ set_relax_mitm,         false, MGMT_SETTING_SIZE },
 };
 
 
-- 
1.8.1.4

