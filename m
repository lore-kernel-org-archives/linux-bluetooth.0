Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: Update advertising data based on management commands
Date: Tue, 15 Oct 2013 06:33:52 -0700
Message-Id: <1381844037-24424-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Magically updating the advertising data when some random command enables
advertising in the controller is not really a good idea. It also caused
a bit of complicated code with the exported hci_udpate_ad function that
is shared from many places.

This patch consolidates the advertising data update into the management
core. It also makes sure that when powering on with LE enabled or later
on enabling LE the controller has a good default for advertising data.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |   2 -
 net/bluetooth/hci_core.c         |  87 +--------------------------
 net/bluetooth/hci_event.c        |   8 ---
 net/bluetooth/mgmt.c             | 126 +++++++++++++++++++++++++++++++++++----
 4 files changed, 116 insertions(+), 107 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4e20842..4a186ec 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1183,8 +1183,6 @@ struct hci_sec_filter {
 #define hci_req_lock(d)		mutex_lock(&d->req_lock)
 #define hci_req_unlock(d)	mutex_unlock(&d->req_lock)
 
-void hci_update_ad(struct hci_request *req);
-
 void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 					u16 latency, u16 to_multiplier);
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c53f7f9..a49ca48 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -685,10 +685,8 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 	if (hdev->commands[5] & 0x10)
 		hci_setup_link_policy(req);
 
-	if (lmp_le_capable(hdev)) {
+	if (lmp_le_capable(hdev))
 		hci_set_le_support(req);
-		hci_update_ad(req);
-	}
 
 	/* Read features beyond page 1 if available */
 	for (p = 2; p < HCI_MAX_PAGES && p <= hdev->max_page; p++) {
@@ -1127,89 +1125,6 @@ done:
 	return err;
 }
 
-static u8 create_ad(struct hci_dev *hdev, u8 *ptr)
-{
-	u8 ad_len = 0, flags = 0;
-	size_t name_len;
-
-	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
-		flags |= LE_AD_GENERAL;
-
-	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
-		if (lmp_le_br_capable(hdev))
-			flags |= LE_AD_SIM_LE_BREDR_CTRL;
-		if (lmp_host_le_br_capable(hdev))
-			flags |= LE_AD_SIM_LE_BREDR_HOST;
-	} else {
-		flags |= LE_AD_NO_BREDR;
-	}
-
-	if (flags) {
-		BT_DBG("adv flags 0x%02x", flags);
-
-		ptr[0] = 2;
-		ptr[1] = EIR_FLAGS;
-		ptr[2] = flags;
-
-		ad_len += 3;
-		ptr += 3;
-	}
-
-	if (hdev->adv_tx_power != HCI_TX_POWER_INVALID) {
-		ptr[0] = 2;
-		ptr[1] = EIR_TX_POWER;
-		ptr[2] = (u8) hdev->adv_tx_power;
-
-		ad_len += 3;
-		ptr += 3;
-	}
-
-	name_len = strlen(hdev->dev_name);
-	if (name_len > 0) {
-		size_t max_len = HCI_MAX_AD_LENGTH - ad_len - 2;
-
-		if (name_len > max_len) {
-			name_len = max_len;
-			ptr[1] = EIR_NAME_SHORT;
-		} else
-			ptr[1] = EIR_NAME_COMPLETE;
-
-		ptr[0] = name_len + 1;
-
-		memcpy(ptr + 2, hdev->dev_name, name_len);
-
-		ad_len += (name_len + 2);
-		ptr += (name_len + 2);
-	}
-
-	return ad_len;
-}
-
-void hci_update_ad(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_le_set_adv_data cp;
-	u8 len;
-
-	if (!lmp_le_capable(hdev))
-		return;
-
-	memset(&cp, 0, sizeof(cp));
-
-	len = create_ad(hdev, cp.data);
-
-	if (hdev->adv_data_len == len &&
-	    memcmp(cp.data, hdev->adv_data, len) == 0)
-		return;
-
-	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
-	hdev->adv_data_len = len;
-
-	cp.length = len;
-
-	hci_req_add(req, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
-}
-
 static int hci_dev_do_open(struct hci_dev *hdev)
 {
 	int ret = 0;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5391469..7b133f0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -939,14 +939,6 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 			clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
 	}
 
-	if (*sent && !test_bit(HCI_INIT, &hdev->flags)) {
-		struct hci_request req;
-
-		hci_req_init(&req, hdev);
-		hci_update_ad(&req);
-		hci_req_run(&req, NULL);
-	}
-
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c071708..285d571 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -536,6 +536,89 @@ static u8 *create_uuid128_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
 	return ptr;
 }
 
