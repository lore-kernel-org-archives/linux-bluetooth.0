Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 15/15] Bluetooth: Add full support for updating privacy state
Date: Sat, 22 Feb 2014 19:06:45 +0200
Message-Id: <1393088805-28658-16-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are several things that need updating in addition to the
HCI_PRIVACY flag when Set Privacy is called. This includes toggling the
HCI_RPA_EXPIRED flag, setting the own_address_type variable, as well as
restarting advertising if necessary.

This patch adds these missing pieces to the set_privacy function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2dd0c730f0e9..7d0ab8b8d65c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4221,6 +4221,7 @@ static int set_privacy(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 		       u16 len)
 {
 	struct mgmt_cp_set_privacy *cp = cp_data;
+	struct hci_request req;
 	bool changed;
 	int err;
 
@@ -4239,11 +4240,42 @@ static int set_privacy(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 	if (cp->privacy) {
 		changed = !test_and_set_bit(HCI_PRIVACY, &hdev->dev_flags);
 		memcpy(hdev->irk, cp->irk, sizeof(hdev->irk));
+		hdev->own_addr_type = ADDR_LE_DEV_RANDOM;
+		set_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
 	} else {
 		changed = test_and_clear_bit(HCI_PRIVACY, &hdev->dev_flags);
 		memset(hdev->irk, 0, sizeof(hdev->irk));
+		cancel_delayed_work(&hdev->rpa_expired);
+		clear_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
+
+		if (!changed)
+			goto send_rsp;
+
+		if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dev_flags) ||
+		    !bacmp(&hdev->bdaddr, BDADDR_ANY))
+			hdev->own_addr_type = ADDR_LE_DEV_RANDOM;
+		else
+			hdev->own_addr_type = ADDR_LE_DEV_PUBLIC;
 	}
 
+	if (!changed || !hdev_is_powered(hdev))
+		goto send_rsp;
+
+	hci_req_init(&req, hdev);
+
+	if (!cp->privacy && bacmp(&hdev->static_addr, BDADDR_ANY))
+		hci_req_add(&req, HCI_OP_LE_SET_RANDOM_ADDR, 6,
+			    &hdev->static_addr);
+
+	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags) &&
+	    hci_conn_num(hdev, LE_LINK) == 0) {
+		disable_advertising(&req);
+		enable_advertising(&req);
+	}
+
+	hci_req_run(&req, NULL);
+
+send_rsp:
 	err = send_settings_rsp(sk, MGMT_OP_SET_PRIVACY, hdev);
 	if (err < 0)
 		goto unlock;
-- 
1.8.5.3

