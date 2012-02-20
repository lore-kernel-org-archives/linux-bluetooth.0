Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: mgmt: Add basic support for Set High Speed command
Date: Tue, 21 Feb 2012 00:24:35 +0200
Message-Id: <1329776676-22800-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329776676-22800-1-git-send-email-johan.hedberg@gmail.com>
References: <1329776676-22800-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds rudimentary support for the Set High Speed command in
the form of a new HCI dev flag (HCI_HS_ENABLED).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |    1 +
 net/bluetooth/mgmt.c        |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ad5e94c..ec37049 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -95,6 +95,7 @@ enum {
 
 	HCI_LE_SCAN,
 	HCI_SSP_ENABLED,
+	HCI_HS_ENABLED,
 };
 
 /* HCI ioctl defines */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 86148b1..4281331 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -418,6 +418,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
 		settings |= MGMT_SETTING_SSP;
 
+	if (test_bit(HCI_HS_ENABLED, &hdev->dev_flags))
+		settings |= MGMT_SETTING_HS;
+
 	return settings;
 }
 
@@ -1093,6 +1096,41 @@ failed:
 	return err;
 }
 
+static int set_hs(struct sock *sk, u16 index, void *data, u16 len)
+{
+	struct mgmt_mode *cp = data;
+	struct hci_dev *hdev;
+	int err;
+
+	BT_DBG("request for hci%u", index);
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_SET_SSP,
+						MGMT_STATUS_INVALID_PARAMS);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_SET_SSP,
+						MGMT_STATUS_INVALID_PARAMS);
+
+	if (!enable_hs) {
+		err = cmd_status(sk, index, MGMT_OP_SET_SSP,
+					MGMT_STATUS_NOT_SUPPORTED);
+		goto failed;
+	}
+
+	if (cp->val)
+		set_bit(HCI_HS_ENABLED, &hdev->dev_flags);
+	else
+		clear_bit(HCI_HS_ENABLED, &hdev->dev_flags);
+
+	err = send_settings_rsp(sk, MGMT_OP_SET_HS, hdev);
+
+failed:
+	hci_dev_put(hdev);
+	return err;
+}
+
 static int add_uuid(struct sock *sk, u16 index, void *data, u16 len)
 {
 	struct mgmt_cp_add_uuid *cp = data;
@@ -2655,6 +2693,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_SET_SSP:
 		err = set_ssp(sk, index, cp, len);
 		break;
+	case MGMT_OP_SET_HS:
+		err = set_hs(sk, index, cp, len);
+		break;
 	case MGMT_OP_ADD_UUID:
 		err = add_uuid(sk, index, cp, len);
 		break;
-- 
1.7.9