+static u8 create_ad(struct hci_dev *hdev, u8 *ptr)
+{
+	u8 ad_len = 0, flags = 0;
+	size_t name_len;
+
+	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
+		flags |= LE_AD_GENERAL;
+
+	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
+		if (lmp_le_br_capable(hdev))
+			flags |= LE_AD_SIM_LE_BREDR_CTRL;
+		if (lmp_host_le_br_capable(hdev))
+			flags |= LE_AD_SIM_LE_BREDR_HOST;
+	} else {
+		flags |= LE_AD_NO_BREDR;
+	}
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
+	if (hdev->adv_tx_power != HCI_TX_POWER_INVALID) {
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
+static void update_ad(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_le_set_adv_data cp;
+	u8 len;
+
+	if (!lmp_le_capable(hdev))
+		return;
+
+	memset(&cp, 0, sizeof(cp));
+
+	len = create_ad(hdev, cp.data);
+
+	if (hdev->adv_data_len == len &&
+	    memcmp(cp.data, hdev->adv_data, len) == 0)
+		return;
+
+	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
+	hdev->adv_data_len = len;
+
+	cp.length = len;
+
+	hci_req_add(req, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
+}
+
 static void create_eir(struct hci_dev *hdev, u8 *data)
 {
 	u8 *ptr = data;
@@ -1555,6 +1638,23 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status)
 
 	if (match.sk)
 		sock_put(match.sk);
+
+	/* Make sure the controller has a good default for
+	 * advertising data. Restrict the update to when LE
+	 * has actually been enabled. During power on, the
+	 * update in powered_update_hci will take care of it.
+	 */
+	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
+		struct hci_request req;
+
+		hci_dev_lock(hdev);
+
+		hci_req_init(&req, hdev);
+		update_ad(&req);
+		hci_req_run(&req, NULL);
+
+		hci_dev_unlock(hdev);
+	}
 }
 
 static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
@@ -1622,18 +1722,18 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto unlock;
 	}
 
+	hci_req_init(&req, hdev);
+
 	memset(&hci_cp, 0, sizeof(hci_cp));
 
 	if (val) {
 		hci_cp.le = val;
 		hci_cp.simul = lmp_le_br_capable(hdev);
+	} else {
+		if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
+			disable_advertising(&req);
 	}
 
-	hci_req_init(&req, hdev);
-
-	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags) && !val)
-		disable_advertising(&req);
-
 	hci_req_add(&req, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(hci_cp),
 		    &hci_cp);
 
@@ -2772,7 +2872,7 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	if (lmp_le_capable(hdev))
-		hci_update_ad(&req);
+		update_ad(&req);
 
 	err = hci_req_run(&req, set_name_complete);
 	if (err < 0)
@@ -3724,7 +3824,7 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto unlock;
 	}
 
-	/* We need to flip the bit already here so that hci_update_ad
+	/* We need to flip the bit already here so that update_ad
 	 * generates the correct flags.
 	 */
 	set_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
@@ -3734,7 +3834,7 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
 		set_bredr_scan(&req);
 
-	hci_update_ad(&req);
+	update_ad(&req);
 
 	err = hci_req_run(&req, set_bredr_complete);
 	if (err < 0)
@@ -4035,9 +4135,6 @@ static int powered_update_hci(struct hci_dev *hdev)
 		    cp.simul != lmp_host_le_br_capable(hdev))
 			hci_req_add(&req, HCI_OP_WRITE_LE_HOST_SUPPORTED,
 				    sizeof(cp), &cp);
-
-		/* In case BR/EDR was toggled during the AUTO_OFF phase */
-		hci_update_ad(&req);
 	}
 
 	if (lmp_le_capable(hdev)) {
@@ -4046,6 +4143,13 @@ static int powered_update_hci(struct hci_dev *hdev)
 			hci_req_add(&req, HCI_OP_LE_SET_RANDOM_ADDR, 6,
 				    &hdev->static_addr);
 
+		/* Make sure the controller has a good default for
+		 * advertising data. This also applies to the case
+		 * where BR/EDR was toggled during the AUTO_OFF phase.
+		 */
+		if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+			update_ad(&req);
+
 		if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
 			enable_advertising(&req);
 	}
-- 
1.8.3.1

